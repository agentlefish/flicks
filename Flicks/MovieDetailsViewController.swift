//
//  MovieDetailsViewController.swift
//  Flicks
//
//  Created by Xiang Yu on 9/15/17.
//  Copyright © 2017 Xiang Yu. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieDetailsScrollView: UIScrollView!
    @IBOutlet weak var movieDetailsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.tabBarController?.tabBar.isHidden = true;

        if let posterUrl = URL(string: movie.highResPosterUrl!) {
            posterImgView.setImageWith(
                URLRequest(url: posterUrl),
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        self.posterImgView.alpha = 0.0
                        self.posterImgView.image = image
                        UIView.animate(withDuration: 2, animations: { () -> Void in
                            self.posterImgView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        self.posterImgView.image = image
                    }
            },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        else {
            //put a default pic here
        }
        
        titleLabel.text = movie.title
        //titleLabel.sizeToFit()
        
        overviewLabel.text = movie.overview
        overviewLabel.sizeToFit()
        
        movieDetailsView.frame.size.height = titleLabel.frame.size.height + overviewLabel.frame.size.height + 40
        
        let contentWidth = movieDetailsScrollView.bounds.width
        let contentHeight = movieDetailsView.frame.origin.y + movieDetailsView.frame.size.height + 50
        movieDetailsScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        movieDetailsScrollView.showsVerticalScrollIndicator = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
