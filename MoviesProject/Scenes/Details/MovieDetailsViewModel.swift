//
//  MovieDetailsViewModel.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import Combine

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private let movieId: Int
    private let useCase: MoviesUseCaseProtocol
    
    init(movieId: Int, useCase: MoviesUseCaseProtocol) {
        self.movieId = movieId
        self.useCase = useCase
    }
    
    func transform(input: MovieDetailsViewModelInput) -> MovieDetailsViewModelOutput {
        let movieDetails = input.appear
            .flatMap({[unowned self] _ in self.useCase.movieDetails(with: self.movieId) })
            .map({ result -> MovieDetailsState in
                switch result {
                    case .success(let movie): return .success(self.toViewModel(from: movie))
                    case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        let loading: MovieDetailsViewModelOutput = input.appear.map({_ in .loading }).eraseToAnyPublisher()

        //juntando os dois
        return Publishers.Merge(loading, movieDetails).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func toViewModel(from movie: Movie) -> MovieViewModel {
        return MovieViewModelBuilder.viewModel(from: movie)
    }
}
