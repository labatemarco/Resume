//
//  ProfessionaCarousel View.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 29/11/2025.
//

import SwiftUI

struct ProfessionCarousel: View {
    var myProfessions: [String]

    @State private var selectedProfessionIndex = 0
    
    // background timer reference
    @State private var timer: DispatchSourceTimer?
    
    var body: some View {
        TabView(selection: $selectedProfessionIndex) {
            ForEach(0..<myProfessions.count, id: \.self) { index in
                Text(myProfessions[index])
                    .font(.custom("Hiragino Sans", size: 12))
                    .foregroundColor(.cyan)
            }
        }
        .onAppear { startTimer() }
        .onDisappear { stopTimer() }
    }
    
    
    // MARK: - GCD Timer (Off Main Thread)
    func startTimer() {
        stopTimer() // prevent duplicates
        
        let t = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .utility))
        t.schedule(deadline: .now() + 2, repeating: 2)
        t.setEventHandler {
            DispatchQueue.main.async {
                withAnimation {
                    selectedProfessionIndex = (selectedProfessionIndex + 1) % myProfessions.count
                }
            }
        }
        t.resume()
        timer = t
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}



