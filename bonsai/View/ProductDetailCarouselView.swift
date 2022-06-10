//
//  ProductDetailCarouselView.swift
//  bonsai
//
//  Created by justyn on 2022-05-31.
//

import Foundation
import SwiftUI

struct ProductDetailCarouselView:View{
    
    @ObservedObject var  productDetailViewModel:ProductDetailViewModel
    

    var body: some View{
        GeometryReader{ geometry in
            CarouselView(numberOfImages: self.productDetailViewModel.product.product_images.count){
                Group{
                    ForEach(self.productDetailViewModel.product.product_images, id:\.image_id){img in
                        let img_url = "https"+img.img_url.dropFirst(4)
                        AsyncImage(url:URL(string: img_url)){ phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                            }else if phase.error != nil{
                                Color.blue
                            }else{
                                ProgressView()
                        }
                            
                        }.onAppear{
                            print("ProductDetail Image Loaded ", img.image_id)
                        }
                    }
                }
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                .clipped()
                .animation(.interactiveSpring())
            }
            
        }
    }
}
