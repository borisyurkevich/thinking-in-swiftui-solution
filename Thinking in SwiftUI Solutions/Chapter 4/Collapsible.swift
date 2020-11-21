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
            ForEach(data.indices,
                    content:{
                        child(at: $0)
                    })
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
    Group {
        Collapsible(alignment: .bottom, expanded: true, spacing: 4, data: [100, 50, 200], content: { size in
        Rectangle().frame(width: size, height: size)
      })
        Collapsible(expanded: false, data: [100, 50, 200], content: { width in
        Rectangle().frame(width: width, height: width)
      })
    }.previewLayout(.sizeThatFits) // This removes device bezel
  }
}
