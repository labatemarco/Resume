//
//  ElevatorMusic.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//



import AVFoundation
import SwiftUI

class AudioVisualizer: ObservableObject {
    @Published var amplitude: Float = 0.0
    @Published var volume: Float = 0.6  // 0 -> 1 max
    @Published var isMuted: Bool = false
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    private var storedVolume: Float = 1.0
    
    var visualAmplitude: Float {
        return pow(amplitude, 0.9) * volume
    }

    
    func play(_ filename: String) {
        guard let url = Bundle.main.url(
            forResource: filename,
            withExtension: "wav"
        ) else {
            print("Audio file not found:", filename)
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.isMeteringEnabled = true
            player?.numberOfLoops = -1  // LOOP FOREVER
            player?.volume = 1.0
            self.volume = 0.6
            player?.prepareToPlay()
            player?.play()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.player?.updateMeters()
                let avg = self.player?.averagePower(forChannel: 0) ?? -60
                let normalized = max(0, (avg + 60) / 60)
                DispatchQueue.main.async { self.amplitude = normalized }
            }
        } catch {
            print("Error:", error)
        }
    }
    
    // MARK: - Volume & Mute
    
    func setVolume(_ newVolume: Float) {
        volume = newVolume
        if !isMuted {
            player?.volume = newVolume
        }
    }
    
    func toggleMute() {
        if isMuted {
            // UNMUTE
            isMuted = false
            player?.volume = storedVolume
        } else {
            // MUTE
            isMuted = true
            storedVolume = volume
            player?.volume = 0.0
        }
    }
}



struct SmallAmplitudeVisualizer: View {
    @ObservedObject var visualizer: AudioVisualizer
    
    let barCount = 12
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<barCount, id: \.self) { _ in
                let height = max(2,
                    CGFloat(visualizer.visualAmplitude) *
                    CGFloat.random(in: 8...25)
                )
                
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.cyan.opacity(0.8))
                    .frame(width: 2, height: height)
            }
        }
        .frame(height: 30)
        .animation(.smooth(duration: 0.20), value: visualizer.visualAmplitude)
    }
}

