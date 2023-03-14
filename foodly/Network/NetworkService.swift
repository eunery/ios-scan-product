//
//  NetworkService.swift
//  foodly
//
//  Created by Sergei Kulagin on 23.11.2022.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    var url = URLComponents(string: "http://193.108.114.190/api/products/")
    
    private init() { }
    
    func loadData<T:Codable>(request: URLRequest, resultType: T.Type, completionHandler:@escaping(_ result: T?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { [weak self]  (data, response, error) -> Void in
            if (error == nil && data != nil) {
                let response = try? JSONDecoder().decode(resultType.self, from: data!)
                print(response)
                _ = completionHandler(response)
            }
        }
        task.resume()
    }
    
    func api<T: Decodable>(_ type: T.Type, url: URLComponents?, urlPath: String?, completionHandler: @escaping(Result<T, APIError>)->Void) {
        
        guard var url = url else {
            let error = APIError.badURL
            completionHandler(Result.failure(error))
            return
        }
        
        if urlPath != nil {
            url.path.append(urlPath!)
        }
    
        let task = URLSession.shared.dataTask(with: (url.url)!) { (data, response, error) in

            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
                
            } else if let data = data {
                let decoder = JSONDecoder( )
                do {
            
                    let result = try decoder.decode(
                        type, from: data)
                    
                    completionHandler(Result.success(result))
                }catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
