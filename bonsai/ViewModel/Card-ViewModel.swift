//
//  ContentView-ViewModel.swift
//  bonsai
//
//  Created by justyn on 2022-05-16.
//

import Foundation
import SwiftUI


struct NetworkResponse <Wrapped: Decodable>: Decodable{
    var result:Wrapped
    enum CodingKeys: String, CodingKey {
           case result = "products"
           
       }
}

@MainActor class CardViewModel: ObservableObject{
    
    enum ProductViewModelState {
        case initial
        case loading
        case sucess(data: [Product])
        case failed(error: Error)
    }
    enum ProductListState {
        case initial
        case empty
        case full
    }
    
    
    
    @Published private(set) var productLimit:Int = 5
    @Published private(set) var productOffset:Int = 0
    @Published private(set) var state: ProductViewModelState = .initial
    @Published private(set) var productListState: ProductListState = .initial
    
    
    private var products:[Product] = []
    private let service: ProductService
    
    init(service: ProductService){
        self.service = service
    }
    
    func refreshProducts() async throws ->Void {
        self.state = .loading
        do{
            self.products = try await self.service.fetchProductsWith(limit: self.productLimit, offset: self.productOffset)
            
            self.productOffset = self.productOffset + self.productLimit

            self.state  = .sucess(data: self.products)
            self.productListState = .full
            
        }catch{
            print("Refresh Product Error",error)
            self.state  = .failed(error: error)
        }
        
    }
    
    
    func removeProduct(removedProduct:Product)-> Void{
        self.state = .loading
        self.products.removeAll(){
            print($0.product_id)
            print(removedProduct.product_id)
            return $0.product_id == removedProduct.product_id
        }
        if self.products.count==0{
            self.productListState = .empty
            
        }
        self.state = .sucess(data: self.products)
        
    }
    
    
    
}
