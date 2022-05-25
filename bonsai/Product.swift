//
//  Card.swift
//  bonsai
//
//  Created by justyn on 2022-05-20.
//


import Foundation

struct ProductResponse: Decodable,Hashable{
    var products : [Product]
}

struct Product: Decodable, Hashable {
    
    var product_id: Int
    var title: String
    var vendor: String
    var price: String
    var product_type: String
    var lineage: String
    var product_url: String
    var product_images:[ProductImages]

}

struct ProductImages:Decodable,Hashable{
    var product_id:Int
    var image_id:String
    var img_url:String
}
struct ProductLoader{
    var urlSession = URLSession.shared
    
 
    
}
