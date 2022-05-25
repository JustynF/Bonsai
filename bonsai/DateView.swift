//
//  DateView.swift
//  bonsai
//
//  Created by justyn on 2022-05-20.
//

import SwiftUI

struct DateView: View {
    @StateObject private var dateViewModel = DateViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(dateViewModel.getDate())
                        .font(.title)
                        .bold()
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
