//
//  APIService.swift
//  foodly
//
//  Created by Sergei Kulagin on 24.11.2022.
//

import Foundation

struct APIService : APIServiceProtocol {
    
    var url = URLComponents(string: "http://193.108.114.190/")
    
    func getAccessToken(url: URLComponents?, completionHandler: @escaping(Result<Token, APIError>) -> Void) {
        
        guard var url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        url.path.append("api/")
        url.path.append("user")
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {

                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))

            } else if let data = data {
                let decoder = JSONDecoder( )
                do {
                    let response = try decoder.decode(Token.self, from: data)
//                    KeychainManager.saveToken(token: response.token)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getPopularProduct(url: URLComponents?, completionHandler: @escaping(Result<ShortProductResponse, APIError>)->Void) {
        
        guard var url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        url.path.append("api/")
        url.path.append("products/popular")
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue( "Bearer \(KeychainManager.getToken())", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder( )
                do {
                    let response = try decoder.decode(
                        ShortProductResponse.self, from: data)
                    print(response)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getHistoryProduct(url: URLComponents?, completionHandler: @escaping(Result<ShortProductResponse, APIError>)->Void) {
        
        guard var url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        url.path.append("api/")
        url.path.append("products/history")
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue( "Bearer \(KeychainManager.getToken())", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder( )
                do {
                    let response = try decoder.decode(
                        ShortProductResponse.self, from: data)
                    print(response)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getProduct(codeNumber: String, url: URLComponents?, completionHandler: @escaping(Result<ProductResponse, APIError>)->Void) {
        
        guard var url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        url.path.append("api/products/\(codeNumber)")
        
        var request = URLRequest(
            url: url.url!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue( "Bearer \(KeychainManager.getToken())", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder( )
                do {
                    print("\n data: \(data)")
                    let response = try decoder.decode(
                        ProductResponse.self, from: data)
                    print("\n after decode: \(response)")
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func getImage(url: String?, completionHandler: @escaping(Result<Foundation.Data, APIError>)->Void){
        
        guard let url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        var request = URLRequest(
            url: URL(string: url)!,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.setValue( "Bearer \(KeychainManager.getToken())", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in

            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
                
            } else if let data = data {
                do {
                    completionHandler(Result.success(data))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
