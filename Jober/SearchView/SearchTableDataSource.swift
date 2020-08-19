//
//  SearchTableDataSource.swift
//  Jober
//
//  Created by Denis Sychev on 10/05/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

// Describes sections types for different parameters. Some cells in sections need to have different behaviors.
// tl, dl parameters have complex string. For example: tl=ios+php+java
enum Section: String {
    case visa = "v"
    case compensations = "e"
    case salary = "s"
    case techLike = "tl"
    case techDislike = "dl"
    case remote = "r"
    case distUnits = "u"
    case distance = "d"
    case location = "l"
    case experience = "ms"
    case role = "dr"
    case jobType = "j"
    case benefits = "b"
    case salaryCurrency = "c"
    case locationOpt = "t"
    
    func cellAccessoryType() -> UITableViewCell.AccessoryType {
        switch self {
        case .techDislike, .techLike:
            return .detailDisclosureButton
        default:
            return .checkmark
        }
    }
    
    func configure(cell: UITableViewCell) -> UITableViewCell {
        switch self {
        case .techLike, .techDislike:
            cell.accessoryType = .detailDisclosureButton
            cell.selectionStyle = .none
        default:
            cell.accessoryType = .checkmark
            cell.selectionStyle = .default
        }
        return cell
    }
    
    // TODO: - Method that returns count values for different section types
}

class SearchTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var networkService: NetworkService?
    var storageController: StorageController?

    var data: [Parameter] = []
    
    required init(with networkService: NetworkService) {
        super.init()
        self.networkService = networkService
        self.storageController = StorageController()
        self.takeData()
    }
    
    func takeData() {
        guard let parameters = storageController?.fetchParameters() else { return }
        self.data = parameters
    }
}

// MARK: - UITableViewDataSource
extension SearchTableDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let parameter = data[section]
        return parameter.values.count
     }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let parameter = data[section]
        return parameter.name
    }
    
    // TODO: - Need Refactoring
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let parameterType = data[indexPath.section]
        let parameter = parameterType.values[indexPath.row]
        cell.textLabel?.text = parameter.name
        guard let sectionType = Section(rawValue: parameterType.key) else {
            cell.accessoryType = .none
            return cell
        }
        cell = sectionType.configure(cell: cell)
        if parameter.isSelected {
            cell.accessoryType = sectionType.cellAccessoryType()
            networkService?.addParameter(withValue: parameter.name, forKey: parameterType.key)
        } else if sectionType == .techLike || sectionType == .techDislike {
            cell.accessoryType = sectionType.cellAccessoryType()
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // TODO: - Need Refactoring
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let parameterType = data[indexPath.section]
        let parameter = parameterType.values[indexPath.row]

        if cell?.accessoryType == UITableViewCell.AccessoryType.checkmark && parameter.isSelected {
            cell?.accessoryType = .none
            networkService?.removeParameter(withValue: parameter.name, forKey: parameterType.key)
            parameter.isSelected = false
            storageController?.save(parameters: data)
        } else {
            cell?.accessoryType = .checkmark
            networkService?.addParameter(withValue: parameter.name, forKey: parameterType.key)
            parameter.isSelected = true
            storageController?.save(parameters: data)
        }
    }
}


