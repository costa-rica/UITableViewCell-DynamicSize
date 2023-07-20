//
//  PostCell.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit

class PostCell: UITableViewCell {
    
    let screenWidth = UIScreen.main.bounds.width
    var post:Post!
    var stckVwPostCell=UIStackView()
    var lblDate=UILabel()
    var lblUsername=UILabel()
    var lblPostText:UILabel?
    
    var lineImageImageView01: UIImageView!
    
    var stckVwUserInteraction=UIStackView()
    var stckVwUserInteractionHeight:CGFloat!
    var likeView:LikeView!
    var commentView:CommentView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stckVwPostCell.removeFromSuperview()
        lblDate.removeFromSuperview()
        lblPostText?.removeFromSuperview()
        
        stckVwUserInteraction.removeFromSuperview()
        likeView.removeFromSuperview()
        commentView.removeFromSuperview()
    }
    
    func configure(with post: Post) {
        self.post = post
        setup_stckVwPostCell()
        setup_lblDate()
        setup_lblUsername()
        setup_lblPostText()
        setup_userInteractionStackView()
    }
    
    func setup_stckVwPostCell(){
        stckVwPostCell.translatesAutoresizingMaskIntoConstraints = false
        stckVwPostCell.axis = .vertical
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
//        lblDate.sizeToFit()
//        post.cell_height = post.cell_height + lblDate.frame.size.height
    }
    
    func setup_lblUsername(){
        lblUsername.text = post.username
        lblUsername.translatesAutoresizingMaskIntoConstraints = false
        lblUsername.font = lblUsername.font.withSize(12.0)
        stckVwPostCell.addArrangedSubview(lblUsername)
        lblUsername.sizeToFit()
//        post.cell_height = post.cell_height + lblUsername.frame.size.height
    }
    func setup_lblPostText(){
        if let unwrapped_postText = post.post_text_ios{
            lblPostText = UILabel()
            lblPostText!.translatesAutoresizingMaskIntoConstraints=false
            lblPostText!.text = unwrapped_postText
            lblPostText!.numberOfLines = 0
//            let _ = sizeLabel(lbl: lblPostText!)// <-- This correctly sizes lblPostText
//            post.cell_height = post.cell_height + lblPostText!.frame.size.height
            
            stckVwPostCell.addArrangedSubview(lblPostText!)
        }
    }
    
    func setup_userInteractionStackView(){
        stckVwUserInteraction.axis = .horizontal
//        stckVwUserInteraction.distribution = .equalSpacing
        likeView = LikeView()
        
//        likeView.rinconStore = self.rinconStore
        likeView.setup_view()
        likeView.post = self.post
        
        commentView = CommentView()
        commentView.post = post
        commentView.setup_view()
//        commentView.postCellDelegate = self
        
//        commentView.post = self.post
        commentView.translatesAutoresizingMaskIntoConstraints=false
        likeView.translatesAutoresizingMaskIntoConstraints=false
        commentView.widthAnchor.constraint(equalToConstant: screenWidth/2).isActive=true
        likeView.widthAnchor.constraint(equalToConstant: screenWidth/2).isActive=true

        stckVwUserInteraction.addArrangedSubview(commentView)
        stckVwUserInteraction.addArrangedSubview(likeView)
        stckVwUserInteraction.translatesAutoresizingMaskIntoConstraints=false
        stckVwPostCell.addArrangedSubview(stckVwUserInteraction)
//        layoutIfNeeded()
        print("stckVwUserInteraction.frame.height : \(stckVwUserInteraction.frame.height )")
//        likeView.viewHeight
        stckVwUserInteractionHeight = max(likeView.viewHeight, commentView.viewHeight)
//        let stckVwUserInteractionHeight = 25.0
//        post.cell_height = post.cell_height + stckVwUserInteractionHeight
//        commentView.backgroundColor = .cyan
//        likeView.backgroundColor = .gray
    }
    
}
