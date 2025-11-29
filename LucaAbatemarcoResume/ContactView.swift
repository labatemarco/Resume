//
//  ContactView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 19/11/2025.
//

import SwiftUI

struct ContactView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            HStack(spacing:30) {
                Text("Email:").font(.headline)
                Text("luca.abatemarco05@gmail.com").font(.headline)
            }
            HStack(spacing: 30) {
                Text("Based in:").font(.headline)
                Text("Los Angeles").font(.headline)
            }
        }
    }
}
