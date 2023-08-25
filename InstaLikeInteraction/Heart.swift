//
//  Heart.swift
//  InstaLikeInteraction
//
//  Created by Giorgio Latour on 8/24/23.
//

import SwiftUI

struct Heart: View {
    let id: UUID = UUID()
    let x: CGFloat
    let y: CGFloat
    @State var rotation: Double = Double.random(in: -20...20)
    
    let gradient: LinearGradient = {
        let startEndPairs: [(UnitPoint, UnitPoint)] = [
            (UnitPoint.bottom, UnitPoint.top),
            (UnitPoint.top, UnitPoint.bottom),
            (UnitPoint.leading, UnitPoint.trailing),
            (UnitPoint.trailing, UnitPoint.leading),
            (UnitPoint.topTrailing, UnitPoint.bottomLeading),
            (UnitPoint.bottomLeading, UnitPoint.topTrailing),
            (UnitPoint.topLeading, UnitPoint.bottomTrailing),
            (UnitPoint.bottomTrailing, UnitPoint.topLeading)
        ]
        
        let positions = startEndPairs.randomElement()!
        
        return LinearGradient(colors: [Color("Pink"), Color("Red"), Color("Orange")],
                              startPoint: positions.0,
                              endPoint: positions.1
        )
    }()
    
    let size: CGSize = CGSize(width: 100, height: 80)
    
    var body: some View {
        gradient
            .frame(width: size.width, height: size.height)
            .mask {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: size.width, height: size.height)
            }
            .shadow(color: Color("Red").opacity(0.4), radius: 10)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
                    rotation = rotation + Double.random(in: -40...40)
                }
            }
    }
}

struct Heart_Previews: PreviewProvider {
    static var previews: some View {
        Heart(x: 0, y: 0)
    }
}
