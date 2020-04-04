//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Clêrton Cunha Leal on 21/03/20.
//  Copyright © 2020 Clêrton Cunha Leal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var memes: [Meme] = []
    var memeAddedCallBacks: [String: ([Meme]) -> Void] = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func addNewMeme(newMeme: Meme) {
        memes.append(newMeme)
        memeAddedCallBacks.values.forEach({callback in callback(memes)})
    }
    
    func subscribeNewMemes(key: String, callback: @escaping ([Meme]) -> Void) {
        memeAddedCallBacks[key] = callback
        callback(memes)
    }

    func unsubscribeNewMemes(key: String) {
        memeAddedCallBacks.removeValue(forKey: key)
    }
}

