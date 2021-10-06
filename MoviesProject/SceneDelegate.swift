//
//  SceneDelegate.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let idMovie = 21542
    
    func movieDetailsController(_ movieId: Int) -> UIViewController {
        let useCase = MoviesUseCase(networkService:  NetworkService())
        let viewModel = MovieDetailsViewModel(movieId: movieId, useCase: useCase)
        return MovieDetailsViewController(viewModel: viewModel)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let currentScene = (scene as? UIWindowScene)
        guard let windowScene = currentScene else { return }
          
            let window = UIWindow(windowScene: windowScene)
        window.rootViewController = movieDetailsController(idMovie)
            window.makeKeyAndVisible()
            self.window = window
    }
}
