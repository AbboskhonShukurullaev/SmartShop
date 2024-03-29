import UIKit
import PKHUD
import SideMenuSwift
import Kingfisher

class MenuViewController: RestaurantViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMenuCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBarUI()
        setupUpCollectionView()
    }
    
    func getMenuCategories() {
        HUD.show(.progress)
        RestaurantService.shared.getRestaurant(success: { (code, restaurant) in
            HUD.hide()
            // The parent Model is assigned -> all child models are assigned too. That means our Restaurant.swift models (ALL!!) are ready.
            self.restaurant = restaurant
            print(code, restaurant)
            self.collectionView.reloadData()
        }) { (code) in
            HUD.hide()
            print("Failed: \(code)")
        }
    }
    
    //MARK: - Properties
    
    var restaurant: RestaurantModel?
    
    lazy var collectionView: UICollectionView = {
        //Необходимо задать Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurant?.popular_categories!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVCell", for: indexPath) as! MenuCVCell
        cell.foodImageView.setImageFromURL((self.restaurant?.popular_categories?[indexPath.item].image_url!)!)
            cell.foodNameLabel.text = self.restaurant?.popular_categories?[indexPath.item].title
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(indexPath.item)")
        let categoryMealsVC = CategoryMealViewController()
        //ZDES mi dostaem naw rest. i naxodim vse categories. dalle naxodim tot samiy po indeksu. I.E "Breakfast". i dalse kidaem v CategoryMealViewController.
        if let selectedCategory = self.restaurant?.popular_categories?[indexPath.item] {
        categoryMealsVC.selectedCategory = selectedCategory
        }
       self.navigationController?.pushViewController(categoryMealsVC, animated: true)
    }
    
    //КВАДРАТ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH / 2.3, height: SCREEN_WIDTH / 2.3)
    }

    //Выравниваем селлы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellWidth : CGFloat = SCREEN_WIDTH / 2.3
        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
        let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 10, left: edgeInsets, bottom: 0, right: edgeInsets)
    }
 

}

extension MenuViewController {
    func setupNavBarUI() {
        title = "Menu"
    }
    
    func setupUpCollectionView() {
        self.view.addSubview(collectionView)
        
        //Достаем наш XIB по имени MenuCVCell
        let nib = UINib.init(nibName: "MenuCVCell", bundle: nil)
        //Регистрируем наш селл
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MenuCVCell")
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
