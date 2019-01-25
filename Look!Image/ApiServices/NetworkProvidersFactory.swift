//
//  NetworkProvidersFactory.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 25/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation


class NetworkProvidersFactory {
    
    
    let settings: NSDictionary? = {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "APIConstants", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
        }
        return nsDictionary
    } ()
    
    func flickrNetworkProvider() -> FlickrPhotosNetworkProvider {
        let baseUrl = settings?["BaseURL"] as? String ?? ""
        let apiKey = settings?["ApiKey"] as? String ?? ""
        let interestingPath = settings?["InterestingPath"] as? String ?? ""
        let searchPath = settings?["SearchPath"] as? String ?? ""
        let recentPath = settings?["RecentPath"] as? String ?? ""
        let photoInfoPath = settings?["PhotoPath"] as? String ?? ""
        let mapper = PhotosMapperImplementation()
        
        let provider = FlickrPhotosNetworkProviderImplementation(
            baseUrl: baseUrl,
            apiKey: apiKey,
            paths: ["searchPath": searchPath,
                    "interestingPath": interestingPath,
                    "recentPath": recentPath,
                    "photoInfoPath": photoInfoPath],
            mapper: mapper)
        
        return provider
    }
}
