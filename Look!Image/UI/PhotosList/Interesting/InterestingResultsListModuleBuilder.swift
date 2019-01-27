//
//  SearchResultsLisModuleBuilder.swift
//  Look!Image
//
//  Created  on 20/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation

class InterestingViewModuleInitializer: NSObject {
    @IBOutlet weak var viewController: PhotosListController!
    
    override func awakeFromNib() {
        InterestingResultsListModuleBuilder().build(for: viewController)
    }
}


class InterestingResultsListModuleBuilder {
    
    func build(for viewController: PhotosListController) {
        let presenter = PhotosListPresenter()
        let interactor = InterestingResultsListInteractor()
        let networkProvider = NetworkProvidersFactory().flickrNetworkProvider()
        interactor.networkProvider = networkProvider
        interactor.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.presenter = presenter
    }
}
