//
//  JobListViewController.swift
//  Jober
//
//  Created by Denis Sychev on 25/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class JobListViewController: UIViewController {

    let api = APIController()
    @IBOutlet weak var tableView: UITableView!
    var jobsDataSource: JobsDataSource?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        jobsDataSource = JobsDataSource()
        showSpinner(onView: self.view)
        api.loadJobs(withCompletion: { [weak self] (items) in
            if let items = items {
                self!.jobsDataSource!.get(items)
                self!.tableView.reloadData()
                self!.removeSpinner()
            }
        })
        
        tableView.dequeueReusableCell(withIdentifier: "JobCell")
        tableView.dataSource = jobsDataSource
        tableView.delegate = jobsDataSource
        tableView.reloadData()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobWebPage" {
            if let indexPath = self.tableView.indexPathForSelectedRow, let jobWebPageViewController = segue.destination as? JobWebPageViewController {
                jobWebPageViewController.link = self.jobsDataSource?.getLinkFromJobAt(indexPath.row) ?? ""
            }
        }
    }
    
}
