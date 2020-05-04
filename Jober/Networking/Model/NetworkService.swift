//
//  APIController.swift
//  Jober
//
//  Created by Denis Sychev on 30/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation
 	
// FIXME: Think about class name, it may need to change (NetworkController)
class NetworkService {
    struct StackoverflowJobsFeedAPI {
        static let jobsFeedURL = URL(string: "https://stackoverflow.com/jobs/feed")!
    }
    
    func load(url: URL, withCompletion completion: @escaping (Data?) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                completion(data)
            }
            
        })
        task.resume()
    }
    
    
    // TODO: Need to add to this function parameters withParameters with type [string: string]
    func loadJobs(withCompletion completion: @escaping ([Item]?) -> Void) {
        let parameters = ["dr":"QATestDeveloper", "v":"true"]
        let url = StackoverflowJobsFeedAPI.jobsFeedURL.appendingParameters(parameters)
        load(url: url, withCompletion: { (data) in
            if let data = data {
                print(url)
                let items = MyXMLParser(with: data)
                completion(items.returnItems())
            } else {
                print("no data")
            }
        })
    }
}

extension URL {
    func appendingParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

