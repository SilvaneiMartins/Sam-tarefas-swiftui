//
//  SamNotesApp.swift
//  SamNotes
//
//  Created by Silvanei  Martins on 27/04/24.
//

import SwiftUI

@main
struct SamNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        #if os(macOS)
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}
