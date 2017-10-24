//
//  SecView.swift
//  CocoaExam1
//
//  Created by Eik Chen on 2017/10/16.
//  Copyright © 2017年 Eik Chen. All rights reserved.
//

import Cocoa

protocol ViewControllerBDelegate{
    func updateText(text:String?)
}

class SecView: NSViewController {
    
    var delegate: ViewControllerBDelegate?
    
    @IBOutlet weak var SecBtn: NSButton!
    @IBOutlet weak var secTextView: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        secTextView.stringValue = (representedObject as! String)
    }
    @IBAction func secBtnPress(_ sender: Any) {
        delegate?.updateText(text: secTextView.stringValue)
        dismiss(nil)
    }
    
}
