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
    var author: String
    var guid: String
    var link: String
    var pubDate: String
    var location: String
}
