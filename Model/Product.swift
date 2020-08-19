//
//  Product.swift
//  Insode0ios
//
//  Created by Yurec on 18.08.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import UIKit

class Product: Decodable {
    var content_id: String
    var content_desc: String
    var content_html: String
    var content_img: String
    var content_name: String
    
    enum CodingKeys: String, CodingKey {
        case content_id
        case content_desc
        case content_html
        case content_img
        case content_name
    }
}
