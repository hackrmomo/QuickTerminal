//
//  CustomWindowController.swift
//  QuickTerminal
//
//  Created by Mohammad Al-Ahdal on 2017-08-06.
//  Copyright © 2017 Mohammad Al-Ahdal. All rights reserved.
//

import Cocoa

class CustomWindowController: NSWindowController{
    var windowIsLoaded:Bool = false
    @IBOutlet var cwindow: CustomWindow!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.cwindow!.titleVisibility = .hidden
        self.cwindow!.titlebarAppearsTransparent = true
        self.cwindow!.styleMask.insert(.fullSizeContentView)
        self.cwindow!.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
        self.cwindow!.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
        self.cwindow!.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
        
        /*NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) {
            self.flagsChanged(with: $0)
            return $0
        }
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }*/
        //add dark/light mode
        
    }
}

class CustomWindow: NSWindow{
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        self.styleMask.insert(NSWindow.StyleMask.texturedBackground)
        self.isMovableByWindowBackground = true
    }
    
}
