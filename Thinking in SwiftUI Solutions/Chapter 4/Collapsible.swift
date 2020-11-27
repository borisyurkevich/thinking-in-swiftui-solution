//
//  Collapsible.swift
//  Collapsable Stack View
//
//  Created by Boris Yurkevich on 21/11/2020.
//

import SwiftUI

struct Collapsible<Element, Content: View>: View {
    var alignment: VerticalAlignment = .center
    var expanded: Bool = false
    var spacing: CGFloat = 8

    let data: [Element]

    let content: (Element) -> Content // This is tricky and weird 🤷🏻‍♂️

    let collpasedWidth: CGFloat = 10
    let height: CGFloat = 50
    

    var body: some View {
        HStack(alignment: alignment, spacing: expanded ? spacing : 0) {
            ForEach(data.indices) { idx in
                child(at: idx)
            }
        }
        .border(Color.black)
    }

    func child(at index: Int) -> some View {
        let isExpanded = expanded || index == data.endIndex - 1
        return content(data[index])
            .frame(width: isExpanded ? nil : collpasedWidth,
                   alignment: Alignment(horizontal: .leading, vertical: alignment))
        // nil is needed so the HStack can control width
        // I also can set with here however it won't be possible to vary it
    }
}

struct Collapsible_Previews: PreviewProvider {
    
    static var previews: some View {
    
    let data: [(CGFloat, Color)] = [(100, .green), (50, .yellow), (200, .blue)]
    
    Group {
        Collapsible(alignment: .bottom, expanded: true, spacing: 4, data: data, content: { item in
            Rectangle()
                .fill(item.1)
                .frame(width: item.0, height: item.0)
      })
        Collapsible(expanded: false, data: data, content: { item in
            Rectangle()
                .fill(item.1)
                .frame(width: item.0, height: item.0)
      })
    }.previewLayout(.sizeThatFits) // This removes device bezel
  }
}
