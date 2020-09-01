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

class ProductsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var products = [FeedItem]()
    
    var pageNumber = 0
    
    var loadMore = true
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        cell.tittle.text = products[indexPath.row].content_name
        
        cell.desc.setAttributedHtmlText(products[indexPath.row].content_desc)
        AF.request(products[indexPath.row].content_img, method: .get).response { response in
            guard let image = UIImage(data:response.data!) else {
                // Handle error
                return
            }
            let imageData = image.jpegData(compressionQuality: 1.0)
            cell.image.image = UIImage(data : imageData!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == products.count - 1 {
            if loadMore {
                NetworkApi.getFeed(pageNumber: pageNumber)
                pageNumber += 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProductCell")
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
                    //                   tableView.reloadData()
                    collectionView.reloadData()
                } else {
                    loadMore = false
                }
            }
        }
    }
}
