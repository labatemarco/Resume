//
//  HeaderView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//

import SwiftUI

struct Header: View {
    
    @ObservedObject var song: AudioVisualizer
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Luca Abatemarco").font(.custom("Hiragino Sans", size: 20))
                        .foregroundColor(.cyan).padding(5).frame(height: 20)
                    HStack {
                        SmallAmplitudeVisualizer(visualizer: song)
                        ProfessionCarousel(myProfessions: ["Developer", "Audio Engineer", "Scientist"]).frame(width: 110, height: 5, alignment: .leading).baselineOffset(5)
                    }
                }
                Spacer()
                Link(destination: URL(string: "https://www.linkedin.com/in/luca-abatemarco/")!) {
                    Image("LI-In-Bug").resizable().frame(width: 35.27, height: 30)
                }
                Link(destination: URL(string: "https://github.com/labatemarco")!) {
                    Image("github-mark").resizable().frame(width: 35.27, height: 30)
                }
                Link(destination: URL(string: "https://www.cue2live.com")!) {
                    Image("cue2liveicon").resizable().frame(width: 35.27, height: 30)
                }
                
            }
        }
    }
}


