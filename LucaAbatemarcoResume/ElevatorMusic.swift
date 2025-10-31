//
//  ElevatorMusic.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//



import AVFoundation

class AudioVisualizer: ObservableObject {
    @Published var amplitude: Float = 0.0
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    func play(_ filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.isMeteringEnabled = true
            player?.play()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.player?.updateMeters()
                let avg = self.player?.averagePower(forChannel: 0) ?? -60
                let normalized = max(0, (avg + 60) / 60)
                DispatchQueue.main.async { self.amplitude = normalized }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

