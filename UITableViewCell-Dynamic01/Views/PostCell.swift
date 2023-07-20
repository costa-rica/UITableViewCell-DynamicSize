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
    var lineImageImageView02: UIImageView!
    
    //comments stack
    var stckVwComments: UIStackView?
    var stckVwCommentsHeight: CGFloat?
    var dictCommentsDate: [String:UILabel]?
    var dictCommentsUsername: [String:UILabel]?
    var dictCommentsText: [String:UILabel]?
    var dictCommentsVw: [String:UIView]?
    
    
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
        lineImageImageView01.removeFromSuperview()
        stckVwUserInteraction.removeFromSuperview()
        likeView.removeFromSuperview()
        commentView.removeFromSuperview()
        
        lineImageImageView02.removeFromSuperview()

        if let unwrapped_comments = post.comments {
            for comment_element in unwrapped_comments{
                if let commentId = comment_element["comment_id"]{
                    dictCommentsDate?["\(post.post_id!), \(commentId)"]?.removeFromSuperview()
                    dictCommentsUsername?["\(post.post_id!), \(commentId)"]?.removeFromSuperview()
                    dictCommentsText?["\(post.post_id!), \(commentId)"]?.removeFromSuperview()
                    dictCommentsVw!["\(post.post_id!), \(commentId)"]?.removeFromSuperview()
                }
            }
        }
        
        stckVwComments?.removeFromSuperview()
    }
    
    func configure(with post: Post) {
        self.post = post
        setup_stckVwPostCell()
        setup_lblDate()
        setup_lblUsername()
        setup_lblPostText()
        setup_line01()
        setup_userInteractionStackView()
        setup_line02()
        setup_commentsView()
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
    func setup_line01(){
        lineImageImageView01 = createDividerLine(thicknessOfLine: 1.0)
        stckVwPostCell.addArrangedSubview(lineImageImageView01)
//        post.cell_height = post.cell_height + lineImageImageView01.image!.size.height
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
    func setup_line02(){
        lineImageImageView02 = createDividerLine(thicknessOfLine: 1.5)
        stckVwPostCell.addArrangedSubview(lineImageImageView02)
//        post.cell_height = post.cell_height + lineImageImageView02.image!.size.height
    }
    
    func setup_commentsView(){

        stckVwComments =  UIStackView()
        stckVwComments!.translatesAutoresizingMaskIntoConstraints = false
        stckVwComments!.axis = .vertical
        stckVwPostCell.addArrangedSubview(stckVwComments!)
        dictCommentsDate = [String:UILabel]()
        dictCommentsUsername = [String:UILabel]()
        dictCommentsText = [String:UILabel]()
        dictCommentsVw = [String:UIView]()
        
        
        if let unwrapped_comments = post.comments {
            stckVwCommentsHeight = 0.0
            stckVwComments?.spacing = heightFromPct(percent: 0.5)
            for comment_element in unwrapped_comments{
                if let commentId = comment_element["comment_id"]{
                    dictCommentsDate!["\(post.post_id!), \(commentId)"] = UILabel()
                    dictCommentsUsername!["\(post.post_id!), \(commentId)"] = UILabel()
                    dictCommentsText!["\(post.post_id!), \(commentId)"] = UILabel()
                    dictCommentsVw!["\(post.post_id!), \(commentId)"] = UIView()
                    
                    if let unwp_lblDate = dictCommentsDate!["\(post.post_id!), \(commentId)"],
                       let unwp_lblUsername = dictCommentsUsername!["\(post.post_id!), \(commentId)"],
                       let unwp_lblText = dictCommentsText!["\(post.post_id!), \(commentId)"],
                        let unwp_vw = dictCommentsVw!["\(post.post_id!), \(commentId)"] {
                        
                        unwp_vw.backgroundColor = .gray
                        unwp_vw.layer.cornerRadius = 10
                        
                        unwp_vw.accessibilityIdentifier = "unwp_vw: \(post.post_id!), \(commentId)"

                        unwp_lblDate.text = comment_element["date"]
                        unwp_lblDate.accessibilityIdentifier = "unwp_lblDate: \(post.post_id!), \(commentId)"
//                        let date_obj = convertStringToDate(date_string: post.date_for_sorting_ios)
//                        let formattedDateString = DateFormatter.localizedString(from: date_obj, dateStyle: .medium, timeStyle: .short)
//                        lblDate.text = formattedDateString
                        unwp_lblDate.semanticContentAttribute = .forceRightToLeft
                        unwp_lblDate.translatesAutoresizingMaskIntoConstraints = false
                        let _ = sizeLabel(lbl: unwp_lblDate)
                        unwp_vw.addSubview(unwp_lblDate)
                        unwp_lblDate.topAnchor.constraint(equalTo: unwp_vw.topAnchor, constant: heightFromPct(percent: 1)).isActive=true
                        unwp_lblDate.trailingAnchor.constraint(equalTo: unwp_vw.trailingAnchor).isActive=true
                        unwp_lblDate.leadingAnchor.constraint(equalTo: unwp_vw.leadingAnchor).isActive=true
                        
                        unwp_lblUsername.text = comment_element["username"]
                        unwp_lblUsername.translatesAutoresizingMaskIntoConstraints=false
                        let _ = sizeLabel(lbl: unwp_lblUsername)
                        unwp_lblUsername.font = unwp_lblUsername.font.withSize(12.0)
                        unwp_vw.addSubview(unwp_lblUsername)
                        unwp_lblUsername.topAnchor.constraint(equalTo: unwp_lblDate.bottomAnchor, constant: heightFromPct(percent: 1)).isActive=true
                        unwp_lblUsername.leadingAnchor.constraint(equalTo: unwp_vw.leadingAnchor, constant: widthFromPct(percent: 2)).isActive=true
                        unwp_lblUsername.trailingAnchor.constraint(equalTo: unwp_vw.trailingAnchor).isActive=true
                        
                        unwp_lblText.text = comment_element["comment_text"]!
                        unwp_lblText.numberOfLines = 0
                        unwp_lblText.translatesAutoresizingMaskIntoConstraints=false
                        let _ = sizeLabel(lbl: unwp_lblText)
                        unwp_vw.addSubview(unwp_lblText)
                        stckVwComments!.addArrangedSubview(unwp_vw)
                        unwp_lblText.topAnchor.constraint(equalTo: unwp_lblUsername.topAnchor, constant: heightFromPct(percent: 2)).isActive=true
                        unwp_lblText.trailingAnchor.constraint(equalTo: unwp_vw.trailingAnchor, constant: widthFromPct(percent: -2)).isActive=true
                        unwp_lblText.bottomAnchor.constraint(equalTo: unwp_vw.bottomAnchor, constant: heightFromPct(percent: -2)).isActive=true
                        unwp_lblText.leadingAnchor.constraint(equalTo: unwp_vw.leadingAnchor, constant: widthFromPct(percent: 2)).isActive=true
                        
//                        post.cell_height = post.cell_height + unwp_lblText.frame.size.height + heightFromPct(percent: 4) + heightFromPct(percent: 1) + unwp_lblDate.frame.size.height + heightFromPct(percent: 2) + unwp_lblUsername.frame.size.height + heightFromPct(percent: 2)
//                        stckVwCommentsHeight = stckVwCommentsHeight! + unwp_lblText.frame.size.height + heightFromPct(percent: 4) + unwp_lblDate.frame.size.height + heightFromPct(percent: 2) + unwp_lblUsername.frame.size.height + heightFromPct(percent: 2)
                    }
                }
            }
            print("-------------------------")
            print("likeView for post: \(post.post_id!)")
            print("lblLikeCount size: \(likeView.lblLikeCount.frame.size)")
            print("btnThumbsUp size: \(likeView.btnThumbsUp.imageView!.image!.size)")
//            print("stckVwCommentsHeight: \(stckVwCommentsHeight!)")
            
//            if post.post_id == "37" {
//                post.cell_height = post.cell_height + 20
//                print("* added height *")
////                stckVwComments!.layoutIfNeeded()
//            }
            
            print("stckVwComment.frame.height: \(stckVwComments!.frame.size.height)")
//            print("stckVwCommentsHeight: \(stckVwCommentsHeight!)")
            
            
            print("-----------")
//            post.cell_height = post.cell_height + stckVwComments!.frame.size.height
        } // if let unwrapped_comments = post.comments
        
//        stckVwCommentsTest?.heightAnchor.constraint(equalToConstant: )
//        setup_btnPostDiagnostics()
        

    }
}
