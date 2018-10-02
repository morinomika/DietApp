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
    let weightData = Weight() // Weightというモデルをインスタンス化

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weightData.date = "a"
        weightData.weight = 20
        self.save();
    }
    
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

