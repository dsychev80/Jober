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
    var description: String { get }
    var link: String { get }
}

class JobCell: UITableViewCell {
    
    static let reuseID = "JobCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewModel: JobCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }

    
}
