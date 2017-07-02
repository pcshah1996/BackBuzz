//
//  NotificationItem.swift
//  BackBuzz
//
//  Created by Prateek Shah on 7/2/17.
//  Copyright © 2017 Prateek Shah. All rights reserved.
//

import Foundation

struct NotificationItem {
    var title: String
    var deadline: Date
    var UUID: String
    
    init(deadline: Date, title: String, UUID: String) {
        self.deadline = deadline
        self.title = title
        self.UUID = UUID
    }
}
