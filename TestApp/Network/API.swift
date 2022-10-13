//
//  API.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import Foundation

enum API: String {
    case mainPathURL = "https://api.unsplash.com/"
    
    case getPhotos = "photos"
    case searchPhotos = "search/photos"
    case getPhoto = "photos/"
    func fullPath() -> String {
        return API.mainPathURL.rawValue + self.rawValue
    }
}
enum Status: String {
    case success = "OK"
    case error = "INTERNAL_ERROR"
}
