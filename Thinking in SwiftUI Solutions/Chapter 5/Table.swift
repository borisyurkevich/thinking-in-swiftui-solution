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
    
    func cellFor(row: Int, column: Int) -> some View {
        cells[row][column]
            .widthPreference(column: column)
            .frame(width: columnWidth[column], alignment: .leading)
            .padding(5)
    }
    
    @State var columnWidth: [Int: CGFloat] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(cells.indices) { row in
                HStack(alignment: .top) {
                    ForEach(self.cells[row].indices) { column in
                        self.cellFor(row: row, column: column)
                    }
                }
                .background(row.isMultiple(of: 2) ?
                                Color(.secondarySystemBackground) : Color(.systemBackground)
                )
            }
        }
        .onPreferenceChange(WidthPreference.self) { self.columnWidth = $0 }
    }
}

struct WidthPreference: PreferenceKey {
    
    static let defaultValue: [Int: CGFloat] = [:]
        
    static func reduce(value: inout Value,
                       nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}


extension View {
    func widthPreference(column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: WidthPreference.self,
                                   value: [column: proxy.size.width])
        })
    }
}

struct Chapter5_Previews: PreviewProvider {
    static var previews: some View {
        Chapter5()
    }
}
