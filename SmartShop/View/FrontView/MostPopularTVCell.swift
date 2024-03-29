
import UIKit

class MostPopularTVCell: UITableViewCell {

    lazy var mealImageView: UIImageView = {
        let mealImageView = UIImageView()
        mealImageView.contentMode = .scaleToFill
        return mealImageView
    }()
    
    lazy var mealNameLabel: UILabel = {
        let mealNameLabel = UILabel()
        mealNameLabel.font = avenirHeavy18
        mealNameLabel.text = ""
        mealNameLabel.textColor = .black
        return mealNameLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = avenirHeavy18
        priceLabel.text = ""
        priceLabel.textColor = .black
        return priceLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(mealImageView)
        contentView.addSubview(mealNameLabel)
        contentView.addSubview(priceLabel)
        
        mealImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(230)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        mealNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mealImageView.snp.bottom).offset(1)
            make.left.equalTo(mealImageView.snp.left)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mealNameLabel)
            make.right.equalTo(mealImageView.snp.right)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
