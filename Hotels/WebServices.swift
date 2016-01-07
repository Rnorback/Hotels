//
//  WebServices.swift
//  Hotels
//
//  Created by Rob Norback on 1/6/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Location:String {
    case SanFran = "San Francisco"
    case Minneapolis = "Minneapolis"
}

let sanFranUrl = "http://www.mobiata.com/testfiles/sanfran-short.json"
let minneapolisUrl = "http://www.mobiata.com/testfiles/minneapolis-short.json"

// This class is in charge of all url requests
class WebServices {
    
    class func getHotelDataForLocation(location:Location, completion:(JSON)->Void, errorBlock:(NSError)->Void) {
        var urlString = ""
        switch location {
        case .SanFran:
            urlString = sanFranUrl
        case .Minneapolis:
            urlString = minneapolisUrl
        }
        
        Alamofire.request(.GET, urlString)
        .validate()
        .responseJSON { request, response, result in
            switch result {
            case .Success(let responseObject):
                let json = JSON(responseObject)
                completion(json)
            case .Failure(_, let error as NSError):
                errorBlock(error)
            default:
                break
            }
        }
    }
}