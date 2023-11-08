//
//  SharedViews.swift
//  AtliFresh
//
//  Created by Eric Coyotl on 11/7/23.
//

import SwiftUI

internal struct labelDivider: View {
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

internal struct ThemeButton: ButtonStyle {
    let width: CGFloat
    let backColor: Color
    let textColor: Color
    
    init(backColor: Color = .blue, textColor: Color = .primary, buttonWidth: CGFloat = 150){
        self.backColor = backColor
        self.textColor = textColor
        self.width = buttonWidth
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: self.width)
            .background(self.backColor)
            .foregroundColor(self.textColor)
            .font(.title2)
            .fontWeight(.semibold)
            .cornerRadius(100)
    }
}
