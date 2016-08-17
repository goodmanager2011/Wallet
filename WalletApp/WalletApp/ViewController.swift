//
//  ViewController.swift
//  WalletApp
//
//  Created by Giang on 8/17/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalculatorDelegate {

    var items = [[String: String]]()
    
    @IBOutlet weak var txt: UITextField!
    var objs: [ActionOBJ]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fnRefresh()
        
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 300)
        let keyboard = CalculatorKeyboard(frame: frame)
        keyboard.delegate = self
        keyboard.showDecimal = true
        txt.inputView = keyboard

        
        
        var firstObj = ActionOBJ.createEntity() as! ActionOBJ
        firstObj.currency = "USD"
        firstObj.value = "-1000"
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()

        
        objs = ActionOBJ.findAll() as! [ActionOBJ]
        let currentBeer = objs[0]

        print(currentBeer.currency)
        

    }
    
    // MARK: - RFCalculatorKeyboard delegate
    func calculator(calculator: CalculatorKeyboard, didChangeValue value: String) {
        txt.text = value
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fnRefresh() -> Void {

        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            if let request = NSData(contentsOfURL: NSURL(string:apiExchangeRate)!){

                let reply = NSString(data: request, encoding: NSUTF8StringEncoding)
                let xml = SWXMLHash.parse(reply as! String)
                
                let arr = xml["ExrateList"]["Exrate"].all
                
                if (arr.count == 0){
                    return;
                }
                
                self.items.removeAll()
                
                for value in arr {
                    let dic = ["Buy": value.element?.attributes["Buy"],
                        "Sell": value.element?.attributes["Sell"],
                        "Transfer": value.element?.attributes["Transfer"],
                        "CurrencyCode": value.element?.attributes["CurrencyCode"]
                        ] as Dictionary
                    
                    self.items.append(dic as! [String : String])
                    
                    print("\(value.element?.attributes["Transfer"] )")
                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    
                    //reload data
                })
            }
            
        })
        
    }


}

