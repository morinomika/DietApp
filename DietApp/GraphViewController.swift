//
//  GraphViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-04.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    var weight: Double!
    @IBOutlet var weightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weightLabel.text = String(weight)
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

