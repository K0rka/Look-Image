//
//  SearchResultsInteractor.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class SearchResultsInteractor: SearchListInteractorInput {
    
    weak var presenter: PhotosListInteractorOutput?
    
    var networkProvider: FlickrPhotosNetworkProvider!
    var searchCriteriaMapper: PhotosMapper!
    
    private var currentSearchRequest: String?
    
    func fetchPhotosList(for searchRequest: String) {
        currentSearchRequest = searchRequest
        guard searchRequest.count >= 3 else {
            return
        }
        networkProvider.fetchPhotos(searchText: searchRequest) { [weak self] (shortPhotos, error) in
            if let _ = error {
                self?.presenter?.didFailToLoadResults()
            } else if let photos = shortPhotos as? [Photo] {
                guard searchRequest == self?.currentSearchRequest else {
                    return
                }
                self?.presenter?.didLoadPhotosList(photos)
                photos.forEach({ (shortPhoto) in
                    self?.networkProvider.getPhoto(with: shortPhoto.id, completionBlock: {[weak self] (photo, error) in
                        if let photo = photo {
                            self?.presenter?.didUpdatePhotoInfo(photo: photo)
                        }
                    })
                })
            }
        }
    }
}
