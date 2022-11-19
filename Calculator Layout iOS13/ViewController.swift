//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var divideBtn: UIButton!
    @IBOutlet weak var equalEctualBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var multBtn: UIButton!
    
    var highLightedBtn: UIButton!
    var setOfNum1 = ""
    var setOfNum2 = ""
    var sum = ""
    var actionSymbol = ""
    var swithToNextSetOfNum = true
    var equalBtn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNumber(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
         }
        if highLightedBtn != nil && highLightedBtn.alpha < 1{
            highLightedBtn.alpha = 1
        }
        UIView.animate(withDuration: 0.2) {
            button.alpha = 0.5
         }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            UIView.animate(withDuration: 0.2) {
                button.alpha = 1
             }
        }
        let btnValue = button.currentTitle!
        if(equalBtn) {
            swithToNextSetOfNum = true
            sum = ""
            setOfNum1 = ""
            equalBtn = false
        }
        if(swithToNextSetOfNum) {
            setOfNum1 += btnValue
            display.text! = setOfNum1
        }else{
            setOfNum2 += btnValue
            display.text! = setOfNum2
        }
    }
    @IBAction func doAction(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
         }
        highlightBtn(button: button)
        
        if(setOfNum1 != "") {
            swithToNextSetOfNum = false
        }
        if(actionSymbol != "" && setOfNum2 != "") {
            sum = doStaffWithNumbers(typeOfAction: actionSymbol, stringOfNumbers1: setOfNum1, stringOfNumbers2: setOfNum2)
            setOfNum1 = sum
            setOfNum2 = ""
        }
        if(sum != "") {
            display.text = sum
        }
        if(button.currentTitle! != "=") {
            actionSymbol = button.currentTitle!
            equalBtn = false
        }
        if(button.currentTitle! == "=") {
            equalBtn = true
        }
    }
    
    @IBAction func clearDisplay(_ sender: UIButton) {
        display.text = "0"
        setOfNum1 = ""
        setOfNum2 = ""
        sum = ""
        swithToNextSetOfNum = true
        equalBtn = false
    }
    
    func doStaffWithNumbers(typeOfAction: String, stringOfNumbers1: String, stringOfNumbers2: String) -> String {
       let num1 = Int(stringOfNumbers1) ?? 0
       let num2 = Int(stringOfNumbers2) ?? 0
        switch typeOfAction {
        case "+":
            return String(num1 + num2)
        case "-":
            return String(num1 - num2)
        case "×":
            return String(num1 * num2)
        case "÷":
            return String(num1 / num2)
        default:
            return "you broke me"
        }
    }
    
    func highlightBtn(button: UIButton) {
        if(highLightedBtn != nil) {
            highLightedBtn.alpha = 1
        }
        button.alpha = 0.5
        highLightedBtn = button
    }
}


