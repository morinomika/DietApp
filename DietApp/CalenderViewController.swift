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
    // カレンダーを取得
    let  calendar = Calendar(identifier: .gregorian)
    
    //当日，昨日，その前日のdate/weight
    var today = Date()
    var yesterday: Date!
    var daybeforeYesterday: Date!
    
    var yesterdayWeight: Double!
    var daybeforeYesterdayWeight: Double!
    
    var color: UIColor = .purple
    
    var date: Date!
    var dateData: Date!

    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()
    
    //時間以降切り捨て
    func roundDate(_ date: Date, calendar cal: Calendar) -> Date {
        return cal.date(from: DateComponents(year: cal.component(.year, from: date), month: cal.component(.month, from: date), day: cal.component(.day, from: date)))!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.delegate = self
        
        // Realmのインスタンスを取得
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Realmに保存されてるWeight型のオブジェクトを全て取得
        let weights = realm.objects(Weight.self)
        print(weights)
        // today_dateから年月日のみ抽出する -> 2017/07/12となる
        let today_date_rounded =  roundDate(today, calendar: calendar)
        print("aaaa\(today_date_rounded)")
        
        //当日，昨日，その前日のdate
        yesterday = today.daysAgo(1)
        daybeforeYesterday = yesterday.daysAgo(1)
        
        // today_dateから年月日のみ抽出する -> 2017/07/12となる
        let yesterday_date_rounded =  roundDate(yesterday, calendar: calendar)
        let daybeforeYesterday_date_rounded =  roundDate(daybeforeYesterday, calendar: calendar)
        
        print (yesterday_date_rounded)
        print (daybeforeYesterday_date_rounded)
        
        changeColor()

        

        
    }
    
    func changeColor() -> UIColor?{
        //（当日，）昨日，その前日のweight
        var yesterdayWeight: Results<Weight>?
        var daybeforeYesterdayWeight: Results<Weight>?
        print("yesterdayWeight\(yesterdayWeight)")
        
//        //doubleがはいる．ここでバグ
//        yesterdayWeight = Weight.select(from: today)
//        daybeforeYesterdayWeight = Weight.select(from: today)
//        if(yesterdayWeight != nil && daybeforeYesterdayWeight != nil){
//            if (yesterdayWeight! >= daybeforeYesterdayWeight!) {
//                return .blue
//            }else if(yesterdayWeight! < daybeforeYesterdayWeight!){
//                return .red
//            }else {
//                return .black
//            }
//        }else{
            return .purple
        
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
        return .purple
    }

    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toWeight", sender: dateData)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeight") {
            let view = segue.destination as! ViewController
            view.date = sender as? Date ?? Date()
            
        }
    }


}
