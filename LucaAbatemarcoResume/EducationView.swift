//
//  EducationView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 19/11/2025.
//

import SwiftUI

struct EducationView: View {
    
    var body: some View {
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
    }
}
