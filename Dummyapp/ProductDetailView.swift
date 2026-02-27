//
//  ProductDetailView.swift
//  Dummyapp
//
//  Created by G Yacobu on 27/02/26.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(product.title)
                .font(.largeTitle)
            
            Text(product.descr)
                .font(.subheadline)
            Text("Price: \(product.price)")
            Text("Product Rating: \(product.rating)")
            
        }
        .padding()
        Spacer()
        .navigationTitle("Product Detail")
    }
}

