//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 28/03/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import Foundation
import UIKit

class MemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes = (UIApplication.shared.delegate as! AppDelegate).memes
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeTableViewCell
        
        let meme = self.memes[indexPath.row]
        cell.memeLable.text = "\(meme.topText) - \(meme.bottomText)"
        cell.memeImage.image = meme.memedImage
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeImageDetailsViewController") as! MemeImageDetailsViewController
        detailController.meme = memes[indexPath.row]
        
        self.navigationController!.present(detailController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        (UIApplication.shared.delegate as! AppDelegate).subscribeNewMemes(key: "MemesTableViewController", callback: { memes in
            self.memes = memes
            self.tableView.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as! AppDelegate).unsubscribeNewMemes(key: "MemesTableViewController")
    }
    
}
