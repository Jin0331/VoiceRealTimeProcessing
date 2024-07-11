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
        VStack(spacing : 25) {
            
            Text("실시간 음성 녹음 및 출력")
                .font(.title)
                .bold()
            
            Button {
                store.send(.voiceRecordButtonTapped)
            } label: {
                Image(systemName: "mic.and.signal.meter")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .tint(.black)
            }

            
        }
        .padding()
    }
}

#Preview {
    ContentView(store: Store(initialState: ContentFeature.State(), reducer: {
        ContentFeature()
    }))
}
