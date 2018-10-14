//
//  ViewController.swift
//  MVVMSimple
//
//  Created by Zafer Kaban on 10/11/18.
//  Copyright © 2018 Zafer Kaban. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, MoviesViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel : MoviesViewModel?
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoviesViewModel()
        self.viewModel?.delegate = self
        self.tableView.dataSource = self
        setupSearchController()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MVVMSimpleCell", for: indexPath)
        let result = viewModel?.elementAtIndex(indexPath)
        cell.textLabel?.text = result?.title
        cell.detailTextLabel?.text = result?.year
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.elementCount()
    }
    
    func setupSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = "Search by movie name"
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
    }

    func searchResultRetrieved() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text, term.count > 4 {
            viewModel?.searchMovies(term)
        }
    }
}
