//
//  MinPayFormulaViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 23/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class MinPayFormulaViewController: UIViewController {
    
    var APR: Double = 0
    var balance: Double = 0
    
    @IBOutlet weak var percentOfBalanceTextfield: UITextField!
    @IBOutlet weak var percentOfBalanceOnlyTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
    }
    
    
    

//    @IBAction func button(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "testViewController")
//        self.navigationController!.pushViewController(vc, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
