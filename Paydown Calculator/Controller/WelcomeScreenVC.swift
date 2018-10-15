//
//  WelcomeScreenViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 20/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class WelcomeScreenVC: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    //MARK: - IB Actions
    @IBAction func getStartedButton(_ sender: Any) {
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Use as many lines as needed to fit the labels text.
        topLabel.numberOfLines = 0
        topLabel.lineBreakMode = .byWordWrapping
        
        middleLabel.numberOfLines = 0
        middleLabel.lineBreakMode = .byWordWrapping
        
        bottomLabel.numberOfLines = 0
        bottomLabel.lineBreakMode = .byWordWrapping
    }

}
