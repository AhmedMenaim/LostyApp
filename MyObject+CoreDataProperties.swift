//
//  MyObject+CoreDataProperties.swift
//  LostyApp
//
//  Created by Crypto on 7/20/19.
//  Copyright © 2019 Crypto. All rights reserved.
//
//

import Foundation
import CoreData


extension MyObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyObject> {
        return NSFetchRequest<MyObject>(entityName: "MyObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var image: NSData?
    @NSManaged public var id: Int64

}
