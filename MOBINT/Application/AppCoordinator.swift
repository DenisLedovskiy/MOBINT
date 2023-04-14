//
//  AppCoordinator.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit

class AppCoordinator {

    var window: UIWindow?

    func start(_ scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        self.window?.overrideUserInterfaceStyle = .light
        mainScene()
    }

    func mainScene() {
        let module = MainViewController()
        window?.rootViewController = module
        window?.makeKeyAndVisible()
    }
}

