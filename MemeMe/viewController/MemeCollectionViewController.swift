//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 29/03/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let flowLayout = UICollectionViewFlowLayout()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        
        cell.image.image = memes[indexPath.row].memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeImageDetailsViewController") as! MemeImageDetailsViewController
        detailController.meme = memes[indexPath.row]
        self.navigationController!.present(detailController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        (UIApplication.shared.delegate as! AppDelegate).subscribeNewMemes(key: "MemeCollectionViewController", callback: { memes in
            self.memes = memes
            self.collectionView.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as! AppDelegate).unsubscribeNewMemes(key: "MemeCollectionViewController")
    }

}

