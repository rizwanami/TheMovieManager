//
//  TMDBConvenience.swift
//  TheMovieManager
//
//  Created by Jarrod Parkes on 2/11/15.
//  Copyright (c) 2015 Jarrod Parkes. All rights reserved.
//

import UIKit
import Foundation

// MARK: - TMDBClient (Convenient Resource Methods)

extension TMDBClient {
    
    // MARK: Authentication (GET) Methods
    /*
        Steps for Authentication...
        https://www.themoviedb.org/documentation/api/sessions
        
        Step 1: Create a new request token
        Step 2a: Ask the user for permission via the website
        Step 3: Create a session ID
        Bonus Step: Go ahead and get the user id 😄!
    */
    func authenticateWithViewController(_ hostViewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        // chain completion handlers for each request so that they run one after the other
        getRequestToken() { (success, requestToken, errorString) in
            
            if success {
                
                // success! we have the requestToken!
                print(requestToken)
                self.requestToken = requestToken
                
                self.loginWithToken(requestToken, hostViewController: hostViewController) { (success, errorString) in
                    
                    if success {
                        self.getSessionID(requestToken) { (success, sessionID, errorString) in
                            
                            if success {
                                
                                // success! we have the sessionID!
                                self.sessionID = sessionID
                                
                                self.getUserID() { (success, userID, errorString) in
                                    
                                    if success {
                                        
                                        if let userID = userID {
                                            
                                            // and the userID 😄!
                                            self.userID = userID
                                        }
                                    }
                                    
                                    completionHandlerForAuth(success, errorString)
                                }
                            } else {
                                completionHandlerForAuth(success, errorString)
                            }
                        }
                    } else {
                        completionHandlerForAuth(success, errorString)
                    }
                }
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
    }
    
    private func getRequestToken(completionHandlerForToken: @escaping ( _ success: Bool, _ requestToken: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        let parameters = [String:AnyObject]()
        
        /* 2. Make the request */
        taskForGETMethod(Methods.AuthenticationTokenNew, parameters: parameters) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForToken(false,  nil, "Login Fail")
            } else {
                if let requestToken = results?[TMDBClient.JSONResponseKeys.RequestToken] as? String {
                    completionHandlerForToken(true, requestToken, nil)
                } else {
                    print("Could not find \(TMDBClient.JSONResponseKeys.RequestToken) in \(results)")
                    completionHandlerForToken(false, nil, "Login Failed (Request Token).")
                }
            }
        }
    }

    
    fileprivate func loginWithToken(_ requestToken: String?, hostViewController: UIViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let authorizationURL = URL(string: "\(TMDBClient.Constants.AuthorizationURL)\(requestToken!)")
        let request = URLRequest(url: authorizationURL!)
        let webAuthViewController = hostViewController.storyboard!.instantiateViewController(withIdentifier: "TMDBAuthViewController") as! TMDBAuthViewController
        webAuthViewController.urlRequest = request
        webAuthViewController.requestToken = requestToken
        webAuthViewController.completionHandlerForView = completionHandlerForLogin
        
        let webAuthNavigationController = UINavigationController()
        webAuthNavigationController.pushViewController(webAuthViewController, animated: false)
        
        performUIUpdatesOnMain {
            hostViewController.present(webAuthNavigationController, animated: true, completion: nil)
        }
    }
    
    fileprivate func getSessionID(_ requestToken: String?, completionHandlerForSession: (_ success: Bool, _ sessionID: String?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
        /*
        
        taskForGETMethod(method, parameters: parameters) { (results, error) in
        
        }
        
        */
    }
    
    fileprivate func getUserID(_ completionHandlerForUserID: (_ success: Bool, _ userID: Int?, _ errorString: String?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
        /*
        
        taskForGETMethod(method, parameters: parameters) { (results, error) in
        
        }
        
        */
    }
    
    // MARK: GET Convenience Methods
    
    func getFavoriteMovies(_ completionHandlerForFavMovies: (_ result: [TMDBMovie]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
    }
    
    func getWatchlistMovies(_ completionHandlerForWatchlist: (_ result: [TMDBMovie]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
    }
    
    func getMoviesForSearchString(_ searchString: String, completionHandlerForMovies: (_ result: [TMDBMovie]?, _ error: NSError?) -> Void) -> URLSessionDataTask? {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        return nil
    }
    
    func getConfig(_ completionHandlerForConfig: (_ didSucceed: Bool, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
    }
    
    // MARK: POST Convenience Methods
    
    func postToFavorites(_ movie: TMDBMovie, favorite: Bool, completionHandlerForFavorite: (_ result: Int?, _ error: NSError?) -> Void)  {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
    }
    
    func postToWatchlist(_ movie: TMDBMovie, watchlist: Bool, completionHandlerForWatchlist: (_ result: Int?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, the API method, and the HTTP body (if POST) */
        /* 2. Make the request */
        /* 3. Send the desired value(s) to completion handler */
        
    }
}
