//
//  ViewController.swift
//  Jober
//
//  Created by Denis Sychev on 25/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = APIController()
    @IBOutlet weak var tableView: UITableView!
    var jobsDataSource: JobsDataSource?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        jobsDataSource = JobsDataSource()
        api.loadJobs(withCompletion: { [weak self] (items) in
            if let items = items {
                self!.jobsDataSource!.get(items)
                self!.tableView.reloadData()
            }
        })
        tableView.dequeueReusableCell(withIdentifier: "JobCell")
        tableView.dataSource = jobsDataSource
        tableView.delegate = jobsDataSource
        tableView.reloadData()
        
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
