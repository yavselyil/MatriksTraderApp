//
//  MatriksTraderAppApp.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController()
            appCoordinator = AppCoordinator(navigationController: navigationController)
            appCoordinator?.start()

            window?.rootViewController = navigationController
            window?.backgroundColor = .white
            window?.makeKeyAndVisible()
        }
        return true
    }
}
