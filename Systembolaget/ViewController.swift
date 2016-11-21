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
    var filteredProducts = [Product]()
    let searchController = UISearchController(searchResultsController: nil)
    var restoredState = SearchControllerRestorableState()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBottomLayoutConstraint: NSLayoutConstraint!
    
    // MARK: Lazy Properties
    lazy var sharedManager: SystembolagetProductManager = {
        
        return SystembolagetProductManager.shared()
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        // Listen for change of download state
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.handleSystembolagetProductManagerStateChange(notification:)), name: Notification.Name.SystembolagetProductManagerChangedState, object: nil)
        
        getAllProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive {
            
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
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
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        self.searchController.searchBar.barStyle = .default
        self.searchController.searchBar.backgroundColor = myGreen
        self.searchController.searchBar.tintColor = .white
        self.searchController.searchBar.searchBarStyle = .default
        self.searchController.searchBar.placeholder = "Sök product..."
        self.searchController.searchBar.barTintColor = myGreen
        self.definesPresentationContext = true
    }
    
    func handleSystembolagetProductManagerStateChange(notification: Notification) {
        
        switch(self.sharedManager.downloadState) {
            
        case .active:
            
            print("Downloading new data...")
            
            DispatchQueue.main.async {
                
                self.activityIndicatorView.startAnimating()
            }
            
        case .idle:
            
            print("Download complete.")
            
            DispatchQueue.main.async {
                
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func getAllProducts(withForce flag: Bool = false) {
        
        if self.sharedManager.products?.count ?? 0 == 0 || flag {
            
            if flag {
                // Clear any existing products before repopulating data
                self.sharedManager.products = [Product]()
            }
            
            guard self.sharedManager.downloadState != .idle else {
                
                return
            }
            
            DispatchQueue.global(qos: .background).async {
                
                // Activity Start
                self.activityIndicatorView?.startAnimating()
                
                self.sharedManager.getProducts() {
                    
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
        
        return self.sharedManager.products?.count ?? 0
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
        
        // Coded segue
        if let product = (self.isSearching()) ? self.filteredProducts[indexPath.row] : self.sharedManager.products?[indexPath.row] {
            
            let detailViewController = DetailViewController.detailViewControllerForProduct(product: product)
            detailViewController.navigationItem.setLeftBarButton(UIBarButtonItem(customView: detailViewController.customBackButton), animated: true)
            detailViewController.navigationItem.titleView = detailViewController.customTitleButton
            detailViewController.navigationItem.setRightBarButton(UIBarButtonItem(customView: detailViewController.favoriteButton), animated: true)
            detailViewController.navigationItem.setHidesBackButton(true, animated: false)
            
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
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
            
            if let product = self.sharedManager.products?[indexPath.row] as Product? {
                
                cell.textLabel?.text = product.name ?? "N/A"
                
            } else {
                
                cell.textLabel?.text = "N/A"
            }
        }
        
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 22)
    }
}

// MARK: - UISearchController
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    // MARK: Search Results Updating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            
            searchFilter(contentFor: searchText)
        }
    }
    
    func searchFilter(contentFor searchText: String, within scope: String = "All") {
        
        if let products = self.sharedManager.products {
            
            self.filteredProducts = products.filter({ (product) -> Bool in
                
                return product.name?.localizedCaseInsensitiveContains(searchText.localizedLowercase) ?? false && product.name?.characters.first == searchText.characters.first
            })
            
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: Search Bar (Delegate)
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: Search Controller (Delegate)
    // --
    
    // MARK: Methods
    
    func isSearching() -> Bool {
        
        UIView.animate(withDuration: 0.45) {
            
            self.searchTopLayoutConstraint?.constant = (self.searchController.isActive) ? 0 : 55
            self.searchBottomLayoutConstraint?.constant = (self.searchController.isActive) ? 0 : 55
        }
        
        return self.searchController.isActive || self.searchController.searchBar.text?.characters.count != 0
    }
}

// MARK: - UIStateRestoration
extension ViewController {
    
    
    // MARK: Types
    
    struct SearchControllerRestorableState {
        
        var wasActive = false
        var wasFirstResponder = false
    }
    
    enum RestorationKeys: String {
        
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
        case filteredProducts
    }
    
    
    // MARK: Decoding / Encoding Restorable State
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        guard let decodedFilteredProducts = coder.decodeObject(forKey: RestorationKeys.filteredProducts.rawValue) as? [Product] else {
            
            return
        }
        
        filteredProducts = decodedFilteredProducts
        restoredState.wasActive = coder.decodeBool(forKey: RestorationKeys.searchControllerIsActive.rawValue)
        restoredState.wasFirstResponder = coder.decodeBool(forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        searchController.searchBar.text = coder.decodeObject(forKey: RestorationKeys.searchBarText.rawValue) as? String
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(filteredProducts, forKey: RestorationKeys.filteredProducts.rawValue)
        coder.encode(searchController.isActive, forKey: RestorationKeys.searchControllerIsActive.rawValue)
        coder.encode(searchController.searchBar.isFirstResponder, forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        coder.encode(searchController.searchBar.text, forKey: RestorationKeys.searchBarText.rawValue)
    }
}

// MARK: - Customize UINavigationControllers
extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}
