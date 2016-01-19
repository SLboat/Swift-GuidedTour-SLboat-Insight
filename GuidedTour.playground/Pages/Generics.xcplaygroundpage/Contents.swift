//: ## Generics
//:
//: Write a name inside angle brackets to make a generic function or type.
//:
//在尖括号里写上一个名字,得到一个通用方法或者类型.
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] { //这里Item是一个代替名字
    var result = [Item]() //结果的最初部分
    for _ in 0..<numberOfTimes { //遍历次数
         result.append(item) //翻滚自己...自己的数组总是能够容纳自己
    }
    return result
}
repeatItem("knock", numberOfTimes:4) //演示它,这是个字符串

repeatItem(12, numberOfTimes: 2) //数字也没有问题

//妙处: 嗯...这些东西对啥子类都管用
//: You can make generic forms of functions and methods, as well as classes, enumerations, and structures.
//:
// 重新实现基本库的可选选项...
enum OptionalValue<Wrapped> { //这里Wrapped是个代名词,看起来通常都喜欢大写首字母
    case None
    case Some(Wrapped) //这里久包含所谓的值了
}
var possibleInteger: OptionalValue<Int> = .None //可选的类型是Int,值是空...
possibleInteger = .Some(100) //解出里面的值...

//: Use `where` after the type name to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.
//:
// 使用where在类型名称后面,指定一个需求类别,像是需要这个类型实现了某个协议,两个类型是一致的,或者这个类型有一个具体的父类.
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool { //T是序列类型(数组啥子的),U也是序列类型-附带要求,T的生成器的元素可以判断相等,T和U的生成器元素等于U的生成器类型
    for lhsItem in lhs { //穷举左边的
        for rhsItem in rhs { //穷举右边的
            if lhsItem == rhsItem { //有一个相等..
                return true
            }
        }
    }
   return false
}
anyCommonElements([1, 2, 3], [3])

func any2CommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool { //有趣,中括号,都是拼命的描述它们的要求....
    var common = 0 //公共数
    for lhsItem in lhs { //穷举左边的
        for rhsItem in rhs { //穷举右边的
            if lhsItem == rhsItem { //有一个相等..
                if common < 1 {
                    common++
                } else {
                    return true //成了
                }
            }
        }
    }
    return false
}
any2CommonElements([1, 2, 3], [2,3])
//: > **Experiment**:
//: > Modify the `anyCommonElements(_:_:)` function to make a function that returns an array of the elements that any two sequences have in common.
//:
//: Writing `<T: Equatable>` is the same as writing `<T where T: Equatable>`.
//:


//: [Previous](@previous)
