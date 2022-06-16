//
//  CardViewContainer.swift
//  bonsai
//
//  Created by justyn on 2022-05-24.
//

import Foundation
import SwiftUI

struct ContentView:View{
    @ObservedObject var cardViewModel:CardViewModel
    var body: some View{
        GeometryReader{
            geometry in
            
            TabView{
                CardStackView(productViewModel: cardViewModel)
                    .tabItem {
                        Image(systemName: "star.fill")
                                Text("Feed")
                    }
            }
        
    }
        
        
    }
}




