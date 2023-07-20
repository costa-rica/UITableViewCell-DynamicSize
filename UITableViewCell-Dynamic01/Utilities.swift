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
