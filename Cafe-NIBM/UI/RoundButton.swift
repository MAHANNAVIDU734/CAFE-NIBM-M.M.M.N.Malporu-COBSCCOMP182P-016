//
//  RoundButton.swift
//  Cafe-NIBM
//
//  Created by Mahan Navidu on 2021-03-07.
//
import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var padding: CGFloat=0.0{
        didSet{
            contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        self.layer.cornerRadius = bounds.size.height / 2
        return bounds
    }

}
