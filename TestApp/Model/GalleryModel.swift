//
//  GalleryModel.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import Foundation

class GalleryModel: Codable {
    let total: Int
    let total_pages: Int
    let results: [Gallery]
}

struct Gallery: Codable, Equatable {
    static func == (lhs: Gallery, rhs: Gallery) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let created_at: String
    let urls: URLS
    let user: User
}

struct URLS: Codable {
    let small: String
}

struct User: Codable {
    let name: String
    let location: String?
    let total_collections: Int?
}

