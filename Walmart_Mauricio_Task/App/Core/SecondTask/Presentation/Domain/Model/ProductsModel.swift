//
//  ProductsModel.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//

struct Product: Codable {
    let id: String
    let name: String
    let price: String
    let stock: Int
    let imageUrl: String
    let location: String
    
    init(entity: ProductEntity) {
        self.id = entity.id ?? ""
        self.name = entity.name ?? ""
        self.imageUrl = entity.imageUrl ?? ""
        self.price = entity.price ?? ""
        self.location = entity.location ?? ""
        self.stock = Int(entity.stock)
    }
}



