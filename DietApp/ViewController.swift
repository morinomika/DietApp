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
    var weightNum: Double!
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
        weightNum = Double(weightTmp)!

        self.performSegue(withIdentifier: "toGraph", sender: nil)
        
        // STEP.1 Realmを初期化
        let realm = try! Realm()
        
        //STEP.2 保存する要素を書く
        let weight = Weight()
        weight.date = date
        weight.weight = weightNum
        
        //STEP.3 Realmに書き込み
        try! realm.write {
            realm.add(weight, update: true)
        }
        
        
        //画面遷移して前の画面に戻る
        self.dismiss(animated: true, completion: nil)

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGraph") {
            let graphView = segue.destination as! GraphViewController
            graphView.weight = self.weightNum
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
