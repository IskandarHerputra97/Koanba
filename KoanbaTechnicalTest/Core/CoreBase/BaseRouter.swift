//
//  BaseRouter.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

open class BaseRouter {
    
    required public init() {}
    
    open func createModule(data: [String:Any]? = nil) -> BaseViewController {
        return BaseViewController()
    }
}
