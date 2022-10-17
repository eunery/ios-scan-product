//
//  Product.swift
//  foodly
//
//  Created by Sergei Kulagin on 23.11.2022.
//

import Foundation

struct ProductResponse: Codable {
    let message: String?
    let data: [Product]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try? values.decode(String?.self, forKey: .message)
        data = try? values.decode([Product]?.self, forKey: .data)
    }
}

struct Product: Codable {
    let barcode: Int
    let name: String?
    let rating: Double?
    let composition: String?
    let image: String
    let isPerishable: Bool
    let supplements: [Supplements]?
    let allergens: [Allergens]?
    let rskrf: Rskrf?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        barcode = try values.decode(Int.self, forKey: .barcode)
        name = try values.decode(String?.self, forKey: .name)
        rating = try values.decode(Double?.self, forKey: .rating)
        composition = try values.decode(String?.self, forKey: .composition)
        image = try values.decode(String.self, forKey: .image)
        isPerishable = try values.decode(Bool.self, forKey: .isPerishable)
        supplements = try? values.decode([Supplements]?.self, forKey: .supplements)
        allergens = try? values.decode([Allergens]?.self, forKey: .allergens)
        rskrf = try values.decode(Rskrf?.self, forKey: .rskrf)
    }
}

struct Supplements: Codable {
    let name: String?
    let offset: Int?
    let length: Int?
    let data: Data?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String?.self, forKey: .name)
        offset = try values.decode(Int?.self, forKey: .offset)
        length = try values.decode(Int?.self, forKey: .length)
        data = try? values.decode(Data?.self, forKey: .data)
        
    }
}

struct Allergens: Codable {
    let name: String?
    let ruName: String?
    let status: Bool?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String?.self, forKey: .name)
        ruName = try values.decode(String?.self, forKey: .ruName)
        status = try values.decode(Bool?.self, forKey: .status)
    }
}

struct Data: Codable {
    let level: Int
    let id: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        level = try values.decode(Int.self, forKey: .level)
        id = try values.decode(Int.self, forKey: .id)
    }
}

struct Rskrf: Codable {
    let link: String
    let rating: Double
    let is_intruder: Bool
    let research_date: Int?
    let info: [Info]?
    let research: [Research]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        link = try values.decode(String.self, forKey: .link)
        rating = try values.decode(Double.self, forKey: .rating)
        is_intruder = try values.decode(Bool.self, forKey: .is_intruder)
        research_date = try values.decode(Int?.self, forKey: .research_date)
        info = try values.decode([Info]?.self, forKey: .info)
        research = try values.decode([Research]?.self, forKey: .research)
    }
}

struct Info: Codable {
    let type: String
    let value: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try values.decode(String.self, forKey: .type)
        value = try values.decode(String.self, forKey: .value)
        
    }
}

struct Research: Codable {
    let name: String
    let value: Double
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        value = try values.decode(Double.self, forKey: .value)
    }
}
