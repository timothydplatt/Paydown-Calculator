//
//  WelcomeScreenViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 20/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBAction func getStartedButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.numberOfLines = 0
        topLabel.lineBreakMode = .byWordWrapping
        middleLabel.numberOfLines = 0
        middleLabel.lineBreakMode = .byWordWrapping
        bottomLabel.numberOfLines = 0
        bottomLabel.lineBreakMode = .byWordWrapping
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}
