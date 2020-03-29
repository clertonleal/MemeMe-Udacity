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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = "\(meme.topText) - \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newMeme" {
            let viewController = segue.destination as! MemeCreatorViewController
            viewController.newItemResult = {
                self.memes = (UIApplication.shared.delegate as! AppDelegate).memes
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
//        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
