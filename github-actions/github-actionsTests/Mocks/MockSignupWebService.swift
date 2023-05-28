//
//  MockSignupWebService.swift
//  TDDUdemyTests
//
//  Created by Denis Yaremenko on 3/25/21.
//

import Foundation
@testable import github_actions

class MockSignupWebService: SignUpWebServiceProtocol {

    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false

    func signUp(withForm formModel: SignupFormRequestModel, completion: @escaping (SignUpResponseModel?, SignUpError?) -> Void) {
        isSignupMethodCalled = true

        guard shouldReturnError else {
            let responseModel = SignUpResponseModel(status: "Ok")
            completion(responseModel, nil)
            return
        }

        let error = SignUpError.failedRequest(description: "SignUp Request was not successful")
        completion(nil, error)

    }
}
