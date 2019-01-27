//
//  InterestingResultsListPresenter.swift
//  Look!Image
//
//  Created  on 18/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class PhotosListPresenter: PhotosListViewOutput, PhotosListInteractorOutput {

    weak var view: PhotosListViewInput?
    var interactor: PhotosListInteractorInput!
    var shownPhotos: [ShortPhoto]?
    
    func viewIsReady() {
        interactor.fetchPhotosList()
        view?.showLoading()
    }

    func reloadResults() {
        interactor.fetchPhotosList()
    }
    
    func didFailToLoadResults() {
        view?.showNoResultsView()
    }
    
    func didLoadPhotosList(_ photos: [Photo]) {
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
