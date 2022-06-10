//
//  Extensions.swift
//  bonsai
//
//  Created by justyn on 2022-05-18.
//

import SwiftUI
import Combine

// to apply touch locater view.
extension View {
    func onTouch(type: TouchLocatingView.TouchType = .all, limitToBounds: Bool = true, perform: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(TouchLocater(type: type, limitToBounds: limitToBounds, perform: perform))
    }
}

extension Double
{
    static func remap(from: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double
    {
        let fromAbs: Double  =  from - fromMin
        let fromMaxAbs: Double = fromMax - fromMin
        let normal: Double = fromAbs / fromMaxAbs
        let toMaxAbs = toMax - toMin
        let toAbs: Double = toMaxAbs * normal
        var to: Double = toAbs + toMin
        
        to = abs(to)
        
        // Clamps it
        if to < toMin { return toMin }
        if to > toMax { return toMax }
       
        return to
    }
}

extension Product{
    struct NetworkResponse: Decodable{
        var result: [Product]
    }
}

extension URLSession {
    func publisher<T: Decodable>(
        for url: URL,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: decoder)
            .map(\.result)
            .eraseToAnyPublisher()
    }
}

