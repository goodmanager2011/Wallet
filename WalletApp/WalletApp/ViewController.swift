//
//  ViewController.swift
//  WalletApp
//
//  Created by Giang on 8/17/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items = [[String: String]]()
    
    var objs: [ActionOBJ]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        fnRefresh()
        
        var firstObj = ActionOBJ.createEntity() as! ActionOBJ
        firstObj.currency = "USD"
        firstObj.value = "-1000"
        
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()

        
        objs = ActionOBJ.findAll() as! [ActionOBJ]
        let currentBeer = objs[0]

        print(currentBeer.currency)
        

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
                    
                    print("\(value.element?.attributes["CurrencyCode"] )")
                    
                }
                dispatch_async(dispatch_get_main_queue(),{
                    
                    //reload data
                })
            }
            
        })
        
    }


}

