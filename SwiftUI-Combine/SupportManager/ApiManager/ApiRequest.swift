//
//  ApiRequest.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import Foundation

protocol Request {
    var url: URL { get set }
    var method: ApiHttpMethods { get set }
    var requestBody: Data? { get set }
    var parameters: [String: Any]? { get set }
}

struct ApiRequest {
    var url: URL
    var method: ApiHttpMethods
    var requestBody: Data?
    var parameters: [String: Any]?
    
    init(withUrl: URL, httpMethods: ApiHttpMethods, requestBody: Data? = nil, requestParameters: [String: Any]? = nil) {
        self.url = withUrl
        self.method = httpMethods
        self.requestBody = requestBody
        self.parameters = requestParameters
    }
}
