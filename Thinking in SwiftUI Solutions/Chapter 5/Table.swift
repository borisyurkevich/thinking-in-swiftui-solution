//
//  Table.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 24/11/2020.
//

import SwiftUI

struct Chapter5: View {
    
    var cells = [
        [Text(""), Text("Monday").bold(), Text("Tuesday").bold(),
         Text("Wednesday").bold()],
        
        [Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
        
        [Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")]
    ]

    var body: some View {
        Table(cells: cells)
            .font(Font.system(.body, design: .serif))
    }
}

struct Table: View {
    
    let cells: [[Text]]
    
    func colorForIndex(idx: Int) -> Color {
        if idx % 2 == 0 {
            return Color.white
        } else {
            return Color.gray
        }
    }
    
    @State var maxWidth:[CGFloat] = [200, 100, 100]
    
    var body: some View {
        HStack() {
            ForEach(cells.indices) { idx in
                VStack(alignment:.leading) {
                    ForEach(cells.indices) { idx2 in
                        cells[idx2][idx]
                            .background(GeometryReader { proxy in
                                colorForIndex(idx: idx)
                                    .preference(key: ColumnWidth.self, value: proxy.size.width)
                            })
                            .onPreferenceChange(ColumnWidth.self) {
                                self.maxWidth[idx] = $0
                                
                            }
                    }
                }.frame(width: maxWidth[idx])
            }
        }
    }
}

struct ColumnWidth: PreferenceKey {
    
    static let defaultValue: CGFloat = 100
        
    static func reduce(value: inout CGFloat,
                       nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }// this suppose to combine all the values and find the largest
}

struct Chapter5_Previews: PreviewProvider {
    static var previews: some View {
        Chapter5()
            .previewLayout(.sizeThatFits)
    }
}
