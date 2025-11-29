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
                        ProfessionCarousel(myProfessions: ["Developer", "Audio Engineer", "Scientist"]).padding([.top], 5).frame(height: 5).baselineOffset(2)
                    }
                }
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


struct ProfessionCarousel: View {
    
    var myProfessions: [String]
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    @State private var selectedProfessionIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedProfessionIndex) {
            ForEach(0..<myProfessions.count, id: \.self) {index in
                ZStack(alignment: .topLeading) {
                    Text(myProfessions[index]).font(.custom("Hiragino Sans", size: 12)).foregroundColor(.cyan)
                }
            }
        }
        .onReceive(timer) {_ in withAnimation(.default)
            {selectedProfessionIndex = (selectedProfessionIndex + 1) % myProfessions.count}
        }
    }
    
}

