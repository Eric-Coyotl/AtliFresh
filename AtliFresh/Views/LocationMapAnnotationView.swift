//
//  LocationMapAnnotationView.swift
//  Atli
//
//  Created by Eric Coyotl on 8/2/23.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "cart.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width:10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-2)
                .padding(.bottom, 38)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            LocationMapAnnotationView()
        }
    }
}
