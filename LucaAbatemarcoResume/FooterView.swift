//
//  FooterView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 19/11/2025.
//

import SwiftUI

struct FooterView: View {
    @ObservedObject var song: AudioVisualizer
    @Binding var pageSelection: PageOptions
    
    
    var body: some View {
                
        HStack {
            Spacer().frame(width: 10)
            MusicSliderView(song: song)
            Button("", systemImage: "house") {
                if pageSelection != .home {
                    pageSelection = .home
                }
            }.labelStyle(.iconOnly)
            Button("", systemImage: "person.crop.circle") {
                if pageSelection != .contact {
                    pageSelection = .contact
                }
            }.labelStyle(.iconOnly)
            Button("", systemImage: "text.page.fill") {
                if pageSelection != .coverLetter {
                    pageSelection = .coverLetter
                }
            }.labelStyle(.iconOnly)
            Spacer()
        }
        .frame(height: 30)
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
    }
}
