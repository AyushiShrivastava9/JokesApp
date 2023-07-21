//
//  NetworkManager.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import Foundation

final class NetworkManager {
    func fetchJokesList(_ completion: @escaping ((Result<[String], APIError>) -> Void)) {
        guard let url = URL(string: Constants.listPath) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            guard let someData = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let itemList = try? JSONDecoder().decode([String].self, from: someData)
            
            DispatchQueue.main.async {
                completion(.success(itemList ?? []))
            }
            
        }
        
        dataTask.resume()
    }
    
    func fetchJokeDetail(category: String, _ completion: @escaping ((Result<JokeResponse, APIError>) -> Void)) {
        guard let url = URL(string: Constants.detailPath + category) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            guard let someData = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = try? JSONDecoder().decode(JokeResponse.self, from: someData) else {
                completion(.failure(.invalidResponse))
                return
            }
            DispatchQueue.main.async {
                completion(.success(response))
            }
            
        }
        
        dataTask.resume()
    }
}
