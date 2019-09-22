//
//  Meal.swift
//  FoodTrackerApp
//
//  Created by Sharetrip-iOS on 9/22/19.
//  Copyright © 2019 Tbbd iOS. All rights reserved.
//

import UIKit
import os.log

struct PropertyKey {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
}

class Meal: NSObject, NSCoding{
    required convenience init?(coder aDecoder: NSCoder) {

        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }

        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage

        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)

        // Must call designated initializer.
        self.init(name: name, photo: photo!, rating: rating)

    }

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
    }


    //MARK: Properties

    var name: String
    var photo: UIImage?
    var rating: Int

    init?(name: String, photo: UIImage, rating: Int) {
       // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }

        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }

        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
