//
//  RecentResultsListInteractor.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation


class RecentResultsListInteractor: PhotosListInteractorInput {
    
    weak var presenter: PhotosListInteractorOutput?
    
    var networkProvider: FlickrPhotosNetworkProvider!
    var searchCriteriaMapper: PhotosMapper!
    
    private var pageIndex = 0
    
    func fetchPhotosList() {
        
        networkProvider.fetchRecentPhotos {[weak self] (shortPhotos, error) in
            if let _ = error {
                self?.presenter?.didFailToLoadResults()
            } else if let photos = shortPhotos as? [Photo] {
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
