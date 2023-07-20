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

// Crops from both sides evenly no aspect ratio adjustment
func cropImage(image: UIImage, width: CGFloat) -> UIImage? {
    let originalSize = image.size
    let originalWidth = originalSize.width
    let originalHeight = originalSize.height
    
    // Calculate the desired height based on the original aspect ratio
    let scaleFactor = width / originalWidth
    let croppedHeight = originalHeight * scaleFactor
    
    // Calculate the crop rect
    let cropRect = CGRect(x: (originalWidth - width) / 2, y: 0, width: width, height: croppedHeight)
    
    // Perform the crop operation
    if let croppedImage = image.cgImage?.cropping(to: cropRect) {
        return UIImage(cgImage: croppedImage)
    }
    
    return nil
}

func createDividerLine(thicknessOfLine:CGFloat) -> UIImageView{
    let screenWidth = UIScreen.main.bounds.width
    let lineImage = UIImage(named: "line01")
    
    let lineImageScreenWidth = cropImage(image: lineImage!, width: screenWidth)
    let cropThin = CGRect(x:0,y:0,width:screenWidth,height:thicknessOfLine)
    let lineImageScreenWidthThin = lineImageScreenWidth?.cgImage?.cropping(to: cropThin)
    let imageViewLine = UIImageView(image: UIImage(cgImage: lineImageScreenWidthThin!))
//    imageViewLine.layer.opacity = 0.6
    imageViewLine.layer.opacity = 0.1
    return imageViewLine
}
