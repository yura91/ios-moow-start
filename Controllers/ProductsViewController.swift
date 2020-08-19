//
//  ItemOneViewController.swift
//  HamburgerMenuBlog
//
//  Created by Yurec on 18.06.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit

class ProductsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkApi.getFeed(pageNumber: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(showFeed(_:)), name:NSNotification.Name(rawValue: "FEED_RECEIVED"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func showFeed(_ notification:Notification){
        
    }
}
