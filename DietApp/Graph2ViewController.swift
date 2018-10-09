//
//  Graph2ViewController.swift
//  DietApp
//
//  Created by Mika on 2018-10-09.
//  Copyright © 2018 Mika. All rights reserved.
//

import UIKit
import Charts
import Realm
import RealmSwift

class Graph2ViewController: UIViewController {
        var sortedData:[Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        sortedData = Weight.graphSelect() as! [Any]
        

       
        let rect = CGRect(x:0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 30)
        let chartView = LineChartView(frame: rect)
        
        var entry = [ChartDataEntry]()
        
        for (i, d) in sortedData.enumerated() {
            entry.append(ChartDataEntry(x: Double(i), y: d as! Double ))
        }
        
        let dataSet = LineChartDataSet(values: entry, label: "data")
        
        chartView.data = LineChartData(dataSet: dataSet)
        
        self.view.addSubview(chartView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
