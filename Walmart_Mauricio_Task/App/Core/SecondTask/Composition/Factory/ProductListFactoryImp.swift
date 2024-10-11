//
//  ProductListFactoryImp.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import Foundation
import UIKit

protocol ProductListViewControllerFactory {
    func makeMapViewController(location: String) -> MapViewController
}

final class ProductListViewControllerFactoryImpl: ProductListViewControllerFactory {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func makeMapViewController(location: String) -> MapViewController {
        let viewModel = MapViewModel(location: location)
        return MapViewController(viewModel: viewModel)
    }
}



