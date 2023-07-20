//
//  CommentView.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import UIKit


class CommentView:UIView {
    var post = Post(){
        didSet{
            if let unwrapped_comments = post.comments {
                lblCommentCount.text = String(unwrapped_comments.count)
            } else {
                lblCommentCount.text = "0"
            }
        }
    }
    var lblCommentCount=UILabel()
    var btnComment=UIButton()
    var viewHeight = 0.0
//    var postCellDelegate: PostCellDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup_view(){
        btnComment.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        btnComment.addTarget(self, action: #selector(btnCommentPressed), for: .touchUpInside)
        
        
        btnComment.translatesAutoresizingMaskIntoConstraints = false
        lblCommentCount.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblCommentCount)
        self.addSubview(btnComment)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        btnComment.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        btnComment.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        lblCommentCount.leadingAnchor.constraint(equalTo: btnComment.trailingAnchor).isActive=true
        lblCommentCount.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true

        
        // Size lbl
        let _ = sizeLabel(lbl: lblCommentCount)
        print("post: \(post.post_id!)")
        print("lblCommentCount size: \(lblCommentCount.frame.size)")
        print("btnComment.imageView.image.frame.size size: \(btnComment.imageView!.image!.size)")
        viewHeight = max(lblCommentCount.frame.size.height, btnComment.imageView!.image!.size.height)
//        viewHeight = 25.0
    }
    
    @objc private func btnCommentPressed() {
        print("Comment button pressed for post: \(post.post_id!)")
//        postCellDelegate.expandNewComment()
    }
}

