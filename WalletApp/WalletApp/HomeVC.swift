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
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController!.navigationBarHidden = true;

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    @IBAction func historyAction(sender: UIButton)
    {
        let vc:HistoryVC = HistoryVC(nibName:"HistoryVC", bundle: nil);
        self.navigationController!.pushViewController(vc, animated: true);
    }
    @IBAction func positiveAction(sender: UIButton)
    {
        sender.selected = !sender.selected;
    }
    @IBAction func negativeAction(sender: UIButton)
    {
        sender.selected = !sender.selected;
    }
}