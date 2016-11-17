//
//  DetailsViewController.swift
//  Systembolaget
//
//  Created by Roberth Hansson-Tornéus on 17/11/2016A.
//  Copyright © 2016 Roberth Hansson-Tornéus. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var product: Product? = Product()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: IBOutlets
    
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
        
        if let product = product {
            
            let sharedProducts = SystembolagetClient.shared().products
            
            if let _ = sharedProducts?.contains(product), let index = sharedProducts?.index(of: product), let isFavorite = sharedProducts?[index].isFavorite {
                
                SystembolagetClient.shared().products?[index].isFavorite = !(isFavorite)
                
                self.updateUI()
            }
        }
    }
}

// MARK: - Methods
extension DetailsViewController {
    
    func updateUI() {
        
        favoriteButton.isSelected = (product?.isFavorite ?? false) ? true : false //
        titleLabel.text = product?.name ?? "-"
        nameLabel.text = product?.name ?? "-"
        yearLabel.text = product?.fromYear ?? "-"
        priceLabel.text = product?.priceVATIncluded ?? "-"
        manufactureLabel.text = product?.manufacturer ?? "-"
        ecoLabel.text = (product?.ecological == "1") ? "Ja" : "Nej"
    }
}
