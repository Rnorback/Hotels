//
//  Hotel.swift
//  Hotels
//
//  Created by Rob Norback on 1/6/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

struct Hotel {
    var imageUrl:String
    var thumbnailUrl:String
    var name:String
    var starRating:Int
    var price:Int
    var location:CLLocation
}

// This class is in charge of deserializing the web requests and passing them on in a completion block
class HotelModelManager {

    class func getHotelsForLocation(location:Location, completion:([Hotel])->Void, errorBlock:(UIAlertController)->Void) {
        WebServices.getHotelDataForLocation(location, completion: { (json) -> Void in
            
            let data = json["body"]["HotelListResponse"]["HotelList"]["HotelSummary"]
            var hotels:[Hotel] = []
            for hotelData in data.arrayValue {
                let name = hotelData["name"].stringValue
                let starRating = hotelData["hotelRating"].intValue
                let price = hotelData["highRate"].intValue
                let longitude = hotelData["longitude"].doubleValue
                let latitude = hotelData["latitude"].doubleValue
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let imageUrl = hotelData["media"][0]["url"].stringValue
                let thumbnailUrl = hotelData["media"][0]["thumbnailUrl"].stringValue
                let hotel = Hotel(imageUrl: imageUrl, thumbnailUrl: thumbnailUrl, name: name, starRating: starRating, price: price, location: location)
                hotels.append(hotel)
            }
            completion(hotels)
            
            }, errorBlock: { (error) -> Void in
                // Create an alert when there is an error and pass it in the error block
                let alertController = UIAlertController(title: "Error Retrieving Hotels in \(location.rawValue)", message:
                    "\(error.localizedDescription)", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                errorBlock(alertController)
        })
    }
}
