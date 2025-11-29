//
//  ResumeView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 15/04/2025.
//

import SwiftUI

struct ResumeView: View {
    @State var artistPortfolioOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 60)
            ScrollView(content: {
                HStack {
                    DisclosureGroup("Education") {
                        EducationView()
                    }.foregroundColor(.cyan)
                }
                Experience()
                Projects().foregroundColor(.cyan)
                VStack {
                    Button(action: {
                        artistPortfolioOpen.toggle()
                    }) {
                        Label("Artist Portfolio", systemImage: "person.crop.square")
                    }
                    .buttonStyle(PressableCapsuleStyle())
                    if artistPortfolioOpen {
                        ArtistPortfolioView()
                    }
                }
                Spacer()
            })
        }
        .padding()
//        .background(Color.black.opacity(0.2).frame(width:400))
    }
    
}




//#Preview {
//    ResumeView()
//}






