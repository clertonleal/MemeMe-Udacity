//
//  MemeImageDetails.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 04/04/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit

class MemeImageDetailsViewController: UIViewController {
    
    @IBOutlet weak var memedImage: UIImageView!
    var meme: Meme?
    
    override func viewWillAppear(_ animated: Bool) {
        memedImage.image = meme?.memedImage
    }
    
}
