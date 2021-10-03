//
//  Movie.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    let voteAverage: Float
    let releaseDate: String?
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

extension Movie {
    var subtitle: String {
        return "\(releaseYear)"
    }
    var releaseYear: Int {
        let date = releaseDate.flatMap { Movie.dateFormatter.date(from: $0) } ?? Date()
        return Calendar.current.component(.year, from: date)
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
