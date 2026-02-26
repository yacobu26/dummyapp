//
//  LoginViewModel.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var isAlert: Bool = false
    @Published var prodcutsList: [Product] = []
    let network_Helper: NetworkHelperProtocol
    
    init(networkHelper: NetworkHelperProtocol) {
        network_Helper = networkHelper
    }
    
    
    func validateCredentials() throws {
        
        guard !username.isEmpty, !password.isEmpty else {
            throw LoginError.emptyFields
        }
        
        guard username.hasSuffix("@gmail.com") else {
            throw LoginError.invalidEmail
        }
        
        guard password.count >= 8 else {
            throw LoginError.weakPasscode
        }
 
    }
    
    
    func loginAPI() async throws {
        
        try validateCredentials()
        let product: TOPProduct = try await network_Helper.apiRequest(baseURL, path: path, headers: nil, method: .get)
        prodcutsList = product.products
    }
    
}

extension LoginViewModel: APIConfig {
    
    var baseURL: String {return "https://dummyjson.com"}
    
    var path: String {return "/products"}
    
    var headers: [String : String]? {nil}
    
    var method: HTTPMethod {.get}
}
