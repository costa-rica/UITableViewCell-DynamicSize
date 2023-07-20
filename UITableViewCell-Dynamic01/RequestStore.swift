//
//  RequestStore.swift
//  UITableViewCell-Dynamic01
//
//  Created by Nick Rodriguez on 20/07/2023.
//


import UIKit

enum EndPoint: String {
    case call_for_image = "call_for_image"
    case are_we_running = "are_we_running"
    case rincon_posts = "rincon_posts"
    case rincon_post_file = "rincon_post_file"
}

class URLStore {
    
    var baseString = "http://127.0.0.1:5002/"
    func createUrl(endPoint: EndPoint) -> URL{
        let baseURLString = baseString + endPoint.rawValue
        let components = URLComponents(string:baseURLString)!
        return components.url!
    }
//    func callEndpointImage(endPoint:EndPoint, file_name:String) -> URL{
//        let baseURLString = baseString + endPoint.rawValue + "/\(file_name)"
//        let components = URLComponents(string:baseURLString)!
//        return components.url!
//    }
    func createUrlWithQueryStringDict(endPoint:EndPoint, queryStringDict:[String:String]) -> URL{
        var urlString = baseString + endPoint.rawValue
        for element in queryStringDict {
            urlString = urlString + "/\(element.value)"
        }
        let components = URLComponents(string:urlString)!
        return components.url!
    }
}

class RequestStore{
    
    var urlStore:URLStore!
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    private let fileManager:FileManager
    private let documentsURL:URL
    init() {
        urlStore = URLStore()
        self.fileManager = FileManager.default
        self.documentsURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func requestGet(endpoint: EndPoint, completion:@escaping(Data) -> Void){
        let url = urlStore.createUrl(endPoint:endpoint)
        print("url: \(url)")
        let task = session.dataTask(with: url) {(data, response, error) in
            if let unwrapped_data = data {
                OperationQueue.main.addOperation {
                    completion(unwrapped_data)
                }
            }
            if let unwrapped_response = response as? HTTPURLResponse{
                print(unwrapped_response.statusCode)
            }
            if let unwrapped_error = error{
                print("Error checking request: \(unwrapped_error)")
            }
        }
        task.resume()
    }
    
    func createRequestPost(endpoint:EndPoint, queryStringDict:[String:String]?, bodyDict:[String:String]?) -> URLRequest{
        var url = urlStore.createUrl(endPoint:endpoint)
        if let unwrapped_queryStringDict = queryStringDict{
            url = urlStore.createUrlWithQueryStringDict(endPoint:endpoint, queryStringDict: unwrapped_queryStringDict)
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",forHTTPHeaderField: "Accept")
        
        // Add body
        
        if let unwrapped_bodyDict = bodyDict{
            var jsonBodyData = Data()
            do {
                let jsonEncoder = JSONEncoder()
                jsonBodyData = try jsonEncoder.encode(unwrapped_bodyDict)
            } catch {
                print("***** Failed to encode rincon_id ****")
            }
            request.httpBody = jsonBodyData
            return request
        }
        return request
    }
    
    
    func requestPost(endpoint:EndPoint, queryStringDict:[String:String]?, completion:@escaping(Data) -> Void){
        var request = createRequestPost(endpoint: endpoint, queryStringDict: nil, bodyDict: nil)
        if let unwrap_dict = queryStringDict {
            request = createRequestPost(endpoint: endpoint, queryStringDict: unwrap_dict, bodyDict: nil)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                OperationQueue.main.addOperation {
                    completion(data)
                }
            }
        }
        task.resume()
    }
    
    func requestOnePhoto(image_file_name:String, completion:@escaping(UIImage) -> Void){
//        print("-- requestPostPhoto")
        let image_file_name_dict = ["image_file_name": image_file_name]
        let request = createRequestPost(endpoint: .call_for_image, queryStringDict:image_file_name_dict, bodyDict: nil )
        let task = session.dataTask(with: request) { (data, response, error) in
            if let unwrapped_data = data {
                OperationQueue.main.addOperation {
                    let uiimage = UIImage(data: unwrapped_data)
                    completion(uiimage!)
//                    print("--> Successfully downloaded image: \(image_file_name)")
                }
            }
            if let unwrapped_error = error{
                print("Error photo request: \(unwrapped_error)")
            }
        }
        task.resume()
    }
    
    func requestRinconPhoto(image_file_name:String,rincon_id:String, completion:@escaping(UIImage) -> Void) {
        let image_file_name_dict = ["image_file_name": image_file_name]
        let request = createRequestPost(endpoint: .call_for_image, queryStringDict:image_file_name_dict, bodyDict: ["rincon_id":rincon_id] )
        let task = session.dataTask(with: request) { (data, response, error) in
            if let unwrapped_data = data {
                OperationQueue.main.addOperation {
                    let uiimage = UIImage(data: unwrapped_data)
                    completion(uiimage!)
                }
            }
            if let unwrapped_error = error{
                print("Error photo request: \(unwrapped_error)")
            }
        }
        task.resume()
    }
    
    // Example of Get Request returning content
    // Source: ChatGPT
    func checkServerStatus(completion: @escaping (String?) -> Void) {
        let url = URL(string: "http://127.0.0.1:5002/are_we_running")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        OperationQueue.main.addOperation {
                            completion(json["message"])
                        }
                    }
                } catch {
                    print("Error: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}



