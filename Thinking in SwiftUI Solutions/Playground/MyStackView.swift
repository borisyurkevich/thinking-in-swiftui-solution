//
//  MyStackView.swift
//  SwiftUI Playground
//
//  Created by Boris Yurkevich on 16/11/2020.
//

import SwiftUI

struct MyStackView: View {
    var body: some View {
        HStack() {
            Rectangle().fill(Color.blue)
                .frame(width: 50, height: 50)
            Rectangle().fill(Color.green)
                .frame(width: 30, height: 30)
            Rectangle().fill(Color.red)
                .frame(width: 40, height: 40)
        }.border(Color.black)
    }
}

struct MyStackView_Previews: PreviewProvider {
    static var previews: some View {
        MyStackView()
    }
}
