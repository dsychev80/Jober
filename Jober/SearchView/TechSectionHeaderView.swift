//
//  TechView.swift
//  Jober
//
//  Created by Denis Sychev on 12.06.2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class TechSectionHeaderView: UIView {
    
    lazy var textField: UITextField = {
        return UITextField(frame: CGRect(x: 20, y: 25, width: self.frame.width - 30, height: 20))
    }()
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel(frame: CGRect(x: 20, y: 5, width: self.frame.width, height: 20))
        headerTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        headerTitle.textAlignment = .left
        return headerTitle
    }()
    
    lazy var headerButton: UIButton = {
        let headerButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        headerButton.addTarget(self, action: #selector(headerTapped), for: .touchUpInside)
        return headerButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .brown
        addSubview(headerButton)
        addSubview(headerTitle)
        textField.backgroundColor = .white
    }
    
    @objc private func headerTapped() {
        print(#function)
    }
}
