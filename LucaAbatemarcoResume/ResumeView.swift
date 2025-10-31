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
        ZStack {
            Image("resumeBackground").resizable()
                VStack(alignment: .leading) {
                    Header().shadow(radius: 20).padding([.bottom], 10)
                    ScrollView(content: {
                        HStack {
                            DisclosureGroup("Education") {
                                HStack {
                                    Image("ucla_logo").resizable().frame(width: 42.58, height: 20)
                                    VStack {
                                        Text("B.S. Chemistry / Materials Science").foregroundColor(Color.indigo)
                                            .bold()
                                        Text("Sep 2016 - Mar 2020")
                                            .foregroundColor(Color.indigo)
                                        Text("Research published: Compressed Intermetallic PdCu for Enhanced Electrocatalysis").font(.custom("Hiragino Sans", size: 10))
                                        Text("Michelle M. Flores Espinosa, Tao Cheng, Mingjie Xu, Luca Abatemarco, Chungseok Choi, Xiaoqing Pan, William A. Goddard III, Zipeng Zhao, and Yu Huang").font(.custom("Hiragino Sans", size: 10)).baselineOffset(2)
                                    }
                                }
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
                .background(Color.black.opacity(0.2).frame(width:400))
            
        }
        .background(Color.clear)
    }
}




//#Preview {
//    ResumeView()
//}








