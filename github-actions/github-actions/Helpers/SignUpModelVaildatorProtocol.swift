//
//  SignUpModelVaildatorProtocol.swift
//  github-actions
//
//  Created by Denis Yaremenko on 5/25/23.
//

import Foundation

protocol SignUpModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isValidEmailFormat(email: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool
}

class SignUpFormModelValidator: SignUpModelValidatorProtocol {

    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        if firstName.count < SignUpConstants.firstNameMinLenght || firstName.count > SignUpConstants.firstNameMaxLenght {
            returnValue = false
        }

        return returnValue
    }

    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        if lastName.count < SignUpConstants.firstNameMinLenght || lastName.count > SignUpConstants.firstNameMaxLenght {
            returnValue = false
        }

        return returnValue
    }

    func isValidEmailFormat(email: String) -> Bool {
        // see Lesson 27
        return NSPredicate(format: "SELF MATCHES %@","").evaluate(with: email)
    }

    func isPasswordValid(password: String) -> Bool {
        // see Lesson 27
        return NSPredicate(format: "SELF MATCHES %@", "").evaluate(with: password)
    }

    func doPasswordsMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
}
