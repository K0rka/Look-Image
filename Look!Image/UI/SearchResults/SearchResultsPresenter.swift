//
//  SearchResultsPresenter.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class SearchResultsPresenter: SearchResultsListViewOutput, PhotosListInteractorOutput {
    weak var view: PhotosListViewInput?
    var interactor: SearchListInteractorInput!
    var shownPhotos: [ShortPhoto]?
    
    func viewIsReady() {
        //We don't need to do anything here for now
    }
    
    func searchRequestDidChange(searchRequest: String) {
        interactor.fetchPhotosList(for: searchRequest)
        view?.showLoading()
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
