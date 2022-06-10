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
    var product_images:[ProductImage]
    var description:String?

}

extension Product{
    static func placeholder()-> Product{
        return Product(product_id: 7518761812156, title: "The Triple Threat", vendor: "Ghost Drops", price: "$22.50", product_type: "Pre Roll Packs", lineage: "hybrid", product_url: "https://cannacabana.com/products/the-triple-threat", product_images: [ProductImage(product_id: 7518761812156, image_id: "7e0243ac106072c99db912656be785e8764055c39d29012acbe5da66dbaf0f80", img_url: "http://cdn.shopify.com/s/files/1/0520/7713/4012/products/d4c69e0f-27de-4267-84bc-01c53c0f42f1_1000x1000.jpg?v=1653507531")], description: "no description")
    }
}

