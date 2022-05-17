//
//  HomeVC.swift
//  mconnectmedia
//
//  Created by Meghna on 17/05/22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var headerBackView: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnCopyAlbum: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
     let margin: CGFloat = 10
    var albumImage: [UIImage] = []
    var dateArray :[String] = []
    var timeArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prePareUI()
        
    }
}
extension HomeVC{
    func prePareUI(){
        headerBackView.backgroundColor = .clear
        
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.backgroundColor = .clear
        btnLogout.setTitleColor(.blue, for: .normal)
        
        btnHistory.setTitle("History", for: .normal)
        btnHistory.backgroundColor = .clear
        btnHistory.setTitleColor(.blue, for: .normal)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
        
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)

    }
}
extension HomeVC{
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        
        UserDefaults.standard.set("", forKey: "emailid")
        UserDefaults.standard.set("", forKey: "pin")
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: "emailid")
            }
        
        UserDefaults.standard.removeSuite(named: "emailid")
        UserDefaults.standard.removeSuite(named: "pin")



//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//         let vc = storyBoard.instantiateViewController(withIdentifier: "RegistationVC") as! RegistationVC
//         self.navigationController?.pushViewController(vc, animated: true)
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "RegistationVC") as! RegistationVC
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
       
    }
    @IBAction func btnHistoryAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       // let vc = ReceiveHistoryVC(nibName: "ReceiveHistoryVC", bundle: nil)
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "ReceiveHistoryVC") as! ReceiveHistoryVC
        vc.receiveAlbumImage = albumImage
               vc.receiveDate = dateArray
               vc.receiveTime = timeArray
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()

//        let vc = storyBoard.instantiateViewController(withIdentifier: "ReceiveHistoryVC") as! ReceiveHistoryVC
//        vc.receiveAlbumImage = albumImage
//        vc.receiveDate = dateArray
//        vc.receiveTime = timeArray
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnCopyAlbumAction(_ sender: UIButton) {
        ImagePickerManager().pickImage(self){ image in
            self.albumImage.append(image)
            self.printTimestamp()
            self.collectionView.reloadData()
            }
    }
}
extension HomeVC{
    func printTimestamp() {
        let finalDate = Date().string(format: "dd/MM/yyyy")
        dateArray.append(finalDate)
        let finalTime = Date().string(format: "HH:mm:ss")
        timeArray.append(finalTime)
    }
    func dataDelete(cellValue : Int){
        self.albumImage.remove(at: cellValue)
        self.collectionView.reloadData()
    }
}
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ImageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell", for: indexPath) as! ImageCollectionCell
        cell.parentVC = self
        cell.btnSelect.tag = indexPath.row
        cell.imgView.image = albumImage[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
