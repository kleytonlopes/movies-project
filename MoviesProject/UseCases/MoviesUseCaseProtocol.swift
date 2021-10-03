//
//  MoviesUseCaseProtocol.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import Combine

protocol MoviesUseCaseProtocol {
    func movieDetails(with identifier: Int) -> AnyPublisher<Result<Movie, Error>, Never>
}
