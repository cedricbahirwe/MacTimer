//
//  LargeText.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 20/06/2021.
//

import SwiftUI


struct LargeText: View {
    let text: String
    
    init(_ value: String) {
        self.text = value
    }
    var body: some View {
        Text(text)
            .font(.system(size: 55, weight: .bold))
    }
}


struct LargeText_Previews: PreviewProvider {
    static var previews: some View {
        LargeText("Danger")
    }
}
