//
//  Crew.swift
//  Tenzortest
//
//  Created by Иван Суслов on 31.05.2021.
//

import Foundation

struct Crew: Codable{
    var adult: Bool
    var gender: Int?
    var id: Int
    var known_for_department:String
    var name: String
    var original_name: String
    var popularity: Double
    var profile_path:String?
    var credit_id:String
    var department: String
    var job: String
}
