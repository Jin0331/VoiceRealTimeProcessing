//
//  VoiceRealTimeProcessingApp.swift
//  VoiceRealTimeProcessing
//
//  Created by JinwooLee on 7/11/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct VoiceRealTimeProcessingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: ContentFeature.State(), reducer: {
                ContentFeature()
            }))
        }
    }
}
