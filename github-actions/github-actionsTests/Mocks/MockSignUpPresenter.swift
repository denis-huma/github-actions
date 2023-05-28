//
//  MockSignUpPresenter.swift
//  TDDUdemyTests
//
//  Created by Denis Yaremenko on 3/29/21.
//

import Foundation
@testable import github_actions

class MockSignUpPresenter: SignUpPresenterProtocol {

    var processUserSignupCalled: Bool = false

    required init(formModelValidator: SignUpModelValidatorProtocol, webService: SignUpWebServiceProtocol, view: SignUpViewDelegateProtocol) {
    }

    func processUserSignUp(formModel: SignUpFormModel) {
        processUserSignupCalled = true
    }
}
