//
//  ParametersController.swift
//  Jober
//
//  Created by Denis Sychev on 02/05/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation

// Class Parameter is intended to describe data model that will be retrieved from storage (now from plist file)
class Parameter: Codable {
    
    class Value: Codable {
        let name: String
        var isSelected: Bool
        
        init(name: String, state: Bool) {
            self.name = name
            self.isSelected = state
        }
    }
    
    let name: String
    let key: String
    var values: [Value]
    
    init(name: String, key: String, values: [Value]) {
        self.name = name
        self.key = key
        self.values = values
    }
}

enum StoragePath: String {
    case defaultParameters = "Parameters"
    case storedParemeters = "StoredParameters"
    case fileExtension = "plist"
}

enum StorageError: Error {
    case noSuchFile
    case noDataInFile
    case fileIsEmpty
    case cantSaveToFile
}

// TODO: - Need to create protocol StorageController with functions: fetch(), save()

// FIXME: - Change name to PlistStorageController
struct StorageController {
    
    public func fetchParameters() -> [Parameter]? {
        guard let storedURL = URL.forPlist(.storedParemeters) else { return nil }
        guard let defaultURL = URL.forPlist(.defaultParameters) else { return nil }
        var plistData: Data = Data()
        do{
            plistData = try Data(contentsOf: storedURL)
        } catch {
            print(StorageError.noDataInFile.localizedDescription)
        }
        if plistData.isEmpty {
            do {
                plistData = try Data(contentsOf: defaultURL)
            } catch (let error) {
                print(error)
                print(StorageError.fileIsEmpty.localizedDescription)
            }
        }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Parameter].self, from: plistData)
    }
    
    public func save(parameters: [Parameter]) {
        guard let dataFileURL = URL.forPlist(.storedParemeters) else { return }
        
        let encoder = PropertyListEncoder()
        let plistData = try? encoder.encode(parameters)
        
        do {
            try plistData?.write(to: dataFileURL, options: .fileProtectionMask)
        } catch(let error) {
            print(error)
            print(StorageError.cantSaveToFile.localizedDescription)
        }
    }
}

extension URL {
    static func forPlist(_ name: StoragePath) -> URL? {
        var url: URL
        let fileManager = FileManager()
        guard let document = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return nil }
        url = document.appendingPathComponent(StoragePath.storedParemeters.rawValue).appendingPathExtension(StoragePath.fileExtension.rawValue)
        switch name {
        case .defaultParameters:
            return Bundle.main.url(forResource: StoragePath.defaultParameters.rawValue, withExtension: StoragePath.fileExtension.rawValue)
        case .storedParemeters:
            return url
        case .fileExtension:
            return nil
        }
    }
}


