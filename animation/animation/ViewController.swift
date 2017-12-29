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
    var firstWeekDayOfMonth = 0
    var todaysDate = 0
    var presentYear = 0
    var presentMonthIndex = 0


    
    



    
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
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        
        if currentMonthIndex == 2 && currentYear % 4 == 0 {
            numOfDaysInMonth[currentMonthIndex-1] = 29
            
        }
        
        presentMonthIndex=currentMonthIndex

        presentYear=currentYear

        
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        
        cell.backgroundColor=UIColor.clear

        if indexPath.item <= firstWeekDayOfMonth - 2 {
            print(firstWeekDayOfMonth)
            cell.isHidden=true
        } else {

            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.dateLabel.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=false
                cell.dateLabel.textColor = UIColor.darkGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.dateLabel.textColor = UIColor.black
            }
        }

        
        return cell
        
        
        

    }
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstWeekDayOfMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
    
    
}







fileprivate let sectionInsets = UIEdgeInsets(top: 0, left:0, bottom : 50, right: 20)

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = (collectionView.frame.width ) / 10
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
}
    
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
    
}


extension Date{
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
      var firstWeekDayOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month],from: self))!
        
    }
}



