//
//  Product.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation

struct Product {
    
    var investorProductId: Int
    var moneybox: Double
    var subscriptionAmount: Double
    var planValue: Double
    var annualLimit: Double
    var depositLimit: Double
    var productFriendlyName: String
    var isFavourite: Bool
    
    enum CodingKeys: String, CodingKey {
        case investorProductId = "InvestorProductId"
        case moneybox = "Moneybox"
        case subscriptionAmount = "SubscriptionAmount"
        case planValue = "PlanValue"
        case productInfo
        case isFavourite = "IsFavourite"
    }
    
    enum ProductInfoKeys: String, CodingKey {
        case annualLimit = "AnnualLimit"
        case depositLimit = "DepositLimit"
        case productFriendlyName = "ProductFriendlyName"
    }
    
}

extension Product: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        investorProductId = try values.decode(Int.self, forKey: .investorProductId)
        moneybox = try values.decode(Double.self, forKey: .moneybox)
        subscriptionAmount = try values.decode(Double.self, forKey: .subscriptionAmount)
        planValue = try values.decode(Double.self, forKey: .planValue)
        isFavourite = try values.decode(Bool.self, forKey: .isFavourite)
        
        let additionalInfo = try values.nestedContainer(keyedBy: ProductInfoKeys.self, forKey: .productInfo)
        annualLimit = try additionalInfo.decode(Double.self, forKey: .annualLimit)
        depositLimit = try additionalInfo.decode(Double.self, forKey: .depositLimit)
        productFriendlyName = try additionalInfo.decode(String.self, forKey: .productFriendlyName)
    }
}
