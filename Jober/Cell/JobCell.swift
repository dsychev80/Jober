//
//  JobCell.swift
//  Jober
//
//  Created by Denis Sychev on 23/04/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

protocol JobCellViewModel {
    var title: String { get }
    var author: String { get }
    var pubDate: String { get }
    var link: String { get }
    var location: String { get }
}

class JobCell: UITableViewCell {
    
    static let reuseID = "JobCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet weak var publicationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        selectionStyle = .none
    }
    
    func set(viewModel: JobCellViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        publicationLabel.text = viewModel.pubDate
        locationLabel.text = viewModel.location
    }
}
