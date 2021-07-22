//
//  ViewController.swift
//  Project1
//
//  Created by user on 05/07/21.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Attributes
    
    var pictures = [String]()
    var picturesSorted = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Challenge 1 day 40: Modify project 1 so that loading the list of NSSL images from our bundle happens in the background.
        
        performSelector(inBackground: #selector(getImages), with: nil)
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        picturesSorted = pictures.sorted()  //Challenge 2: Show the list of images sorted by alphabetical order
        
    }
    
    //MARK: - Methods
    
    @objc func getImages() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        picturesSorted = pictures.sorted()  //Challenge 2: Show the list of images sorted by alphabetical order
        performSelector(inBackground: #selector(UITableView.reloadData), with: nil)
        
    }
    
    //MARK: - TablewView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        picturesSorted.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
        cell.textLabel?.text = picturesSorted[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picturesSorted[indexPath.row]
            vc.pictureTitle = "Picture \(indexPath.row + 1) of \(picturesSorted.count)" // Challenge 3: Add "Picture (position in the list) of (number of pictures)" as the title of every picture
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

