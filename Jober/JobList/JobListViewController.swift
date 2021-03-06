//
//  JobListViewController.swift
//  Jober
//
//  Created by Denis Sychev on 25/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class JobListViewController: UIViewController {

    let networkService = NetworkService()
    @IBOutlet weak var tableView: UITableView!
    var jobsDataSource: JobsDataSource = JobsDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewSetup()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showJobWebPage.rawValue {
            if let indexPath = self.tableView.indexPathForSelectedRow, let jobWebPageViewController = segue.destination as? JobWebPageViewController {
                jobWebPageViewController.link = self.jobsDataSource.getLinkFromJobAt(indexPath.row)
            }
        } else if segue.identifier == Constants.showSearchView.rawValue {
            if let searchViewController = segue.destination as? SearchViewController {
                searchViewController.networkService = self.networkService
            }
        }
    }
    
    private func tableViewSetup() {
        tableView.dequeueReusableCell(withIdentifier: Constants.jobCellIdentifier.rawValue)
        tableView.dataSource = jobsDataSource
        tableView.delegate = jobsDataSource
        tableView.reloadData()
        
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    private func loadData() {
        showSpinner(onView: self.view)
        networkService.loadJobs(withCompletion: { [weak self] (items) in
            if let items = items {
                self!.jobsDataSource.get(items)
                self!.tableView.reloadData()
                self!.removeSpinner()
            }
        })
    }
    
}
