//
//  SearchResultsProtocols.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

protocol SearchListInteractorInput {
    func fetchPhotosList(for searchRequest: String)
}


protocol SearchResultsListViewOutput: PhotosListViewOutput {
    func searchRequestDidChange(searchRequest: String)
}
