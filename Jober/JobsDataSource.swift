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
        var author: String
        var link: String
        var pubDate: String
        var location: String
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
        cell.set(viewModel: JobViewModel.CellData(title: job.title, author: job.author, link: job.link, pubDate: job.pubDate, location: job.location))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
