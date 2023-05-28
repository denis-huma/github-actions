//
//  SignUpViewDelegateProtocol.swift
//  github-actions
//
//  Created by Denis Yaremenko on 5/25/23.
//

import Foundation

protocol SignUpViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errorHandler(error: SignUpError)
}
