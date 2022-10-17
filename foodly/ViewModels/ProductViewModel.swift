//
//  ProductViewModel.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.11.2022.
//

import Foundation
import UIKit

class ProductViewModel : ObservableObject {
    
    var products: Dynamic<[Product]> = Dynamic([Product]())
    var productImage: Dynamic<UIImage> = Dynamic(UIImage())
    var isLoading: Dynamic<Bool?> = Dynamic(false) 
    var errorMessage: Dynamic<String?> = Dynamic(String())
    
    func loadData(codeNumber: String) {
        
        self.isLoading.value = true
        errorMessage.value = nil
        
        let service = APIService()
        service.getProduct(codeNumber: codeNumber, url: service.url) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading.value = false
                switch result {
                case .failure(let error):
                    self.errorMessage.value = error.localizedDescription
    //                print(error.description)
                case .success(let productResponse):
//                    print("--- succes with \(productResponse.data!.count):\(productResponse.data!)")
                    self.products.value = productResponse.data!
                    getImage(url: productResponse.data![0].image)
//                    self.composition.value = self.editText(description: list.composition!, supplements: list.supplements)
                }
            }
        }
    }
    
    func getImage(url: String?){
        
        self.isLoading.value = true
        
        let service = APIService()
        service.getImage(url: url) { [unowned self] result in
            
            DispatchQueue.main.async {
                self.isLoading.value = false
                switch result {
                case .failure(let error):
                    self.errorMessage.value = error.localizedDescription
                case .success(let data):
                    self.productImage.value = UIImage(data: data)!
                }
            }
        }
    }
    
//    func editText(description: String?, supplements: [Supplements]) -> NSMutableAttributedString {
//        let string = NSMutableAttributedString()
//        
//        let textColor = [NSAttributedString.Key.foregroundColor: UIColor(named: "Background")]
//        let succesColor = [NSAttributedString.Key.backgroundColor: UIColor(named: "Success")]
//        let middleColor = [NSAttributedString.Key.backgroundColor: UIColor(named: "Tiger")]
//        let dangerousColor = [NSAttributedString.Key.backgroundColor: UIColor(named: "Chili400")]
//        
//        
//        let originalArray = description!.components(separatedBy: ",")
//        
//        let componentsArray = originalArray.map { $0.trimmingCharacters(in: .whitespaces) }
//        var temp = NSAttributedString()
//        temp = NSAttributedString(string: description!, attributes: succesColor)
//        string.append(temp)
//        for textComponent in componentsArray {
//            temp = NSAttributedString(string: textComponent)
//            for supplement in self.supplements.value {
//                if (textComponent == supplement.name || textComponent.elementsEqual(supplement.name!)) {
//                    if (supplement.data!.level <= 1){
//                        temp = NSAttributedString(string: textComponent, attributes: succesColor as [NSAttributedString.Key : Any])
//                    } else if (supplement.data!.level >= 4) {
//                        temp = NSAttributedString(string: textComponent, attributes: dangerousColor as [NSAttributedString.Key : Any])
//                    } else {
//                        temp = NSAttributedString(string: textComponent, attributes: middleColor as [NSAttributedString.Key : Any])
//                    }
//                }
//            }
//            string.append(temp)
//        }
//        
//        return string
//    }
    
//    static func errorState() -> ProductViewModel{
//        let productViewModel = ProductViewModel()
//        productViewModel.errorMessage.value = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
//        return productViewModel
//    }
//
//    static func successState() -> ProductViewModel {
//        let productViewModel = ProductViewModel()
//
//        return productViewModel
//    }
    
}
