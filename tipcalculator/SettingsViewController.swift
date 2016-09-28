//
//  SettingsViewController.swift
//  tipcalculator
//
//  Created by Guranjan Singh on 9/25/16.
//  Copyright © 2016 Guranjan Singh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var defaultTipPercentage: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultTipPercentage.selectedSegmentIndex = defaults.integer(forKey: "DefaultTipPercentage")
    }

    @IBAction func DefaultTipPercentChanged(_ sender: UISegmentedControl) {
        defaults.set(sender.selectedSegmentIndex, forKey: "DefaultTipPercentage")
        defaults.synchronize()
    }
}
