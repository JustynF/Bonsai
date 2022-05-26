//
//  CardService.swift
//  bonsai
//
//  Created by justyn on 2022-05-25.
//

import Foundation
enum ProductsFetcherError: Error {
    case invalidURL
    case httpRequestFailed
    case missingData
   }
struct ProductService{
    
    
     func fetchProductsWith(limit:Int, offset:Int) async throws -> [Product]{
        let url = "http://localhost:8080/api/rest/products/"+String(limit)+"/"+String(offset)
        let response = try await makeUrlRequestWith(url: url)
        return response.products
       
    }
    
    private func makeUrlRequestWith(url:String) async throws -> ProductResponse{
        var result = ProductResponse(products: [])
        guard let url = URL(string: url)else{
            throw ProductsFetcherError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from:url)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                throw ProductsFetcherError.httpRequestFailed
            }
            result = try JSONDecoder().decode(ProductResponse.self, from: data)
            return result
          }
          catch {
              print("URLSession Error:",error)
          }
        return result
    }
}
