import UIKit

class ViewController: UIViewController {
    
    var imageUrls: [String] = ImagesFileDecoder.images()
    
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: "CustomViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
//    override func loadView() {
//        self.view = ViewWithCollection()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomViewCell
        cell.index = indexPath
        
        cell.setIamge(url: imageUrls[indexPath.row])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
