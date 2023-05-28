//
//  SignUpFormRequestModel.swift
//  github-actions
//
//  Created by Denis Yaremenko on 5/25/23.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    var name: String
    var surname: String
    var email: String
    var password: String
}

struct SignUpResponseModel: Decodable {
    let status: String
}

enum SignUpError: LocalizedError, Equatable {

    case invalidResponseModelParsing
    case invalidRequestURLString
    case failedRequest(description: String)

    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch

    var errorDescription: String? {
        switch self {

        case .invalidResponseModelParsing, .invalidRequestURLString:
            return ""

        case .invalidFirstName:
            return "invalid first name"

        case .invalidLastName:
            return "invalid last name"

        case .invalidEmail:
            return "invalid email"

        case .invalidPassword:
            return "Invalid password"

        case .passwordsDoNotMatch:
            return "Password do not match"

        case .failedRequest(let description):
            return description
        }
    }
}



