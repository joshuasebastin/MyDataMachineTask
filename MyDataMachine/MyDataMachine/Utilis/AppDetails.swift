//
//  AppDetails.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import Foundation

enum EndPoints: String {
    case posts = "posts"
}
struct AppDetails {
    let baseURL:String = "https://jsonplaceholder.typicode.com/"
    let detailScreenTitle = "Details"
    let userListCell = "UserCell"
}
