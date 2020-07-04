//
//  UserProfileController.swift
//  Insode0ios
//
//  Created by Yurec on 01.07.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(json_Response_Received(_:)), name:NSNotification.Name(rawValue: "JSON_PROFILE_RECEIVED"), object: nil)
        NetworkApi.updateProfile()
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func json_Response_Received(_ notification:Notification) {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let json = dict["json"] as? [String: Any]{
                // do something with your image
                emailField.text = json["email"] as? String
                phoneField.text = json["phone"] as? String
                nameField.text = json["username"] as? String
            }
        }
    }

}
