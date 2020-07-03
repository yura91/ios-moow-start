//
//  NetworkApi.swift
//  Insode0ios
//
//  Created by Yurec on 02.07.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import Foundation
import Alamofire

class NetworkApi : NSObject{
    private static let defaults = UserDefaults.standard
    
    static func login(email: String, password: String){
        let login = Login1(email: email, password: password)
         AF.request("https://inside4sandbox.ikiev.biz/Auth_API/check_login",
                          method: .post,
                   parameters: login).responseJSON{ response in
                           switch response.result {
                           case .success(let value):
                               if let json = value as? [String: Any] {
                                   print(json)
                                   if let new_token = json["new_token"]{
                                       print(new_token)
                                       defaults.set(new_token, forKey: "new_token")
                                       NotificationCenter.default.post(name: Notification.Name(rawValue:"JSON_RESPONSE_RECEIVED"),
                                                                    object: nil, userInfo: ["token":new_token])
                                   }
                               }
                           case .failure(let error):
                               print(error)
                           }
                   }
        
    }
    
    static func register(email: String, password: String){
        let login = Login1(email: email, password: password)
         AF.request("https://inside4sandbox.ikiev.biz/Auth_API/check_reg",
                          method: .post,
                   parameters: login).responseJSON{ response in
                           switch response.result {
                           case .success(let value):
                               if let json = value as? [String: Any] {
                                   print(json)
                                   if let new_token = json["new_token"]{
                                       print(new_token)
                                       defaults.set(new_token, forKey: "new_token")
                                       NotificationCenter.default.post(name: Notification.Name(rawValue:"JSON_RESPONSE_RECEIVEDReg"),
                                                                    object: nil, userInfo: ["token":new_token])
                                   }
                               }
                           case .failure(let error):
                               print(error)
                           }
                   }
    }
    
    static func updateProfile(){
        let inside4_session = defaults.string(forKey: "new_token")
        AF.request("https://inside4sandbox.ikiev.biz/Auth_API/user_row_json",
                         method: .get,
                         parameters: ["inside4_session":inside4_session]).responseJSON{ response in
                    
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json)
                            if let new_token = json["new_token"]{
                            print(new_token)
                            defaults.set(new_token, forKey: "new_token")
                            }
                            if let email = json["email"]{
                            print(email)
                            }
                            }
                    case .failure(let error):
                        print(error)
                    }
        }
        
    }

}
