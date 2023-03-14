//
//  APIServiceProtocol.swift
//  foodly
//
//  Created by Sergei Kulagin on 25.11.2022.
//

import Foundation

protocol APIServiceProtocol {
    
    func getAccessToken(url: URLComponents?, completionHandler: @escaping(Result<Token, APIError>) -> Void)
    
    func getProduct(codeNumber: String, url: URLComponents?, completionHandler: @escaping(Result<ProductResponse, APIError>)->Void)
    
    func getImage(url: String?, completionHandler: @escaping(Result<Foundation.Data, APIError>)->Void)
}
