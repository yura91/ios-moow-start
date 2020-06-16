//
//  ViewController.swift
//  HamburgerMenuBlog
//
//  Created by Erica Millado on 7/15/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

extension UIStackView {
func addBackground(color: UIColor) {
    let subView = UIView(frame: bounds)
    subView.backgroundColor = color
    subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subView, at: 0)
}
}
    
class ViewController: UIViewController {
    
    @IBOutlet weak var stackLeading: NSLayoutConstraint!
    @IBOutlet weak var stackTrailing: NSLayoutConstraint!
    @IBOutlet var ubeView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    var hamburgerMenuIsVisible = false
    
    @IBAction func hamburgerBtnTapped(_ sender: Any) {
        //if the hamburger menu is NOT visible, then move the ubeView back to where it used to be
        if !hamburgerMenuIsVisible {
            
            //this constant is NEGATIVE because we are moving it 150 points OUTWARD and that means -150
            stackTrailing.constant = self.view.frame.size.width/2
            
            //1
            hamburgerMenuIsVisible = true
        } else {
        //if the hamburger menu IS visible, then move the ubeView back to its original position
            stackLeading.constant = 0
            stackTrailing.constant = 0
            
            //2
            hamburgerMenuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stackView.addBackground(color: .white)
    }


}

