//
//  Post.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//

import Foundation

class Post: Codable{
    var post_id: String!
    var user_id: String!
    var username: String!
    var rincon_id: String!
    var date_for_sorting_ios: String!
    var post_text_ios:String?
    var image_filenames_ios: String?
    var image_files_array: [String]?
    var video_exists:Bool?
    var video_file_name: String?
    var rincon_dir_path: URL?
    var cell_height: CGFloat!
    var cell_height_no_media: CGFloat!
    var comments: [[String:String]]!
    var liked:Bool!
    var like_count: Int!
}
