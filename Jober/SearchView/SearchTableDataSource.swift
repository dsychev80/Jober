//
//  SearchTableDataSource.swift
//  Jober
//
//  Created by Denis Sychev on 10/05/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import UIKit

class SearchTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var networkService: NetworkService?
    var storageController: StorageController?

    var data: [Parameter] = []
    
    required init(with networkService: NetworkService) {
        self.networkService = networkService
        self.storageController = StorageController()
        guard let parameters = storageController?.fetchParameters() else { return }
        self.data = parameters
    }
}

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
        return parameter.key
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let parameterType = data[indexPath.section]
        let parameter = parameterType.values[indexPath.row]
        cell.textLabel?.text = parameter.name
        if parameter.isSelected {
            cell.accessoryType = .checkmark
            networkService?.addParameter(withValue: parameter.name, forKey: parameterType.key)
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
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
