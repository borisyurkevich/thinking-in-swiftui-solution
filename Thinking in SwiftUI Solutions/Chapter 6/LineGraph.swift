//
//  LineGraph.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 05/12/2020.
//

import SwiftUI
import os

struct LineGraph: View {
    
    let linePoints: [CGFloat] = [0.1, 0.7, 0.3, 0.6, 0.45, 1.1]
    
    @State var isVisible: Bool = false
    
    var body: some View {
        LineGraphShape(points: linePoints)
            .trim(from: 0, to: isVisible ? 1 : 0)
            .stroke(Color.red, lineWidth: 2)
            .border(Color.gray, width: 1)
            .padding()
            .onAppear {
                withAnimation(.easeInOut(duration: 4.0)) {
                    isVisible = true
                }
            }
    }
}

struct LineGraphShape: Shape {
    
    let points: [CGFloat]
    let logger = Logger()

    func path(in rect: CGRect) -> Path {
                
        let widthIncrement = rect.width / CGFloat(points.count)
        var currentWidth: CGFloat = 0
        var lines: [CGPoint] = []
        let height = rect.height
        for point in points {
            
            let x: CGFloat = currentWidth
            currentWidth += widthIncrement
            
            let cocoaPoint = 1 - point // First, convert a point into the Cocoa coordinate system
            let y: CGFloat =  height * cocoaPoint
            
            lines.append(CGPoint(x: x, y: y))
            logger.log(level: .debug, "\(x),\(y)")
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
            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .previewLayout(.sizeThatFits)
    }
}
