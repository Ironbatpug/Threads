//
//  RunCell.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 08..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {
    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var runDateLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(run: Run) {
        print(run)
        
        
        
        runDurationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        runDateLbl.text = run.date.getDateString()
    }

}
