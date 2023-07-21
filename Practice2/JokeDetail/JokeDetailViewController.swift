//
//  JokeDetailViewController.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import UIKit

final class JokeDetailViewController: UIViewController {
    
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewModel: JokeDetailViewModel
    
    init(viewModel: JokeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.fetchDetail()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(jokeLabel)
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
}

extension JokeDetailViewController: JokeDetailViewModelDelegate {
    func reloadView(_ response: JokeResponse) {
        jokeLabel.text = response.value ?? ""
        UIImage().load(from: "https://api.chucknorris.io/img/chucknorris_logo_coloured_small@2x.png", completion: { [weak self] image in
            self?.imageView.image = image
        })
    }
}
