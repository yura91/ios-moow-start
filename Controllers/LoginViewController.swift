//
//  LoginViewController.swift
//  HamburgerMenuBlog
//
//  Created by Yurec on 18.06.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit
import Alamofire

struct Login1: Encodable {
    let email: String
    let password: String
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(json_Response_Received(_:)), name:NSNotification.Name(rawValue: "JSON_RESPONSE_RECEIVED"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func json_Response_Received(_ notification:Notification) {
    let userProfileController = UserProfileController(nibName: "UserProfileController", bundle: nil)
    self.navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    @IBAction func onLoginClick(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
         if(isValidEmail(email)){
            NetworkApi.login(email: email, password: password)
        }
            
        }
        
    }
    
    @IBAction func onClickRegister(_ sender: UIButton) {
        let registerController = RegistrationViewController(nibName: "RestrationViewController", bundle: nil)
        self.navigationController?.pushViewController(registerController, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
