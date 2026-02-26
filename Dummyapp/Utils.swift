//
//  Utils.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}


protocol APIConfig {
    var baseURL: String {get}
    var path: String {get}
    var headers: [String : String]? {get}
    var method: HTTPMethod {get}
}


protocol NetworkHelperProtocol {
    
    func apiRequest<T:Decodable>(_ baseURL: String,path: String, headers: [String:String]?, method: HTTPMethod) async throws -> T
}


enum LoginError: LocalizedError {
    case emptyFields
    case invalidEmail
    case weakPasscode
    
    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "Username and password cannot be empty"
        case .invalidEmail:
            return "Email must end with @gmail.com"
        case .weakPasscode:
            return "Password must be at least 8 characters"
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailure
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The provided URL is not valid"
        case .invalidResponse:
            return "The Server returned invalid response"
        case .decodingFailure:
            return "Failed to decode the response data"
        }
    }
}

enum Field {
    case email
    case password
}

