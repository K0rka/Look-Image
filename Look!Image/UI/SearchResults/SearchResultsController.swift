//
//  SearchResultsController.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit

class SearchResultsController: PhotosListController, UISearchBarDelegate {

    var searchPresenter: SearchResultsListViewOutput?
    
    @IBOutlet weak var tipView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if interestingResults.isEmpty {
            showTip()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    func showTip() {
        tipView.isHidden = false
        emptyView.isHidden = true
        loadingView.isHidden = true
        tableView.isHidden = true
    }
    
    override func showLoading() {
        tipView.isHidden = true
        super.showLoading()
    }
    
    override func showNoResultsView() {
        tipView.isHidden = true
        super.showNoResultsView()
    }
    
    override func showResults(_ photos: [Photo]) {
        tipView.isHidden = true
        super.showResults(photos)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchPresenter?.searchRequestDidChange(searchRequest: searchBar.text ?? "")

    }
}
