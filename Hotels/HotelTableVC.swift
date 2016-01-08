//
//  HotelTableVC.swift
//  Hotels
//
//  Created by Rob Norback on 1/6/16.
//  Copyright © 2016 Rob Norback. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD

class HotelTableVC: UITableViewController {
   
    var hotelsArray:[Hotel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show spinner
        startSpinner()
        HotelModelManager.getHotelsForLocation(.SanFran) { (hotelsArray) -> Void in
            self.hotelsArray = hotelsArray
            self.tableView.reloadData()
            //Stop spinner
            self.stopSpinner()
        }
    }
    
    func startSpinner() {
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        loadingNotification.labelText = "Loading"
    }
    
    func stopSpinner() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }

    @IBAction func segmentControlValueChanged(segmentedControl: UISegmentedControl) {
        if let city = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex) {
            switch city {
            case "San Francisco":
                // Start spinner
                startSpinner()
                HotelModelManager.getHotelsForLocation(.SanFran) { (hotelsArray) -> Void in
                    self.hotelsArray = hotelsArray
                    self.tableView.reloadData()
                    //Stop spinner
                    self.stopSpinner()
                }
            case "Minneapolis":
                // Start spinner
                startSpinner()
                HotelModelManager.getHotelsForLocation(.Minneapolis) { (hotelsArray) -> Void in
                    self.hotelsArray = hotelsArray
                    self.tableView.reloadData()
                    //Stop spinner
                    self.stopSpinner()
                }
            default:
                break
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hotelCell", forIndexPath: indexPath) as! HotelTableViewCell
        
        // Configure the cell...
        if hotelsArray.count != 0 {
            let hotel = hotelsArray[indexPath.row]
            cell.hotelNameLabel.text = hotel.name
            cell.hotelPriceLabel.text = "$\(hotel.price) per night"
            cell.hotelImageView.kf_setImageWithURL(NSURL(string: hotel.imageUrl)!,placeholderImage: UIImage(named: "placeholder"))
        }
        
        return cell
    }
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            if let vc = segue.destinationViewController as? HotelDetailVC {
                let indexPath = tableView.indexPathForSelectedRow
                vc.hotelData = hotelsArray[indexPath!.row]
            }
        }
    }
    

}
