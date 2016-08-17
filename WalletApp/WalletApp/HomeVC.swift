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

    //MARK:- INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController!.navigationBarHidden = true;
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    //MARK:- ACTION
    @IBAction func historyAction(sender: UIButton)
    {
        let vc:HistoryVC = HistoryVC(nibName:"HistoryVC", bundle: nil);
        self.navigationController!.pushViewController(vc, animated: true);
    }
    @IBAction func positiveAction(sender: UIButton)
    {
        sender.selected = !sender.selected;
        btnNegative.selected = false;
    }
    @IBAction func negativeAction(sender: UIButton)
    {
        sender.selected = !sender.selected;
        btnPositive.selected = false;

    }
    @IBAction func doneAction(sender: UIButton)
    {
        if tfValues.text != nil && tfValues.text != ""{
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

        }

    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}