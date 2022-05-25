//
//  DateView-ViewModel.swift
//  bonsai
//
//  Created by justyn on 2022-05-23.
//

import Foundation

extension DateView{
    @MainActor class DateViewModel:ObservableObject{
        
        private var dateFormatter = DateFormatter()
        
        func getDate() -> String{
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            var currentDate = dateFormatter.string(from: Date.now)
            return currentDate
        }
    }
}
