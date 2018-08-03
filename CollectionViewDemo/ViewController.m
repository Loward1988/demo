//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by longanyang on 2017/12/14.
//  Copyright © 2017年 longanyang. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject
@property (nonatomic, assign) NSInteger hands;
@property (nonatomic, assign) NSInteger feet;
- (void)printp;
@end

@implementation Person
- (void)printp; {
    NSLog(@"123");
}

@end

@interface Person2 : Person
- (void)printp;
@end

@implementation Person2
- (void)printp {
    NSLog(@"456");
}
@end

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperationWithBlock:^{
        NSLog(@"11 %@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"22 %@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"33 %@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"44 %@", [NSThread currentThread]);
    }];
    
//    Person *p1 = [[Person alloc] init];
//    [p1 addObserver:self forKeyPath:@"hands" options:NSKeyValueObservingOptionNew context:nil];
//    dispatch_queue_t queue = dispatch_queue_create("myQ", DISPATCH_QUEUE_PRIORITY_DEFAULT);
//    dispatch_async(queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            p1.hands = 2;
//        });
//    });
//    p1.hands = 3;
    
    
//    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    NSLog(@"%@", change);
//    NSLog(@"%@", [NSThread currentThread]);
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //flowLayout.headerReferenceSize = CGSizeMake(100, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor blueColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
     return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
