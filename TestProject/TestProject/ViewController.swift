//
//  ViewController.swift
//  TestProject
//
//  Created by Patel, Sanjay on 3/31/17.
//  Copyright © 2017 Patel, Sanjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AppointmentServiceDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var appointmentTableView: UITableView!
    var pastAppointmentArray = [Appointment]()
    var futureAppointmentArray = [Appointment]()
    var asthmaArray = [Appointment]()
    var  index = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Briana's Appointments"
        // Find Appointments using AppointmentService
        let appointmentService = AppointmentService.getInstance()
        appointmentService.delegate = self as AppointmentServiceDelegate
        appointmentService.getAppointments()
        index = 0
        
        // Display Appointments as per UI
        appointmentTableView.register(UINib(nibName: "UpComingVisitCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
        appointmentTableView.register(UINib(nibName: "PastVistCell", bundle: nil), forCellReuseIdentifier: "PastVistCell")
        appointmentTableView.dataSource = self
        appointmentTableView.delegate = self
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "logo.png"), for: UIControlState.normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func appointmentsRetrieved(pastAppointmentArray: [Appointment], futureAppointmentArray: [Appointment]){
        self.pastAppointmentArray = pastAppointmentArray
        self.futureAppointmentArray = futureAppointmentArray
        self.asthmaArray = self.pastAppointmentArray.filter({($0.isAsthmaAppointment == true)})
        
        
    }
    
    //Mark: TableViewDelegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            if index == 1{
                return  self.asthmaArray .count
            }else{
                
                return  self.pastAppointmentArray .count
            }
        }else{
            return  self.futureAppointmentArray .count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let  cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpComingVisitCell
            let appointement = self.futureAppointmentArray[indexPath.row]
            cell.providerName.text =  "Dr.\(appointement.providerFirstName!)"
            cell.providerImage.downloadImage(from: "https://photo.nemours.org/P/\(appointement.providerId!)/100x100?type=P")
            cell.selectionStyle = .none
            appointmentTableView.separatorStyle = .none
            cell.specalityLabel.text = appointement.providerSpecialty
            cell.addressLabel.text = appointement.address
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd,yyyy"
            let dateString = formatter.string(from: appointement.dateAndTime!)
            cell.dateLabel.text = dateString
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm a";
            let timeString = dateFormatter.string(from: appointement.dateAndTime!)
            cell.timeLabel.text = timeString
            
            return cell
        }else{
            let  cell = tableView.dequeueReusableCell(withIdentifier: "PastVistCell", for: indexPath) as! PastVistCell
            var appointement = Appointment()
            if index == 1{
                appointement = self.asthmaArray[indexPath.row]
                
            }else{
                appointement = self.pastAppointmentArray[indexPath.row]
                
            }
            
            cell.providerImageView.downloadImage(from: "https://photo.nemours.org/P/\(appointement.providerId!)/100x100?type=P")
            appointmentTableView.separatorStyle = .singleLine
            cell.specalityLabel.text = appointement.providerSpecialty
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd,yyyy"
            let dateString = formatter.string(from: appointement.dateAndTime!)
            cell.dateLabel.text = dateString
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm a";
            let timeString = dateFormatter.string(from: appointement.dateAndTime!)
            
            cell.providerNameLabel.text = "\(timeString)-Dr.\(appointement.providerFirstName!)"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 200
        }else{
            return 100
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 0){
            
            return 50
            
        }else{
            
            return 60
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0){
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
            view.backgroundColor = UIColor.white
            let label = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
            
            label.text = "Upcoming Visits"
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            
            label.textColor = UIColor.black
            
            view.addSubview(label)
            
            return view
            
        }else{
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
            view.backgroundColor = UIColor.white
            
            let label = UILabel(frame: CGRect(x: 25, y: 12, width: 200, height: 30))
            label.text = "Past Visits"
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            label.textColor = UIColor.black
            
            let bottomView = UIView(frame: CGRect(x: 0, y: view.frame.size.height-5, width: tableView.frame.size.width, height: 2))
            bottomView.backgroundColor = UIColor(red: 247/255, green: 174/255, blue: 82/255, alpha: 1.0)
            view.addSubview(bottomView)
            
            let titleCont1 = TZSegmentedControl(sectionTitles: ["All Types", "Asthma Only"])
            
            titleCont1.frame = CGRect(x: view.frame.size.width-190, y: 0, width:180, height: 55)
            titleCont1.indicatorWidthPercent = 0.0
            titleCont1.backgroundColor = UIColor.white
            titleCont1.borderColor = UIColor.red
            titleCont1.selectedSegmentIndex = index
            titleCont1.borderWidth = 0.0
            titleCont1.segmentWidthStyle = .dynamic
            titleCont1.verticalDividerEnabled = true
            titleCont1.verticalDividerWidth = 0.0
            titleCont1.verticalDividerColor = UIColor.red
            titleCont1.selectionStyle = .arrow
            titleCont1.selectionIndicatorLocation = .down
            titleCont1.selectionIndicatorColor = UIColor(red: 247/255, green: 174/255, blue: 82/255, alpha: 1.0)
            titleCont1.selectionIndicatorHeight = 5.0
            titleCont1.borderType = .top
            titleCont1.edgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            titleCont1.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.black,
                                                      NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 13)]
            titleCont1.addTarget(self, action: #selector(selectorValueChanged)
                , for:.valueChanged)
            titleCont1.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray,
                                              NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14.0) ?? UIFont.systemFont(ofSize: 13)]
            view.addSubview(titleCont1)
            
            view.addSubview(label)
            
            return view
            
        }
        
    }
    
    
    func selectorValueChanged(_ sender: Any) {
        let obj = sender as! TZSegmentedControl
        index = obj.selectedSegmentIndex
        
        appointmentTableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
        
        
    }
    
    
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        
        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil
        
        // check if the image is already in the cache
        if let imageToCache = imageCache.object(forKey: imgURL! as NSString) {
            self.image = imageToCache
            return
        }
        
        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                imageCache.setObject(imageToCache!, forKey: imgURL! as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
    }
}

