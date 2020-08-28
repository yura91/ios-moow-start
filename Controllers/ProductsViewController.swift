//
//  ItemOneViewController.swift
//  HamburgerMenuBlog
//
//  Created by Yurec on 18.06.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit
import Alamofire


extension UILabel {
   func setAttributedHtmlText(_ html: String) {
      if let attributedText = html.attributedHtmlString {
        self.text = attributedText.string
      }
   }
}

class ProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var products = [FeedItem]()
    
    var pageNumber = 0
    
    var loadMore = true
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.label.text = products[indexPath.row].content_name
        
        cell.descLabel.setAttributedHtmlText(products[indexPath.row].content_desc)
//        cell.loadedImage.pin_setImage(from: URL(string: products[indexPath.row].content_img))
        AF.request(products[indexPath.row].content_img, method: .get).response { response in
            guard let image = UIImage(data:response.data!) else {
                // Handle error
                return
            }
            let imageData = image.jpegData(compressionQuality: 1.0)
            cell.loadedImage.image = UIImage(data : imageData!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == products.count - 1 {
            if loadMore {
            NetworkApi.getFeed(pageNumber: pageNumber)
            pageNumber += 1
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductCell")
        NetworkApi.getFeed(pageNumber: pageNumber)
        pageNumber += 1
        NotificationCenter.default.addObserver(self, selector: #selector(showFeed(_:)), name:NSNotification.Name(rawValue: "FEED_RECEIVED"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func showFeed(_ notification:Notification){
        if let dict = notification.userInfo as NSDictionary? {
            if let feed = dict["feed"] as? Feed{
                if(feed.products.count != 0) {
                    let products = feed.products
                    self.products.append(contentsOf: products)
                    tableView.reloadData()
                } else {
                   loadMore = false
                }
            }
        }
    }
}
