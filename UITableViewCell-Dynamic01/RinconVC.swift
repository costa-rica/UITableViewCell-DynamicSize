//
//  RinconVC.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit

class RinconVC: UIViewController{
    var requestStore: RequestStore!
    let vwVCHeaderOrange = UIView()
    
    var tblRincon = UITableView()
    
    var posts:[Post]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblRincon.delegate = self
        tblRincon.dataSource = self
        
        tblRincon.rowHeight = UITableView.automaticDimension
        tblRincon.estimatedRowHeight = 100
        
        // Register a UITableViewCell
        tblRincon.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tblRincon.register(PostCell.self, forCellReuseIdentifier: "PostCell")

        
        setup_vwVCHeaderOrange()
        setup_tblRincon()
    }
    
    func setup_vwVCHeaderOrange(){
        view.addSubview(vwVCHeaderOrange)
        vwVCHeaderOrange.accessibilityIdentifier = "vwVCHeaderOrange"
        vwVCHeaderOrange.backgroundColor = .orange
        vwVCHeaderOrange.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrange.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vwVCHeaderOrange.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrange.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrange.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    }
    
    func setup_tblRincon(){
        tblRincon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tblRincon)
        tblRincon.accessibilityIdentifier = "tblRincon"
        tblRincon.topAnchor.constraint(equalTo: vwVCHeaderOrange.bottomAnchor).isActive=true
        tblRincon.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        tblRincon.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
        tblRincon.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
    }
}

extension RinconVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
}

extension RinconVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let current_post = posts[indexPath.row]
        

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
        cell.textLabel?.text = current_post.post_id
        if let unwp_lblPost = current_post.post_text_ios{
            print("set cell with STyle")
            cell.detailTextLabel?.text = unwp_lblPost
            cell.detailTextLabel?.numberOfLines = 0
        }
        return cell

    }
    
    
}
