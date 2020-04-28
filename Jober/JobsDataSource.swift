//
//  JobsDataSource.swift
//  Jober
//
//  Created by Denis Sychev on 23/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation
import UIKit

struct JobViewModel {
    struct CellData: JobCellViewModel {
        var title: String
        var description: String
        var link: String
    }
}

class JobsDataSource: NSObject {
    private var jobs: [Item] = []
    
    func get(_ jobs: [Item]) {
        self.jobs = jobs
    }
    
    func getLinkFromJobAt(_ index: Int) -> String {
        return jobs[index].link
    }
}

extension JobsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JobCell.self), for: indexPath) as! JobCell
        cell.set(viewModel: JobViewModel.CellData(title: job.title, description: job.description, link: job.link))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
