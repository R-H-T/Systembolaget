//
//  SystembolagetClient.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 16/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

typealias CompletionHandler = ((_ success: Any?, _ error: NSError?)->())

class SystembolagetClient: NSObject {
    
    // MARK: - Properties
    
    var products: [Product]? = Product() // TODO: Create a model named Product?
    
    
    // MARK: - Methods
    
    func getProducts(completion: (()->())? = nil) {
        
        _getProducts { (data, error) in
            
            if error != nil {
                
                print(error?.localizedDescription ?? "Error unknown.")
                completion?()
                return
            }
            
            self.products = data
            completion?()
        }
    }
    
    /// Return a list of products with a completion handler (Private)
    fileprivate func _getProducts(completion: @escaping CompletionHandler) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: Constants.SAFE_URL) else {
            
            let error = NSError(domain: "SystembolagetClient.getProducts", code: 0, userInfo: ["Error" : "URL Returned Null. Failed to Proceed."]);
            
            completion(nil, error)
            
            return
        }
        
        // Create new request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a new task
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                
                // Handle Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                print("URL Session Task succeeded: HTTP \(statusCode)")
                
                guard let data = data else {
                    
                    let error = NSError(domain: "SystembolagetClient.getProducts", code: 2, userInfo: ["Error" : "Data returned Null. Failed to proceed."]);
                    
                    completion(nil, error)
                    
                    return
                }
                
                var document: SMXMLDocument? = nil
                
                do {
                    
                    document = try SMXMLDocument(data: data)
                    
                } catch let error as NSError {
                    
                    completion(data, error)
                }
                
                if let products = document?.childrenNamed("artikel") {
                    
                    
                    // TODO: Add a model for representing the Product
                    completion(products, nil)
                    
                    return
                    
                } else {
                    
                    completion(data, NSError(domain: "SystemBolaget.client", code: 3, userInfo: ["Error" : "Error fetching products from xml document."]))
                }
                
            } else {
                
                // Handle Failure
                let error = NSError(domain: "SystembolagetClient.getProducts", code: 1, userInfo: ["Error" : "URL Session Task Failed: \(error!.localizedDescription)"])
                
                print(error.localizedDescription)
                
                completion(nil, error)
            }
        })
        
        // Start task
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    // MARK: - Shared Instance
    
    class func shared() -> SystembolagetClient {
        
        struct Singleton {
            
            static let SharedInstance = SystembolagetClient()
        }
        
        return Singleton.SharedInstance
    }
}
