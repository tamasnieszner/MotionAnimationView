//
//  MotionAnimationView.swift
//  animated transparent circles for background view. (dynamic wallpaper)
//
//  Created by Tamás Nieszner on 2021. 11. 09..
//

import SwiftUI

struct MotionAnimationView: View {
    // MARK: - Properties
    
    @State private var randomCircleCount = Int.random(in: 12...16)
    @State private var isAnimating: Bool = false
    
    // MARK: - Methods
    
    func randomCoordinate(max: CGFloat) -> CGFloat {
        return CGFloat.random(in: 0...max)
    }
    
    func randomSize() -> CGFloat {
        return CGFloat(Int.random(in: 10...300))
    }
    
    func randomScale() -> CGFloat {
        return CGFloat(Double.random(in: 0.1...2.0))
    }

    func randomSpeed() -> Double {
        return Double.random(in: 0.025...1)
    }

    func randomDelay() -> Double {
        return Double.random(in: 0...2)
    }
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0...randomCircleCount, id: \.self) { item in
                    Circle()
                        .foregroundColor(.gray)
                        .opacity(0.15)
                        .frame(width: randomSize(), height: randomSize(), alignment: .center)
                        .scaleEffect(isAnimating ? randomScale() : 1)
                        .position(x: randomCoordinate(max: geometry.size.width), y: randomCoordinate(max: geometry.size.height))
                        .animation(Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
                                .repeatForever()
                                .speed(randomSpeed())
                                .delay(randomDelay())
                        )
                        .onAppear {
                            isAnimating = true
                        }
                }
            }
            .drawingGroup()
        }
    }
}

// MARK: - Previews

struct MotionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MotionAnimationView()
    }
}
