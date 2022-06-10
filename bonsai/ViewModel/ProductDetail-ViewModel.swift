//
//  ProductView-ViewModel.swift
//  bonsai
//
//  Created by justyn on 2022-05-30.
//

import Foundation
import SwiftUI


@MainActor class ProductDetailViewModel:ObservableObject{
    
    private var prodcuctService:ProductService
    @Published private(set) var product:Product = Product.placeholder()
    
    init(productService:ProductService){
        self.prodcuctService = productService
    }
    
    func fetchProduct(id:Int) async ->  Void{
        
        do{
            let response = try await self.prodcuctService.fetchProductsWith(id: id)
            self.product = response[0]
            
        }catch{
            print("Failed to fetch ProductDetail", error )
        }
    }
    
    
}
