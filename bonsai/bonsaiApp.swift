//
//  bonsaiApp.swift
//  bonsai
//
//  Created by justyn on 2022-05-04.
//

import SwiftUI

@main
struct bonsaiApp: App {
    @StateObject var cardViewModel = ProductViewModel(service: ProductService())
    var body: some Scene {
        WindowGroup {
            ContentView(cardViewModel: cardViewModel)
        }
    }
}
