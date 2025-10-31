//
//  Experience.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//

import SwiftUI

struct Experience: View {
    var experienceDates: [String: [String: Date?]] = [
    "Microfabrica": ["start": Calendar.current.date(from: DateComponents(year: 2020, month: 7)), "end":  Calendar.current.date(from: DateComponents(year: 2022, month: 3))],
    "Effigy Music LLC": ["start": Calendar.current.date(from: DateComponents(year: 2022, month: 3)), "end": Date()]
    ]
    var experienceRole: [String: String] = [
        "Microfabrica": "Jr. Process Engineer",
        "Effigy Music LLC": "Owner/Playback Engineer"
    ]
    
    var body: some View {
        DisclosureGroup("Experience") {
                LazyVStack {
                    ForEach(Array(experienceDates), id: \.key) { key, value in
                        let position = experienceRole[key] ?? nil
                        ExperienceCell(key: key, position: position ?? "", start: value["start"] ?? nil,
                                       end: value["end"] ?? nil)
                    }
                }
        }.foregroundColor(.cyan)
    }
}



struct ExperienceCell: View {
    @State var contentExpanded: Bool = false
    let key: String
    let position: String
    let start: Date?
    let end: Date?
    var formattedInterval: String {
        guard let start = start, let end = end else { return "" }
        
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium // or .long
        formatter.timeStyle = .none
        return formatter.string(from: start, to: end)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.blue, lineWidth: 2)
                .padding([.top, .bottom], 1)
                .background(.ultraThinMaterial)
                .allowsHitTesting(false)
                .frame(width: contentExpanded ? 365 : 200)
            VStack {
                Text(key)
                    .frame(height: 20)
                    .padding([.top, .leading, .trailing], 4)
                Text(position)
                    .font(.system(size: 12))
                if start != nil && end != nil {
                    Text(formattedInterval)
                        .padding([.bottom, .leading, .trailing], 4)
                }
                if contentExpanded {
                    ExperienceContent(experience: key)
                }
                
                Button("Details", action: {
                    contentExpanded.toggle()
                })
                .padding(5)
                .font(.system(size: 10))
                .foregroundColor(.black)
                .background(Color.blue)
                .background(in: .capsule, fillStyle: .init(eoFill: true, antialiased: true))
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderless)
            }
            .padding([.bottom], 5)
        }
            
    }
}


struct ExperienceContent: View {
    let experienceContent: [String: [String: Any]] = [
        "Microfabrica": [
            "header": "Sustaining engineer for mature HVM wafer-based process to develop high aspect ratio MEMS components and medical devices in ISO 9001 and ISO 13485 environment.",
            "content": ["Sustained production for high volume MEMS manufacturing process across Photolithography, Electroplating, and Planarization modules",
                        "Defect tracker owner; focus on metrology for alignment and critical dimension.",
                        "Led technology transfer area to international parent company twice; once as owner of inspection, and once as owner of sputtering for special research team",
                        "Team member for product development and technology transfer of thermal management product into high volume manufacturing."]
        ],
        "Effigy Music LLC": [
            "header": "Build show rigs and program live shows for A list artists,  taking them on tour to support systems and programming:",
            "content": [
                "Worked with numerous grammy-winning and nominated artists such as: Victoria Monet, Dominic Fike, Ari Lennox, Swae Lee, Cordae, Pinkpantheress, Arlo Parks, and others doing everything from arena shows to Jimmy Fallon.",
                "Engineer/document custom playback and MIDI rigs, as well as program them; a combination of technical rigor and creative awareness.",
                "Currently coding a custom Ableton Live extension with a python backend, and Swift frontend."
            ]
        ]
    ]
    var experience: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let header = experienceContent[experience]?["header"] as? String {
                Text(header)
                    .padding(2)
                    .font(.system(size: 12))
            }
            
            if let contentList = experienceContent[experience]?["content"] as? [String] {
                ForEach(contentList, id: \.self) {
                    bulletPoint in
                    HStack(alignment: .top) {
                        Text("•").bold().padding([.leading], 4)
                        Text(bulletPoint)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 10))
                    }
                }
            }
        }
    }
}
