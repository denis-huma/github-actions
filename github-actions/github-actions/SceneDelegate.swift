//
//  SceneDelegate.swift
//  github-actions
//
//  Created by Denis Yaremenko on 5/20/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let wScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: wScene.coordinateSpace.bounds)
        window?.windowScene = wScene
        window?.makeKeyAndVisible()
        window?.rootViewController = SignUpViewController()
    }
}



sudo cp -R [folder path to be copied] [destination]

sudo cp -R /Users/denisyaremenko/Desktop/CICourses/CI/github-actions /Users/denisyaremenko/Desktop/CICourses/GithubActions
