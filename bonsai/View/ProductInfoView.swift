//
//  ProductDetailView.swift
//  bonsai
//
//  Created by justyn on 2022-05-31.
//

import Foundation
import SwiftUI


struct ProductInfoView:View{
    @ObservedObject var productDetailViewModel:ProductDetailViewModel
    
    var body: some View{
        HStack{
            Group{
                VStack{
                    HStack{
                        Text(productDetailViewModel.product.title)
                            .font(.title)
                            .bold()
                            .lineLimit(2)
                        
                        Spacer()
                        Spacer()
                    }
                    HStack{
                        Text(productDetailViewModel.product.price)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Text(productDetailViewModel.product.vendor)
                            .font(.subheadline)
                            .bold()
                        Text(productDetailViewModel.product.lineage)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                     Spacer()
                    }
                    Spacer()
                    HStack{
                        Text("Description")
                            .font(.headline)
                            .bold()
                        Spacer()
                    }
                    Text(productDetailViewModel.product.description ?? "Description N/A")
                    HStack{
                        Text(productDetailViewModel.product.product_url)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            
        }
    }
}
