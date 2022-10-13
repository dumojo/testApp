//
//  FavoritePhoto+CoreDataProperties.swift
//  TestApp
//
//  Created by Артем Дорожкин on 11.10.2022.
//
//

import Foundation
import CoreData


extension FavoritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePhoto> {
        return NSFetchRequest<FavoritePhoto>(entityName: "FavoritePhoto")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension FavoritePhoto : Identifiable {

}
