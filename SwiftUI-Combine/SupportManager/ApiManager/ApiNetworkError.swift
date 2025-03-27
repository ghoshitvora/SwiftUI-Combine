//
//  ApiNetworkError.swift
//  SwiftUI-Combine
//
//  Created by Ghoshit.
//

import Foundation

struct ApiNetworkError: Error, Decodable {
    let httpStatusCode: Int?
    let message: String?
}
