//
//  WKUtils.swift
//  WatchApp
//
//  Created by Audrey Li on 5/22/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

public class WKUtils {
    public class func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}