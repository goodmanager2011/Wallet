//
//  HomeVC.swift
//  WalletApp
//
//  Created by Manh on 8/17/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class HomeVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CalculatorDelegate {
   /*
     //MARK:- OUTLET
    //MARK:- VAR
    //MARK:- DATA
    //MARK:- ACTION
    //MARK:- TABLEVIEW
 */
    //MARK:- OUTLET
    @IBOutlet var       tfValues:UITextField!;
    @IBOutlet var       btnPositive:UIButton!;
    @IBOutlet var       btnNegative:UIButton!;
    @IBOutlet var       tfTotal: UILabel!;
    @IBOutlet var       svInput:UIView!;
    @IBOutlet var       btnDone:UIButton!;
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet var       lbCurrency:UILabel!;

    //MARK:- VAR
    var objs: [ActionOBJ]!
    let pickerData = ["USD","VND","AUD","BGN","BRL","CAD","CHF","CNY","CZK", "DKK"]

    //MARK:- INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBarHidden = true
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 250)
        let keyboard = CalculatorKeyboard(frame: frame)
        keyboard.delegate = self
        keyboard.showDecimal = true
        tfValues.inputView = keyboard

        
        getListData()
        hideStackView()
        lbCurrency.text = pickerData[0]
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //MARK:- DATA
    func getListData() {
        objs = ActionOBJ.findAll() as! [ActionOBJ]
        totalData()
    }
    func totalData()
    {
        var value: Double = 0;
        for item in objs {
            value = value + (item.value as NSString).doubleValue
        }
        tfTotal.text = String(format: "%.2f %@", value, "$")
        if value >= 0 {
            tfTotal.textColor = UIColor.whiteColor()
        }
        else
        {
            tfTotal.textColor = UIColor.redColor()
        }
    }
    //MARK:- ACTION
    func hideStackView() {
        if !btnPositive.selected && !btnNegative.selected {
            svInput.hidden = true
            btnDone.hidden = true
        }
        else
        {
            svInput.hidden = false
            btnDone.hidden = false
        }
    }
    @IBAction func historyAction(sender: UIButton)
    {
        let vc:HistoryVC = HistoryVC(nibName:"HistoryVC", bundle: nil);
        self.navigationController!.pushViewController(vc, animated: true);
    }
    @IBAction func positiveAction(sender: UIButton)
    {
        sender.selected = !sender.selected
        btnNegative.selected = false
        hideStackView()
    }
    @IBAction func negativeAction(sender: UIButton)
    {
        sender.selected = !sender.selected
        btnPositive.selected = false
        hideStackView()
    }
    @IBAction func doneAction(sender: UIButton)
    {
        if tfValues.text != nil && tfValues.text != "" && (btnPositive.selected || btnNegative.selected){
            var str = "";
            if btnPositive.selected {
                str = String(format: "+%@", tfValues.text!)
            }
            if btnNegative.selected {
                str = String(format: "-%@", tfValues.text!)
            }
            let firstObj = ActionOBJ.createEntity() as! ActionOBJ
            firstObj.currency = "USD"
            firstObj.value = str;
            NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
            getListData();
        }

    }
    @IBAction func currencyAction(sender: UIButton)
    {
        myPicker.hidden = !myPicker.hidden;
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myPicker.hidden = true;
        lbCurrency.text = pickerData[row]
    }
    
    // MARK: - RFCalculatorKeyboard delegate
    func calculator(calculator: CalculatorKeyboard, didChangeValue value: String) {
        tfValues.text = value
    }
}