//
//  ChartViewController.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/9/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var barChartView: LineChartView!
    
    var aliveEntriesPerGeneration: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(aliveEntriesPerGeneration)
        
        setChartSurvival(/*values: [110,9,8,7,8,7,6,5,4,3,2,3,3,3,3,3,3,6,3,5,3,4,35,34,200,220,1,1,1,1]*/)
        
    }
    func setChartSurvival(/*values: [Double]*/) {
        
        var dataEntries: [ChartDataEntry] = aliveEntriesPerGeneration
        
        /* //Here we add the values to an array and turn them into ChartDataEntry.
         //I commented this out because I ended up passing a ChartDataEntry array right away so this wasn't needed
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
         */
        
        //sets the data entries into a Data Set and changes some attributes of this data set to look pretty
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Nodes Alive")
        lineChartDataSet.setColor(.blue)
        lineChartDataSet.setCircleColor(.blue)
        lineChartDataSet.fillColor = .blue
        lineChartDataSet.fillAlpha = 85
        lineChartDataSet.drawFilledEnabled = true;
        lineChartDataSet.circleRadius = 0
        
        
        //actually turns the view that holds the chart into the chart itself by
        //populating it with the data from the dataset
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        barChartView.data = lineChartData
        
    }
}

