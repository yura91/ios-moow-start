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
    
class MainViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var stackLeading: NSLayoutConstraint!
    @IBOutlet weak var stackTrailing: NSLayoutConstraint!
    @IBOutlet var ubeView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    var hamburgerMenuIsVisible = false
    
    @IBAction func onLoginClick(_ sender: Any) {
        let loginController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginController, animated: true)

    }
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
    

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let ind = tabBar.items?.firstIndex(of: item){
            switch ind {
            case 0:
                print(ind)
                let favouriteController = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
                self.navigationController?.pushViewController(favouriteController, animated: true)
            case 1:
                print(ind)
                let productsController = UIStoryboard.init(name: "ProductViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController

                self.navigationController?.pushViewController(productsController!, animated: true)
           case 2:
                print(ind)
                let itemTwoController = ItemTwoViewController(nibName: "ItemTwoViewController", bundle: nil)
                self.navigationController?.pushViewController(itemTwoController, animated: true)
            case 3:
                print(ind)
                let moreController = MoreViewController(nibName: "MoreViewController", bundle: nil)
                self.navigationController?.pushViewController(moreController, animated: true)
                
            default:
                print(ind)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stackView.addBackground(color: .white)
        tabBar.delegate = self
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
                
            leftSwipe.direction = .left
            rightSwipe.direction = .right

            view.addGestureRecognizer(leftSwipe)
            view.addGestureRecognizer(rightSwipe)
        }
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
                print("Swipe Left")
            stackLeading.constant = 0
            stackTrailing.constant = 0
            hamburgerMenuIsVisible = false
        }
    
        if (sender.direction == .right) {
            print("Swipe Right")
            stackTrailing.constant = self.view.frame.size.width/2
            hamburgerMenuIsVisible = true

        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }


}

