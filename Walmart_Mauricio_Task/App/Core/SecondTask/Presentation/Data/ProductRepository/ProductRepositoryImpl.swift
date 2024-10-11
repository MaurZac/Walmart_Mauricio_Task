//
//  ProductRepositoryImpl.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//





import Foundation
import CoreData

protocol ProductRepository {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func saveProducts(_ products: [Product])
    func loadProductsFromCoreData() -> [Product]
}

final class ProductRepositoryImpl: ProductRepository {
    
    private let apiURL = "https://666beb7749dbc5d7145bc490.mockapi.io/apirecipes/v1/products"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: apiURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sin datos"])))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func saveProducts(_ products: [Product]) {
        let context = CoreDataManager.shared.context
        
        context.performAndWait {
            for product in products {
                let productEntity = ProductEntity(context: context)
                productEntity.id = product.id
                productEntity.name = product.name
                productEntity.price = product.price
                productEntity.stock = Int16(product.stock)
                productEntity.imageUrl = product.imageUrl
                productEntity.location = product.location
            }
            
            CoreDataManager.shared.saveContext()
        }
    }
    
    func loadProductsFromCoreData() -> [Product] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            let productEntities = try context.fetch(fetchRequest)
            return productEntities.map { productEntity in
                Product(entity: productEntity)
            }
        } catch {
            print("Fallo al obtener los productos desde Core Data: \(error)")
            return []
        }
    }
}
