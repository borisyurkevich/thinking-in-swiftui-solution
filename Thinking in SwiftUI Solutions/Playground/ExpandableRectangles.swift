//
//  Rectangles.swift
//  Collapsable Stack View
//
//  Created by Boris Yurkevich on 21/11/2020.
//

import SwiftUI

struct ExpandableRectangles: View {
    
    var expanded: Bool = false
    
    var body: some View {
        if expanded {
            HStack() {
                Rectangles()
            }.border(Color.black)
        } else {
            ZStack(alignment: .myCenter) {
                Rectangles()
            }.border(Color.black)
        }
    }
}

struct Rectangles: View {

    var body: some View {
        Group {
            Rectangle().fill(Color.red)
                .frame(width: 40, height: 40)
            Rectangle().fill(Color.green)
                .frame(width: 30, height: 30)
            Rectangle().fill(Color.blue)
                .frame(width: 50, height: 50)
        }
    }
}

enum MyCenterID: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context.width * 2
    }
}

extension Alignment {
    static let myCenter = Alignment(horizontal: HorizontalAlignment(MyCenterID.self), vertical: .center)
}

// - MARK: Preview

struct Rectangles_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableRectangles()
            .previewLayout(.sizeThatFits)
    }
}

struct ExpandableRectangles_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExpandableRectangles(expanded: true)
            ExpandableRectangles(expanded: false)
        }.previewLayout(.sizeThatFits)
    }
}
