//
//  AsyncImageCarouselView.swift
//  bonsai
//
//  Created by justyn on 2022-05-23.
//
import SwiftUI
import Combine

import Foundation

struct CarouselView<Content: View>: View{
    private var numberOfImages: Int
    private var content: Content
    
    @State private var currentIndex: Int = 0
    @State private var tapPoisition:CGPoint = CGPoint(x:0,y:0)
    
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
            self.numberOfImages = numberOfImages
            self.content = content()
        }
    var body: some View {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .onTouch{ CGPoint in
                    self.tapPoisition = CGPoint
                }.onTapGesture {
                    if(self.tapPoisition.x>geometry.size.width/2){
                        self.currentIndex = self.currentIndex < numberOfImages-1 ? self.currentIndex+1 : self.currentIndex
                    }else{
                        self.currentIndex = self.currentIndex > 0 ? self.currentIndex-1 : self.currentIndex
                    }
                }
            }
        }
}
