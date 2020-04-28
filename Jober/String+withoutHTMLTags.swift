//
//  String+withoutHTMLTags.swift
//  Jober
//
//  Created by Denis Sychev on 23/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

extension String {
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with: " ", options: .regularExpression, range: nil)
    }
}
