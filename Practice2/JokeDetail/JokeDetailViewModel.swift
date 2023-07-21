//
//  JokeDetailViewModel.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import Foundation

protocol JokeDetailViewModelDelegate: AnyObject {
    func reloadView(_ response: JokeResponse)
}

final class JokeDetailViewModel {
    private let category: String
    
    weak var delegate: JokeDetailViewModelDelegate?
    
    init(category: String) {
        self.category = category
    }
    
    func fetchDetail() {
        NetworkManager().fetchJokeDetail(category: category) { [weak self] result in
            switch result {
            case .success(let response):
                self?.delegate?.reloadView(response)
            case .failure: break
            }
        }
    }
}
