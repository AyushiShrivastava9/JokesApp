//
//  UIImage+Additions.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import UIKit

extension UIImage {
    func load(from urlString: String?, completion: @escaping ((UIImage?) -> Void)) {
        guard let urlStr = urlString,
              let imageURL = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let someData = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: someData)
            DispatchQueue.main.async {
                completion(image)
            }
            
        }.resume()
    }
}
