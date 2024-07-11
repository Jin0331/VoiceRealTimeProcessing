//
//  ContentFeature.swift
//  VoiceRealTimeProcessing
//
//  Created by JinwooLee on 7/11/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContentFeature {
    
    @ObservableState
    struct State : Equatable {
        let id = UUID()
        let isProcessing : Bool = false
    }
    
    enum Action {
        case voiceRecordButtonTapped
    }
    
    @Dependency(\.audioProcessingManager) var audioProcessingManager
    
    var body : some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case .voiceRecordButtonTapped:
                
                audioProcessingManager.setupAuadioProcessing()
                audioProcessingManager.startRecordingAndPlaying()
                
                return .none
                
            default :
                return .none
            }
            
        }
    }
}
