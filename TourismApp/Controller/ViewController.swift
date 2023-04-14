//
//  ViewController.swift
//  TourismApp
//
//  Created by Ariq Hikari on 10/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tourismTableView: UITableView!
    
    var data = [Tourism]()
    let urlData = "https://tourism-api.dicoding.dev/list"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tourismTableView.dataSource = self
        tourismTableView.delegate = self
        
        tourismTableView.register(
          UINib(nibName: "TourismTableViewCell", bundle: nil),
          forCellReuseIdentifier: "TourismCell"
        )
        
        getData(from: urlData)
    }
    
    @IBAction func goToWebsite(_ sender: Any) {
          if let url = URL(string: urlData), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          }
    }
    
    private func getData(from url: String)  {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // have data
            var result: TourismResponse?
            do {
                result = try JSONDecoder().decode(TourismResponse.self, from: data)
            } catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            self.data = json.places
            DispatchQueue.main.async {
                self.tourismTableView.reloadData()
            }
        }
        
        task.resume()
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
          withIdentifier: "TourismCell",
          for: indexPath
        ) as? TourismTableViewCell {

          let tourism = data[indexPath.row]
          cell.tourismLabel.text = tourism.name
          cell.tourismLike.text = String(tourism.like) + " likes"
            
          cell.tourismImage.load(urlString: tourism.image)
          cell.tourismImage.contentMode = .scaleAspectFill
          cell.tourismImage.layer.cornerRadius = 8
          cell.tourismImage.clipsToBounds = true

          return cell
        } else {
          return UITableViewCell()
        }
    }
    
    override func prepare(
       for segue: UIStoryboardSegue,
       sender: Any?
     ) {
       if segue.identifier == "moveToDetail" {
         if let detaiViewController = segue.destination as? DetailViewController {
           detaiViewController.tourism = sender as? Tourism
         }
       }
     }
}

extension ViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
      performSegue(withIdentifier: "moveToDetail", sender: data[indexPath.row])
  }
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
