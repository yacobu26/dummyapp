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
    
    
    var body: some View {
        
        NavigationStack {
             
            List(products) { product in 
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
            
        
        }
    }
}

#Preview {
    ProductView()
}
