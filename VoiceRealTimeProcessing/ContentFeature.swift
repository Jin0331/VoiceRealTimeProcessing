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
    }
    
    enum Action {
        
    }
    
    var body : some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            default :
                return .none
            }
            
        }
    }
}
