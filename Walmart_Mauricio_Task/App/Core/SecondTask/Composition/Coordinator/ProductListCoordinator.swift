//
//  ProductListCoordinator.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func navigateToMapView(location: String)
}

final class ProductListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var viewControllerFactory: ProductListViewControllerFactory
    
    init(navigationController: UINavigationController, viewControllerFactory: ProductListViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start() {
        let productViewController = ProductListViewController()
        print("starting ProductListCoordinator")
        productViewController.coordinator = self
        navigationController.pushViewController(productViewController, animated: true)
    }
    
    func navigateToMapView(location: String) {
        let mapViewController = viewControllerFactory.makeMapViewController(location: location)
        navigationController.pushViewController(mapViewController, animated: true)
    }
}


