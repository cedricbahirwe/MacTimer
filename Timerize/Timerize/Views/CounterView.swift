//
//  CounterView.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 20/06/2021.
//

import SwiftUI

struct CounterView: View {
    let title: String
    let left: String
    let right: String
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 0) {
                LargeText(left)
                LargeText(right)
            }
            .frame(width: 110, height: 70)
            .background(Color.white)
            .cornerRadius(12)
            .foregroundColor(.black)
            
            Text(title)
                .font(.headline)
        }
        .frame(width: 110)
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(title: "Hours", left: "0", right: "3")
    }
}
