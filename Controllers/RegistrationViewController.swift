//
//  RestrationViewController.swift
//  HamburgerMenuBlog
//
//  Created by Yurec on 19.06.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit
import Alamofire

struct Login: Encodable {
    let email: String
    let password: String
}


class RegistrationViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func onRegisterClick(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if(isValidEmail(email)) {
         let login = Login(email: email, password: password)
        

        AF.request("https://inside4sandbox.ikiev.biz/Auth_API/check_reg",
                   method: .post,
                   parameters: login).response { response in
            debugPrint(response)
          }
        }
            
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
   }

  
}
