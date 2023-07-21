//
//  JokeListViewModel.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import Foundation

protocol JokeListViewModelDelegate: AnyObject {
    func reloadData()
}

final class JokeListViewModel {
    private var items: [String] = []
    
    weak var delegate: JokeListViewModelDelegate?
    
    func noOfRows() -> Int {
        items.count
    }
    
    func item(at index: Int) -> String? {
        guard items.indices.contains(index) else {
            return nil
        }
        return items[index]
    }
    
    func fetchItems() {
        NetworkManager().fetchJokesList { [weak self] in
            switch $0 {
            case .success(let items):
                self?.items = items
                self?.delegate?.reloadData()
            case .failure: break
            }
        }
    }
}

enum Category {
    case jokes, mobilePhones
}
