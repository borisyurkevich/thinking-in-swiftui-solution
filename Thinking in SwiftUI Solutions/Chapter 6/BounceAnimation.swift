//
//  BounceAnimation.swift
//  Thinking in SwiftUI Solutions
//
//  ⚠️ Preview doesn't animates, run on Simulator.
//
//  Created by Boris Yurkevich on 04/12/2020.
//

import SwiftUI

struct BounceAnimation: View {
    
    @State var times = 0
    
    var body: some View {
        Circle()
            .fill(Color.blue)
            .padding()
            .bounce(times: times)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    times += 1
                }
            }
    }
}

struct Bounce: AnimatableModifier {
    
    let amplitude: CGFloat = 50

    var times: CGFloat
    
    var animatableData: CGFloat {
        get { times }
        set { times = newValue }
    }
    
    func body(content: Content) -> some View {
        content.offset(y: -abs(sin(times * .pi)) * amplitude)
    }
}

fileprivate extension View {
    func bounce(times: Int) -> some View {
        modifier(Bounce(times: CGFloat(times)))
    }
}

struct BounceAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BounceAnimation()
            .previewLayout(.sizeThatFits)
    }
}
