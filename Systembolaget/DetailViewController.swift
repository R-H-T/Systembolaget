//
//  DetailViewController.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 17/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var product: Product? = Product()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var indexOfProduct: Int? {
        
        if let product = self.product {
            
            return SystembolagetProductManager.shared().products?.index(of: product)
            
        } else {
            
            return nil
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var customBackButton: UIButton!
    @IBOutlet weak var customTitleButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var manufactureLabel: UILabel!
    @IBOutlet weak var ecoLabel: UILabel!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUI()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func toggleLikeAction(_ sender: UIButton) {
        
        if let product = self.product {
            
            self.product?.isFavorite = !(product.isFavorite)
            
            // Update the UI first, thus giving the user instant visual feedback before we actually do the real magic behind the scenes
            self.updateUI()
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                if let index = self.indexOfProduct, let updatedProduct = self.product {
                    
                    // Replace the outdated product with the new one
                    SystembolagetProductManager.shared().products?[index] = updatedProduct
                    
                    // Persist any changes
                    SystembolagetProductManager.shared().save()
                    
                    DispatchQueue.main.async {
                        
                        // Update UI a second time
                        self.updateUI()
                    }
                }
            }
        }
    }
}

// MARK: - Methods
extension DetailViewController {
    
    func updateUI() {
        
        let name = product?.name ?? "-"
        favoriteButton.isSelected = (product?.isFavorite ?? false) ? true : false
        // titleLabel.text = name
        nameLabel.text = name
        customTitleButton.setTitle(name, for: .normal)
        yearLabel.text = (product?.fromYear != "N/A") ? (product?.fromYear ?? "-") : "-"
        priceLabel.text = (product?.priceVATIncluded != "N/A") ? (product?.priceVATIncluded ?? "-") : "-"
        manufactureLabel.text = (product?.manufacturer != "N/A") ? (product?.manufacturer ?? "-") : "-"
        ecoLabel.text = (product?.ecological == "1") ? "Ja" : "Nej"
    }
}

// MARK: - Initialization
extension DetailViewController {
    
    static var storyboardName: String { return "Main" }
    static var viewControllerIdentifier: String { return String(describing: DetailViewController.self) }
    
    class func detailViewControllerForProduct(product: Product) -> DetailViewController {
        
        let storyboard = UIStoryboard(name: DetailViewController.storyboardName, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailViewController.viewControllerIdentifier) as! DetailViewController
        
        viewController.product = product
        
        return viewController
    }
}
