//
//  GraphViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-04.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
import Realm

class GraphViewController: UIViewController {
    var weight: Double!
    @IBOutlet var weightLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        weightLabel.text = String(weight)

    
    }
}

