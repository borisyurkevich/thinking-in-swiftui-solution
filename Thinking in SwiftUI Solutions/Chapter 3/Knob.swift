//
//  ContentView.swift
//  Knob
//
//  Created by Chris Eidhof on 05.11.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }
    func knobColor(_ color: Color?) -> some View {
        environment(\.knobColor, color)
    }
}

fileprivate struct KnobColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}
extension EnvironmentValues {
    var knobColor: Color? {
        get { self[KnobColorKey.self] }
        set { self[KnobColorKey.self] = newValue }
    }
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    var pointerSize: CGFloat? = nil
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobColor) var customColor

    var body: some View {
         KnobShape(pointerSize: pointerSize ?? envPointerSize)
            .fill(fillColor)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
    
    var fillColor: Color {
        customColor ?? (colorScheme == .dark ? Color.white : Color.black)
    }
    // Just syntatic sugar for if else inside
    // of another if else
    // if custom color
    //    custom color
    // else
    // if color schema is dark
    //    white
    // else
    //     black
}

struct KnobMainView: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.1
    @State var hueValue: Double = 0.1
    @State var useDefaultColor = true

    var body: some View {
        VStack {
            Knob(value: $value)
                .frame(width: 100, height: 100)
                .knobPointerSize(knobSize)
                .knobColor(useDefaultColor ? nil : Color(hue: hueValue, saturation: 0.66, brightness: 0.66))
                
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            HStack {
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
            }
            HStack {
                Text("Knob Color")
                Slider(value: $hueValue, in: 0...1)
            }
            Toggle(isOn: $useDefaultColor) {
                Text("Default Color")
            }
            Button("Toggle", action: {
                withAnimation(.default) {
                    value = value == 0 ? 1 : 0
                }
            })
        }
    }
}

struct KnobMainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KnobMainView()
                .preferredColorScheme(.light)
            KnobMainView()
                .preferredColorScheme(.dark)
        }.previewLayout(.sizeThatFits)
    }
}
