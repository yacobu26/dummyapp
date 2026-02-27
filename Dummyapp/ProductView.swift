//
//  ProductView.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import SwiftUI
import SwiftData

struct ProductView: View {
    @Query var products: [ProductEntity]
    @State private var searchText: String = ""
    
    var filteredProducts: [ProductEntity] {
        if searchText.isEmpty {
           return products
        }
        return products.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }    
    
    var body: some View {
        
        NavigationStack {
             
            List(filteredProducts) { product in 
                NavigationLink(destination: ProductDetailView(product: product)) {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(product.title)
                            .font(.headline)
                        
                        Text(product.descr)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("Price: $ \(product.price)")
                        Text("Rating: \(product.rating)")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                    .padding(.vertical, 8)
                    
                } 
            }
                
            .navigationTitle("Product_List")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search products...")
            
        
        }
        
    }
}

#Preview {
    ProductView()
}
