//
//  HomeViewModel.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import Foundation
import UIKit

class HomeViewModel : ObservableObject {
    
    var popularProducts: Dynamic<[ShortProduct]> = Dynamic([ShortProduct]())
    var historyProducts: Dynamic<[ShortProduct]> = Dynamic([ShortProduct]())
    
    var isLoading: Dynamic<Bool?> = Dynamic(false)
    var errorMessage: Dynamic<String?> = Dynamic(String())
    
    func loadPopularData() {
        
        self.isLoading.value = true
        errorMessage.value = nil
        
        let service = APIService()
        service.getPopularProduct(url: service.url) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading.value = false
                switch result {
                case .failure(let error):
                    self.errorMessage.value = error.localizedDescription
    //                print(error.description)
                case .success(let productResponse):
//                    print("--- succes with \(productResponse.data!.count):\(productResponse.data!)")
                    self.popularProducts.value = productResponse.items
//                    self.composition.value = self.editText(description: list.composition!, supplements: list.supplements)
                }
            }
        }
    }
    
    func loadHistoryData() {
        
        self.isLoading.value = true
        errorMessage.value = nil
        
        let service = APIService()
        service.getHistoryProduct(url: service.url) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading.value = false
                switch result {
                case .failure(let error):
                    self.errorMessage.value = error.localizedDescription
    //                print(error.description)
                case .success(let productResponse):
//                    print("--- succes with \(productResponse.data!.count):\(productResponse.data!)")
                    self.historyProducts.value = productResponse.items
                    print(productResponse.items)
//                    self.composition.value = self.editText(description: list.composition!, supplements: list.supplements)
                }
            }
        }
    }
    
    func getImage(url: String?) -> UIImage {
        
        self.isLoading.value = true
        var image = UIImage()
        let service = APIService()
        service.getImage(url: url) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading.value = false
                switch result {
                case .failure(let error):
                    self.errorMessage.value = error.localizedDescription
                case .success(let data):
                    image = UIImage(data: data)!
                }
            }
        }
        return image
    }
}
