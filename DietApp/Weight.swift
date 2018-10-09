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
    @objc dynamic var water: Int = 0
    
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
            Weight.realm.add(self, update: true)
        }
    }
    
    func update(method: (() -> Void)) {
        try! Weight.realm.write {
            method()
        }
    }
    //date型をわたしたらdoubleで帰ってくる
    static func select(from date: Date) -> Double? {
        let result = realm.objects(Weight.self).filter("date == %@", date).last
        print("select \(result)")
        return result?.weight
    }
    
    static func waterSelect(from date: Date) -> Int? {
        let result = realm.objects(Weight.self).filter("date == %@", date).last
        print("select \(result)")
        return result?.water
    }
    
  
    
    static func graphSelect() -> Any? {
        let realm = try! Realm()
        let results = realm.objects(Weight.self).sorted(byKeyPath:"date", ascending: true)
        let numbers = results.value(forKey: "weight")
        print ("なんば\(numbers)")
        return numbers
    }
}


