//
//  BottomBarView.swift
//  bonsai
//
//  Created by justyn on 2022-05-24.
//
import SwiftUI
import Foundation
struct ViewFactory {
    static func button(_ name: String, renderingMode: Image.TemplateRenderingMode = .original) -> some View {
        Button(action: {}) {
            Image(name)
                .renderingMode(renderingMode)
                
        }
    }
}
struct BottomBarView: View {
    private var product:Product
    private var viewModel:ProductViewModel
    init(viewModel:ProductViewModel,product:Product){
        self.product=product
        self.viewModel=viewModel
    }
    var body: some View {
        HStack {
            ViewFactory.button("test")
            ViewFactory.button("back_icon", renderingMode: .template)
                .foregroundColor(.orange)
            Spacer()
            ViewFactory.button("close_icon", renderingMode: .template)
                .foregroundColor(.red)
            
            Spacer()
            ViewFactory.button("approve_icon", renderingMode: .template)
                .foregroundColor(.green)
            Spacer()
            ViewFactory.button("boost_icon", renderingMode: .template)
                .foregroundColor(.purple)
            
        }
        .padding([.leading, .trailing])
    }
}


