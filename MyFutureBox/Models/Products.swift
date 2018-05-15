//
//  CurrentWeekInformation.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation


struct CurrentWeeklyInfo: Decodable {
    
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products = "Products"
    }
}
