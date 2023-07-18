//
//  UIView+Ext.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 17/07/23.
//

import UIKit

public typealias Closure = () -> ()

class ClosureSleeve {
    let closure: Closure
    init(_ closure: @escaping Closure) {
        self.closure = closure
    }
    @objc func invoke() {
        closure()
    }
}

extension UIView {
    //Added uiview extension to addaction to uiview components
    public func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping Closure) {
        let sleeve = ClosureSleeve(closure)
        let gesture = UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
