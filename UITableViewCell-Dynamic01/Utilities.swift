//
//  Utilities.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit


func widthFromPct(percent:Float) -> CGFloat {
    let screenWidth = UIScreen.main.bounds.width
    let width = screenWidth * CGFloat(percent/100)
    return width
}

func heightFromPct(percent:Float) -> CGFloat {
    let screenHeight = UIScreen.main.bounds.height
    let height = screenHeight * CGFloat(percent/100)
    return height
}

func convertStringToDate(date_string: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
//    let dateString = "2023-04-15 22:24:07.848128"
    let date = dateFormatter.date(from: date_string)!
    
    // use this date
    // let formattedDateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
    return date
}

func sizeLabel(lbl:UILabel)  -> UILabel{
    let maximumLabelSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    
    // Call sizeThatFits on the label with the maximum size. The method will return the optimal size of the label.
    let expectedLabelSize: CGSize = lbl.sizeThatFits(maximumLabelSize)
    
    lbl.frame = CGRect(x: lbl.frame.origin.x, y: lbl.frame.origin.y, width: expectedLabelSize.width, height: expectedLabelSize.height)
    
    return lbl
}
