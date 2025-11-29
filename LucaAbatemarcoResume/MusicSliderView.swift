//
//  MusicSliderView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 28/11/2025.
//

import SwiftUI

struct MusicSliderView: View {
    @ObservedObject var song: AudioVisualizer
    
    
    var body: some View {
        HStack {

            // Mute button
            Button(action: { song.toggleMute() }) {
                Image(systemName: song.isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.system(size: 12))
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }

            // Volume slider
            Slider(
                value: Binding(
                    get: { Double(song.volume) },
                    set: { song.setVolume(Float($0)) }
                ),
                in: 0...1
            )
            .frame(width: 100)
            .scaleEffect(0.6, anchor: .leading)
        }
    }
}



