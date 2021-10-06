//
//  ViewController.swift
//  MoviesProject
//
//  Created by Kleyton Lopes on 03/10/21.
//

import UIKit
import SnapKit
import Combine

class MovieDetailsViewController: UIViewController {
    private let appear = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []
    private let viewModel: MovieDetailsViewModelProtocol
    let titleLabel: UILabel = {
           let label = UILabel()
           label.backgroundColor = .yellow
           label.numberOfLines = 0
           label.text = "Movie Title"
           return label
       }()
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.view.addSubview(titleLabel)
        updateViewConstraints()
        bind(to: viewModel)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appear.send(())
    }
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view).inset(20)
            make.leading.equalTo(self.view).inset(20)
            make.trailing.equalTo(self.view).inset(20)
        }
        super.updateViewConstraints()
    }
    //Bind -> Render -> Show
    private func bind(to viewModel: MovieDetailsViewModelProtocol) {
        let input = MovieDetailsViewModelInput(appear: appear.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    private func render(_ state: MovieDetailsState) {
        switch state {
        case .loading:
            print("Loading")
        case .failure:
            print("failure")
        case .success(let movieDetails):
            show(movieDetails)
        }
    }
    private func show(_ movieDetails: MovieViewModel) {
        titleLabel.text = movieDetails.title
    }

}
