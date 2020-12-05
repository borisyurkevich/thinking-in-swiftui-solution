//
//  Triangle.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 05/12/2020.
//

import SwiftUI

struct TriangleView: View {
    var body: some View {
        Triangle()
    }
}

struct Triangle: Shape {

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.width/2, y: 0))
            p.addLines([
                CGPoint(x: rect.width, y: rect.height),
                CGPoint(x: 0, y: rect.height),
                CGPoint(x: rect.width/2, y: 0)
            ])
        }
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
