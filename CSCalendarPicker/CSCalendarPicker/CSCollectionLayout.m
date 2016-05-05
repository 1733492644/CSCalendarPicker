

#import "CSCollectionLayout.h"
#import "UIView+Extension.h"

@implementation CSCollectionLayout


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


//即将布局时调用
-(void)prepareLayout
{
    [super prepareLayout];
    
    
    //设置滚动方向为水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.itemSize = CGSizeMake(self.collectionView.width / 3, self.collectionView.height);
    
    self.minimumLineSpacing = 0;
    
    CGFloat aaa = (self.collectionView.frame.size.width - self.collectionView.width / 3) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, aaa, 0, aaa);
    
 
    
}


//每次重新布局都会调用
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //屏幕上可见的矩形框
    CGRect isrect;
    isrect.size = self.collectionView.frame.size;
    isrect.origin = self.collectionView.contentOffset;
    
    //计算屏幕中间点的x
    CGFloat ceterX = self.collectionView.contentOffset.x + isrect.size.width * 0.5;
    
    //遍历布局属性，判断cell是否在矩形框中
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        //不在屏幕矩形框中的花，就跳过
        if (!CGRectIntersectsRect(isrect, attr.frame)) continue;
        
        
        //计算出缩放比例
       CGFloat scale = 1 + (1 - ((ABS(attr.center.x - ceterX)) / (self.collectionView.frame.size.width * 0.5)));
        
        attr.transform3D = CATransform3DMakeScale(scale * 0.8, scale * 0.8, 1.0);
        attr.alpha = scale * 0.5;
        
        
    }
    
    return array;
    
}



-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    
    //计算屏幕所在矩形框的CGRect
    CGRect isrect;
    isrect.origin = proposedContentOffset;
    isrect.size = self.collectionView.frame.size;
    
    
    //计算屏幕中间点的x
    CGFloat ceterX = self.collectionView.contentOffset.x + isrect.size.width * 0.5;
    
    
    
    //当前在屏幕上的布局属性
    NSArray *array = [self layoutAttributesForElementsInRect:isrect];
    
    CGFloat abc = 100000000;
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        if(ABS(attr.center.x - ceterX) < ABS(abc)){
        
            abc = attr.center.x - ceterX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + abc, 0);
    
    
    
}

@end
