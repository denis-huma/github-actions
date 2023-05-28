//
//  SignUpPresenter.swift
//  TDDUdemy
//
//  Created by Denis Yaremenko on 3/25/21.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
         view: SignUpViewDelegateProtocol)
    func processUserSignUp(formModel: SignUpFormModel)
}

class SignUpPresenter: SignUpPresenterProtocol {

    private var formModelValidator: SignUpModelValidatorProtocol
    private var webService: SignUpWebServiceProtocol
    private weak var view: SignUpViewDelegateProtocol?

    required init(formModelValidator: SignUpModelValidatorProtocol,
         webService: SignUpWebServiceProtocol,
        view: SignUpViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.view = view
    }

    func processUserSignUp(formModel: SignUpFormModel) {

        if !formModelValidator.isFirstNameValid(firstName: formModel.name) {
            self.view?.errorHandler(error: .invalidFirstName)
            return
        }

        if !formModelValidator.isLastNameValid(lastName: formModel.surname) {
            self.view?.errorHandler(error: .invalidLastName)
            return
        }

//        if !formModelValidator.isValidEmailFormat(email: formModel.email) {
//            self.view?.errorHandler(error: .invalidEmail)
//            return
//        }

//        if !formModelValidator.isPasswordValid(password: formModel.password) {
//            self.view?.errorHandler(error: .invalidPassword)
//            return
//        }

        if !formModelValidator.doPasswordsMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            self.view?.errorHandler(error: .passwordsDoNotMatch)
            return
        }

        let requestModel = SignupFormRequestModel.init(name: formModel.name, surname: formModel.surname, email: formModel.email, password: formModel.password)

        webService.signUp(withForm: requestModel) { [weak self] (response, error) in
            guard let self = self else { return }

            if let responseModel = response {
                self.view?.successfulSignup()
                return
            }

            if let responseError = error {
                self.view?.errorHandler(error: responseError)
                return
            }
        }
    }
}

