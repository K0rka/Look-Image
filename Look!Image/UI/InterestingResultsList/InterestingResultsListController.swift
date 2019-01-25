//
//  InterestingResultsListController.swift
//  Look!Image
//
//  Created  on 18/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit

class InterestingResultsListController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
InterestingResultsListViewInput {

    @IBOutlet weak var numberOfResultsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    var presenter: InterestingResultsListViewOutput!
    var interestingResults = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        presenter.viewIsReady()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestingResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath)
        
        if let cell = cell as? PhotoCell {
            cell.configure(with: interestingResults[indexPath.row])
        }
        
        return cell
    }
    
    
    func showLoading() {
        emptyView.isHidden = true
        loadingView.isHidden = false
        tableView.isHidden = true
    }
    
    func showNoResultsView() {
        emptyView.isHidden = false
        loadingView.isHidden = true
        tableView.isHidden = true
    }
    
    func showResults(_ photos: [Photo]) {
        emptyView.isHidden = true
        loadingView.isHidden = true
        tableView.isHidden = false
        interestingResults = photos
        tableView.reloadData()
    }
    
    func updatePhoto(index: Int, photoInfo: Photo) {
        interestingResults[index] = photoInfo
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}


