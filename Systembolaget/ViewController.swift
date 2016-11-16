//
//  ViewController.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 16/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    lazy var sharedClient: SystembolagetClient = {
        
        return SystembolagetClient.shared()
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Test Run
        getAllProducts()
    }
    
    
    // MARK: - Methods
    
    func getAllProducts(withForce flag: Bool = false) {
        
        if self.sharedClient.products?.count ?? 0 == 0 || flag {
            
            if flag {
                // Clear any existing products before repopulating data
                self.sharedClient.products = [Product]()
            }
            
            DispatchQueue.global(qos: .background).async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                self.sharedClient.getProducts() {
                    
                    DispatchQueue.main.async {
                        
                        print(self.sharedClient.products?[0].number ?? "nil")
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
        }
    }
}

