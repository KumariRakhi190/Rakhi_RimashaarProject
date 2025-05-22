//
//  TextFieldExtensions.swift
//  RakhiKumari_MachineRound
//
//  Created by Rakhi Kumari on 21/05/25.
//

import UIKit

extension UITextField {
    func setLeftRightPadding(left: CGFloat, right: CGFloat) {
        // Left padding
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = leftView
        self.leftViewMode = .always

        // Right padding
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
}
