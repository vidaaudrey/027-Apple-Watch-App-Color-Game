//
//  ScoreInterfaceController.swift
//  WatchApp
//
//  Created by Audrey Li on 5/22/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import WatchKit
import Foundation


class ScoreInterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let scores:[String] = NSUserDefaults.standardUserDefaults().valueForKey(WKConfig.UserDefaultScoreName) as? [String] {
        
            table.setNumberOfRows(scores.count, withRowType: WKConfig.TableRowType)
            for (index, score) in enumerate(scores) {
                let row = table.rowControllerAtIndex(index) as! TableRowController
                row.textLabel.setText("\(score)")
            }
            
            
      
        }

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
