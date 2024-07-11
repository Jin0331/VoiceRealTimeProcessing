//
//  AudioProcessingManager.swift
//  VoiceRealTimeProcessing
//
//  Created by JinwooLee on 7/11/24.
//

import Foundation
import AVFoundation
import ComposableArchitecture

final class AudioProcessingManager {
    private var audioEngine: AVAudioEngine!
    private var inputNode: AVAudioInputNode!
    private var outputNode: AVAudioOutputNode!
    private var eqNode: AVAudioUnitEQ!
    private var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    func setupAuadioProcessing() {
        setupAudioSession()
        setupAudioEngine()
    }
    
    private func setupAudioSession() {
        do {
            try audioSession.setCategory(.playAndRecord, options: [.allowBluetooth, .defaultToSpeaker])
            try audioSession.setMode(.gameChat)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            // 핸드폰 내장 마이크로 고정
            if let availableInputs = audioSession.availableInputs {
                for input in availableInputs {
                    if input.portType == .builtInMic {
                        try audioSession.setPreferredInput(input)
                        print(input)
                        break
                    }
                }
            } else {
                print("???")
            }
            
            // 이어폰 출력 설정
            try audioSession.overrideOutputAudioPort(.none)
            
        } catch {
            print("Audio session setup error: \(error)")
        }
    }
    
    private func setupAudioEngine() {
        self.audioEngine = AVAudioEngine()
        
        guard let audioEngine = audioEngine else {
            print("Audio engine initialization failed")
            return
        }
        
        self.inputNode = audioEngine.inputNode
        self.outputNode = audioEngine.outputNode
        self.eqNode = AVAudioUnitEQ(numberOfBands: 10)
        
        guard let inputNode = inputNode, let outputNode = outputNode, let eqNode = eqNode else {
            print("Audio nodes initialization failed")
            return
        }
        
        for band in eqNode.bands {
            band.filterType = .parametric
            band.frequency = 1000.0 // 예제 주파수
            band.bandwidth = 1.0
            band.gain = 0.0
            band.bypass = false
        }
        
        let inputFormat = inputNode.inputFormat(forBus: 0)
        audioEngine.attach(eqNode)
        audioEngine.connect(inputNode, to: eqNode, format: inputFormat)
        audioEngine.connect(eqNode, to: audioEngine.mainMixerNode, format: inputFormat)
        audioEngine.connect(audioEngine.mainMixerNode, to: outputNode, format: inputFormat)
        
        audioEngine.mainMixerNode.outputVolume = 1.0
    }
    
    func startRecordingAndPlaying() {
        if !audioEngine.isRunning {
            do {
                try audioEngine.start()
            } catch {
                print("Audio engine start error: \(error)")
            }
        }
    }
    
    func stopRecordingAndPlaying() {
        audioEngine.stop()
    }
    
    func forceBuiltInMic() {
        do {
            // 핸드폰 내장 마이크로 고정
            if let availableInputs = audioSession.availableInputs {
                for input in availableInputs {
                    if input.portType == .builtInMic {
                        try audioSession.setPreferredInput(input)
                        break
                    }
                }
            }
        } catch {
            print("Error setting preferred input: \(error)")
        }
    }
}

private enum AudioProcessingManagerKey: DependencyKey {
    static var liveValue: AudioProcessingManager = AudioProcessingManager()
}

extension DependencyValues {
    var audioProcessingManager: AudioProcessingManager {
        get { self[AudioProcessingManagerKey.self] }
        set { self[AudioProcessingManagerKey.self] = newValue }
    }
}
