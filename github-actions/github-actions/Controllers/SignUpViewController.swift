//
//  ViewController.swift
//  TDDUdemy
//
//  Created by Denis Yaremenko on 3/18/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userFirstNameTestField: UITextField!
    @IBOutlet weak var userLastNameTestField: UITextField!
    @IBOutlet weak var emailTestField: UITextField!
    @IBOutlet weak var passwordTestField: UITextField!
    @IBOutlet weak var repeatPasswordTestField: UITextField!
    @IBOutlet weak var signupButton: UIButton!

    var signupPresenter: SignUpPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

//        #if DEBUG
//        if CommandLine.arguments.contains("-skipSurvey") {
//            print("Skipping survey page")
//        }
//        #endif
//
//        // Another way for getting arguments
//        // Process Info contains much more functionality and it is more advanced
//        #if DEBUG
//        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
//            print("Skipping survey page")
//        }
//        #endif

        if signupPresenter == nil {
            let signUpModelValidator = SignUpFormModelValidator()

            // see UITest File

            let sugnUpUrl = ProcessInfo.processInfo.environment["signUpUrl"]
                ?? SignUpConstants.pathURLString

            let webService = SignUpWebService(urlString: sugnUpUrl)

            signupPresenter = SignUpPresenter(formModelValidator: signUpModelValidator, webService: webService, view: self)
        }
    }

    //MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let signupFormModel = SignUpFormModel(name: userFirstNameTestField.text ?? "", surname: userLastNameTestField.text ?? "", email: emailTestField.text ?? "", password: passwordTestField.text ?? "", repeatPassword: repeatPasswordTestField.text ?? "")

        signupPresenter?.processUserSignUp(formModel: signupFormModel)
    }

    @IBAction func openButtonTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        guard let sut = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else { return }
//        sut.view.accessibilityIdentifier = "SecondViewController"
//        present(sut, animated: false, completion: nil)
    }
}

extension SignUpViewController: SignUpViewDelegateProtocol {
    func successfulSignup() {
        let alert = UIAlertController.init(title: "Success", message: "The sign up operation was successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))

        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }

    func errorHandler(error: SignUpError) {
        let alert = UIAlertController.init(title: "Error",
                                           message: "\(error.errorDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))

        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }
}

