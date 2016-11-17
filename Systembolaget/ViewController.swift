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
    
    var lastSelectedIndexPath: IndexPath? = nil
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    let searchController = UISearchController(searchResultsController: nil)
    var filteredProducts = [Product]()
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    // MARK: Lazy Properties
    lazy var sharedClient: SystembolagetClient = {
        
        return SystembolagetClient.shared()
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        getAllProducts()
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailView" {
            
            if let indexPathRow = self.tableView.indexPathForSelectedRow?.row, let product = (isSearching()) ? self.filteredProducts[indexPathRow] : self.sharedClient.products?[indexPathRow] {
                
                let detailView = segue.destination as! DetailsViewController
                
                detailView.product = product
            }
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func backToMain(_ segue: UIStoryboardSegue) {
        // Unwind segue
    }
}


// MARK: - Methods
extension ViewController {
    
    func configure() {
        
        let myGreen = UIColor(red: 60/255, green: 160/255, blue: 30/255, alpha: 1.0)
        
        // Configure a Beautiful Table View
        self.tableView.delegate = self
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
        self.tableView.layer.borderColor = myGreen.cgColor
        self.tableView.layer.borderWidth = 3
        
        // Setup the Search Controller
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.tableView.tableHeaderView = searchController.searchBar
        self.searchController.searchBar.barStyle = .default
        self.searchController.searchBar.backgroundColor = myGreen
        self.searchController.searchBar.tintColor = .white
        self.searchController.searchBar.searchBarStyle = .prominent
        self.searchController.searchBar.placeholder = "Sök product..."
        self.searchController.searchBar.barTintColor = myGreen
        self.definesPresentationContext = true
    }
    
    func getAllProducts(withForce flag: Bool = false) {
        
        if self.sharedClient.products?.count ?? 0 == 0 || flag {
            
            if flag {
                // Clear any existing products before repopulating data
                self.sharedClient.products = [Product]()
            }
            
            DispatchQueue.global(qos: .background).async {
                
                // Activity Start
                self.activityIndicatorView?.startAnimating()
                
                self.sharedClient.getProducts() {
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        
                        // Activity End
                        self.activityIndicatorView?.stopAnimating()
                    }
                }
            }
            
        } else {
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate Methods & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isSearching() {
            
            return self.filteredProducts.count
        }
        
        return self.sharedClient.products?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        configure(cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.lastSelectedIndexPath = indexPath
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return true
    }
    
    // Configure Cell
    func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        
        if self.isSearching() {
            
            if let product = self.filteredProducts[indexPath.row] as Product? {
                
                cell.textLabel?.text = product.name ?? "N/A"
                
            } else {
                
                cell.textLabel?.text = "N/A"
            }
            
        } else {
            
            if let product = self.sharedClient.products?[indexPath.row] as Product? {
                
                cell.textLabel?.text = product.name ?? "N/A"
                
            } else {
                
                cell.textLabel?.text = "N/A"
            }
        }
        
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 22)
    }
}

// MARK: Search Controller Delegate
extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            
            searchFilter(contentFor: searchText)
        }
    }
    
    func searchFilter(contentFor searchText: String, within scope: String = "All") {
        
        if let products = self.sharedClient.products {
            
            self.filteredProducts = products.filter({ (product) -> Bool in
                
                return product.name?.localizedLowercase == searchText.localizedLowercase
            })
            
            self.tableView.reloadData()
        }
    }
    
    func isSearching() -> Bool {
        return self.searchController.isActive && self.searchController.searchBar.text?.isEmpty != true && self.searchController.searchBar.text != ""
    }
}
