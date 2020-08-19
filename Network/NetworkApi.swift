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
                                NotificationCenter.default.post(name: Notification.Name(rawValue:"LOGIN_RESPONSE_RECEIVED"),
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
                                NotificationCenter.default.post(name: Notification.Name(rawValue:"REGISTRATION_RESPONSE_RECEIVED"),
                                                                object: nil, userInfo: ["token":new_token])
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
    static func getProfile(){
        let inside4_session = defaults.string(forKey: "new_token")
        AF.request("https://inside4sandbox.ikiev.biz/Auth_API/user_row_json",
                   method: .get,
                   parameters: ["inside4_session":inside4_session]).responseJSON{ response in
                    
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json)
                            if let csrf_token = json["csrf_token"]{
                                print(csrf_token)
                                defaults.set(csrf_token, forKey: "csrf_token")
                                
                            }
                            
                            if let new_token = json["new_token"]{
                                print(new_token)
                                defaults.set(new_token, forKey: "new_token")
                            }
                            
                            NotificationCenter.default.post(name: Notification.Name(rawValue:"GET_PROFILE_RECEIVED"),
                                                            object: nil, userInfo: ["json":json])
                        }
                    case .failure(let error):
                        print(error)
                    }
        }
        
    }
    
    static func updateProfile(name:String, phone:String, email:String){
        let csrf_token = defaults.string(forKey: "csrf_token")
        let inside4_session = defaults.string(forKey: "new_token")
        AF.request("https://inside4sandbox.ikiev.biz/Auth_API/update_user_data",
                   
                   method: .post,
                   parameters: ["inside4_session":inside4_session!, "csrf_token":csrf_token!, "name":name, "email":email, "phone":phone]).responseJSON{ response in
                    
                    switch response.result {
                    case .success(let value):
                        if let json = value as? [String: Any] {
                            print(json)
                            if let new_token = json["new_token"]{
                                print(new_token)
                                defaults.set(new_token, forKey: "new_token")
                                
                            }
                            NotificationCenter.default.post(name: Notification.Name(rawValue:"UPDATE_PROFILE_RECEIVED"),
                                                            object: nil, userInfo: ["json":json])
                        }
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
    static func getProducts(pageNumber: Int){
        let inside4_session = defaults.string(forKey: "new_token")
        AF.request("https://inside4sandbox.ikiev.biz/Info_API/feed",
                   
                   method: .post,
                   parameters: ["inside4_session":inside4_session!, "page": pageNumber]).responseDecodable(of: Products.self) { response in
                    guard let products = response.value else { return }
                    defaults.set(products.newToken, forKey: "new_token")
        }
    }
    
}
