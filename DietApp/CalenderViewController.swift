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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.delegate = self //この行を追加

    }
    
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        print("date selected: \(dayView.date!)")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        datePicker.updateLayout()
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
