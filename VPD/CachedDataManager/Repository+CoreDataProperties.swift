//
//  Repository+CoreDataProperties.swift
//  VPD
//
//  Created by durodola on 27/09/2024.
//
//

import Foundation
import CoreData


extension CoreDataRepository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataRepository> {
        return NSFetchRequest<CoreDataRepository>(entityName: "Repository")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var fullName: String?
    @NSManaged public var url: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var ownerAvatarURL: String?
    @NSManaged public var type: String?

}

extension CoreDataRepository : Identifiable {

}
