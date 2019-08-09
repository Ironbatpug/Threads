//
//  RealmConfig.swift
//  Threads
//
//  Created by Molnár Csaba on 2019. 08. 09..
//  Copyright © 2019. Molnár Csaba. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfig {
    static var runDataConfig: Realm.Configuration{
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALM_RUN_CONFIG)
        let config = Realm.Configuration(
            fileURL: realmPath,
            schemaVersion: 0,
            migrationBlock: {migration, oldSchemaVerion in
                if (oldSchemaVerion < 0 ){
                    
                }
                
            })
        return config
    }
}

