//
//  KeychainError.swift
//  foodly
//
//  Created by Sergei Kulagin on 20.12.2022.
//

import Foundation

enum KeychainError {
    case alreadySet
    case unexpectedData
    case unHandledError(status: OSStatus)
}
