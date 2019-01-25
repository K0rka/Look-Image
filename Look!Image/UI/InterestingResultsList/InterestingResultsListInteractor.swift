//
//  InterestingResultsListInteractor.swift
//  Look!Image
//
//  Created  on 18/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class InterestingResultsListInteractor: InterestingResultsListInteractorInput {    
    
    weak var presenter: InterestingResultsListInteractorOutput?
    
    var networkProvider: FlickrPhotosNetworkProvider!
    var searchCriteriaMapper: PhotosMapper!

    private var pageIndex = 0
    
    func fetchInteresting() {
        
        networkProvider.fetchInterestingPhotos {[weak self] (shortPhotos, error) in
            if let _ = error {
                self?.presenter?.didFailToLoadResults()
            } else if let photos = shortPhotos as? [Photo] {
                self?.presenter?.didLoadInterestingResults(photos)
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
