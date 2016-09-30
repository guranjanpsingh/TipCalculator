//
//  ViewController.swift
//  tipcalculator
//
//  Created by Guranjan Singh on 9/24/16.
//  Copyright © 2016 Guranjan Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipAmount: UITextField!
    @IBOutlet weak var totalBill: UITextField!
    
    fileprivate var currentTipUnit: TipUnit = TipUnit.percent
    fileprivate var defaultTipValuesArray = [18.0, 20.0, 25.0]
    
    @IBOutlet weak var splitingChequeBetween: UILabel!
    let defaults = UserDefaults.standard

    @IBOutlet weak var selectedTipMethod: UISegmentedControl!
    
    @IBOutlet weak var currentSplitChequeSliderValue: UISlider!
    override func viewDidLoad() {
        let currentDefaultTipIndex = defaults.integer(forKey: "DefaultTipPercentage")
        currentTipAmount = defaultTipValuesArray[currentDefaultTipIndex]
    }
    
    fileprivate enum TipUnit:Int  {
        case percent
        case dollar
    }
    
    fileprivate var currentTipAmount: Double {
        get {
            if (tipAmount.text != ""){
                return Double(tipAmount.text!)!
            }
            return 0.0
        }
        set {
            tipAmount.text = String(newValue)
        }
    }
    
    fileprivate var currentBillAmount: Double {
        get {
            if (billAmount.text != "" && billAmount.text! != "$"){
                return Double(billAmount.text!.replacingOccurrences(of: "$", with: ""))!
            }
            return 0.0
        }
        set {
            billAmount.text = String(format: "$ %.2f", newValue)
        }
    }
    
    fileprivate var currentTotalBill: Double {
        get {
            if (totalBill.text != "" && totalBill.text! != "$"){
                return Double(totalBill.text!.replacingOccurrences(of: "$", with: ""))!
            }
            return 0.0
        }
        set {
            totalBill.text = String(format: "$%.2f", newValue)
        }
    }
    
    @IBAction func billAmountDidChange(_ sender: UITextField) {
        CalculateTip()
    }
    
    @IBAction func tipAmountDidChange(_ sender: UITextField) {
        CalculateTip()
    }
    
    @IBAction func totalDidChange(_ sender: UITextField) {
        selectedTipMethod.selectedSegmentIndex = TipUnit.dollar.rawValue // select method as dollars.
        currentTipAmount = currentTotalBill - currentBillAmount
    }
    
    @IBAction func tipUnitChanged(_ sender: UISegmentedControl) {
        currentTipUnit = TipUnit(rawValue:sender.selectedSegmentIndex)!
    }
    
    @IBAction func onTapAway(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func splitChequeChanged(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        splitingChequeBetween.text = String(Int(sender.value))
        CalculateTip()
    }
    
    func CalculateTip() {
        var total = 0.0
        if (currentTipUnit == TipUnit.percent){
            total = currentBillAmount + (currentBillAmount * (currentTipAmount/100))
        }
        else {
            total = currentBillAmount + currentTipAmount
        }
        print(total)
        print(currentSplitChequeSliderValue.value)
        currentTotalBill = total / Double(currentSplitChequeSliderValue.value)
        print(currentTotalBill)
    }
}

