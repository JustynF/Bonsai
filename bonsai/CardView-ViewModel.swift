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

@MainActor class ProductViewModel: ObservableObject{
    
    enum ProductViewModelState {
        case na
        case loading
        case sucess(data: [Product])
        case failed(error: Error)
    }
    
    
    
    @Published private(set) var productLimit:Int = 5
    @Published private(set) var productOffset:Int = 0
    @Published private(set) var state: ProductViewModelState = .na
    
    private var products:[Product] = []
    private let service: ProductService
    
    init(service: ProductService){
        self.service = service
    }
    
    func getProducts() async ->Void{
        self.state = .loading
    }
  
    func refreshProducts() async throws ->Void {
        self.state = .loading
        do{
            self.products = try await self.service.fetchProductsWith(limit: self.productLimit, offset: self.productOffset)
            
            self.state  = .sucess(data: self.products)
            
        }catch{
            print("Update Product Error",error)
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
        self.state = .sucess(data: self.products)
     
    }
    
    
    
}
