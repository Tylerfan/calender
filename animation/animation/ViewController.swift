//
//  ViewController.swift
//  animation
//
//  Created by Guiyang Fan on 12/19/17.
//  Copyright © 2017 Guiyang Fan. All rights reserved.
//

import UIKit


private let reuseIdentifier = "CustomCell"

enum MyTheme {
    case light
    case dark
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


   // @IBOutlet weak var DataLabel: UILabel!
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        
        initializeView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    func initializeView(){
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())

        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
            
        }
        
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor.white
        
        cell.dateLabel.text = "no"
        return cell
    }
}





fileprivate let sectionInsets = UIEdgeInsets(top: 50, left:0,bottom : 50, right: 0)

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 7 - 8
        let height: CGFloat = 40
        return CGSize(width: widthPerItem, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
}
    
}



