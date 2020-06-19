//
//  FavouriteViewController.swift
//  HamburgerMenuBlog
//
//  Created by Yurec on 17.06.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit

extension UITextView {

func centerVertically() {
    let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
    let size = sizeThatFits(fittingSize)
    let topOffset = (bounds.size.height - size.height * zoomScale) / 2
    let positiveTopOffset = max(1, topOffset)
    contentOffset.y = -positiveTopOffset
}
}
    
class FavouriteViewController: UIViewController {

    @IBOutlet weak var txtFavourite: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFavourite.centerVertically()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
