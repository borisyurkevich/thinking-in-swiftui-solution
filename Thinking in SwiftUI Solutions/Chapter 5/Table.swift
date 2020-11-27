//
//  Table.swift
//  Thinking in SwiftUI Solutions
//
//  Created by Boris Yurkevich on 24/11/2020.
//

import SwiftUI

struct Chapter5: View {
    
    var cells = [
        [Cell(Text("")), Cell(Text("Monday").bold()), Cell(Text("Tuesday").bold()),
         Cell(Text("Wednesday").bold())],

        [Cell(Text("Berlin").bold()), Cell(Text("Cloudy")), Cell(Text("Mostly\nSunny")), Cell(Text("Sunny"))],

        [Cell(Text("London").bold()), Cell(Text("Heavy Rain")), Cell(Text("Cloudy")), Cell(Text("Sunny"))]
    ]

    var body: some View {
        Table(cells: cells)
            .font(Font.system(.body, design: .serif))
    }
}

struct Cell<Content: View>: View {
    
    init(_ content: Content) {
        self.content = content
    }
    
    let content: Content
    
    @State var isSelected: Bool = false
    
    var body: some View {
        if isSelected {
            content
                .border(Color.blue)
        } else {
            content
        }
    }
}

struct SelectedModifier: ViewModifier {
    var selected: Bool
    
    func body(content: Content) -> some View {
        if selected {
            return content.border(Color.red)
        } else {
            return content.border(Color.clear)
        }
    }
}

struct Table: View {
    
    let cells: [[Cell<Text>]]
    
    @State var columnWidth: [Int: CGFloat] = [:]
    @State var selectedCell: (Int, Int)? = nil // Selected row and column
    
    func colorForIndex(idx: Int) -> Color {
        if idx.isMultiple(of: 2) {
            return Color(.secondarySystemGroupedBackground)
        } else {
            return Color(.systemGroupedBackground)
        }
    }
    
    func cellFor(row: Int, column: Int) -> some View {
        cells[row][column]
            .widthPreference(column: column)
            .frame(width: columnWidth[column], alignment: .leading)
            .padding(5)
            .border(Color.purple)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(cells.indices) { row in
                HStack(alignment: .top) {
                    ForEach(self.cells[row].indices) { column in
                        self.cellFor(row: row, column: column)
                            .onTapGesture {
                                withAnimation {
                                    selectedCell = (row, column)
                                }
                            }
                            .anchorPreference(key: BoundsKey.self, value: .bounds, transform: { anchor in
                                selectedCell ?? (-1, -1) == (row, column) ? anchor : nil
                            })
                    }
                }
                .background(colorForIndex(idx: row))
            }
        }
        .overlayPreferenceValue(BoundsKey.self, { anchor in
            if let anchor = anchor {
                GeometryReader { proxy in
                    Rectangle()
                        .fill(Color.clear)
                        .border(Color.red, width: 2)
                        .frame(width: proxy[anchor].width, height: proxy[anchor].height)
                        .offset(x: proxy[anchor].minX, y: proxy[anchor].minY)
                        .frame(width: proxy[anchor].size.width, height: proxy[anchor].height, alignment: .bottomLeading)
                }
            }
        })
        .onPreferenceChange(WidthPreference.self) { self.columnWidth = $0 }
    }
}

// MARK: Layout

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

// MARK: Selection

struct BoundsKey: PreferenceKey {
    
    static var defaultValue: Anchor<CGRect>? = nil
        
    static func reduce(value: inout Value,
                       nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}

struct Chapter5_Previews: PreviewProvider {
    static var previews: some View {
        Chapter5()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
