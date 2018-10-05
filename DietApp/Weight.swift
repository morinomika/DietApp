//
//  Weight.swift
//  DietApp
//
//  Created by Mika on 2018-10-02.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import RealmSwift


class Weight: Object {
    static let realm = try! Realm()

    @objc dynamic var id = 0
    @objc dynamic var date = Date()
    @objc dynamic var weight: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    static func create() -> Weight {
        let weight = Weight()
        weight.id = lastId()
        return weight
    }
    
    static func lastId() -> Int {
        if let weight = realm.objects(Weight.self).last {
            return weight.id + 1
        } else {
            return 1
        }
    }
    
    
    func save() {
        try! Weight.realm.write {
            Weight.realm.add(self)
        }
    }
    
    func update(method: (() -> Void)) {
        try! Weight.realm.write {
            method()
        }
    }
    
 
//    static func loadAll() -> [Weight] {
//        let users = realm.objects(Weight.self).sorted(byKeyPath: "id", ascending: false)
//        var ret: [Weight] = []
//        for user in users {
//            ret.append(user)
//        }
//        return ret
//    }
//    


    static func select(from day: Date) -> Double? {
        let result = realm.objects(Weight.self).filter("date == %@", day)
        return result[0].weight
    }
    
    
}
