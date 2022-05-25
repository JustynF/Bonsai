//
//  CardViewContainer.swift
//  bonsai
//
//  Created by justyn on 2022-05-24.
//

import Foundation
import SwiftUI

struct ContentView:View{
    @ObservedObject var cardViewModel:ProductViewModel
    var body: some View{
        GeometryReader{
            geometry in
            
            TabView{
                CardViewContainer(productViewModel: cardViewModel)
                    .tabItem {
                        Image(systemName: "star.fill")
                                Text("Feed")
                    }
            }
        
    }
        
        
    }
}




