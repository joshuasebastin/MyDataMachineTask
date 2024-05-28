//
//  UserViewModel.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import Foundation

class UserViewModel {
    
    func fetchPosts(page: Int, limit: Int, completion: @escaping (UserModel?) -> Void) {
        let postUrlString = AppDetails().baseURL + EndPoints.posts.rawValue + "?_page=\(page)&_limit=\(limit)"
        
        guard let url = URL(string: postUrlString) else {
            print("Invalid URL string: \(postUrlString)")
            completion(nil)
            return
        }
        
        Webservices().load(resource: url) { data in
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let userD = try JSONDecoder().decode(UserModel.self, from: data)
                DispatchQueue.main.async {
                    completion(userD)
                }
            } catch {
                print("Failed to decode JSON:- \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
