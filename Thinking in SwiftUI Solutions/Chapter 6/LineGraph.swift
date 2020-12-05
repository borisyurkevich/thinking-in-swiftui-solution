//
//  LineGraph.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 05/12/2020.
//

import SwiftUI

let linePoints: [CGFloat] = [0.1, 0.7, 0.3, 0.6, 0.45, 1.1]

struct LineGraph: View {
    
    
    var body: some View {
        LineGraphShape(points: linePoints)
            .stroke(Color.red, lineWidth: 2)
            .border(Color.gray, width: 1)
    }
}

struct LineGraphShape: Shape {
    
    let points: [CGFloat]

    func path(in rect: CGRect) -> Path {
        
        var lines: [CGPoint] = []
        
        for point in points {
            let x: CGFloat = rect.width / CGFloat(points.count)
            let y: CGFloat = rect.height * point
            lines.append(CGPoint(x: y, y: y))
        }
        
        return Path { p in
            let start = CGPoint(x: 0, y: 0)
            p.move(to: start)
            p.addLines(lines)
        }
    }
}

struct LineGraph_Previews: PreviewProvider {
    static var previews: some View {
        LineGraph()
            .previewLayout(.sizeThatFits)
            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
