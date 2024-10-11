//
//  ProductListViewModel.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import Foundation
import Combine

final class ProductListViewModel: ObservableObject {
    
    private let repository: ProductRepository
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var products: [Product] = []
    var onProductsFetched: (() -> Void)?
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func fetchProducts() {
        isLoading = true
        
        let localProducts = repository.loadProductsFromCoreData()
        
        if localProducts.isEmpty {
            repository.fetchProducts { [weak self] result in
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.repository.saveProducts(products)
                    print("Productos cargados desde API")
                    self?.onProductsFetched?()
                case .failure(let error):
                    self?.error = error
                }
                
                self?.isLoading = false
            }
        } else {
            self.products = localProducts
            print("Productos cargados desde Core Data")
            self.onProductsFetched?()
            
            isLoading = false
        }
    }
    
    func loadProductsFromLocal() {
        self.products = repository.loadProductsFromCoreData()
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func getProduct(at index: Int) -> Product {
        return products[index]
    }
}
