//
//  SignUpPresenterTests.swift
//  github-actionsTests
//
//  Created by Denis Yaremenko on 5/25/23.
//

import XCTest
@testable import github_actions

class SignUpPresenterTests: XCTestCase {

    var sut: SignUpPresenter!
    var signUpFormModel: SignUpFormModel!

    var mockSignUpModelValidator: MockSignUpModelValidator!
    var mockSignUpWebService: MockSignupWebService!
    var mocksignUpView: MocksignUpView!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        signUpFormModel = SignUpFormModel(name: "Den",
                                          surname: "Remen",
                                          email: "yaremdennis@gmail.com",
                                          password: "12345",
                                          repeatPassword: "12345")

        mockSignUpModelValidator = MockSignUpModelValidator()
        mockSignUpWebService = MockSignupWebService()
        mocksignUpView = MocksignUpView()

        sut = SignUpPresenter(formModelValidator: mockSignUpModelValidator,
                              webService: mockSignUpWebService,
                              view: mocksignUpView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signUpFormModel = nil
        mockSignUpModelValidator = nil
        mockSignUpWebService = nil
        mocksignUpView = nil
        sut = nil
    }

    func testSignUpPresenter_WhenInformationProvided_WillValidateEachProperty() {

        sut.processUserSignUp(formModel: signUpFormModel)

        XCTAssertTrue(mockSignUpModelValidator.isFirstNameValidated, "First name is not validated")
        XCTAssertTrue(mockSignUpModelValidator.isLastNameValidated, "Last name is not validated")
//        XCTAssertTrue(mockSignUpModelValidator.isEmailFormatValidated, "Email is not validated")
//        XCTAssertTrue(mockSignUpModelValidator.isPasswordValidated, "Password is not validated")
        XCTAssertTrue(mockSignUpModelValidator.isPasswordEqualityValidated, "Passwords do not match")
    }

    func testSignUpPresenter_WhenGivenValidFormModel_ShouldCallSignUpMethod() {
        sut.processUserSignUp(formModel: signUpFormModel)
        XCTAssertTrue(mockSignUpWebService.isSignupMethodCalled,
                      "The signUp() method was not called in the SignUpWebService class")
    }

    func testSignUpPresenter_WhenSignUpOperationSuccessful_CallsSuccessOnViewDelegate() {
        let successExpectation = expectation(description: "Expected the successfulSignUp() method to be called")

        mocksignUpView.expectation = successExpectation
        sut.processUserSignUp(formModel: signUpFormModel)
        self.wait(for: [successExpectation], timeout: 5.0)



        XCTAssertEqual(mocksignUpView.successfulSignupCounter, 1, "The successful signup() method was called more than one time")
    }

    func testSignUpPresenter_WhenSignUpOperationFails_ShouldCallErrorOnDelegate() {
        let errorExpectation = expectation(description: "Expected the errorHandler() method to be called")

        mocksignUpView.expectation = errorExpectation
        mockSignUpWebService.shouldReturnError = true
        sut.processUserSignUp(formModel: signUpFormModel)

        self.wait(for: [errorExpectation], timeout: 5.0)

        XCTAssertEqual(mocksignUpView.errorSignupCounter, 1)
        XCTAssertEqual(mocksignUpView.successfulSignupCounter, 0)
        XCTAssertNotNil(mocksignUpView.signupError)
    }
}

