//
//  ApiServiceProtocol.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import Foundation
import Combine

protocol ApiManagerProtocol {
    func apiRequest<T: Decodable>(_ request: ApiRequest, responseType: T.Type) -> AnyPublisher<T, ApiNetworkError>
}
