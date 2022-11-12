# CS61A

## hw2. make_repeater解法

已知
``` python
def product(n, term):
    """Return the product of the first n terms in a sequence.
    n -- a positive integer
    term -- a function that takes one argument to produce the term

    >>> product(3, identity)  # 1 * 2 * 3
    6
    >>> product(5, identity)  # 1 * 2 * 3 * 4 * 5
    120
    >>> product(3, square)    # 1^2 * 2^2 * 3^2
    36
    >>> product(5, square)    # 1^2 * 2^2 * 3^2 * 4^2 * 5^2
    14400
    >>> product(3, increment) # (1+1) * (2+1) * (3+1)
    24
    >>> product(3, triple)    # 1*3 * 2*3 * 3*3
    162
    """
    "*** YOUR CODE HERE ***"
    result = 1
    i = 1
    while i <= n:
        result *= term(i)
        i += 1
    return result   

def accumulate(combiner, base, n, term):
    """Return the result of combining the first n terms in a sequence and base.
    The terms to be combined are term(1), term(2), ..., term(n).  combiner is a
    two-argument commutative function.

    >>> accumulate(add, 0, 5, identity)  # 0 + 1 + 2 + 3 + 4 + 5
    15
    >>> accumulate(add, 11, 5, identity) # 11 + 1 + 2 + 3 + 4 + 5
    26
    >>> accumulate(add, 11, 0, identity) # 11
    11
    >>> accumulate(add, 11, 3, square)   # 11 + 1^2 + 2^2 + 3^2
    25
    >>> accumulate(mul, 2, 3, square)    # 2 * 1^2 * 2^2 * 3^2
    72
    >>> accumulate(lambda x, y: x + y + 1, 2, 3, square)
    19
    >>> accumulate(lambda x, y: 2 * (x + y), 2, 3, square)
    58
    >>> accumulate(lambda x, y: (x + y) % 17, 19, 20, square)
    16
    """
    "*** YOUR CODE HERE ***"
    i = 1
    result = base
    while i <= n:
        result = combiner(result,term(i))
        i += 1
    return result

def compose1(func1, func2):
    """Return a function f, such that f(x) = func1(func2(x))."""
    def f(x):
        return func1(func2(x))
    return f

def make_repeater(func, n):
    """Return the function that computes the nth application of func.

    >>> add_three = make_repeater(increment, 3)
    >>> add_three(5)
    8
    >>> make_repeater(triple, 5)(1) # 3 * 3 * 3 * 3 * 3 * 1
    243
    >>> make_repeater(square, 2)(5) # square(square(5))
    625
    >>> make_repeater(square, 4)(5) # square(square(square(square(5))))
    152587890625
    >>> make_repeater(square, 0)(5) # Yes, it makes sense to apply the function zero times!
    5
    """
    "*** YOUR CODE HERE ***"
```

这里可以看到accumulate是函数product的一个抽象
product函数的作用是给一个整数n,和一个函数term,
计算从term(1),term(2),...,term(n)的乘积

而accumulate的函数做了一个更高层的抽象，对于任意两个term(i)
,term(j)之间的运算符，由原来的乘法运算符抽象到了任意二元运算符

## self-reference
**画出下列程序的执行栈帧图(Environment Diagrams)**

``` python
def horse(mask):
    horse = mask
    def mask(horse):
        return horse
    return horse(mask)

mask = lambda horse : horse(2)
horse(mask)
```

## function decorators

``` python
def trace1(fn):
    """
    """
    def traced(x):
        print("Calling", fn, 'on argument', x)
        return fn(x)
    return traced

@trace1    # ===> square = trace1(square)
def square(x):
    return x * x

def sum_suqares_up_to(n):
    k = 1
    total = 0
    while k <= n:
        total, k = total + square(k), k+1
    
    return total

```

## 如何验证递归的正确性

以验证阶乘为例
``` python
def fact(n):
    if n == 0:
        return 1
    else:
        return n * fact(n - 1)
```
Is fact implemented correctly?
1. Verify the base case.
2. Treat fact as a functional abstraction!
3. Assum that fact(n - 1) is correct,**don't care about how does it implement this first**
4. Verify that fact(n) is correct, assuming that fact(n - 1) correct.

When learning to write recursive functions, put the base case first!

Base case is always important in recursive functions!

## 树形递归

tree recursion allows us look at a very large space of possibilities in a small amount of code

knapsack: 给定数字n和k，数字k可否由数字n上的一位或者多位的数字相加而成？
``` python
# 背包问题？递归解法
def knap(n, k):
    if n == 0:
        return k == 0
    else:
        with_last = knap(n // 10, k - n % 10)
        without_last = knap(n // 10, k)

        return with_last or without_last

```

counting partition: 给定数字n，m, 将数字n分解成一系列数字的和，但这些数字最大不超过m, 有多少种分解方法？

``` python
# 不剪枝，留到递归边界处理
def count_partitions(n, m):
    if n == 0:
        return 1
    elif n < 0:
        return 0
    elif m == 0:
        return 0
    else:
        with_m = count_partitions(n - m, m)
        without_m = count_partitions(n, m - 1)
        return with_m + without_m

```
**剪枝或递归边界不要重复或者遗漏当做剪枝时一定要考虑好剪掉了哪些枝，哪些没有被剪掉没有被剪掉的需要在递归边界处进行处理**
``` python
# 不剪枝，留到递归边界处理
def count_partitions(n, m):
    if n == 0:
        return 1
    elif m == 0:
        return 0
    else:
        if n < m:
            return count_partitions(n, m - 1)
        return count_partitions(n - m, m)+count_partitions(n, m - 1)
```

binary print: 给定数字k,打印所有的不超过k位的二进制数字，用01的方式打印出来
``` python
...
```

key-value store:
``` python
def lens(prev = lambda x:0):
    def put(k, v):
        def get(k2):
            if k2 == k:
                return v
            else:
                return prev(k2)
        return get,lens(get)
    return put
```

## 编码简记
ASCII: 规定了128种字符规范，并没有涵盖西文字母之外的字符

Unicode: 在一个字符集中包含了世界上所有文字和符号，统一编码，来终结不同编码产生乱码的问题。

Unicode 统一了所有字符的编码，是一个 Character Set，也就是字符集，字符集只是给所有的字符一个唯一编号，但是却没有规定如何存储

UTF-32 每个字符都用4个byte存储，太浪费空间

UTF-8使用变长存储，1～4 bytes 存储一位字符

GB2321 -> GBK -> GB18030 (国内提出的标准，不同版本之间应该只是对字符集做了扩展)

# python中使用可变的默认参数是非常危险的

``` bash
>>> def f(s = []):
...     s.append(5)
...     return len(s)
... 
>>> f()
1
>>> f()
2
>>> f()
3
>>> f()
4
```