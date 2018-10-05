//
//  Data+.swift
//  DietApp
//
//  Created by Mika on 2018-10-05.
//  Copyright © 2018 Mika. All rights reserved.
//

import Foundation

extension Date {
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func daysAgo(_ numDays: Int) -> Date {
        return addDays(-numDays)
    }
}
