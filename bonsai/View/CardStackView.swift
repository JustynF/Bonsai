//
//  ContentView.swift
//  bonsai
//
//  Created by justyn on 2022-05-04.
//

import SwiftUI

struct CardStackView: View {
    @ObservedObject var productViewModel:CardViewModel
    
    
    var body: some View {
       
            VStack{
                GeometryReader{ geometry in
                    LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 0.8509803922, green: 0.6549019608, blue: 0.7803921569, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                                        .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                    

                        VStack{
                            DateView()
                            switch productViewModel.state{
                            case .sucess(let products):
                            Spacer()
                            ZStack{
                                ForEach(products,id: \.product_id){ product in
                                    Group{
                                            CardView(product: product,viewModel: productViewModel) { removedProduct in
                                                self.productViewModel.removeProduct(removedProduct: removedProduct)
                                            }
                                    }
                                    
                                }
                            }
                            case .loading:
                                ProgressView()
                                
                            default:
                                EmptyView()
                            }
                        }
                   
                }
                
            }.task {
                do{
                    try await productViewModel.refreshProducts()
                }catch{
                    print("Error Loading Products error",error)
                }
            }.task(id:productViewModel.productListState){
                switch productViewModel.productListState{
                case .empty:
                    do{
                        try await productViewModel.refreshProducts()
                    }catch{
                        print("error",error)
                    }
                default:
                    break
                }
            }
    }
}


