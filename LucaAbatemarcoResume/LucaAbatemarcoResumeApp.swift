//
//  LucaAbatemarcoResumeApp.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 15/04/2025.
//

import SwiftUI

@main
struct LucaAbatemarcoResumeApp: App {
    var body: some Scene {
        WindowGroup {
            MasterView()
                .frame(width: 400, height: 500)
        }.windowResizability(.contentSize)
    }
}
