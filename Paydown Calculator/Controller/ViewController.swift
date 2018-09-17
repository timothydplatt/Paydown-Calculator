import UIKit

class ViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var leftScrollView: UIScrollView!
    @IBOutlet weak var rightScrollView: UIScrollView!
    @IBOutlet weak var leftContainerView: UIView!
    @IBOutlet weak var rightContainerView: UIView!
    
    //MARK:- PROPERTIES
    
    
    //MARK:- APP LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialScreenHeight = self.view.frame.size.height
        
        leftScrollView.delegate = self
        rightScrollView.delegate = self
        leftScrollView.showsVerticalScrollIndicator = false
        rightScrollView.showsVerticalScrollIndicator = false
        
        let leftScaleContainerView = ScaleView(frame: CGRect(x: leftContainerView.frame.origin.x , y: leftContainerView.frame.origin.y, width: self.view.frame.width/2, height: leftContainerView.frame.height), scaleStartPosition: CGPoint(x: self.view.frame.width/2, y: initialScreenHeight/4), scaleEndPosition: CGPoint(x: self.view.frame.width/2, y: leftContainerView.frame.height), scaleDirection: "Left")
        
        
        let rightScaleContainerView = ScaleView(frame: CGRect(x: rightContainerView.frame.origin.x , y: rightContainerView.frame.origin.y, width: self.view.frame.width/2, height: rightContainerView.frame.height), scaleStartPosition: CGPoint(x: self.view.frame.width/2, y: initialScreenHeight/4), scaleEndPosition: CGPoint(x: self.view.frame.width/2, y: rightContainerView.frame.origin.y), scaleDirection: "Right")
        

        leftScaleContainerView.backgroundColor = .yellow
        leftScaleContainerView.alpha = 0.5
        self.leftContainerView.addSubview(leftScaleContainerView)
        
        rightScaleContainerView.backgroundColor = .yellow
        rightScaleContainerView.alpha = 0.5
        self.rightContainerView.addSubview(rightScaleContainerView)
        
//        let x = MinPayCalculator()
//        let y = x.minPayCalculator(balance: "1000", APR: "20", repaymentType: 1, percentOfBalance: "1", fixedAmount: "25", percentOfBalanceOnly: "0")
//        print(y)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let maximumLeftVerticalOffset: CGFloat = leftScrollView.contentSize.height - leftScrollView.frame.height
        let maximumRightVerticalOffset: CGFloat = rightScrollView.contentSize.height - rightScrollView.frame.height
        
        if (leftScrollView == scrollView) {
            
            let currentLeftVerticalOffset: CGFloat = leftScrollView.contentOffset.y
            let percentageLeftVerticalOffset: CGFloat = currentLeftVerticalOffset / maximumLeftVerticalOffset
            
            let movePercentageRightVerticalOffsetBy = -percentageLeftVerticalOffset
            //let movePercentageRightVerticalOffsetBy = percentageLeftVerticalOffset
            rightScrollView.contentOffset.y = maximumRightVerticalOffset * movePercentageRightVerticalOffsetBy

        } else if (rightScrollView == scrollView) {
            
            let currentRightVerticalOffset: CGFloat = rightScrollView.contentOffset.y
            let percentageRightVerticalOffset: CGFloat = currentRightVerticalOffset / maximumRightVerticalOffset
            
            let movePercentageLeftVerticalOffsetBy = -percentageRightVerticalOffset
            leftScrollView.contentOffset.y = maximumLeftVerticalOffset * movePercentageLeftVerticalOffsetBy

        }
    }
    
}
