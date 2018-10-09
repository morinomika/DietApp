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
    var calendar = Calendar(identifier: .gregorian)
    //当日，昨日，その前日のdate/weight
    var today = Date()
    var yesterday: Date!
    var daybeforeYesterday: Date!
    
    // 
    var today_date_rounded: Date!
    var yesterday_date_rounded: Date!
    var daybeforeYesterday_date_rounded: Date!
    
    var yesterdayWeight: Double!
    var daybeforeYesterdayWeight: Double!
    
    var color: UIColor = .black
    
    //押した日付
    var date: Date!
    var dateData: Date!
    
    var color2: UIColor!
    
//    var dateYest: Date!
//    var date2days: Date!
//
//    var date_rounded: Date!
//    var dateYest_rounded: Date!
//    var date2days_rounded: Date!
//
//    var dateYestWeight: Double!
//    var date2daysWeight: Double!
    
    @IBOutlet var waterView: UIImageView!
    
    var waterImage1:UIImage = UIImage(named: "empty")!
    var waterImage2:UIImage = UIImage(named: "water2")!
    var waterImage3:UIImage = UIImage(named: "water3")!
    var waterImage4:UIImage = UIImage(named: "full")!
    
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
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
        

        
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        
        // Realmのインスタンスを取得
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // Realmに保存されてるWeight型のオブジェクトを全て取得
        let weights = realm.objects(Weight.self)
        print(weights)
        
        // today_dateから年月日のみ抽出する -> 2017/07/12となる
        today_date_rounded =  roundDate(today, calendar: calendar)
        print("today\(today_date_rounded)")

        
        
        //当日，昨日，その前日のdate
        yesterday = today.daysAgo(1)
        daybeforeYesterday = yesterday.daysAgo(1)
        
        // today_dateから年月日のみ抽出する -> 2017/07/12となる
        yesterday_date_rounded = roundDate(yesterday, calendar: calendar)
        daybeforeYesterday_date_rounded = roundDate(daybeforeYesterday, calendar: calendar)
        
        let waterCount = Weight.waterSelect(from: today_date_rounded)
        print("水\(waterCount)")
        
        if waterCount == 1 {
            waterView.image = waterImage1
        }else if waterCount == 2 {
            waterView.image = waterImage2
        }else if waterCount == 3 {
            waterView.image = waterImage3
        }else if waterCount == 4 {
            waterView.image = waterImage4
        }

        
        print ("yesterday\(yesterday_date_rounded)")
        print ("2daysbefoew\(daybeforeYesterday_date_rounded)")
        

        
        //        if yesterday_date_rounded >= daybeforeYesterday_date_rounded {
        //            self.view.backgroundColor = UIColor.cyan
        //        } else if yesterday_date_rounded < daybeforeYesterday_date_rounded {
        //            self.view.backgroundColor = UIColor.darkGray
        //        }
        changeColor()
    }
    
    func changeColor() -> UIColor?{
        //（当日，）昨日，その前日のweight
        var yesterdayWeight: Double?
        var daybeforeYesterdayWeight: Double?
        print("yesterdayWeight\(yesterdayWeight)")

        //doubleがはいる．ここでバグ
        yesterdayWeight = Weight.select(from: yesterday_date_rounded)
        print(yesterdayWeight)
        var weightYest: Double!

        daybeforeYesterdayWeight = Weight.select(from: daybeforeYesterday_date_rounded)

        print("yesterdayweight")
        print(yesterdayWeight)
        print("yesterdayweight2")
        print(daybeforeYesterdayWeight)

        if (yesterdayWeight! >= daybeforeYesterdayWeight!) {
            self.view.backgroundColor = UIColor.darkGray
//            color2 = UIColor.darkGray
        } else if (yesterdayWeight! < daybeforeYesterdayWeight!) {
            self.view.backgroundColor = UIColor(hex: "fcbae6")
//            color2 = UIColor(hex: "fcbae6")
        }

        if(yesterdayWeight != nil && daybeforeYesterdayWeight != nil){
            if (yesterdayWeight! >= daybeforeYesterdayWeight!) {
                return .blue
            }else if(yesterdayWeight! < daybeforeYesterdayWeight!){
                return .red
            }else {
                return .black
            }
        }else{
            return .black
        }
    }
    
    // select the cell
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
        dateData = dayView.date
        print("今日\(dateData)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        datePicker.updateLayout()
    }
    
    //カレンダーの数字の色を変える（その日とその日の前の日のweightを比べる）
    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toWeight", sender: dateData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeight") {
            let view = segue.destination as! ViewController
            view.date = sender as? Date ?? Date()
            
        }
    }
    var colorForWeekDaysViewBackground: UIColor {
        return UIColor(hex: "6a7df7", alpha: 1)
        
    }
    var colorForSelectionCircleForToday: UIColor {
        return UIColor(hex: "f450be", alpha: 1)
        
    }
    var colorForSelectionCircleForOtherDate: UIColor {
        return UIColor(hex: "fcbae6")
        
    }
    var fontForWeekDaysViewText: JBFont {
        return JBFont(name: "Marker Felt", size: .medium)
        
    }
    var fontForDayLabel: JBFont {
        return JBFont(name: "Marker Felt", size: .medium)
        
    }
//    
//    var colorForDayLabelInMonth: UIColor {
//        return color2
//    }





    
    ///Color of the 'today' date label text
    var colorForCurrentDay: UIColor {
        return color
        
    }
    
    ///Color of any label text that is selected
    var colorForSelelectedDayLabel: UIColor {
        return color
        
    }
}
