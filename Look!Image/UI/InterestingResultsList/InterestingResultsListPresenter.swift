//
//  InterestingResultsListPresenter.swift
//  Look!Image
//
//  Created  on 18/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class InterestingResultsListPresenter: InterestingResultsListViewOutput, InterestingResultsListInteractorOutput {
    



    weak var view: InterestingResultsListViewInput?
    var interactor: InterestingResultsListInteractorInput!
    var shownPhotos: [ShortPhoto]?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd., EEE"
        return dateFormatter
    }()
    
    func viewIsReady() {
        interactor.fetchInteresting()
        view?.showLoading()
    }

    
    func didFailToLoadResults() {
        view?.showNoResultsView()
    }
    
    func didLoadInterestingResults(_ photos: [Photo]) {
        shownPhotos = photos
        if photos.isEmpty {
            view?.showNoResultsView()
        } else {
            view?.showResults(photos)
        }
    }
    
    func didUpdatePhotoInfo(photo: Photo) {
        if let index = shownPhotos?.firstIndex(where: { (shortPhoto) -> Bool in
            return photo.id == shortPhoto.id
        }) {
            self.view?.updatePhoto(index: index, photoInfo: photo)
        }
    }
    
    
}
