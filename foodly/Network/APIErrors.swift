//
//  APIErrors.swift
//  foodly
//
//  Created by Sergei Kulagin on 25.11.2022.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        
        switch self {
        case .badURL, .parsing, .unknown:
            return "Something went wrong"
        case .badResponse(statusCode: _):
            return "not found"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
    
    var description: String {
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
            
        case .badResponse(statusCode: let statusCode):
            return "bad response \(statusCode)"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        }
    }
}
