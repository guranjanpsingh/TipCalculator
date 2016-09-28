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
            if (billAmount.text != ""){
                return Double(billAmount.text!)!
            }
            return 0.0
        }
        set {
            billAmount.text = String(newValue)
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
            totalBill.text = String(format: "$%.2f",newValue)
        }
    }
    
    @IBAction func billAmountDidChange(_ sender: UITextField) {
        if (currentTipUnit == TipUnit.percent){
            currentTotalBill = currentBillAmount + (currentBillAmount * (currentTipAmount/100))
        }
        else {
            currentTotalBill = currentBillAmount + currentTipAmount
        }
    }
    
    @IBAction func tipAmountDidChange(_ sender: UITextField) {
        if (currentTipUnit == TipUnit.percent){
            currentTotalBill = currentBillAmount + (currentBillAmount * (currentTipAmount/100))
        }
        else {
            currentTotalBill = currentBillAmount + currentTipAmount
        }
    }
    @IBAction func totalDidChange(_ sender: UITextField) {
            print(currentBillAmount)
            print(currentTotalBill)
            currentTipAmount = currentTotalBill - currentBillAmount
        print("Total Changed")
    }
    @IBAction func tipUnitChanged(_ sender: UISegmentedControl) {
        currentTipUnit = TipUnit(rawValue:sender.selectedSegmentIndex)!
        if (currentTipUnit == TipUnit.percent){
            currentTotalBill = currentBillAmount + (currentBillAmount * (currentTipAmount/100))
        }
        else {
            currentTotalBill = currentBillAmount + currentTipAmount
        }
    }
    @IBAction func onTapAway(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

