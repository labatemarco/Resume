//
//  ContentView.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 15/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State var artistPortfolioOpen: Bool = false
    
    var body: some View {
        ZStack {
            
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
                            }.foregroundColor(.black)
                        }
                        Experience()
                        Projects().foregroundColor(.black)
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
                .background(Color.white.opacity(0.4).frame(width:300).blur(radius: 20))
            
        }
        .background(Color.mint)
    }
}




#Preview {
    ContentView()
}



struct Header: View {
    
    var body: some View {
             HStack {
                VStack {
                    Text("Luca Abatemarco").font(.custom("Hiragino Sans", size: 20))
                        .foregroundColor(.black).padding(5).frame(height: 20)
                    ProfessionCarousel(myProfessions: ["Developer", "Audio Engineer", "Scientist"]).padding([.top], 5).frame(height: 5).baselineOffset(2)
                }
                Link(destination: URL(string: "https://www.linkedin.com/in/luca-abatemarco/")!) {
                    Image("LI-In-Bug").resizable().frame(width: 35.27, height: 30)
                }
                 Link(destination: URL(string: "https://github.com/labatemarco")!) {
                     Image("github-mark").resizable().frame(width: 35.27, height: 30)
                 }
                 Link(destination: URL(string: "https://www.cue2live.com")!) {
                     Image("cue2liveicon").resizable().frame(width: 35.27, height: 30)
                 }
                 
            }
    }
}


struct ProfessionCarousel: View {
    
    var myProfessions: [String]
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    @State private var selectedProfessionIndex: Int = 0
    var body: some View {
        TabView(selection: $selectedProfessionIndex) {
            ForEach(0..<myProfessions.count, id: \.self) {index in
                ZStack(alignment: .topLeading) {
                    Text(myProfessions[index]).font(.custom("Hiragino Sans", size: 12)).foregroundColor(.black)
                }
            }
        }
        .onReceive(timer) {_ in withAnimation(.default)
            {selectedProfessionIndex = (selectedProfessionIndex + 1) % myProfessions.count}
        }
    }
    
}


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
        }.foregroundColor(.black)
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
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.blue, lineWidth: 2)
                    .padding([.top, .bottom], 1)
                    .background(Color.cyan.opacity(0.2))
                    .allowsHitTesting(false)
            )
            
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
                .fill(Color.black.opacity(0.1))
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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Addison Tour 2025")
                            .font(.headline)
                        Text("Playback Engineer and Programmer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case 2:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("God Games Tour 2024-25")
                            .font(.headline)
                        Text("Queens of the Stone Age")
                            .font(.headline)
                        Text("Nero Tour Support 2025")
                            .font(.headline)
                        Text("Playback Engineer and Programmer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                case 3:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Malibu Tour 2024")
                            .font(.headline)
                        Text("Ableton Programmer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case 4:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("One-Off: Z100 Jumpstart to Summer")
                            .font(.headline)
                        Text("Playback Tech")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case 5:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("I'll Always Come Find You Tour 2024")
                            .font(.headline)
                        Text("Ableton Programmer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 6:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Multiple One-offs 2024")
                            .font(.headline)
                        Text("Playback Engineer, Programmer, Mixer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 7:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Jaguar Tour 2023")
                            .font(.headline)
                        Text("Tonight Show w/ Jimmy Fallon 2023")
                            .font(.headline)
                        Text("Playback Engineer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case 8:
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Primavera Sound 2023")
                            .font(.headline)
                        Text("Gov Ball NYC 2023")
                            .font(.headline)
                        Text("Playback Engineer and Programmer")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

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
