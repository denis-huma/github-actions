//
//  SignUpWebServiceProtocol.swift
//  github-actions
//
//  Created by Denis Yaremenko on 5/25/23.
//

import Foundation

protocol SignUpWebServiceProtocol {
    func signUp(withForm formModel: SignupFormRequestModel, completion: @escaping (SignUpResponseModel?, SignUpError?) -> Void)
}

class SignUpWebService: SignUpWebServiceProtocol {

    private var urlString: String
    private var urlSession: URLSession

    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }

    func signUp(withForm formModel: SignupFormRequestModel, completion: @escaping (SignUpResponseModel?, SignUpError?) -> Void) {

        guard let url = URL(string: urlString) else {
            completion(nil, SignUpError.invalidRequestURLString)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        request.httpBody = try? JSONEncoder().encode(formModel)

        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in

            // if url request fails
            if let requestError = error {
                completion(nil, SignUpError.failedRequest(description: requestError.localizedDescription))
                return
            }

            if let data = data,
               let signupResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: data) {
                completion(signupResponseModel, nil)
            } else {
                completion(nil, SignUpError.invalidResponseModelParsing)
            }
        }

        dataTask.resume()
    }
}

