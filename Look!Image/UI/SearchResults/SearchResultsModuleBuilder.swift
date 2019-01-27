//
//  SearchResultsModuleBuilder.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class SearchResultsModuleInitializer: NSObject {
    @IBOutlet weak var viewController: SearchResultsController!
    
    override func awakeFromNib() {
        SearchResultsModuleBuilder().build(for: viewController)
    }
}


class SearchResultsModuleBuilder {
    
    func build(for viewController: SearchResultsController) {
        let searchPresenter = SearchResultsPresenter()
        let interactor = SearchResultsInteractor()
        let networkProvider = NetworkProvidersFactory().flickrNetworkProvider()
        interactor.networkProvider = networkProvider
        interactor.presenter = searchPresenter
        searchPresenter.view = viewController
        searchPresenter.interactor = interactor
        viewController.searchPresenter = searchPresenter
    }
}
