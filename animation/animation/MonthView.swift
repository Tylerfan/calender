//
//  MonthView.swift
//  animation
//
//  Created by Guiyang Fan on 12/26/17.
//  Copyright © 2017 Guiyang Fan. All rights reserved.
//

import UIKit

class MonthView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
func setupViews() {
    self.addSubview(lblName)
    lblName.topAnchor.constraint(equalTo: topAnchor).isActive=true
    lblName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
    lblName.widthAnchor.constraint(equalToConstant: 350).isActive=true
    lblName.heightAnchor.constraint(equalTo: heightAnchor).isActive=true
    
    
    
}

let lblName: UILabel = {
    let lbl = UILabel()
    lbl.text = "Default Month Year text"
    //lbl.textColor = Style.monthViewLblColor
    lbl.textAlignment = .center
    lbl.font = UIFont.boldSystemFont(ofSize: 16)
    lbl.translatesAutoresizingMaskIntoConstraints=false
    return lbl
    
    
    
}()


}
