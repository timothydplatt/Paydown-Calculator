//
//  TestViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 23/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit
import Charts

class TestViewController: UIViewController {
    
    @IBOutlet weak var payDownTimeLabel: UILabel!
    @IBOutlet weak var chtChart: LineChartView!
    
    var numbers : [Double] = []
    var APR: Double = 0
    var balance: Double = 0
    var percentageOfBalance: Double = 0
    var percentageOfBalanceOnly: Double = 0
    var repaymentAmount: Double = 0
    var payDownTime: Int = 0
    var cumulativeInterest: Decimal = 0
    var firstMinPaymentAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minPayCalculator = MinPayCalculator()
        let payDownTimeIfPayingMinimum = minPayCalculator.minPayCalculator(balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        payDownTime = payDownTimeIfPayingMinimum.payDownTime
        cumulativeInterest = payDownTimeIfPayingMinimum.cumulativeInterest
        firstMinPaymentAmount = payDownTimeIfPayingMinimum.minPaymentAtMonths[0]
        //print("firstMinPaymentAmount \(firstMinPaymentAmount)")
        
        payDownTimeLabel.text = String(payDownTime)  + " Months"
        
        for i in 0..<payDownTimeIfPayingMinimum.balanceAtMonth.count {
  
            numbers.append(payDownTimeIfPayingMinimum.balanceAtMonth[i])
            
        }
        
        updateGraph()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //GRAPH CODE
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        line1.colors = [UIColor.magenta] //Sets the colour to blue
        
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        chtChart.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
        
        chtChart.autoScaleMinMaxEnabled = true
        chtChart.drawGridBackgroundEnabled = false
        chtChart.rightAxis.enabled = false
        chtChart.xAxis.labelPosition = .bottom
        //chtChart.animate(xAxisDuration: 3)
        chtChart.animate(xAxisDuration: 3, easingOption: .easeInBack)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finalScreenSegue" {
            let viewController = segue.destination as! TestViewController2ViewController
            
            viewController.balance = balance
            viewController.APR = APR
            viewController.percentageOfBalance = percentageOfBalance
            viewController.percentageOfBalanceOnly = percentageOfBalanceOnly
            viewController.repaymentAmount = repaymentAmount
            viewController.payDownTime = payDownTime
            viewController.cumulativeInterest = cumulativeInterest
            viewController.firstMinPaymentAmount = firstMinPaymentAmount
        }
    }
    
}

