//
//  SystembolagetClient.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 16/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

typealias CompletionHandler = ((_ success: [Product]?, _ error: NSError?)->())

class SystembolagetClient: NSObject {
    
    // MARK: - Properties
    
    var products: [Product]? = [Product]() // TODO: Create a model named Product?
    
    
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
                    
                    completion(nil, error)
                }
                
                if let products = document?.childrenNamed("artikel") {
                    
                    var productDict: [String : Any]? = [:]
                    var newProducts: [Product]? = [Product]()
                    
                    for product in products {
                        
                        productDict?[Product.Keys.Number] = (product as AnyObject)[Product.Keys.Number] as? String
                        productDict?[Product.Keys.ArticleID] = (product as AnyObject)[Product.Keys.ArticleID] as? String
                        productDict?[Product.Keys.ProductNumber] = (product as AnyObject)[Product.Keys.ProductNumber] as? String
                        productDict?[Product.Keys.Name] = (product as AnyObject)[Product.Keys.Name] as? String
                        productDict?[Product.Keys.Name2] = (product as AnyObject)[Product.Keys.Name2] as? String
                        productDict?[Product.Keys.PriceVATIncluded] = (product as AnyObject)[Product.Keys.PriceVATIncluded] as? String
                        productDict?[Product.Keys.VolumeInML] = (product as AnyObject)[Product.Keys.VolumeInML] as? String
                        productDict?[Product.Keys.PricePerLiter] = (product as AnyObject)[Product.Keys.PricePerLiter] as? String
                        productDict?[Product.Keys.SoldSince] = (product as AnyObject)[Product.Keys.SoldSince] as? String
                        productDict?[Product.Keys.Expired] = (product as AnyObject)[Product.Keys.Expired] as? String
                        productDict?[Product.Keys.ProductGroup] = (product as AnyObject)[Product.Keys.ProductGroup] as? String
                        productDict?[Product.Keys.TypeDesc] = (product as AnyObject)[Product.Keys.TypeDesc] as? String
                        productDict?[Product.Keys.Style] = (product as AnyObject)[Product.Keys.Style] as? String
                        productDict?[Product.Keys.Packaging] = (product as AnyObject)[Product.Keys.Packaging] as? String
                        productDict?[Product.Keys.Seal] = (product as AnyObject)[Product.Keys.Seal] as? String
                        productDict?[Product.Keys.Origin] = (product as AnyObject)[Product.Keys.Origin] as? String
                        productDict?[Product.Keys.OriginCountryName] = (product as AnyObject)[Product.Keys.OriginCountryName] as? String
                        productDict?[Product.Keys.Manufacturer] = (product as AnyObject)[Product.Keys.Manufacturer] as? String
                        productDict?[Product.Keys.Provider] = (product as AnyObject)[Product.Keys.Provider] as? String
                        productDict?[Product.Keys.FromYear] = (product as AnyObject)[Product.Keys.FromYear] as? String
                        productDict?[Product.Keys.SampledYear] = (product as AnyObject)[Product.Keys.SampledYear] as? String
                        productDict?[Product.Keys.AlchoholLevel] = (product as AnyObject)[Product.Keys.AlchoholLevel] as? String
                        productDict?[Product.Keys.Supply] = (product as AnyObject)[Product.Keys.Supply] as? String
                        productDict?[Product.Keys.SupplyText] = (product as AnyObject)[Product.Keys.SupplyText] as? String
                        productDict?[Product.Keys.Ecological] = (product as AnyObject)[Product.Keys.Ecological] as? String
                        productDict?[Product.Keys.Koscher] = (product as AnyObject)[Product.Keys.Koscher] as? String
                        productDict?[Product.Keys.RawIngredientsDescription] = (product as AnyObject)[Product.Keys.RawIngredientsDescription] as? String
                        
                        if let dictionary = productDict {
                            
                            let product = Product(with: dictionary)
                            
                            newProducts?.append(product)
                        }
                        
                        productDict = [:]
                    }
                    
                    // TODO: Add a model for representing the Product
                    completion(newProducts, nil)
                    
                    return
                    
                } else {
                    
                    completion(nil, NSError(domain: "SystemBolaget.client", code: 3, userInfo: ["Error" : "Error fetching products from xml document."]))
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
