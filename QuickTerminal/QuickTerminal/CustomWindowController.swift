//
//  CustomWindowController.swift
//  QuickTerminal
//
//  Created by Mohammad Al-Ahdal on 2017-08-06.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Cocoa

class CustomWindowController: NSWindowController{
    
    var alted:Bool = true
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window!.titleVisibility = .hidden
        self.window!.titlebarAppearsTransparent = true
        self.window!.styleMask.insert(.fullSizeContentView)
        self.window!.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
        self.window!.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
        self.window!.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
        
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
            self.flagsChanged(with: $0)
            return $0
        }
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
        //add dark/light mode
        
    }
    
    override func flagsChanged(with event: NSEvent) {
        switch event.modifierFlags.intersection(.deviceIndependentFlagsMask) {
        case NSEvent.ModifierFlags.option:
            self.alted = true
            break
        default:
            self.alted = false
            break
        }
    }
    override func keyDown(with event: NSEvent) {
        switch event.keyCode{
        case 0x31: //space
            if alted{
                //remove view
                self.window!.orderBack(self)
                self.close()
            }else if !alted{
                //Do nothing
            }
            break
        default:
            break
            //Do nothing
        }
    }
    
}
