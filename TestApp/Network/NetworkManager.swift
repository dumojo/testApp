//
//  NetworkManager.swift
//  TestApp
//
//  Created by Артем Дорожкин on 10.10.2022.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    private var parser = Parser()
    
    let clientID = "akeirjKrx0Ujd_L2ckdiephVGAdtKPK1LNHud4rbGx8"
    
    func getPhotos( page: Int, completion: @escaping ([Gallery]?, Status) -> ()){
        
        var params: [String: Any] = [:]
        
        params["page"] = page
        params["per_page"] = 30
        params["client_id"] = clientID
        
        AF.request("\(API.getPhotos.fullPath())", method: .get, parameters: params).response { [self] (responce) in
       
            guard let data = responce.data else { return completion(nil, .error)}
            
            guard let photos: [Gallery]?  = parser.parseJSON(with: data) else {return completion(nil, .error)}
            
            completion(photos, .success)
            
        }
    }
    func searchPhotos(query: String,page: Int, completion: @escaping (GalleryModel?, Status) -> ()){
        
        var params: [String: Any] = [:]
        
        params["page"] = page
        params["per_page"] = 30
        params["query"] = query
        params["client_id"] = clientID
        
        AF.request("\(API.searchPhotos.fullPath())", method: .get, parameters: params).response { [self] (responce) in
       
            guard let data = responce.data else { return completion(nil, .error)}
            
            guard let photos: GalleryModel?  = parser.parseJSON(with: data) else {return completion(nil, .error)}
            
            completion(photos, .success)
            
        }
    }
    func getPhoto(id: String? , completion: @escaping (Gallery?, Status) -> ()){
        
        var params: [String: Any] = [:]
//        if let photoID = id {
//            params["id"] = photoID
//        }
        params["client_id"] = clientID
        
        AF.request("\(API.getPhoto.fullPath()+(id ?? ""))", method: .get, parameters: params).response { [self] (responce) in
       
            guard let data = responce.data else { return completion(nil, .error)}
            
            guard let photo: Gallery?  = parser.parseJSON(with: data) else {return completion(nil, .error)}
           
            completion(photo, .success)
            
        }
    }
}
