//
//  Webservices.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import Foundation

final class Webservices {
    
    func load(resource: URL, completion: @escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: resource) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
