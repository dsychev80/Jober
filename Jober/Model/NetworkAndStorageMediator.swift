//
//  NetworkAndStorageMediator.swift
//  Jober
//
//  Created by Denis Sychev on 23.05.2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

class NetworkAndStorageMediator {
    public var parameters: [Parameter]?
    
    private var storageController: StorageController
    private var networkService: NetworkService
    
    init(with storageController: StorageController, and networkService: NetworkService) {
        self.storageController = storageController
        self.networkService = networkService
        
        self.parameters = self.storageController.fetchParameters()
        
    }
    
    func addStoredParameters() {
//        for parameterType in parameters {
//            for value in parameterType.values {
//                if value.isSelected {
//                    networkService.addParameter(withValue: value.name, forKey: parameterType.key)
//                }
//            }
//        }
    }
    
}
