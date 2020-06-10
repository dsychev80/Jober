//
//  NetworkService.swift
//  Jober
//
//  Created by Denis Sychev on 30/03/2020.
//  Copyright © 2020 Denis Sychev. All rights reserved.
//

import Foundation
 	
class NetworkService {
    
    private struct StackoverflowJobsFeedAPI {
        static let jobsFeedURL = URL(string: "https://stackoverflow.com/jobs/feed")!
    }
    
    private var queryItems: [URLQueryItem] = []
    
    func addParameter(withValue value: String, forKey key: String) {
        let queryItem = URLQueryItem(name: key, value: value)
        if !queryItems.contains(queryItem) {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
    }
    
    func removeParameter(withValue value: String, forKey key: String) {
        let queryItem = URLQueryItem(name: key, value: value)
        if queryItems.contains(queryItem) {
            if let index = queryItems.firstIndex(of: queryItem) {
                queryItems.remove(at: index)
            }
        }
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
    
    func loadJobs(withCompletion completion: @escaping ([Item]?) -> Void) {
        let url = StackoverflowJobsFeedAPI.jobsFeedURL.appendingParameters(queryItems)
        load(url: url, withCompletion: { (data) in
            if let data = data {
                print(url)
                let items = JoberXMLParser(with: data)
                completion(items.returnItems())
            } else {
                print("no data")
            }
        })
    }
    
}

extension URL {
    func appendingParameters(_ parameters: [URLQueryItem]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = parameters
        return urlComponents.url!
    }
}

