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
    private var audioSession: AVAudioSession!
    
    func setupAuadioProcessing() {
        
    }
    
    private func setupAudioSession() {
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setMode(.default)
            try audioSession.setActive(true)
        } catch {
            print("Audio session setup error: \(error)")
        }
    }
    
    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode
        outputNode = audioEngine.outputNode
        
        let inputFormat = inputNode.inputFormat(forBus: 0)
        let outputFormat = outputNode.inputFormat(forBus: 0)
        
        audioEngine.connect(inputNode, to: outputNode, format: inputFormat)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { (buffer, when) in
            self.outputNode.installTap(onBus: 0, bufferSize: 1024, format: outputFormat) { (buffer, when) in
                self.audioEngine.mainMixerNode.outputVolume = 1.0
            }
        }
        
        do {
            try audioEngine.start()
        } catch {
            print("Audio engine start error: \(error)")
        }
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
