//
//  HotelDetailVC.swift
//  Hotels
//
//  Created by Rob Norback on 1/6/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import UIKit
import Kingfisher

class HotelDetailVC: UIViewController {
    
    
    @IBOutlet var hotelImageView: UIImageView!
    @IBOutlet var hotelNameLabel: UILabel!
    @IBOutlet var hotelStarRatingLabel: UILabel!
    @IBOutlet var hotelPriceLabel: UILabel!
    
    var hotelData:Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotelImageView.kf_setImageWithURL(NSURL(string: hotelData.imageUrl)!)
        print(hotelData.imageUrl)
        hotelNameLabel.text = hotelData.name
        hotelStarRatingLabel.text = String(hotelData.starRating)
        hotelPriceLabel.text = "$\(hotelData.price)"
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mapSegue" {
            if let vc = segue.destinationViewController as? HotelMapVC {
                vc.hotelData = self.hotelData
            }
        }
    }


}
