//
//  SettingsInterfaceController.swift
//  WatchApp
//
//  Created by Audrey Li on 5/22/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {
    @IBOutlet weak var timeSlider: WKInterfaceSlider!

    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    var timeToPlay: NSTimeInterval = 3
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let timeToPlay = context as? NSTimeInterval {
            self.timeToPlay = timeToPlay
        }
        timeLabel.setText("\(timeToPlay)")
        timeSlider.setValue(Float(timeToPlay))
       
    }
    @IBAction func sliderValueChanged(value: Float) {
        timeToPlay = NSTimeInterval(value)
        timeLabel.setText("\(timeToPlay)")
    }
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        return timeToPlay
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
