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
        
        //Populate the detail view
        hotelNameLabel.text = hotelData.name
        hotelImageView.kf_setImageWithURL(NSURL(string: hotelData.imageUrl)!,placeholderImage: UIImage(named: "placeholder"))
        hotelStarRatingLabel.text = "\(hotelData.starRating) Star Rating"
        hotelPriceLabel.text = "$\(hotelData.price) Per Night"
        
        //Round the edges of the image
        hotelImageView.layer.cornerRadius = 5
        hotelImageView.clipsToBounds = true
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
