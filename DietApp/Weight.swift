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
    @objc dynamic var date = ""
    @objc dynamic var weight: Double = 0.0
    
//    override static func primaryKey() -> String? {
//        return "date"
//    }
}
