//
//  SearchResultsLisModuleBuilder.swift
//  Look!Image
//
//  Created  on 20/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit

class InterestingViewModuleInitializer: NSObject {
    @IBOutlet weak var viewController: InterestingResultsListController!
    
    override func awakeFromNib() {
        InterestingResultsListModuleBuilder().build(for: viewController)
    }
}


class InterestingResultsListModuleBuilder {
    
    func build(for viewController: InterestingResultsListController) {
        let presenter = InterestingResultsListPresenter()
        let interactor = InterestingResultsListInteractor()
        let networkProvider = NetworkProvidersFactory().flickrNetworkProvider()
        interactor.networkProvider = networkProvider
        interactor.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.presenter = presenter
    }
}
