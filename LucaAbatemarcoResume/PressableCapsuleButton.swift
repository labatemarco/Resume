//
//  PressableCapsuleButton.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 15/09/2025.
//


import SwiftUI

struct PressableCapsuleStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var selectionOpen: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 5)
            .font(.custom("Hiragino Sans", fixedSize: 12)).baselineOffset(2)
            .background(
                Capsule().fill(
                    isEnabled
                        ? Color.cyan.opacity(configuration.isPressed ? 0.5 : 1.0)
                        : Color.gray.opacity(0.3)
                )
            )
            .foregroundColor(
                    isEnabled
                    ? .black
                    : .white
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}


struct SmallPressableCapsuleStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var selectionOpen: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .font(.custom("Hiragino Sans", fixedSize: 10)).baselineOffset(2)
            .background(
                Capsule().fill(
                    isEnabled
                        ? Color.cyan.opacity(configuration.isPressed ? 0.5 : 1.0)
                        : Color.gray.opacity(0.3)
                )
            )
            .foregroundColor(
                    isEnabled
                    ? .black
                    : .white
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
            .frame(width:70)
    }
}

