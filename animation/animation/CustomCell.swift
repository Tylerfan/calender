//
//  CustomCell.swift
//  animation
//
//  Created by Guiyang Fan on 12/26/17.
//  Copyright © 2017 Guiyang Fan. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 0
        
    }
    
    

    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //dateLabel.isUserInteractionEnabled = false
        //dateLabel.isHighlighted = false
        self.layer.borderWidth = 0 //whatever the default border width is
        self.layer.borderColor = UIColor.clear.cgColor //whatever the cell's default color is
    }
    
}
