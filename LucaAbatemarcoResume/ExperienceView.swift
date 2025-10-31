//
//  Experience.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 31/10/2025.
//

import SwiftUI


struct Experience: View {
    
    var body: some View {
        DisclosureGroup("Experience") {
            ExperienceTimeline()
        }
        .foregroundColor(.cyan)
    }
}


struct ExperienceContent: View {
    let experienceContent: [String: [String: Any]] = [
        "Microfabrica": [
            "header": "Sustaining engineer for mature HVM wafer-based process to develop high aspect ratio MEMS components and medical devices in ISO 9001 and ISO 13485 environment.",
            "content": [
                "Sustained production for high volume MEMS manufacturing process across Photolithography, Electroplating, and Planarization modules.",
                "Defect tracker owner; focus on metrology for alignment and critical dimension.",
                "Led technology transfer to international parent company twice — once as inspection owner, once as sputtering owner for research team.",
                "Team member for product development and technology transfer of thermal management product into HVM."
            ]
        ],
        "Effigy Music LLC": [
            "header": "Build show rigs and program live shows for A-list artists, taking them on tour to support systems and programming:",
            "content": [
                "Worked with numerous Grammy-winning and nominated artists such as Victoria Monét, Dominic Fike, Ari Lennox, Swae Lee, Cordae, PinkPantheress, Arlo Parks, and others.",
                "Engineered and documented custom playback and MIDI rigs; combination of technical rigor and creative awareness.",
                "Currently coding a custom Ableton Live extension with a Python backend and Swift frontend."
            ]
        ]
    ]
    
    var experience: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let header = experienceContent[experience]?["header"] as? String {
                Text(header)
                    .font(.system(size: 12))
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
            }
            
            if let contentList = experienceContent[experience]?["content"] as? [String] {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(contentList, id: \.self) { bulletPoint in
                        HStack(alignment: .top, spacing: 6) {
                            Text("•")
                                .bold()
                            Text(bulletPoint)
                                .font(.system(size: 10))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
        .padding(6)
    }
}



struct ExperienceTimeline: View {
    var experienceDates: [String: [String: Date?]] = [
        "Microfabrica": [
            "start": Calendar.current.date(from: DateComponents(year: 2020, month: 7)),
            "end": Calendar.current.date(from: DateComponents(year: 2022, month: 3))
        ],
        "Effigy Music LLC": [
            "start": Calendar.current.date(from: DateComponents(year: 2022, month: 3)),
            "end": Date()
        ]
    ]
    
    var experienceRole: [String: String] = [
        "Microfabrica": "Jr. Process Engineer",
        "Effigy Music LLC": "Owner / Playback Engineer"
    ]
    
    var sortedExperiences: [(String, [String: Date?])] {
        // Sort by start date descending
        Array(experienceDates)
            .sorted { lhs, rhs in
                guard
                    let lStart = lhs.value["start"] ?? nil,
                    let rStart = rhs.value["start"] ?? nil
                else { return false }
                return lStart > rStart
            }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Experience")
                .font(.title2.bold())
                .foregroundColor(.cyan)
                .padding(.bottom, 8)
            
            ForEach(Array(sortedExperiences.enumerated()), id: \.offset) { index, element in
                let key = element.0
                let value = element.1
                let position = experienceRole[key] ?? ""
                
                TimelineEntryView(
                    key: key,
                    position: position,
                    start: value["start"] ?? nil,
                    end: value["end"] ?? nil,
                    isLast: index == sortedExperiences.count - 1
                )
            }
        }
        .padding()
    }
}

struct TimelineEntryView: View {
    @State private var expanded = false
    let key: String
    let position: String
    let start: Date?
    let end: Date?
    let isLast: Bool
    
    var formattedInterval: String {
        guard let start = start, let end = end else { return "" }
        let formatter = DateIntervalFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: start, to: end)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Circle()
                    .fill(expanded ? .cyan : .gray.opacity(0.5))
                    .frame(width: 12, height: 12)
                    .scaleEffect(expanded ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: expanded)
                
                if !isLast {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(width: 2, height: 50)
                        .padding(.top, -4)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(key)
                    .font(.headline)
                
                Text(position)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if start != nil && end != nil {
                    Text(formattedInterval)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                if expanded {
                    ExperienceContent(experience: key)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
                
                Button(expanded ? "Hide Details" : "Details") {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        expanded.toggle()
                    }
                }
                .font(.system(size: 11, weight: .semibold))
                .padding(.top, 4)
                .foregroundColor(.cyan)
                .buttonStyle(.plain)
            }
            .padding(.bottom, 8)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}
