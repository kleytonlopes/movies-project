//
//  NetworkServiceProtocol.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import Foundation
import Combine

protocol NetworkServiceProtocol: AnyObject {
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
}


struct Resource<T: Decodable> {
    let url: URL
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}

extension Resource {

    static func details(movieId: Int) -> Resource<Movie> {
        let url = ApiConstants.baseUrl.appendingPathComponent("/movie/\(movieId)")
        let parameters: [String : CustomStringConvertible] = [
            "api_key": ApiConstants.apiKey,
            "language": Locale.preferredLanguages[0]
            ]
        return Resource<Movie>(url: url, parameters: parameters)
    }
}
