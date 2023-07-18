//
//  AppWireframe.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class AppWireFrame {
    init() { }
}

extension AppWireFrame: NavigationDelegate {
    func pushToPage(routerName: String, from: UIViewController, animated: Bool) {
        let classRouterType = NSClassFromString(routerName) as? BaseRouter.Type
        
        if let vc: BaseViewController = classRouterType?.init().createModule() {
            changePage(dest: vc,from: from, animated: animated)
        } else {
            print("Page not found")
        }
    }
    
    private func changePage(dest: UIViewController, from: UIViewController, animated: Bool, hideBottomBar: Bool = true) {
        dest.hidesBottomBarWhenPushed = hideBottomBar
        from.navigationController?.pushViewController(dest, animated: animated)
    }
    
    public func navigateToPageWithArgs(_ destination: String, from: UIViewController, data: [String : Any]) {
        let classRouterType = NSClassFromString(destination) as? BaseRouter.Type
        if let vc: BaseViewController = classRouterType?.init().createModule(data: data) {
            changePage(dest: vc, from: from, animated: true)
        } else {
            print("Page not found")
        }
    }
    
    public func popViewController(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = vc.navigationController else {
            vc.dismiss(animated: animated, completion: completion)
            return
        }
        
        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let completion = completion {
                    completion()
                }
            }
        } else {
            navigationController.dismiss(animated: animated, completion: completion)
        }
    }
}
