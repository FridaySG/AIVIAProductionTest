//
//  HeroObject.swift
//  AiviaProdTest
//
//  Created by Adam on 2020-01-19.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

//Codable object meant to directly absorb the JSON values using swift built-in decoding
struct HeroData: Codable{
    var id: Int?
    var name: String?
    var identity: String?
    var group: String?
    var place_of_origin: String?
    var publisher: String?
}

struct HeroObject: Codable{

    var data: [HeroData]
    
}


