//
//  CalenderViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-02.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import JBDatePicker
import RealmSwift
import Realm
import Foundation

//初めの画面
class CalenderViewController: UIViewController, JBDatePickerViewDelegate  {
    @IBOutlet var datePicker: JBDatePickerView!
    
    //当日，昨日，その前日のdate/weight
    let today = Date()
    var yesterday: Date!
    var daybeforeYesterday: Date!
    var yesterdayWeight: Double!
    var daybeforeYesterdayWeight: Double!
    
    var date: Date!
    var dateData: Date!
//    var dateDataWeight: Double!
//    var dateDataYesterday: Date!
//    var dateDataYesterdayWeight: Double!

    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
        
        // Realmのインスタンスを取得
        let realm = try! Realm()
        
        // Realmに保存されてるWeight型のオブジェクトを全て取得
        let weights = realm.objects(Weight.self)
        print(weights)
        print (today)
        
        //当日，昨日，その前日のdate
        yesterday = today.daysAgo(1)
        daybeforeYesterday = yesterday.daysAgo(1)
        print (yesterday)
        print (daybeforeYesterday)
        
    }

    
    // select the cell
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
        dateData = dayView.date
        print("今日\(dateData)")
//
//
//        dateDataYesterday = dateData.daysAgo(1)
//        print("昨日\(dateDataYesterday)")
//
//        dateDataWeight = Weight.select(from: dateData)!
//
//        if (dateDataWeight != nil){
//            print(dateDataWeight)
//        }
//
//        do{
//        try dateDataYesterdayWeight = Weight.select(from: dateDataYesterday)
//        print(dateDataYesterdayWeight)
//        } catch{
//            print("error")
//        }

    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePicker.updateLayout()
    }
    
//カレンダーの数字の色を変える（その日とその日の前の日のweightを比べる）
    var colorForDayLabelInMonth: UIColor{
        //（当日，）昨日，その前日のweight
        var yesterdayWeight: Double?
        var daybeforeYesterdayWeight: Double?
        
        //doubleがはいる．ここでバグる
        yesterdayWeight = Weight.select(from: yesterday)
        daybeforeYesterdayWeight = Weight.select(from: daybeforeYesterday)

        if(yesterdayWeight != nil && daybeforeYesterdayWeight != nil){
            if (yesterdayWeight! >= daybeforeYesterdayWeight!) {
                return UIColor.blue
            }else if(yesterdayWeight! <= daybeforeYesterdayWeight!){
                return UIColor.red
            }else {
                return UIColor.black
            }
        }else{
            return UIColor.purple
        }
        return UIColor.orange
    }



    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toWeight", sender: dateData)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeight") {
            let view = segue.destination as! ViewController
            view.date = sender as? Date
        }
    }


}
