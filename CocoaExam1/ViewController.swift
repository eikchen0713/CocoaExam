//
//  ViewController.swift
//  CocoaExam1
//
//  Created by Eik Chen on 2017/9/26.
//  Copyright © 2017年 Eik Chen. All rights reserved.
//

import Cocoa
import ORSSerial

class ViewController: NSViewController , ViewControllerBDelegate , ORSSerialPortDelegate{
    func serialPortWasRemovedFromSystem(_ serialPort: ORSSerialPort) {
        self.serialPort = nil
    }
    

    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var BTN02: NSButton!
    @IBOutlet weak var TEXT01: NSTextField!
    @IBOutlet weak var BTN01: NSButton!
    
    var serialPort: ORSSerialPort? {
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier?._rawValue == "SecSegue"
        {
            (segue.destinationController as! NSViewController).representedObject = textLabel.stringValue
        
            if let viewControllerB = segue.destinationController as? SecView {
                viewControllerB.delegate = self
            }
        }
    }
    
    func updateText(text:String?)
    {
        textLabel.stringValue = text!
    }

    @IBAction func BTN01Press(_ sender: Any) {
        //TEXT01.stringValue = "Button 01 Press"
        //textView.insertText("BTN01 Press\n")
        //textView.textStorage?.append(NSAttributedString(string : "BTN01 Press\n"))
        
        //let cmd = "ls -l\n\r"
        var cmd = TEXT01.stringValue
        cmd = cmd + "\r"
        
        serialPort = ORSSerialPort(path: "/dev/cu.wchusbserial14110")
        serialPort?.baudRate = 115200
        serialPort?.parity = ORSSerialPortParity.none
        serialPort?.numberOfStopBits = 1
        
        serialPort?.open()
        usleep(50000)
        
        serialPort?.send(cmd.data(using: String.Encoding.ascii)!) // someData is an NSData object
        
        usleep(150000)
        serialPort?.close()
        
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            print(string)
            textView.textStorage?.append(NSAttributedString(string : string as String))
            textView.scrollToEndOfDocument(nil)
        }
    }
    
    func serialPort(_ serialPort: ORSSerialPort, didEncounterError error: Error) {
        print("SerialPort \(serialPort) encountered an error: \(error)")
    }
    
    @IBAction func BTN02Press(_ sender: Any) {
        TEXT01.stringValue = "Button 02 Press"
        //textView.insertText("BTN02 Press\n")
        textView.textStorage?.append(NSAttributedString(string : "BTN02 Press\n"))
    }
}

