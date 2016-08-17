//
//  HomeVC.swift
//  WalletApp
//
//  Created by Manh on 8/17/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class HomeVC: UIViewController {
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
    @IBOutlet var       svInput:UIStackView!;
    @IBOutlet var       btnDone:UIButton!;

    //MARK:- VAR
    var objs: [ActionOBJ]!

    //MARK:- INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBarHidden = true
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        getListData()
        hideStackView()
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
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}