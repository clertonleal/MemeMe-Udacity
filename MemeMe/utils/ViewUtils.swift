//
//  ViewUtils.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 21/03/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit

func generateScreenShot(view: UIView) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: view.frame.size)
    return renderer.image(actions: { context in
        view.layer.render(in: context.cgContext)
    })
}

func getTextFieldAttributes() -> [NSAttributedString.Key: Any] {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 42)!,
        NSAttributedString.Key.strokeWidth: -6.0,
        NSAttributedString.Key.paragraphStyle: paragraphStyle
    ]
    
    return memeTextAttributes
}
