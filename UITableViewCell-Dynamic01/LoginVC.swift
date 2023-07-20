//
//  ViewController.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit

class LoginVC: UIViewController {
    
    
    var requestStore: RequestStore!
    let vwVCHeaderOrange = UIView()
    var lblTitle = UILabel()
    let btnLogin = UIButton()
    
    var posts = [Post](){
        didSet{
            if posts.count > 0 {
                
                performSegue(withIdentifier: "goToRinconVC", sender: self)
            }
        }
    }// segue here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestStore = RequestStore()
        
        setup_vwVCHeaderOrange()
        setup_lblTitle()
        setup_btnLogin()
    }
    
    func setup_vwVCHeaderOrange(){
        view.addSubview(vwVCHeaderOrange)
        vwVCHeaderOrange.backgroundColor = .orange
        vwVCHeaderOrange.translatesAutoresizingMaskIntoConstraints = false
        vwVCHeaderOrange.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        vwVCHeaderOrange.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        vwVCHeaderOrange.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        vwVCHeaderOrange.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    }
    func setup_lblTitle(){
        lblTitle.text = "Login"
        lblTitle.font = UIFont(name: "Rockwell_tu", size: 30)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: vwVCHeaderOrange.bottomAnchor, constant: heightFromPct(percent: 5)).isActive=true
        lblTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 5)).isActive=true
    }
    func setup_btnLogin(){
        view.addSubview(btnLogin)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.backgroundColor = .blue
        btnLogin.layer.cornerRadius = 10
        btnLogin.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: heightFromPct(percent: 10)).isActive=true
        btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: widthFromPct(percent: 10)).isActive=true
        btnLogin.addTarget(self, action: #selector(touchDown(_:)), for: .touchDown)
        btnLogin.addTarget(self, action: #selector(touchUpInside(_:)), for: .touchUpInside)
    }
        
    @objc func touchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: nil)
        print("touchDown")
    }

    @objc func touchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut], animations: {
            sender.transform = .identity
        }, completion: nil)
        print("touchUpInside")
        requestStore.requestPost(endpoint: .rincon_posts, queryStringDict: ["rincon_id":"1"]){ data in
            do {
                let jsonDecoder = JSONDecoder()
                let rincon_post_response = try jsonDecoder.decode([Post].self, from:data)
                self.posts = rincon_post_response
            } catch {
                print("Failed to Decode")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToRinconVC"){
            let rinconVC = segue.destination as! RinconVC
            
            rinconVC.posts = posts
            rinconVC.requestStore = requestStore
            print("posts count: \(posts.count)")
        }
    }
}

