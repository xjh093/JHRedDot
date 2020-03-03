# JHRedDot
Red dot. 小红点

# What is it?

1.自动靠右

2.通过 `JHRedDotConfig` 配置更多属性
```
@interface JHRedDotConfig : NSObject

/** Size of red dot. */
@property (nonatomic,  assign) CGSize  size;

/** Radius of red dot. */
@property (nonatomic,  assign) CGFloat  radius;

/** Default is 'redColor'. */
@property (nonatomic,  strong) UIColor *color;

/** Right space in superview. */
@property (nonatomic,  assign) CGFloat  offsetX;

/** Top space in superview. */
@property (nonatomic,  assign) CGFloat  offsetY;

@end
```

![image](https://github.com/xjh093/JHRedDot/blob/master/image/1.png)

![image](https://github.com/xjh093/JHRedDot/blob/master/image/2.png)

![image](https://github.com/xjh093/JHRedDot/blob/master/image/3.png)

![image](https://github.com/xjh093/JHRedDot/blob/master/image/4.png)

![image](https://github.com/xjh093/JHRedDot/blob/master/image/5.png)


# Logs
2. Fix bug.(2020-03-03)
1. Upload.(2018-09-03)

