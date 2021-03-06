//
//  Person+CoreDataProperties.h
//  CoreDataSample
//
//  Created by imaginedays on 2018/3/12.
//  Copyright © 2018年 imaginedays. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL sex;

@end

NS_ASSUME_NONNULL_END
