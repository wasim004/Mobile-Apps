//
//  Trip.swift
//  TripCard
//
//  Created by Wasim Ahmad on 4/12/17.
//  Copyright © 2017 Wasim Ahmad. All rights reserved.
//

import UIKit
import Parse
struct Trip {
    var tripId = ""
    var city = ""
    var country = ""
    var featuredImage: PFFile?
    var price:Int = 0
    var totalDays:Int = 0
    var isLiked = false
    init(tripId: String, city: String, country: String, featuredImage: PFFile!,
         price: Int, totalDays: Int, isLiked: Bool) {
        self.tripId = tripId
        self.city = city
        self.country = country
        self.featuredImage = featuredImage
        self.price = price
        self.totalDays = totalDays
        self.isLiked = isLiked
    }
    init(pfObject: PFObject) {
        self.tripId = pfObject.objectId!
        self.city = pfObject["city"] as! String
        self.country = pfObject["country"] as! String
        self.price = pfObject["price"] as! Int
        self.totalDays = pfObject["totalDays"] as! Int
        self.featuredImage = pfObject["featuredImage"] as? PFFile
        self.isLiked = pfObject["isLiked"] as! Bool
    }
        func toPFObject() -> PFObject {
            let tripObject = PFObject(className: "Trip")
            tripObject.objectId = tripId
            tripObject["city"] = city
            tripObject["country"] = country
            tripObject["featuredImage"] = featuredImage
            tripObject["price"] = price
            tripObject["totalDays"] = totalDays
            tripObject["isLiked"] = isLiked
            return tripObject
        }
    }
