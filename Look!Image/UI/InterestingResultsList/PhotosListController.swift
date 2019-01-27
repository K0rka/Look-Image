//
//  InterestingResultsListController.swift
//  Look!Image
//
//  Created  on 18/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit

class PhotosListController: UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
PhotosListViewInput {

    @IBOutlet weak var numberOfResultsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    var presenter: InterestingResultsListViewOutput!
    var interestingResults = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 180
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
    
    var selectedIndexPath: IndexPath?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "showPhotoDetails", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotoDetailController,
            let indexPAth = selectedIndexPath {
            controller.photoToShow = interestingResults[indexPAth.row]
            selectedIndexPath = nil
            
        }
    }
}


