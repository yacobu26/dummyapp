//
//  Product.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import Foundation
import SwiftData

struct TOPProduct: Codable {
   
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let title, description, category: String
    let price, discountPercentage,rating: Double
    let stock: Int
     
}


@Model
class ProductEntity {
    @Attribute(.unique)
    var title: String
    var category: String
    var descr: String
    var price: Double
    var rating: Double
    var discountPercentage: Double
    var stock: Int
    
    init(title: String, category: String, description: String, price: Double, rating: Double, discountPercentage: Double, stock: Int) {
        self.title = title
        self.category = category
        self.descr = description
        self.price = price
        self.rating = rating
        self.discountPercentage = discountPercentage
        self.stock = stock
    }
    
   
    
    
}


