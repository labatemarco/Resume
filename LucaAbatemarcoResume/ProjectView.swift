//
//  ProjectView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//

import SwiftUI


struct Projects: View {
    var projectDict: [String: [String: Any]] = [
        "Cue2Live": [
            "Description": "Setlist App for Ableton Live, with a server written in Ableton's built in python implementation, and a frontend GUI written in Swift. Allows for show control of Ableton Live sessions not natively available.",
            "Time to Completion": "4 months", // Change to actual time interval type
            "Skills Used": ["Python", "Swift", "Appkit", "Networking", "Core MIDI"]
        ],
        "Cue2Live-iOS": [
            "Description": "Mobile companion app client for Cue2Live MacOS. Allows show control from an iPad or iPhone.",
            "Time to Completion": "6 months",
            "Skills Used": ["Swift", "SwiftUI","Network.Foundation", "Networking", "Core MIDI"]
        ],
        "Cue2Live Website": [
            "Description": "Website to host Cue2Live family of software.",
            "Time to Completion": "1 month", // Change to actual time interval type
            "Skills Used": ["Django", "Python", "Javascript", "CSS", "HTML", "PostGreSQL", "nginx", "gunicorn", "bash"]
        ]
    ]
    var body: some View {
        DisclosureGroup("Projects") {
            LazyVStack {
                ForEach(Array(projectDict), id: \.key) { key , value in
                    let description: String? = value["Description"] as? String
                    let length: String? = value["Time to Completion"] as? String
                    let skills: [String]? = value["Skills Used"] as? [String]
                    projectCell(key: key, description: description ?? "", length: length ?? "", skills: skills ?? [])
                }
            }.padding([.top, .bottom], 5)
        }
    }
}


struct projectCell: View {
    let key: String
    let description: String
    let length: String
    let skills: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text("•").bold().padding([.leading], 4)
                Text(key)
            }.padding([.top], 10)
            Section {
                Text(description).font(.system(size: 11))
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
                    .padding([.top, .bottom], 1)
                    .background(Color.cyan.opacity(0.2))
                    .allowsHitTesting(false)
                
            )
            HStack {
                Text("Development Time: ")
                Text(length)
            }.padding([.bottom], 10)
            
            WrapHStack(skills)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .stroke(.black, lineWidth: 1)
                .fill(.ultraThinMaterial)
                .padding(2)
        )
    }
}


struct WrapHStack: View {
    let skills: [String]
    init(_ skills: [String]) { self.skills = skills }
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 6)], spacing: 6) {
            ForEach(skills, id: \.self) { skill in
                Text(skill)
                    .font(.caption2)
                    .padding(6)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(6)
            }
        }
    }
}
