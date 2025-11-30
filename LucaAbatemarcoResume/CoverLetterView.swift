//
//  CoverLetterView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 22/11/2025.
//
import SwiftUI

struct CoverLetterView: View {
    var body: some View {
        VStack {
            Text("Cover Letter").font(.headline)
            VStack(alignment: .leading, spacing: 16) {
                
                Text("""
            My career blends a scientific approach with real-world music production experience — from building custom macOS and iOS playback systems to running live shows for major touring artists. I’m excited by the opportunity to bring that perspective to your firm.
            """)
                .font(.caption)
                
                Text("""
            Before moving into playback engineering, I worked as a Jr. Process Engineer at a MEMS fabrication facility, specializing in optical metrology and contributing to high-performance MEMS used in modern semiconductor test systems. Since 2022, I’ve applied that same discipline to live music playback, designing and operating digital audio systems that must perform flawlessly under pressure.
            """)
                .font(.caption)
                
                Text("""
            Outside of touring, I’ve been building custom macOS and iOS applications directly related to my work in audio and my development as a software engineer. Recent projects include a Swift-based playback controller that integrates with Ableton Live via a Python backend and has been successfully show-tested, as well as a SwiftUI iOS companion app. I’m also developing an educational iOS app that visualizes data structures in real time using SwiftUI. Through these projects, I’ve deepened my understanding of Swift, SwiftUI, Core frameworks, unit testing, and production-quality Xcode development.
            """)
                .font(.caption)
                
                Text("""
            I’m ready to contribute to software development at scale and eager to bring my multidisciplinary background to your team.
            """)
                .font(.caption)
            }
            .padding(10)
            .foregroundStyle(.black)
            .frame(width: 350)
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.mix(with: .gray, by: 0.2).opacity(0.9))
                    .stroke(Color.gray, lineWidth: 1)
                
            )
            
        }
        .padding([.top], 10)
    }
}
