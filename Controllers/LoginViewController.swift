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

    @IBAction func onLoginClick(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
         if(isValidEmail(email)){
            
        let login = Login1(email: email, password: password)
        AF.request("https://inside4sandbox.ikiev.biz/Auth_API/check_login",
                   method: .post,
                   parameters: login).response { response in
            debugPrint(response)
          }}
            
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
