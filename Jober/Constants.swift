//
//  Constants.swift
//  Jober
//
//  Created by Denis Sychev on 22/05/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

enum Constants: String {
    // MARK: - NetworkService constants
    case StackOverflowJobsFeedURL = "https://stackoverflow.com/jobs/feed"
    
    // MARK: - JobListViewController
    // Segues
    case showJobWebPage = "showJobWebPage"
    case showSearchView = "showSearchView"
    // Cell identifier
    case jobCellIdentifier = "JobCell"
    
    // MARK: - JobCell
}
