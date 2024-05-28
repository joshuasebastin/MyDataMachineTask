//
//  UserModel.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import Foundation

// MARK: - UserElement
struct UserElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias UserModel = [UserElement]
