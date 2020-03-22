//
//  ImageUtils.swift
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
