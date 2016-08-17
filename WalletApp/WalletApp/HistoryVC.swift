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
    @IBOutlet var tableControl: UITableView!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController!.navigationBarHidden = true;
        //init tableviewcell
        tableControl.registerNib(UINib.init(nibName: String(HistoryCell), bundle: nil), forCellReuseIdentifier: cellID);

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    @IBAction func homeAction(sender: UIButton)
    {
        self.navigationController!.popViewControllerAnimated(true);
    }
    //MARK:- TABLEVIEW
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
//    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension;
//    }
//    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
//        return UITableViewAutomaticDimension;
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
        cell.deleteButton.tag = indexPath.row + 100;
        cell.deleteButton.addTarget(self, action: #selector(deleteAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.editButton.tag = indexPath.row + 200;
        cell.editButton.addTarget(self, action: #selector(editAction), forControlEvents: UIControlEvents.TouchUpInside)

    }
    func deleteAction(sender: UIButton) -> Void {
        let index = sender.tag - 100
    }
    func editAction(sender: UIButton) -> Void {
        let index = sender.tag - 200
    }

}