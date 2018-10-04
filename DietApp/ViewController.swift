//
//  ViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-02.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet var weightText: UITextField!
    let weightData = Weight() // Weightというモデルをインスタンス化
    var date: String!
    var weight: Double!
    var weightTmp: String!
    @IBOutlet var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = date
    }
    
    
    
    @IBAction func next(_ sender: UIButton) {
        weightTmp = weightText.text//追加
        weight = Double(weightTmp)!

        self.performSegue(withIdentifier: "toGraph", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGraph") {
            let graphView = segue.destination as! GraphViewController
            graphView.weight = self.weight
        }
    }
}
/*
    
    
    // データを保存するための処理
    func save() {
        do {
            let realm = try Realm()  // Realmのインスタンスを作成します。
            try realm.write {
                realm.add(self.weightData)  // 作成した「realm」というインスタンスにrealmDataを書き込みます。
            }
        } catch {
            
        }
    }


}

 */
