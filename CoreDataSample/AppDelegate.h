//
//  AppDelegate.h
//  CoreDataSample
//
//  Created by imaginedays on 2018/3/12.
//  Copyright © 2018年 imaginedays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

