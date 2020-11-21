//
//  MaskView.swift
//  SwiftUI Playground
//
//  Created by Boris Yurkevich on 16/11/2020.
//

import SwiftUI

struct MaskView: View {
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .padding()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fit/*@END_MENU_TOKEN@*/)
            .mask(ContentView())
    }
}

struct MaskView_Previews: PreviewProvider {
    static var previews: some View {
        MaskView()
    }
}
