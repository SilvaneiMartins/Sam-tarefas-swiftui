//
//  ContentView.swift
//  SamNotes
//
//  Created by Silvanei  Martins on 27/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .buttonStyle(BorderlessButtonStyle())
            .textFieldStyle(PlainTextFieldStyle())
    }
}

#Preview {
    ContentView()
}
