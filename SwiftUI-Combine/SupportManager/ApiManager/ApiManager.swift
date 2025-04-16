//
//  ApiManager.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import Foundation
import Combine

class ApiManager:ApiManagerProtocol {
    
    // MARK: - API Method
    
    func apiRequest<T: Decodable>(_ request: ApiRequest, responseType: T.Type) -> AnyPublisher<T, ApiNetworkError> {
        let urlRequest = self.createApiUrlRequestWithHeader(request: request)
        return performApiOperation(urlRequest, responseType)
    }
    
    // MARK: - Custom Method
    
    private func createApiUrlRequestWithHeader(request: ApiRequest) -> URLRequest {
        
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let requestBody = request.requestBody {
            urlRequest.httpBody = requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        }
        
          //Note: You can put comman authtication and header part here
//        if(authenticationToken != nil) {
//            urlRequest.setValue(authenticationToken!, forHTTPHeaderField: "authorization")
//        }
        
        return urlRequest
    }
    
    private func performApiOperation<T: Decodable>(_ requestUrl: URLRequest, _ responseType: T.Type) -> AnyPublisher<T, ApiNetworkError> {
        
        return URLSession.shared.dataTaskPublisher(for: requestUrl)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse else {
                    throw ApiNetworkError(httpStatusCode: 0, message: "Invalid Response")
                }
                
                let statusCode = response.statusCode
                debugPrint("📡 HTTP Status Code: \(statusCode)")
                
                guard (200...299).contains(statusCode) else {
                    throw ApiNetworkError(httpStatusCode: statusCode, message: "Request failed with status code \(statusCode)")
                }
                
                guard !result.data.isEmpty else {
                    throw ApiNetworkError(httpStatusCode: statusCode, message: "No data received from server")
                }
                
                return result.data
            }
            .decode(type: responseType, decoder: JSONDecoder())
            .mapError { error in
                return ApiNetworkError(httpStatusCode: 0, message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
}
