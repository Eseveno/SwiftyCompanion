//
//  SecondViewController.swift
//  Swifty-compagnon
//
//  Created by Erwan SEVENO on 2/21/17.
//  Copyright © 2017 Erwan SEVENO. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var projectTable: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var navItem: UIView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var lvlSkillTable: UITableView!
    var cells : [UITableViewCell] = []
    var user : Userinfo!
    var _cellNamePhotoTableViewCell : CellNamePhotoTableViewCell! = CellNamePhotoTableViewCell()
    var _cellLvlProgress : LevelProgressCell! = LevelProgressCell()
    var _lvlSkillCell : LvlSkillCell! = LvlSkillCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background42")!)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableview == self.mainTable {
            return 100
        }
        if tableview == self.lvlSkillTable || tableview == self.projectTable {
            return 30
        }
        return 0
   }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableview == self.mainTable {
            return cells.count
        }
        if tableview == self.lvlSkillTable{
            return self.user.namelevel.count
        }
        if tableview == self.projectTable{
            return self.user.project.count
        }
        return (0)
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableview == self.mainTable {
            cells[indexPath.row].backgroundColor = UIColor.clear
            return cells[indexPath.row]
        }
        if tableview == self.lvlSkillTable{
            return setupNameLvlCell(cellForRowAt: indexPath)
        }
        if tableview == self.projectTable{
            return setupProjectCell(cellForRowAt: indexPath)
        }
        return cells[indexPath.row]
    }
    
    func setupView()
    {
        var image = UIImage(named: "42")
        
        self.navItem.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundColor")!)
        self.mainTable.register(UINib.init(nibName: "CellNamePhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "cellNamePhotoTableViewCell")
        self.mainTable.register(UINib.init(nibName: "LevelProgressCell", bundle: nil), forCellReuseIdentifier: "levelProgressCell")
        self.lvlSkillTable.register(UINib.init(nibName : "LvlSkillCell", bundle: nil), forCellReuseIdentifier: "lvlSkillCell")
        self.projectTable.register(UINib.init(nibName : "LvlSkillCell", bundle: nil), forCellReuseIdentifier: "projectCell")
        cells.append(self.setupPhotoNameCell())
        cells.append(self.setupProgressCell())
        
    }
    
    func setupProjectCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: LvlSkillCell = self.projectTable.dequeueReusableCell(withIdentifier: "projectCell") as! LvlSkillCell
        cell.name.delegate = self
        cell.level.delegate = self
        cell.name.text = self.user.project[indexPath.row].0
        cell.name.font = cell.name.font?.withSize(8)
        if self.user.project[indexPath.row].1 is NSNull {
            cell.level.text = "0"
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        }
        else{
            cell.level.text = String(format:"%d", (self.user.project[indexPath.row].1) as! Int)
            if ((self.user.project[indexPath.row].1 as! Int) > 50){
                cell.backgroundColor = UIColor.green.withAlphaComponent(0.2)
            }
            else{
                cell.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            }
        }
        return cell
    }
    
    func setupNameLvlCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: LvlSkillCell = self.lvlSkillTable.dequeueReusableCell(withIdentifier: "lvlSkillCell") as! LvlSkillCell
        cell.name.delegate = self
        cell.level.delegate = self
        cell.backgroundColor = UIColor.clear
        cell.name.text = self.user.namelevel[indexPath.row].0
        cell.level.text = String(format:"%.2f", self.user.namelevel[indexPath.row].1)
        return cell
    }
    
    func setupProgressCell() -> UITableViewCell{
        _cellLvlProgress = self.mainTable.dequeueReusableCell(withIdentifier: "levelProgressCell") as? LevelProgressCell
        _cellLvlProgress.lvlText.delegate = self
        _cellLvlProgress.lvlText.text = String(format:"%.2f", self.user.level)
        _cellLvlProgress.lvlBar.progress = self.user.level - floor(self.user.level)
        return _cellLvlProgress
    }
    
    @IBAction func buttontouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupPhotoNameCell() -> UITableViewCell{
        
        var phone : String
        var location : String

        if self.user.phone is NSNull {
            phone = "Pas renseigné"
        }
        else{
            phone = self.user.phone as! String
        }
        if self.user.location is NSNull {
            location = "Pas a l'ecole"
        }
        else{
            location = self.user.location as! String
        }
        _cellNamePhotoTableViewCell = self.mainTable.dequeueReusableCell(withIdentifier: "cellNamePhotoTableViewCell") as? CellNamePhotoTableViewCell
        let conc = self.user.grade + "\n" + self.user.login + "\n" + phone + "\n" + location
        _cellNamePhotoTableViewCell.textName.delegate = self
       _cellNamePhotoTableViewCell.textName.text = conc
        if let checkedUrl = URL(string: self.user.photoUrl) {
            _cellNamePhotoTableViewCell.userPhoto.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
        return _cellNamePhotoTableViewCell!
    }
    
        func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                completion(data, response, error)
                }.resume()
        }
        
        func downloadImage(url: URL) {
            getDataFromUrl(url: url) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { () -> Void in
                   self._cellNamePhotoTableViewCell.userPhoto.image = UIImage(data: data)
                }
            }
        }

    // Implementation on skillCell
    
    
    
    
    
    
    
    
    
    
    
}
