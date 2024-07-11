//
//  ContentView.swift
//  VoiceRealTimeProcessing
//
//  Created by JinwooLee on 7/11/24.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    
    let store : StoreOf<ContentFeature>
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView(store: Store(initialState: ContentFeature.State(), reducer: {
        ContentFeature()
    }))
}
