//
//  MoviesUseCase.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import Combine

final class MoviesUseCase: MoviesUseCaseProtocol {

    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func movieDetails(with identifier: Int) -> AnyPublisher<Result<Movie, Error>, Never> {
        return networkService.load(Resource<Movie>.details(movieId: identifier))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Movie, Error>, Never> in
                .just(.failure(error))
            }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}

final class Scheduler {
    //para limitar número máximo de requisicoes
    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main

}
