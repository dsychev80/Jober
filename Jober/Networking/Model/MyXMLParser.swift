//
//  XMLParser.swift
//  Jober
//
//  Created by Denis Sychev on 08/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

protocol XMLParsing {
    func returnItems() -> [Item]
}

class MyXMLParser: NSObject, XMLParserDelegate, XMLParsing {
    
    enum XMLFeedNames: String {
        case item = "item"
        case description = "description"
        case title = "title"
        case guid = "guid"
        case link = "link"
    }
    
    typealias XMLTag = XMLFeedNames
    
    private let data: Data
    private var string: String = ""
    private var items: [Item] = []
    private var item: Item = Item()
    
    init(with data: Data) {
        self.data = data
        super.init()
    }
    
    
    func returnItems() -> [Item] {
        let parser = XMLParser(data: self.data)
        parser.delegate = self
        parser.parse()
        return items
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        string = ""
        
        if let element: XMLFeedNames = XMLFeedNames(rawValue: elementName) {
            switch element {
            case .item:
                item = Item()
            default:
                return
                   }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let element: XMLFeedNames = XMLFeedNames(rawValue: elementName) {
            switch element {
            case .item:
                items.append(item)
            case .title:
                item.title = string
            case .description:
                item.description = string.removeHTMLTags()
            case .guid:
                item.guid = string
            case .link:
                item.link = string
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.string += string
    }
    
}
