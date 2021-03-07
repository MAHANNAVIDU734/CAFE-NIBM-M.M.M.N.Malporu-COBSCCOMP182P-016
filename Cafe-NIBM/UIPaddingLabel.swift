//
//  UIPaddingLabel.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//

import UIKit

@IBDesignable
class UIPaddingLabel: UILabel {
    @IBInspectable var padding:CGFloat = 0.0
    override func drawText(in rect: CGRect) {
        let paddingInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        super.drawText(in: rect.inset(by: paddingInset))
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 2 * padding,
                      height: size.height + 2 * padding)
    }

}
