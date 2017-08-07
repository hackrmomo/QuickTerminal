//
//  CustomWindowController.swift
//  QuickTerminal
//
//  Created by Mohammad Al-Ahdal on 2017-08-06.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Cocoa

class CustomWindowController: NSWindowController{
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window!.titleVisibility = .hidden
        self.window!.titlebarAppearsTransparent = true
        self.window!.styleMask.insert(.fullSizeContentView)
        self.window!.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
        self.window!.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
        self.window!.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
        self.window!.styleMask.remove(NSWindow.StyleMask.resizable)
        
        //add dark/light mode
        
    }
    
}
