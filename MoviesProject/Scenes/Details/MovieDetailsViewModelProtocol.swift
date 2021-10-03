//
//  MovieDetailsViewModelProtocol.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import Combine

//o input se refere a view, ou seja, as ações que desencadeiam mudanças na view
struct MovieDetailsViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
}

//o output se refere ao comportamento que será mostrado ao usuário
typealias MovieDetailsViewModelOutput = AnyPublisher<MovieDetailsState, Never>

protocol MovieDetailsViewModelProtocol : AnyObject {
    func transform(input: MovieDetailsViewModelInput) -> MovieDetailsViewModelOutput
}


enum MovieDetailsState {
    case loading
    case success(MovieViewModel)
    case failure(Error)
}
extension MovieDetailsState: Equatable {
    static func == (lhs: MovieDetailsState, rhs: MovieDetailsState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsMovie), .success(let rhsMovie)): return lhsMovie == rhsMovie
        case (.failure, .failure): return true
        default: return false
        }
    }
}
