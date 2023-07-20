//
//  PostCell.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post:Post!
    var stckVwPostCell=UIStackView()
    var lblDate=UILabel()
    var lblPostText:UILabel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with post: Post) {
        self.post = post
        setup_stckVwPostCell()
        setup_lblDate()
    }
    
    func setup_stckVwPostCell(){
        stckVwPostCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stckVwPostCell)
        stckVwPostCell.topAnchor.constraint(equalTo: contentView.topAnchor).isActive=true
        stckVwPostCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive=true
        stckVwPostCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive=true
        stckVwPostCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive=true
    }
    
    func setup_lblDate(){
        let date_obj = convertStringToDate(date_string: post.date_for_sorting_ios)
        let formattedDateString = DateFormatter.localizedString(from: date_obj, dateStyle: .medium, timeStyle: .short)
        lblDate.text = formattedDateString
        lblDate.semanticContentAttribute = .forceRightToLeft
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        stckVwPostCell.addArrangedSubview(lblDate)
        lblDate.sizeToFit()
        post.cell_height = post.cell_height + lblDate.frame.size.height
    }
    func setup_lblPostText(){
        if let unwrapped_postText = post.post_text_ios{
            lblPostText = UILabel()
            lblPostText!.translatesAutoresizingMaskIntoConstraints=false
            lblPostText!.text = unwrapped_postText
            lblPostText!.numberOfLines = 0
            let _ = sizeLabel(lbl: lblPostText!)// <-- This correctly sizes lblPostText
            post.cell_height = post.cell_height + lblPostText!.frame.size.height
            
            stckVwPostCell.addArrangedSubview(lblPostText!)
        }
    }
    
}
