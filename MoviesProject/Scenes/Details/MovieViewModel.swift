//
//  MovieViewModel.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import UIKit.UIImage
import Combine

struct MovieViewModel {
    let id: Int
    let title: String
    let subtitle: String
    let overview: String
    let poster: AnyPublisher<UIImage?, Never>?
    let rating: String

    init(id: Int, title: String, subtitle: String, overview: String, poster: AnyPublisher<UIImage?, Never>? = nil, rating: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.overview = overview
        self.poster = poster
        self.rating = rating
    }
}

extension MovieViewModel: Hashable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MovieViewModelBuilder {
    static func viewModel(from movie: Movie) -> MovieViewModel {
        return MovieViewModel(id: movie.id,
                              title: movie.title,
                              subtitle: movie.subtitle,
                              overview: movie.overview,
                              rating: String(format: "%.2f", movie.voteAverage))
    }
}
