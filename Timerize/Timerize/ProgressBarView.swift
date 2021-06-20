//
//  ProgressBarView.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 15/06/2021.
//

import SwiftUI

struct ProgressBar: View {

    let progress: CGFloat

    private var barColor: Color
    private var animationTime: TimeInterval = 0.3

    public init(initialProgress: CGFloat, color: Color) {
        self.progress = initialProgress
        self.barColor = color
    }
    
    
    var computedColor: Color {
        return progress > 0.7 ? barColor : progress > 0.3 ? .yellow : .red
    }
    

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Main Bar
                Rectangle()
                    .fill(Color(.systemGray).opacity(0.8))

                // Progress Bar
                Rectangle()
                    .fill(computedColor)
                    .frame(width: min(geo.size.width, geo.size.width * progress))
                    .animation(.linear)
            }.cornerRadius(25.0)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(initialProgress: 0.5, color: .orange)
    }
}
