//
//  ViewController.swift
//  QuickTerminal
//
//  Created by Mohammad Al-Ahdal on 2017-08-06.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var inputField: NSTextField!
    
    var shifted:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func shell(_ args: String) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        let cmd = args.characters.split(separator: " ").map(String.init)
        task.arguments = cmd
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x24:
            print("enter has been pressed")
            //Do the execution
            if shifted {
                print("NextLine")
            }else if !shifted {
                print("Run")
                shell(self.inputField.stringValue)
            }
            break
        default:
            break
            //Do nothing
        }
    }
    
    override func flagsChanged(with event: NSEvent) {
        //check for 56 or 60
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

