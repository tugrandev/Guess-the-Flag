//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Tuğran on 22.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert: Bool = false
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please read this")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
