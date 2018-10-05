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

class CalenderViewController: UIViewController, JBDatePickerViewDelegate  {
    @IBOutlet var datePicker: JBDatePickerView!
    var date: Date!
    var dateData: Date!
    var dateDataWeight: Double!
    var dateDataYesterday: Date!
    var dateDataYesterdayWeight: Double!

    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.delegate = self //この行を追加
        
        // Realmのインスタンスを取得
        let realm = try! Realm()
        
        // Realmに保存されてるWeight型のオブジェクトを全て取得
        let weights = realm.objects(Weight.self)
        print(weights)
        

    }

    
    // select the cell
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
//        date = dateFormatter.string(from: dayView.date!) //追加
        dateData = dayView.date
        print("今日\(dateData)")
        

        dateDataYesterday = dateData.daysAgo(1)
        print("昨日\(dateDataYesterday)")
        
        dateDataWeight = Weight.select(from: dateData)
        print(dateDataWeight)
        
        dateDataYesterdayWeight = Weight.select(from: dateDataYesterday)
        print(dateDataYesterdayWeight)

    }
//    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//    lazy var date = calendar.dateByAddingUnit(.Day, value: -10, toDate: dateData, options: NSCalendar.Options())!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePicker.updateLayout()
    }
    
    var colorForSelelectedDayLabel: UIColor{
        if (dateDataWeight >= dateDataYesterdayWeight) {
            return UIColor.blue
        }else if(dateDataWeight <= dateDataYesterdayWeight){
            return UIColor.red
        }else {
            return UIColor.black
        }
        
    }
    
//    var colorForDayLabelInMonth: UIColor {
//        if
//        return UIColor of choice
//
//    }
    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toWeight", sender: dateData)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeight") {
            let view = segue.destination as! ViewController
            view.date = sender as? Date
        }
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
