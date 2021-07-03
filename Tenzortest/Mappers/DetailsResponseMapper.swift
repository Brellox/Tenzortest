//
//  DetailsResponseMapper.swift
//  Tenzortest
//
//  Created by Иван Суслов on 31.05.2021.
//

import Foundation

class DetailsResponseMapper {
    
    private let castMapper = DetailsJsonToCastMapper()
    private let crewMapper = DetailsJsonToCrewMapper()
    
    func map(data: Data?) throws -> DetailsApiResponse {
        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
        let id = json.value(forKey: "id") as! Int
        let cast = try (json["cast"] as! NSArray).map { try self.castMapper.map(data: $0 as! NSDictionary)}
        let crew = try (json["crew"] as! NSArray).map { try self.crewMapper.map(data: $0 as! NSDictionary)
        }
        
        return DetailsApiResponse(id: id, cast: cast, crew:crew )
    }
}


class DetailsJsonToCastMapper {
    
    func map(data: NSDictionary) throws -> Cast {
        return Cast(
            adult: data.value(forKey: "adult") as! Bool,
            gender: data.value(forKey: "gender") as? Int,
            id: data.value(forKey: "id") as! Int,
            known_for_department: data.value(forKey: "known_for_department") as! String,
            name: data.value(forKey: "name") as! String,
            original_name: data.value(forKey: "original_name") as! String,
            popularity: data.value(forKey: "popularity") as! Double,
            profile_path: data.value(forKey: "profile_path") as? String,
            cast_id: data.value(forKey: "cast_id") as! Int,
            character: data.value(forKey: "character") as! String,
            credit_id: data.value(forKey: "credit_id") as! String,
            order: data.value(forKey: "order") as! Int
        )
    }
}

    class DetailsJsonToCrewMapper {
        
        func map(data: NSDictionary) throws -> Crew {
            return Crew(
                adult: data.value(forKey: "adult") as! Bool,
                gender: data.value(forKey: "gender") as? Int,
                id: data.value(forKey: "id") as! Int,
                known_for_department: data.value(forKey: "known_for_department") as! String,
                name: data.value(forKey: "name") as! String,
                original_name: data.value(forKey: "original_name") as! String,
                popularity: data.value(forKey: "popularity") as! Double,
                profile_path: data.value(forKey: "profile_path") as? String,
                credit_id: data.value(forKey: "credit_id") as! String,
                department: data.value(forKey: "department") as! String,
                job: data.value(forKey: "job") as! String
            )
        }
    }
