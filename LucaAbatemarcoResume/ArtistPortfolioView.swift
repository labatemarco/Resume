//
//  ArtistPortfolioView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//

import SwiftUI

struct ArtistPortfolioView: View {
    @State var selection = 0
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("Addison Rae") { selection = 1 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("The Kills") { selection = 2 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("Anderson Paak") { selection = 3 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("Zara Larsson") { selection = 4 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                }
                HStack {
                    Button("Blxst") { selection = 5 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("Latto") { selection = 6 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("Victoria Monet") { selection = 7 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                    Button("PinkPantheress") { selection = 8 }
                        .buttonStyle(SmallPressableCapsuleStyle())
                }
            }
            .padding()
                    
            Divider()
            
            // Content area
            Group {
                switch selection {
                case 1:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Addison Tour 2025")
                                .font(.headline)
                            Text("Playback Engineer &")
                                .font(.subheadline)
                            Text("Programmer")
                                .font(.subheadline)
                            Image("Addy").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }

                case 2:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("God Games Tour 2024-25")
                                .font(.headline)
                            Text("Queens of the Stone Age")
                                .font(.headline)
                            Text("Nero Tour Support 2025")
                                .font(.headline)
                            Text("Playback Engineer & Programmer")
                                .font(.subheadline)
                            Image("TheKills").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }

                case 3:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Malibu Tour 2024")
                                .font(.headline)
                            Text("Ableton Programmer")
                                .font(.subheadline)
                            Image("AP").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                    
                case 4:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("One-Off: Z100 Jumpstart to Summer")
                                .font(.headline)
                            Text("Playback Tech")
                                .font(.subheadline)
                            Image("Zara").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                    
                case 5:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("I'll Always Come Find You Tour 2024")
                                .font(.headline)
                            Text("Ableton Programmer")
                                .font(.subheadline)
                            Image("Blxst").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                case 6:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Multiple One-offs 2024")
                                .font(.headline)
                            Text("Playback Engineer, Programmer, Mixer")
                                .font(.subheadline)
                            Image("Latto").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                case 7:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Jaguar Tour 2023")
                                .font(.headline)
                            Text("Tonight Show w/ Jimmy Fallon 2023")
                                .font(.headline)
                            Text("Playback Engineer")
                                .font(.subheadline)
                            Image("VM").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }
                case 8:
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Primavera Sound 2023")
                                .font(.headline)
                            Text("Gov Ball NYC 2023")
                                .font(.headline)
                            Text("Playback Engineer and Programmer")
                                .font(.subheadline)
                            Image("Pink").resizable().frame(width:80, height:80)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Spacer()
                    }

                default:
                    EmptyView()
                }
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 200)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black) // fill under your text
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1) // border line
                    )
                )
        }
    }
}
