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
    var body: some View {
        HStack {

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

struct BottomBarView_Previews: PreviewProvider {
    static var product = Product(product_id: 12, title: "Spike", vendor: "Verse", price: "39.99", product_type: "Concentrates", lineage: "Sativa", product_url: "", product_images: [ProductImages(product_id: 12, image_id: "144", img_url: "url")])
    static var previews: some View {
        
        BottomBarView()
    }
    
}
