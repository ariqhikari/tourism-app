//
//  DetailViewController.swift
//  TourismApp
//
//  Created by Ariq Hikari on 10/04/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tourismImage: UIImageView!
    
    var tourism: Tourism? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let result = tourism {
            nameLabel.text = result.name
            descLabel.text = result.description
            latLabel.text  = String(format: "%.1f", result.latitude)
            longLabel.text = String(format: "%.1f", result.longitude)
            
            tourismImage.load(urlString: result.image)
            tourismImage.contentMode = .scaleAspectFill
            tourismImage.layer.cornerRadius = 8
            tourismImage.clipsToBounds = true
        }
    }
}
