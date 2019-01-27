//
//  InterestingResultsListProtocols.swift
//  Look!Image
//
//  Created  on 20/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

protocol PhotosListInteractorOutput: class {
    func didLoadPhotosList(_ photos: [Photo])
    func didUpdatePhotoInfo(photo: Photo)
    func didFailToLoadResults()
}

protocol PhotosListInteractorInput {
    func fetchPhotosList()
}

protocol PhotosListViewInput: class {
    func showResults(_ flightSearchResults: [Photo])
    func updatePhoto(index: Int, photoInfo: Photo)
    func showNoResultsView() 
    func showLoading()
}

protocol PhotosListViewOutput {
    func viewIsReady()
}
