//
//  SearchTableViewController.swift
//  Jober
//
//  Created by Denis Sychev on 01/05/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewDataSource: SearchTableDataSource?
    var networkService: NetworkService?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let networkService = networkService else { return }
        self.networkService = networkService
        
        tableViewDataSource = SearchTableDataSource(with: networkService)
        tableView.dataSource = self.tableViewDataSource
        tableView.delegate = self.tableViewDataSource
    }
}
