//
//  Products.swift
//  Insode0ios
//
//  Created by Yurec on 19.08.2020.
//  Copyright © 2020 Erica Millado. All rights reserved.
//

import Foundation

class Feed: Decodable {
    let products: [FeedItem]
    let newToken: String
    
    enum CodingKeys: String, CodingKey {
        case products = "pages_list"
        case newToken = "new_token"
    }
}
