//
//  MoviesViewController.swift
//  FirstLook
//
//  Created by Andrew Ervin Gierke on 10/12/17.
//  Copyright © 2017 And. All rights reserved.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Dependency Injection
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var searches = [MovieSearchResults]()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        
    }
    
    //MARK: - Tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        let searchResult = searches[indexPath.row]
        cell.textLabel?.text = searchResult.searchTerm
        cell.detailTextLabel?.text = "\(searchResult)"
        return cell
    }
}

//MARK: - UISearchBar delegate
extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        
        guard let searchText = searchBar.text else { return }
        
        MovieAPI.searchForMovie(searchText) { [weak self] (result) in
            self?.searchBar.isHidden = false
            
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "API Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            case .success(let results):
                self?.searches.append(results)
                if let searches = self?.searches {
                    self?.tableView.insertRows(at: [IndexPath(row: searches.count-1, section: 0)], with: .top)
                }
            }
        }
    }
}
    
    
    
//MARK: - Navigation
    

