//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsPresentingViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    private var repos: [GithubRepo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Automatically resize table cells
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 105
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = repos?.count {
        return count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didSaveSettings(settings: GithubRepoSearchSettings){ // upon saving settings from searchsettingsVC, update searchsettings and do a search to update the tableview cells.
        searchSettings = settings
        doSearch()
    }
    
    func didCancelSettings(){
        // do nothing upon canceling settings view (return to previous state before going to settings view).
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! tableCell
        cell.repo = repos![indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // initialize the settings view controller to communicate with self, and have self's current settings.
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! SearchSettingsViewController
        vc.delegate = self
        vc.settings = searchSettings
    }
    
    // Perform the search.
    fileprivate func doSearch() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            // Store the returned newRepos into repos
            self.repos = newRepos
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
        }, error: { (error) -> Void in
            print(error!)
        })
    }
}


// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
