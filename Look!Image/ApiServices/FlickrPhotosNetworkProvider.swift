//
//  FlickrPhotosNetworkProvider.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 23/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

protocol FlickrPhotosNetworkProvider {
    func getPhoto(with id: String, completionBlock: @escaping (Photo?, Error?) -> Void)
    func fetchInterestingPhotos(completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void)
    func fetchRecentPhotos(completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void)
    func fetchPhotos(searchText: String, completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void)
}

class FlickrPhotosNetworkProviderImplementation: FlickrPhotosNetworkProvider {
    let apiKeyName = "api_key"
    let methodName = "method"

    private let baseUrl: String
    private let apiKey: String
    private let interestingPath: String
    private let searchPath: String
    private let recentPath: String
    private let photoInfoPath: String
    private let mapper: PhotosMapper
    

    
    init(baseUrl: String,
         apiKey: String,
         paths: [String: String],
         mapper: PhotosMapper) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.interestingPath = paths["interestingPath"] ?? ""
        self.searchPath = paths["searchPath"] ?? ""
        self.recentPath = paths["recentPath"] ?? ""
        self.photoInfoPath = paths["photoInfoPath"] ?? ""
        self.mapper = mapper
    }
    
    
    func fetchInterestingPhotos(completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void) {
        var parameters = [String: String] ()
        parameters[apiKeyName] = apiKey
        parameters[methodName] = interestingPath
        
        fetchPhotosList(parameters: parameters, completionBlock: completionBlock)
    }
    
    func fetchRecentPhotos(completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void) {
        var parameters = [String: String] ()
        parameters[apiKeyName] = apiKey
        parameters[methodName] = recentPath
        
        fetchPhotosList(parameters: parameters, completionBlock: completionBlock)

    }
    
    func fetchPhotos(searchText: String, completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void) {
        var parameters = [String: String] ()
        parameters[apiKeyName] = apiKey
        parameters[methodName] = searchPath
        parameters["text"] = searchText
        
        fetchPhotosList(parameters: parameters, completionBlock: completionBlock)

    }
    
    func getPhoto(with id: String, completionBlock: @escaping (Photo?, Error?) -> Void) {
        var parameters = [String: String] ()
        parameters[apiKeyName] = apiKey
        parameters[methodName] = photoInfoPath
        parameters["photo_id"] = id
        Alamofire.request(URL(string: baseUrl)!, method: .get, parameters: parameters).response {[weak self] (response) in
            if let data = response.data {
                let photo = self?.mapper.map(photoData: data)
                completionBlock(photo, nil)
            }
        }
    }
    
    private func fetchPhotosList(parameters: [String: String], completionBlock: @escaping ([ShortPhoto]?,  Error?) -> Void) {
        Alamofire.request(URL(string: baseUrl)!, method: .get, parameters: parameters).response { [weak self] (response) in
            if let data = response.data {
                let photos = self?.mapper.map(photosData: data)
                completionBlock(photos, nil)
            }
        }
    }
}

