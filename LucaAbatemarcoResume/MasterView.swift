//
//  MasterView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 19/11/2025.
//

import SwiftUI

enum PageOptions {
    case home
    case contact
    case coverLetter
}


struct MasterView: View {
    @State var pageSelection: PageOptions = .home
    @StateObject var song = AudioVisualizer()
    
    
    var body: some View {
        ZStack {
            Image("resumeBackground").resizable()
            switch pageSelection {
            case .home:
                ResumeView()
            case .contact:
                ContactView()
            case .coverLetter:
                CoverLetterView()
            }
            VStack(alignment: .leading) {
                Header(song: song).shadow(radius: 20).padding()
                Spacer()
                VStack {
                    FooterView(song: song, pageSelection: $pageSelection)
                }
            }
        }
        .onAppear() {
            DispatchQueue.main.async() {
                song.play("ElevatorMusicTrack")
            }
        }
    }
}



