//
//  StringHelper.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 17/07/23.
//

import Foundation

public class StringHelper: NSObject {
    //String helper to convert minutes to hours and minutes
    public func convertMinutesToHoursMinutes(minutesString: String) -> String? {
        if let minutes = Int(minutesString) {
            let hours = minutes / 60
            let remainingMinutes = minutes % 60
            
            return "\(hours)h \(remainingMinutes)m"
        } else {
            return nil
        }
    }
}
