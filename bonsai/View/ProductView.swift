//
//  ProductDetailView.swift
//  bonsai
//
//  Created by justyn on 2022-05-26.
//

import SwiftUI
import Foundation


struct ProductView: View{
    @Environment(\.dismiss) var dismiss
    @ObservedObject var productDetailViewModel:ProductDetailViewModel
    private var productId:Int
    
    init(productId:Int,productDetailViewModel:ProductDetailViewModel){
        self.productId = productId
        self.productDetailViewModel = productDetailViewModel
    }
    var body: some View{
        GeometryReader{ geometry in
            ScrollView{
                Group{
                    VStack{
                        ProductDetailCarouselView(productDetailViewModel: self.productDetailViewModel)
                       .onAppear{
                            print("Product Detail Carousel Loaded")
                        }
                       .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                        ProductInfoView(productDetailViewModel: self.productDetailViewModel)
                    
                        
                        
                    }
                    .onAppear{
                        print("ProductDetailView Loaded")
                    }
                    
                    .task {
                        print("ProductDetail Task started")
                        await productDetailViewModel.fetchProduct(id: productId)
                        print("ProductDetail Task ended")
                    }
                }
            }

                
        }
    }
    
}


struct ProductDetailView_Preview:PreviewProvider{
    
    static var previews: some View{
        ProductView(productId:Product.placeholder().product_id ,productDetailViewModel: ProductDetailViewModel(productService: ProductService()))
    }
    
}
