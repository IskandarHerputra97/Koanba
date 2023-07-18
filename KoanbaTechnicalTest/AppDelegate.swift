//
//  AppDelegate.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppWireFrame()
        navigateToHome()
        return true
    }
    
    private func setupAppWireFrame() {
        let appWireFrame = AppWireFrame()
        NavigationManager.shared.navDelegate = appWireFrame
    }
    
    private func navigateToHome() {
        let firstScreen = HomeRouter.init().createModule()
        let nav = UINavigationController(rootViewController: firstScreen)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

