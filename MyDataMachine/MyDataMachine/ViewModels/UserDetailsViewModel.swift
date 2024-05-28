//
//  UserDetailsViewModel.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import Foundation
import UIKit

class UserDetailsViewModel {
    var user:[UserElement] = [UserElement]()
    
    var currentPage = 1
    private let limit = 10
    var isLoading = false
    var updateHandler: ((Bool) -> Void)?
}

extension UserDetailsViewModel {
    // Get the number Of rows Count
    func numberOfRows(index:Int) -> Int{
        return user.count
    }
    
    // Simulate heavy computation
    func computeHeavyTask(for post: UserElement) -> String {
        let startTime = CFAbsoluteTimeGetCurrent()
        Thread.sleep(forTimeInterval: 0.1) // Simulating a heavy task
        let endTime = CFAbsoluteTimeGetCurrent()
        print("Computed additional details for post \(post.id) \(post.title) in \(endTime - startTime) seconds")
        return "\(post.id) \(post.title)"
    }
    
    func getPost(at index: Int) -> UserElement? {
        return user[index]
    }
    
     func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        
        UserViewModel().fetchPosts(page: currentPage, limit: limit) { [weak self] newPosts in
            DispatchQueue.main.async {
                guard let self = self else { return } // Check for nil self
                if let newPosts = newPosts,!newPosts.isEmpty {
                    self.user.append(contentsOf: newPosts)
                    self.updateHandler?(true)
                } else {
                    self.updateHandler?(false)
                    print("No Data \(self.currentPage)")
                }
                self.isLoading = false
            }
        }
    }
}
