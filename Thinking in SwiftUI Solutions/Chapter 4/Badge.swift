//
//  Badge.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 23/11/2020.
//

import SwiftUI

extension View {
    
    func badge(count: Int) -> some View {
        overlay(Badge(count: count)
                    .offset(x: 12, y: -12),
                alignment: .topTrailing)
            .padding()
    }
}

struct BadgeParent: View {
    
    @State var count: Int = 10
    
    var body: some View {
        Text("Hello")
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .padding(6)
            .background(Color.gray)
            .badge(count: count)
    }
}

struct Badge: View {
    var colour = Color.red
    var size: CGFloat = 20
    
    let count: Int
    
    var isHidden: Bool {
        count != 0
    }
    
    var body: some View {
        if isHidden {
            Text("\(count)")
                .font(.caption)
                .foregroundColor(Color.white)
                .lineLimit(1)
                .padding(6)
                .frame(minWidth: size)
                .background(
                    Circle()
                        .fill(colour)
                )
        }
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        BadgeParent()
            .previewLayout(.sizeThatFits)
        Badge(count: 1)
            .previewLayout(.sizeThatFits)
    }
}
