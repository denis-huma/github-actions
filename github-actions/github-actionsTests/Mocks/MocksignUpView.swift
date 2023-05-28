//
//  MocksignUpView.swift
//  github-actionsTests
//
//  Created by Denis Yaremenko on 5/25/23.
//

import Foundation
import XCTest
@testable import github_actions

class MocksignUpView: SignUpViewDelegateProtocol {

    var expectation: XCTestExpectation?

    var successfulSignupCounter = 0
    var errorSignupCounter = 0

    var signupError: SignUpError?

    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }

    func errorHandler(error: SignUpError) {
        signupError = error
        errorSignupCounter += 1
        expectation?.fulfill()
    }
}

