//
//  HistoryVC.swift
//  WalletApp
//
//  Created by Manh on 8/17/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
let cellID: String = "historyCellID";

class HistoryVC: UIViewController {
    
    //MARK:- OUTLET
    @IBOutlet var tableControl: UITableView!;
    
    //MARK:- VAR
    var objs: [ActionOBJ]!
    //MARK:- INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController!.navigationBarHidden = true;
        //init tableviewcell
        tableControl.registerNib(UINib.init(nibName: String(HistoryCell), bundle: nil), forCellReuseIdentifier: cellID);
        //
        getListData()
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    //MARK:- DATA
    func getListData() {
        objs = ActionOBJ.findAll() as! [ActionOBJ]
    }
    //MARK:- ACTION
    @IBAction func homeAction(sender: UIButton)
    {
        self.navigationController!.popViewControllerAnimated(true);
    }
    func deleteAction(sender: UIButton) -> Void {
        let index = sender.tag - 100
        let currentBeer = objs[index]
        currentBeer.deleteEntity();
        NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
        getListData()
        self.tableControl.reloadData();
    }
    func editAction(sender: UIButton) -> Void {
//        let index = sender.tag - 200
    }
    //MARK:- TABLEVIEW
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objs.count;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: HistoryCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! HistoryCell;
        
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell: HistoryCell = cellTmp as! HistoryCell;
        let currentBeer = objs[indexPath.row]
        cell.priceButton.text = String(format: "%@ %@", currentBeer.value, currentBeer.currency);
        
        cell.deleteButton.tag = indexPath.row + 100;
        cell.deleteButton.addTarget(self, action: #selector(deleteAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.editButton.tag = indexPath.row + 200;
        cell.editButton.addTarget(self, action: #selector(editAction), forControlEvents: UIControlEvents.TouchUpInside)

    }


}