//
//  UIView + Ext.swift
//  Test_App
//
//  Created by Antony Razhnou on 12/15/22.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
    
    func removeSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.willRemoveSubview(i)
            i.removeFromSuperview()
        }
    }
    
    func fillSuperview(padding: UIEdgeInsets? = nil) {
        guard let superView = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: padding?.top ?? 0),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -(padding?.bottom ?? 0)),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding?.left ?? 0),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -(padding?.right ?? 0))
        ])
    }
}
