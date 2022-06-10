//
//  ProductImage.swift
//  bonsai
//
//  Created by justyn on 2022-05-31.
//

import Foundation

struct ProductImage:Decodable,Hashable{
    var product_id:Int
    var image_id:String
    var img_url:String
}
