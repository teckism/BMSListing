//
//  MovieCastCollectionViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelForName: UILabel!
    
    @IBOutlet weak var labelForCharacterName: UILabel!
    
    @IBOutlet weak var imageViewForCharacter: UIImageView!
    @IBOutlet weak var viewForDropShadow: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func loadCast(cast : Cast){
        self.labelForName.text = cast.name ?? ""
        self.labelForCharacterName.text = cast.character ?? ""
        if let image = cast.profilePath{
            imageViewForCharacter.sd_setImage(with: URL(string: Constants.BaseUrls.kProfilePathBaseUrl + image), placeholderImage: UIImage(named: "placeholder"));
        }
        else{
            self.imageViewForCharacter.image = UIImage(named: "placeholder");
        }
        
        self.viewForDropShadow.dropShadow()
        
    }
}
