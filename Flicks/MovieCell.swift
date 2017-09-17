//
//  MovieCell.swift
//  Flicks
//
//  Created by Xiang Yu on 9/14/17.
//  Copyright © 2017 Xiang Yu. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // disable selection effect
        // selectionStyle = .none
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        selectedBackgroundView = backgroundView
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        //selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //titleLabel.sizeToFit()
        overviewLabel.sizeToFit()
    }

}
