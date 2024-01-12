//
//  SignUpViewControllerTests.swift
//  TDDUdemyTests
//
//  Created by Denis Yaremenko on 3/29/21.
//

import XCTest
@testable import github_actions

class SignUpViewControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: SignUpViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignUpViewController") as? SignUpViewController

        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
    }

    func testSignUpViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut.userFirstNameTestField, "The first name textfield is not connected to an IBOutlet")

        XCTAssertEqual(firstNameTextField.text, "", "First name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(sut.userLastNameTestField.text, "", "Last name text field was not empty when the view controller initially loaded")
        XCTAssertEqual(sut.emailTestField.text, "", "Email text field was not empty when the view controller initially loaded")
        XCTAssertEqual(sut.passwordTestField.text, "", "Password text field was not empty when the view controller initially loaded")
        XCTAssertEqual(sut.repeatPasswordTestField.text, "", "Repeat password text field was not empty when the view controller initially loaded")
    }

    func testViewController_WhenCreated_HasSignUpButtonAndAction() throws {
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "SignUp button is not connected")

        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "Signup button does not have any actions assigned to it")

        XCTAssertEqual(signupButtonActions.count, 1)

        XCTAssertEqual(signupButtonActions.first, "signUpButtonTapped:", "There is no actions with a name signupButtonTapped assigned to signup button")
    }

    func testViewController_WhenSignUpButtonTapped_InvokesSignupProcess() {

        let mockSignUpModelValidator = MockSignUpModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignUpView = MocksignUpView()

        let mockSignUpPresenter = MockSignUpPresenter(formModelValidator: mockSignUpModelValidator, webService: mockSignupWebService, view: mockSignUpView)

        sut.signupPresenter = mockSignUpPresenter

        sut.signupButton.sendActions(for: .touchUpInside)

//        XCTAssertFalse(mockSignUpPresenter.processUserSignupCalled, "The processusersignup() method was not called on a Presenter object when the signup button was tapped in a signUpViewController")
    }
}
