//
//  RecentResultsListModuleBuilder.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 27/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation


class RecentResultsListModuleInitializer: NSObject {
    @IBOutlet weak var viewController: PhotosListController!
    
    override func awakeFromNib() {
        RecentResultsListModuleBuilder().build(for: viewController)
    }
}


class RecentResultsListModuleBuilder {
    
    func build(for viewController: PhotosListController) {
        let presenter = PhotosListPresenter()
        let interactor = RecentResultsListInteractor()
        let networkProvider = NetworkProvidersFactory().flickrNetworkProvider()
        interactor.networkProvider = networkProvider
        interactor.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.presenter = presenter
    }
}
