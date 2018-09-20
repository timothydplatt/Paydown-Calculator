//
//  CustomNavigationController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 20/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
