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
    
    var products: [Product]? = [Product]()
    
    
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
                    
                    if let products = document?.childrenNamed("artikel") {
                        
                        var productDict: [String : Any]? = [:]
                        var newProducts: [Product] = [Product]()
                        
                        for product in products as! [SMXMLElement] {
                            
                            productDict?[Product.Keys.Number] = "\(product.value(withPath: Product.Keys.Number) ?? "N/A")"
                            productDict?[Product.Keys.ArticleID] = "\(product.value(withPath: Product.Keys.ArticleID) ?? "N/A")"
                            productDict?[Product.Keys.ProductNumber] = "\(product.value(withPath: Product.Keys.ProductNumber) ?? "N/A")"
                            productDict?[Product.Keys.Name] = "\(product.value(withPath: Product.Keys.Name) ?? "N/A")"
                            productDict?[Product.Keys.Name2] = "\(product.value(withPath: Product.Keys.Name2) ?? "N/A")"
                            productDict?[Product.Keys.PriceVATIncluded] = "\(product.value(withPath: Product.Keys.PriceVATIncluded) ?? "N/A")"
                            productDict?[Product.Keys.VolumeInML] = "\(product.value(withPath: Product.Keys.VolumeInML) ?? "N/A")"
                            productDict?[Product.Keys.PricePerLiter] = "\(product.value(withPath: Product.Keys.PricePerLiter) ?? "N/A")"
                            productDict?[Product.Keys.SoldSince] = "\(product.value(withPath: Product.Keys.SoldSince) ?? "N/A")"
                            productDict?[Product.Keys.Expired] = "\(product.value(withPath: Product.Keys.Expired) ?? "N/A")"
                            productDict?[Product.Keys.ProductGroup] = "\(product.value(withPath: Product.Keys.ProductGroup) ?? "N/A")"
                            productDict?[Product.Keys.TypeDesc] = "\(product.value(withPath: Product.Keys.TypeDesc) ?? "N/A")"
                            productDict?[Product.Keys.Style] = "\(product.value(withPath: Product.Keys.Style) ?? "N/A")"
                            productDict?[Product.Keys.Packaging] = "\(product.value(withPath: Product.Keys.Packaging) ?? "N/A")"
                            productDict?[Product.Keys.Seal] = "\(product.value(withPath: Product.Keys.Seal) ?? "N/A")"
                            productDict?[Product.Keys.Origin] = "\(product.value(withPath: Product.Keys.Origin) ?? "N/A")"
                            productDict?[Product.Keys.OriginCountryName] = "\(product.value(withPath: Product.Keys.OriginCountryName) ?? "N/A")"
                            productDict?[Product.Keys.Manufacturer] = "\(product.value(withPath: Product.Keys.Manufacturer) ?? "N/A")"
                            productDict?[Product.Keys.Provider] = "\(product.value(withPath: Product.Keys.Provider) ?? "N/A")"
                            productDict?[Product.Keys.FromYear] = "\(product.value(withPath: Product.Keys.FromYear) ?? "N/A")"
                            productDict?[Product.Keys.SampledYear] = "\(product.value(withPath: Product.Keys.SampledYear) ?? "N/A")"
                            productDict?[Product.Keys.AlchoholLevel] = "\(product.value(withPath: Product.Keys.AlchoholLevel) ?? "N/A")"
                            productDict?[Product.Keys.Supply] = "\(product.value(withPath: Product.Keys.Supply) ?? "N/A")"
                            productDict?[Product.Keys.SupplyText] = "\(product.value(withPath: Product.Keys.SupplyText) ?? "N/A")"
                            productDict?[Product.Keys.Ecological] = "\(product.value(withPath: Product.Keys.Ecological) ?? "N/A")"
                            productDict?[Product.Keys.Koscher] = "\(product.value(withPath: Product.Keys.Koscher) ?? "N/A")"
                            productDict?[Product.Keys.RawIngredientsDescription] = "\(product.value(withPath: Product.Keys.RawIngredientsDescription) ?? "N/A")"
                            
                            if let dictionary = productDict {
                                
                                let product = Product(with: dictionary)
                                
                                newProducts.append(product)
                            }
                            
                            productDict = [:]
                        }
                        
                        completion(newProducts, nil)
                        
                    } else {
                        
                        completion(nil, NSError(domain: "SystemBolaget.client", code: 3, userInfo: ["Error" : "Error fetching products from xml document."]))
                    }
                    
                } catch let error as NSError {
                    
                    completion(nil, error)
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
