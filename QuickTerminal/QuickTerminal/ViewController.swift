//
//  ViewController.swift
//  QuickTerminal
//
//  Created by Mohammad Al-Ahdal on 2017-08-06.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var inputField: CustomTextField!
    @IBOutlet weak var outputScrollView: NSScrollView!
    @IBOutlet var outputField: NSTextView!
    
    
    var shifted:Bool = false;
    
    override func viewDidAppear() {
        super.viewDidAppear()
        inputField.initialize()
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
            self.flagsChanged(with: $0)
            return $0
        }
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
        
    }
    
    @discardableResult
    func shell(_ args: String) -> (output: [String], error: [String], exitCode: Int32) {
        var output : [String] = []
        var error : [String] = []
        
        
        let task = Process()
        task.launchPath = "/usr/bin/env"
        let cmd = args.characters.split(separator: " ").map(String.init)
        task.arguments = cmd
        
        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe
        
        task.launch()
        
        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: outdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            output = string.components(separatedBy: "\n")
        }
        
        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: errdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            error = string.components(separatedBy: "\n")
        }
        
        task.waitUntilExit()
        let status = task.terminationStatus
        
        return (output, error, status)
    }
    
    func updateOutput(_ lastCommand: (output:[String], error:[String], exitCode: Int32)) {
        for str in lastCommand.output {
            if self.outputField.string == "" {
                self.outputField.string += str
            }else{
                self.outputField.string += "\n\(str)"
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x24: //return
            if shifted {
                //make new line?
            }else if !shifted {
                if self.inputField.stringValue == "clear"{
                    //erase it all
                    self.outputField.string = ""
                    self.inputField.stringValue = ""
                }else if self.inputField.stringValue == ""{
                    //do nothing
                }else{
                    let lastCommand = shell(self.inputField.stringValue)
                    self.inputField.stringValue = ""
                    //launchUpdate
                    updateOutput(lastCommand)
                    
                }
            }
            break
        default:
            break
            //Do nothing
        }
    }
    
    
    
    override func flagsChanged(with event: NSEvent) {
        //check for .shift and .option
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case NSEvent.ModifierFlags.shift:
            self.shifted = true
            break
        default:
            self.shifted = false
            break
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

class CustomTextField:NSTextField {
    
    func initialize() {
        //Do stuff
    }
    
}

