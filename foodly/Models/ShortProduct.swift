//
//  ShortPopular.swift
//  foodly
//
//  Created by Sergei Kulagin on 21.12.2022.
//

import Foundation

struct ShortProductResponse : Codable{
    var total: Int
    var isLastPage: Bool?
    var items: [ShortProduct]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        total = try values.decode(Int.self, forKey: .total)
        isLastPage = try values.decode(Bool?.self, forKey: .isLastPage)
        items = try values.decode([ShortProduct].self, forKey: .items)
        
    }
}

struct ShortProduct : Codable  {
    var barcode: Int
    var name: String
    var rating: Double
    var image: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        barcode = try values.decode(Int.self, forKey: .barcode)
        name = try values.decode(String.self, forKey: .name)
        rating = try values.decode(Double.self, forKey: .rating)
        image = try values.decode(String?.self, forKey: .image)
        
    }
}
