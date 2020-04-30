//
//  FeedResponse.swift
//  Jober
//
//  Created by Denis Sychev on 30/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

struct Item: Decodable {
    var title: String
    var description: String
    var guid: String
    var link: String
    
//    enum CodingKeys: String, CodingKey {
//        case title
//        case description
//        case guid
//        case link
//    }
}
