//
//  NetworkHelper.swift
//  Dummyapp
//
//  Created by G Yacobu on 26/02/26.
//

import Foundation

class NetworkHelper: NetworkHelperProtocol {
    
    func apiRequest<T: Decodable>(_ baseURL: String, path: String, headers: [String : String]?, method: HTTPMethod) async throws -> T  {
        
        guard let baseURL = URL(string: baseURL) else {
            throw NetworkError.invalidURL 
        }
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        components.path = path
        
        guard let finalUrl = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse , 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        }catch {
            throw NetworkError.decodingFailure
        }
 
    }   
    
    
    
    
}
