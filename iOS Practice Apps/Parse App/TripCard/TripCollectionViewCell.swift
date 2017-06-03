//
//  TripCollectionViewCell.swift
//  TripCard
//
//  Created by Wasim Ahmad on 4/12/17.
//  Copyright © 2017 Wasim Ahmad. All rights reserved.
//

import UIKit



protocol TripCollectionCellDelegate {
    func didLikeButtonPressed(cell: TripCollectionViewCell)
}
class TripCollectionViewCell: UICollectionViewCell {
    
    
        var delegate:TripCollectionCellDelegate?
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var totalDaysLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var isLiked:Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(named: "heartfull"), for: .normal) } else {
                likeButton.setImage(UIImage(named: "heart"), for: .normal) }
        } }
    
   
    @IBAction func likeButtonTapped(sender: AnyObject) {
        delegate?.didLikeButtonPressed(cell: self)
        print("Hello");
    }

    
}

