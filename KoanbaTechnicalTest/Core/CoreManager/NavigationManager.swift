//
//  NavigationManager.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

struct NavigationDestination {
    public static var home = NSStringFromClass(HomeRouter.self)
    public static var detail = NSStringFromClass(DetailRouter.self)
}

protocol NavigationDelegate {
    func pushToPage(routerName: String, from: UIViewController, animated: Bool)
    func navigateToPageWithArgs(_ destination: String, from: UIViewController, data: [String : Any])
    func popViewController(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?)
}

class NavigationManager {
    static var shared = NavigationManager()
    var navDelegate: NavigationDelegate?
}
