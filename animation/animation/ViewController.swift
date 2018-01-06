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

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var monthLabel: UILabel!
    // @IBOutlet weak var DataLabel: UILabel!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func buttonClicked(sender: UIButton){
        if sender == rightBtn {
            currentMonthIndex += 1
            if currentMonthIndex > 12 {
                currentMonthIndex = 1
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex <= 0 {
                currentMonthIndex = 12
                currentYear -= 1
            }
        }
 
        firstWeekDayOfMonth=getFirstWeekDay()
        monthLabel.text="\(monthsArr[currentMonthIndex - 1]) \(currentYear)"
        dayCollectionView.reloadData()
    }
    
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var firstWeekDayOfMonth = 0
    var todaysDate = 0
    var presentYear = 0
    var presentMonthIndex = 0
    var cellSelectedAtMonth = Dictionary<Int,Array<IndexPath>>()    //[Int : [IndexPath]]()
    var cellSelected = [IndexPath : Bool]()
    var eventCount = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        dayCollectionView.dataSource = self
        dayCollectionView.delegate = self
        eventTable.dataSource = self
        eventTable.delegate = self
        
        //allows multiple selection of cells simultaneously
        self.dayCollectionView.allowsMultipleSelection = true;
        self.addBtn.target = self
        self.addBtn.action = #selector(addEvent(_:))

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
        monthLabel.text = monthsArr[currentMonthIndex - 1]
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
        cell.backgroundColor = UIColor.clear

        if indexPath.item <= firstWeekDayOfMonth - 2 {
            print(firstWeekDayOfMonth)
            cell.isHidden=true
        } else {

            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.dateLabel.text="\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=true
                cell.dateLabel.textColor = UIColor.darkGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.dateLabel.textColor = UIColor.black
            }
            
            //rehighlight the selected cell if the month is current month

            if (cellSelectedAtMonth[currentMonthIndex] != nil && cellSelectedAtMonth[currentMonthIndex]!.contains(indexPath)){
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.gray.cgColor
            }
            
        }
        return cell
    }

    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell

        if (cellSelected[indexPath] == nil || cellSelected[indexPath] == false) {
            cellSelected[indexPath] = true
            if cellSelectedAtMonth[currentMonthIndex] == nil {
                cellSelectedAtMonth[currentMonthIndex] = []
            }
            var arr = cellSelectedAtMonth[currentMonthIndex]!
            arr.append(indexPath)
            cellSelectedAtMonth[currentMonthIndex] = arr
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.gray.cgColor
            
        }
        else{
            cellSelected[indexPath] = false
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor

            if  cellSelectedAtMonth[currentMonthIndex] != nil && cellSelectedAtMonth[currentMonthIndex]!.contains(indexPath) {
                let arr = cellSelectedAtMonth[currentMonthIndex]!
                let newArr = arr.filter{$0 != indexPath}
                cellSelectedAtMonth[currentMonthIndex] = newArr
        }
        
    }
     dayCollectionView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "test"
        return cell
    }
    
    
    @IBAction func addEvent(_ sender: UIBarButtonItem) {
        eventCount += 1;
        self.eventTable.reloadData()
        performSegue(withIdentifier: "eventView", sender: self)

        print(eventCount)
        
    }
    

    
    
    
    func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstWeekDayOfMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
}

fileprivate let sectionInsets = UIEdgeInsets(top: 0, left:0, bottom : 50, right: 30)

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = (collectionView.frame.width ) / 10
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
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



