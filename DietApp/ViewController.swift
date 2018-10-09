//
//  ViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-02.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import RealmSwift
import RealmSwift
import Realm

//2画面目
class ViewController: UIViewController {
    @IBOutlet var waterButton1: UIButton!
    @IBOutlet var waterButton2: UIButton!
    @IBOutlet var waterButton3: UIButton!
    @IBOutlet var waterButton4: UIButton!
    
    var waterCount: Int!
    
    @IBOutlet var weightText: UITextField!
    var date: Date = Date()
    var weightNum: Double!
    var weightTmp: String!
    var dateLabelText: String!
    @IBOutlet var dateLabel: UILabel!
    
    let image:UIImage = UIImage(named:"full")!
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabelText = dateFormatter.string(from: date)
        dateLabel.text = dateLabelText
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        weightTmp = weightText.text
        weightNum = Double(weightTmp)

        self.performSegue(withIdentifier: "toGraph", sender: nil)
        
        //はるふさんのやり方でrealmに保存
        let weight = Weight.create()
        weight.date = date
        weight.weight = weightNum
        weight.water = waterCount
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        weight.save()
    }
    
    @IBAction func water1(_ sender: UIButton) {
        waterButton1.setImage(image , for: .normal)
        waterCount = 1
    }
    @IBAction func water2(_ sender: UIButton) {
        waterButton1.setImage(image , for: .normal)
        waterButton2.setImage(image , for: .normal)
        waterCount = 2
    }
    @IBAction func water3(_ sender: UIButton) {
        waterButton1.setImage(image , for: .normal)
        waterButton2.setImage(image , for: .normal)
        waterButton3.setImage(image , for: .normal)
        waterCount = 3
    }
    @IBAction func water4(_ sender: UIButton) {
        waterButton1.setImage(image , for: .normal)
        waterButton2.setImage(image , for: .normal)
        waterButton3.setImage(image , for: .normal)
        waterButton4.setImage(image , for: .normal)
        waterCount = 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGraph") {
            let graphView = segue.destination as! GraphViewController
            graphView.weight = self.weightNum
        }
    }
    
}

