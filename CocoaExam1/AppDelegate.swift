//
//  AppDelegate.swift
//  CocoaExam1
//
//  Created by Eik Chen on 2017/9/26.
//  Copyright © 2017年 Eik Chen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func runTest1(_ sender: Any) {
        print("Run Test1")
    }
    
    @IBAction func runTest2(_ sender: Any) {
        print("Run Test2")
    }
    
    @IBAction func runAbout(_ sender: Any) {
        print("Run About")
    }
}

