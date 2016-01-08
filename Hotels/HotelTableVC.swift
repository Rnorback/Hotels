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
        loadHotelDataForLocation(.SanFran)
    }
    
    func loadHotelDataForLocation(location:Location) {
        startSpinner()
        HotelModelManager.getHotelsForLocation(location, completion: { (hotelsArray) -> Void in
            self.hotelsArray = hotelsArray
            self.tableView.reloadData()
            self.stopSpinner()
            }, errorBlock : { (alertController) -> Void in
                self.presentViewController(alertController, animated: true, completion: nil)
                self.stopSpinner()
        })
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
            // Get data for city and reload the tableView
            switch city {
            case "San Francisco":
                loadHotelDataForLocation(.SanFran)
            case "Minneapolis":
                loadHotelDataForLocation(.Minneapolis)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            if let vc = segue.destinationViewController as? HotelDetailVC {
                // Pass the data for the selected hotel to the detail view controller
                let indexPath = tableView.indexPathForSelectedRow
                vc.hotelData = hotelsArray[indexPath!.row]
            }
        }
    }
    

}
