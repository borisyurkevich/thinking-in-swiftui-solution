//
//  AnimatedRectangle.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 28/11/2020.
//

import SwiftUI

struct AnimatedRectangle: View {

    @State var selected: Bool = false
    
    var body: some View {
    
        Button(action: { self.selected.toggle() }) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(selected ? Color.red : .green)
                .frame(width: selected ? 100 : 50,
                       height: selected ? 100 : 50)

        }.animation(.default)
    }
}

struct LoadingIndicator: View {

    @State private var animating = false

    var body: some View {

        Image(systemName: "rays")
            .rotationEffect(animating ? Angle.degrees(360) : .zero)
            .animation(Animation
                        .linear(duration: 2)
                        .repeatForever(autoreverses: false))
            .onAppear { self.animating = true }
    }
}

struct Entry: View {
    
    @State var visible = false
    
    var body: some View {
        VStack {
            Button("Toggle") { self.visible.toggle() }
            if visible {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
                    .transition(.slide)
                    .animation(.default)
            }
        }
    }
}


struct AnimatedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        Entry()
    }
}
