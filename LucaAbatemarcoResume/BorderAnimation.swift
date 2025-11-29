//
//  BorderAnimation.swift
//  LucaAbatemarcoResume
//
//  Created by Luca Abatemarco on 16/11/2025.
//


import SwiftUI
import simd



// MARK: - Main View
struct BorderAnimation: View {
    let points: [CGPoint]
    let canvasSize: CGSize
    let duration: Double
    let loop: Bool
    
    @State private var progress: CGFloat = 0
    
    private let sampler: SplineSampler
    
    init(points: [CGPoint], canvasSize: CGSize, duration: Double = 6.0, loop: Bool = true) {
        self.points = points
        self.canvasSize = canvasSize
        self.duration = duration
        self.loop = loop
        self.sampler = SplineSampler(through: points, samplesPerSegment: 50)
    }
    
    var body: some View {
        ZStack {
            // trailing thread tail (continuous, short window behind needle)
            ThreadStrokeShape(
                samples: sampler.samples,
                totalLength: sampler.totalLength,
                progress: progress,
                tailWindow: 0.12   // tweak for how long the tail is
            )
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        .cyan.opacity(0.9), // near the head
                        .cyan.opacity(0.0)  // fades out
                    ],
                    startPoint: .trailing,
                    endPoint: .leading
                )
            )
            .shadow(color: .cyan.opacity(0.4), radius: 6, x: 0, y: 0)
            
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .onAppear {
            withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
                progress = 1
            }
        }
    }

    
    private func touchGlowOpacity(for index: Int) -> Double {
        // glow a pin briefly when the needle is near it
        guard let tPin = sampler.tForPin[index] else { return 0 }
        let d = abs(progress - tPin)
        let falloff: CGFloat = 0.03
        let v = max(0, 1 - (d / falloff))
        return Double(v * v) // sharper peak
    }
}


// MARK: - Trimmed thread
fileprivate struct ThreadStrokeShape: Shape {
    let samples: [CGPoint]
    let totalLength: CGFloat
    var progress: CGFloat
    var tailWindow: CGFloat = 1.0 // 1.0 = full loop; <1 draws only a segment behind the needle
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        guard !samples.isEmpty, totalLength > 0 else { return Path() }
        
        // Treat progress as circular 0...1
        let endT = progress
        let window = max(0, min(1, tailWindow))
        
        // Helper to add a segment for a [t0, t1] interval
        func addSegment(from startT: CGFloat, to endT: CGFloat, into path: inout Path) {
            let startL = totalLength * startT
            let endL   = totalLength * endT
            
            var acc: CGFloat = 0
            var started = false
            
            for i in 1..<samples.count {
                let a = samples[i - 1]
                let b = samples[i]
                let seg = distance(a, b)
                let next = acc + seg
                
                // segment lies (even partially) within [startL, endL]
                if next >= startL && acc <= endL {
                    let t0 = max(0, (startL - acc) / seg)
                    let t1 = min(1, (endL   - acc) / seg)
                    let p0 = mix(a, b, t0)
                    let p1 = mix(a, b, t1)
                    
                    if !started {
                        path.move(to: p0)
                        started = true
                    } else {
                        path.addLine(to: p0)
                    }
                    path.addLine(to: p1)
                }
                
                acc = next
                if acc > endL { break }
            }
        }
        
        var path = Path()
        
        if window >= 1 {
            // full loop from 0...endT (your old behavior)
            addSegment(from: 0, to: endT, into: &path)
        } else {
            let startT = endT - window
            
            if startT < 0 {
                // Wrap: [startT+1, 1] then [0, endT]
                addSegment(from: startT + 1, to: 1, into: &path)
                addSegment(from: 0, to: endT, into: &path)
            } else {
                addSegment(from: startT, to: endT, into: &path)
            }
        }
        
        return path
    }
}


// MARK: - Spline Sampler (Catmull–Rom)
fileprivate final class SplineSampler {
    let samples: [CGPoint]
    let totalLength: CGFloat
    let tForPin: [Int: CGFloat]

    // cache cumulative lengths so state(at:) is cheap
    private let cumulativeLengths: [CGFloat]

    init(through pins: [CGPoint], samplesPerSegment: Int = 40) {
        // handle degenerate cases
        guard pins.count >= 2 else {
            self.samples = pins
            self.totalLength = 0
            self.tForPin = [:]
            self.cumulativeLengths = Array(repeating: 0, count: pins.count)
            return
        }

        // 1) Build straight-line samples along each segment
        var s: [CGPoint] = []
        s.append(pins[0])

        for i in 0..<(pins.count - 1) {
            let a = pins[i]
            let b = pins[i + 1]

            for j in 1...samplesPerSegment {
                let t = CGFloat(j) / CGFloat(samplesPerSegment)
                let pt = mix(a, b, t)
                s.append(pt)
            }
        }

        // 2) Compute cumulative distances
        var cumulative: CGFloat = 0
        var cum: [CGFloat] = Array(repeating: 0, count: s.count)
        for i in 1..<s.count {
            cumulative += distance(s[i - 1], s[i])
            cum[i] = cumulative
        }
        let total = max(cumulative, 0.0001)

        // 3) Map each original pin to a 0..1 parameter by nearest sample
        var map: [Int: CGFloat] = [:]
        for (idx, pin) in pins.enumerated() {
            if let k = nearestIndex(of: pin, in: s) {
                let t = cum[k] / total
                map[idx] = t
            }
        }

        self.samples = s
        self.totalLength = total
        self.tForPin = map
        self.cumulativeLengths = cum
    }

    func state(at t: CGFloat) -> (point: CGPoint, angle: CGFloat)? {
        guard !samples.isEmpty else { return nil }

        let clamped = max(0, min(1, t))
        let target = totalLength * clamped

        // binary search over precomputed cumulative lengths
        var lo = 0
        var hi = samples.count - 1

        while lo < hi {
            let mid = (lo + hi) / 2
            if cumulativeLengths[mid] < target {
                lo = mid + 1
            } else {
                hi = mid
            }
        }

        let i = max(1, lo)
        let a = samples[i - 1]
        let b = samples[i]

        let segLen = max(0.0001, distance(a, b))
        let local = (target - cumulativeLengths[i - 1]) / segLen
        let pos = mix(a, b, local)

        let dir = simd_double2(x: Double(b.x - a.x), y: Double(b.y - a.y))
        let angle = atan2(dir.y, dir.x)

        return (pos, CGFloat(angle))
    }
}


// MARK: - Math helpers
fileprivate func catmullRom(_ p0: CGPoint, _ p1: CGPoint, _ p2: CGPoint, _ p3: CGPoint, _ t: CGFloat) -> CGPoint {
    // Catmull–Rom (centripetal-ish with alpha=0.5 stability would need chord lengths; here we use uniform, good enough for UI)
    let t2 = t * t
    let t3 = t2 * t
    let x = 0.5 * ((2*p1.x) +
                   (-p0.x + p2.x) * t +
                   (2*p0.x - 5*p1.x + 4*p2.x - p3.x) * t2 +
                   (-p0.x + 3*p1.x - 3*p2.x + p3.x) * t3)
    let y = 0.5 * ((2*p1.y) +
                   (-p0.y + p2.y) * t +
                   (2*p0.y - 5*p1.y + 4*p2.y - p3.y) * t2 +
                   (-p0.y + 3*p1.y - 3*p2.y + p3.y) * t3)
    return CGPoint(x: x, y: y)
}

fileprivate func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    hypot(a.x - b.x, a.y - b.y)
}

fileprivate func mix(_ a: CGPoint, _ b: CGPoint, _ t: CGFloat) -> CGPoint {
    CGPoint(x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t)
}

fileprivate func nearestIndex(of point: CGPoint, in list: [CGPoint]) -> Int? {
    guard !list.isEmpty else { return nil }
    var best = 0
    var bestD = CGFloat.greatestFiniteMagnitude
    for (i, p) in list.enumerated() {
        let d = distance(point, p)
        if d < bestD { bestD = d; best = i }
    }
    return best
}


func borderPoints(for size: CGSize, inset: CGFloat = 4) -> [CGPoint] {
    let w = size.width
    let h = size.height
    
    return [
        CGPoint(x: inset,       y: inset),        // top-left
        CGPoint(x: w - inset,   y: inset),        // top-right
        CGPoint(x: w - inset,   y: h - inset),    // bottom-right
        CGPoint(x: inset,       y: h - inset),    // bottom-left
        CGPoint(x: inset,       y: inset)         // back to start to close loop
    ]
}
