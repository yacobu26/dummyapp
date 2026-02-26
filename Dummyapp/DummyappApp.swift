//
//  DummyappApp.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import SwiftUI
import SwiftData

@main
struct DummyappApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }.modelContainer(for: ProductEntity.self)
    }
}
