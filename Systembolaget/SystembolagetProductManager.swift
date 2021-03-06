//
//  SystembolagetProductManager.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 17/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

// MARK: - Files Support
fileprivate var _documentsDirectoryURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
fileprivate let _fileURL: URL = _documentsDirectoryURL.appendingPathComponent("Systembolaget-Context")

class SystembolagetProductManager: NSObject {
    
    
    // MARK - Properties
    
    var products: [Product]? = [Product]()
    var downloadState: DownloadState = .idle
    
    // MARK: - Types
    
    enum DownloadState: String {
        
        case active
        case idle
    }
    
    // MARK: - Initializers
    
    override init() {
        
    }
    
    
    // MARK: - Methods
    
    func getProducts(completion: (()->())? = nil) {
        
        
        // If products exists in store, we'll reuse that data
        if let products = SystembolagetProductManager.unarchiveProducts(), self.products?.count ?? 0 == 0 {
            
            self.products = products
            
            completion?()
            
            return
        }
        
        guard downloadState != .active else { return }
        
        setDownloadState(to: .active)
        
        // Fetch fresh data
        SystembolagetClient.shared().getProducts { (data, error) in
            
            // Remove any products in our collection to avoid duplicates (Add more logic to preserve favorites, if necessary)
            self.products = []
            
            if error != nil {
                
                print(error?.localizedDescription ?? "Error unknown.")
                
                self.setDownloadState(to: .idle)
                
                completion?()
                
                return
            }
            
            // Populate the products array
            self.products = data
            
            self.setDownloadState(to: .idle)
            completion?()
            
            // Persist fetched products
            self.save()
        }
    }
    
    private func setDownloadState(to state: DownloadState) {
        
        downloadState = state
        NotificationCenter.default.post(Notification(name: Notification.Name.SystembolagetProductManagerChangedState))
    }
    
    func save() {
        
        // If nothing exists, we'll do nothing
        guard let products = self.products else {
            return
        }
        
        NSKeyedArchiver.archiveRootObject(products, toFile: _fileURL.path)
    }
    
    class func unarchiveProducts() -> [Product]? {
        
        if FileManager.default.fileExists(atPath: _fileURL.path) {
            
            return NSKeyedUnarchiver.unarchiveObject(withFile: _fileURL.path) as? [Product]
            
        } else {
            
            return nil
        }
    }
    
    
    // MARK: - Shared Instance
    
    class func shared() -> SystembolagetProductManager {
        
        struct Singleton {
            
            static let SharedInstance = SystembolagetProductManager()
        }
        
        return Singleton.SharedInstance
    }
}


extension NSNotification.Name {
    
    static let SystembolagetProductManagerChangedState = Notification.Name(rawValue: "\(String(describing: SystembolagetProductManager.self))ChangedState")
}
