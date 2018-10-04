//
//  CalenderViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-02.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import JBDatePicker

class CalenderViewController: UIViewController, JBDatePickerViewDelegate  {
    @IBOutlet var datePicker: JBDatePickerView!
    var date: String!
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

    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dateFormatter.string(from: dayView.date!))")
        date = dateFormatter.string(from: dayView.date!) //追加

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePicker.updateLayout()
    }
    
    var colorForSelelectedDayLabel: UIColor{
        return UIColor.blue
        
    }
    @IBAction func next(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toWeight", sender: nil)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toWeight") {
            let view = segue.destination as! ViewController
            view.date = self.date
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
