//
//  InterestingResultsListProtocols.swift
//  Look!Image
//
//  Created  on 20/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

protocol InterestingResultsListInteractorOutput: class {
    func didLoadInterestingResults(_ photos: [Photo])
    func didUpdatePhotoInfo(photo: Photo)
    func didFailToLoadResults()
}

protocol InterestingResultsListInteractorInput {
    func fetchInteresting()
}

protocol InterestingResultsListViewInput: class {
    func showResults(_ flightSearchResults: [Photo])
    func updatePhoto(index: Int, photoInfo: Photo)
    func showNoResultsView() 
    func showLoading()
}

protocol InterestingResultsListViewOutput {
    func viewIsReady()
}
