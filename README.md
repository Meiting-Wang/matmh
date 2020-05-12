# Stata 新命令：matmh——扩展版的矩阵运算命令

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 摘要

本文主要介绍了个人编写的可在 Stata 内存中进行更多矩阵运算的`matmh`命令。

## 目录

- **摘要**
- **一、引言**
- **二、命令的安装**
- **三、语法与选项**
- **四、实例**
- **五、命令运行展示**
- **附录：全文所有命令行**

## 一、引言

本文介绍的`matmh`命令，为 matrix math 的简写，旨在缓解 Stata 系统自带的`matrix`命令鸡肋的矩阵运算功能。基于`matrix`内核，**`matmh`不仅能处理所有`matrix`能处理的矩阵运算，而且还具有拓展版子矩阵提取、元素运算、逻辑运算、数学函数运算、幂运算以及构建等差或等比数列的功能**。

鉴于个人使用 MATLAB 的习惯，我更喜欢在进行完矩阵运算后，结果被呈现在软件界面上，于是该命令被默认设置为自动展示结果至 Stata 界面上。有基础的读者也可以根据自己的习惯进行调整。

也许有读者会说，Mata 也能进行本文命令的操作，且速度更快。而事实上，（1）如果不是非常高维的矩阵或大量的矩阵运算，我们肉眼是几乎不能区分 Stata 和 Mata 的速度；（2）如果使用 Mata 命令，那么我们可能需要在 Stata 环境和 Mata 环境中来回切换，甚是不便；（3）如果使用 Mata 命令，矩阵的行列名传递会很麻烦，有兴趣的读者可以尝试一下，而本文命令将自动传递矩阵行列名。当然，这不是说 Mata 不好，实际上，我也经常使用 Mata 做一些其他的事情，它在某些方面有着 Stata 不可比拟的优势（如大量的 Stata 环境没有的函数），只是，在并不是很复杂的矩阵运算中，本文的命令足以。

由于该命令建立在`matrix`内核上，如果读者对此命令不太熟悉，建议先学习`matrix`命令，然后再进一步学习本文的`matmh`命令。

## 二、命令的安装

`matmh`命令以及本人其他命令的代码都托管于 GitHub 上，以使得同学们可以随时下载安装这些命令。

首先你需要有`github`命令，如果没有，可参见[「Stata 新命令：wmtsum——描述性统计表格的输出」](https://mp.weixin.qq.com/s/oLgXf0KTgoePOnN1mJUllA)进行安装。

然后你就可以运行以下命令安装最新的`matmh`命令及其帮助文件了：

```stata
github install Meiting-Wang/matmh
```

当然，你也可以`github search`一下，也能找到`matmh`命令安装的入口：

```stata
github search matmh
```

## 三、语法与选项

**命令语法**：

```stata
matmh a_matrix_operation_expression [, options]
```

> - `a_matrix_operation_expression`: 输入一个矩阵运算表达式，如`A = (1,2\3,4)`

**选项（options）**：

- `display(fmt)`: 设置矩阵的数值格式
- `ndisplay`: 不在 Stata 界面展示矩阵。该命令默认会在 Stata 界面展示运算结果中的矩阵

> - 以上选项均可以缩写，详情可以在安装完命令后`help matmh`

## 四、实例

- **初始化**

```stata
matmh drop _all
matmh A = (4,6,8,10\-1,0,1,16\1.2,1.3,1.4,1.5\3.6,-1.6,-1.4,-1.5)
matmh B = (3,2,2,5\5,6,7,8\8,3,4,11\6,13,14,6)
```

- **从一个矩阵中提取子矩阵**

```stata
matmh test = A                         //复制矩阵A
matmh test = A[2,3]                    //提取矩阵A第2行第3列的元素
matmh test = A[1:3,2]                  //提取矩阵A第1至3行，第2列的元素
matmh test = A[1:,2]                   //提取矩阵A第2列的元素
matmh test = A[:,2]                    //提取矩阵A第2列的元素
matmh test = A[1:3,2:4]                //提取矩阵A第1至3行，第2至4列的元素
matmh test = A[1:3,2:]                 //提取矩阵A第1至3行，第2至最后一列的元素
matmh test = A[1:3,:]                  //提取矩阵A第1至3行，所有列的元素
matmh test = A[1:3,1 3 4]              //提取矩阵A第1至3行，第1、3、4列的元素
matmh test = A[1 3 4,1 3 4]            //提取矩阵A第1、3、4行，第1、3、4列的元素
matmh test = A[1 3 4,1 3 4], nd        //求得矩阵test后不将其展示出来
matmh test = A[1 3 4,1 3 4], d(%9.3f)  //求得矩阵test后并把其以%9.3f的格式展示出来
```

- **矩阵的元素运算**

```stata
matmh test = A.+B     //点加
matmh test = A.-B     //点减
matmh test = A.*B     //点乘
matmh test = A./B     //点除
matmh test = A.^B     //点幂
```

- **矩阵的逻辑运算**

```stata
matmh test = (A>B)      //不等式逻辑值
matmh test = A>=B
matmh test = A==B
matmh test = A<=B
matmh test = A<B
matmh test = A!=B
matmh test = A~=B
matmh test = A&B      //逻辑与
matmh test = A|B      //逻辑或
matmh test = !A       //逻辑非
matmh test = ~A
```

- **矩阵的数学函数运算**

```stata
matmh test = reverse(A)    //将矩阵A中的所有元素转化为其倒数(自创函数)
matmh test = ln(A)         //求自然对数
matmh test = log10(A)      //求以10为底的对数
matmh test = abs(A)        //求绝对值
matmh test = exp(A)        //求以自然数为底的指数
matmh test = floor(A)      //求矩阵A的"地板"
matmh test = round(A)      //求与矩阵A最近的板
matmh test = ceil(A)       //求与矩阵A的"天花板"
```

> 更多的数学函数，可以`help mathematical functions`

- **矩阵的幂运算**

```stata
matmh test = A^10          //10个方阵A相乘
matmh test = A^(10)
matmh test = A^-1          //方阵A的逆
matmh test = A^(-1)
```

- **等差或等比列向量的构建**

```stata
*apd: arithmetic progression containing delta
*ape: arithmetic progression containing end_number
*gpd: geometric progression containing delta
*gpe: geometric progression containing end_number
*matmh test = apd(begin_num,quantity_of_numbers,delta)
*matmh test = ape(begin_num,quantity_of_numbers,end_num)
*matmh test = gpd(begin_num,quantity_of_numbers,delta)
*matmh test = gpe(begin_num,quantity_of_numbers,end_num)

matmh test = 1::10   //生成等差列向量：[1,2,3,4,5,6,7,8,9,10]'
matmh test = 1:2:11  //生成等差列向量：[1,3,5,7,9,11]'
matmh test = 1:2:12  //生成等差列向量：[1,3,5,7,9,11]'

matmh test = apd(1,6,3)   //生成等差列向量：[1,4,7,10,13,16]'
matmh test = ape(1,5,21)  //生成等差列向量：[1,6,11,16,21]'
matmh test = gpd(1,6,2)   //生成等比列向量：[1,2,4,8,16,32]'
matmh test = gpe(1,5,81)  //生成等比列向量：[1,3,9,37,81]'
```

- **可执行`matrix`命令可执行的矩阵运算，如下，但不限于：**

```stata
matmh test = A + B
matmh test = A * B
matmh test = A # B
matmh test = A \ B
matmh test = (A,B)
matmh test = A / 3
matmh test = hadamard(A,B)
matmh test = J(2,3,9)
matmh test = matuniform(4,5)
matmh test = trace(A)
matmh test = rowsof(A)
matmh A[1,1] = 100
matmh rown A = row1 row2 row3 row4
matmh dir
matmh drop test
matmh rename A new_A
matmh list new_A
matmh test = (6,2,4\2,3,2\4,2,6)
matmh symeigen X v = test
matmh svd U W V = test
```

> 以上所有实例都可以在`help matmh`中直接运行。  
> ![](https://imgkr.cn-bj.ufileos.com/bdbab909-00cb-491a-b303-11e54b23de1b.png)

## 五、命令运行展示

- **命令行**

```stata
matmh A = (4,6,8,10\-1,0,1,16\1.2,1.3,1.4,1.5\3.6,-1.6,-1.4,-1.5)
matmh B = (3,2,2,5\5,6,7,8\8,3,4,11\6,13,14,6)
matmh test = A[1 3 4,1 3 4]
matmh test = A.*B
matmh test = A>=B
matmh test = abs(A)
matmh test = A^2
matmh test = 1::10
matmh test = matuniform(4,5)
```

- **运行结果**

```stata
. matmh A = (4,6,8,10\-1,0,1,16\1.2,1.3,1.4,1.5\3.6,-1.6,-1.4,-1.5)

A[4,4]
      c1    c2    c3    c4
r1     4     6     8    10
r2    -1     0     1    16
r3   1.2   1.3   1.4   1.5
r4   3.6  -1.6  -1.4  -1.5

. matmh B = (3,2,2,5\5,6,7,8\8,3,4,11\6,13,14,6)

B[4,4]
    c1  c2  c3  c4
r1   3   2   2   5
r2   5   6   7   8
r3   8   3   4  11
r4   6  13  14   6

. matmh test = A[1 3 4,1 3 4]

test[3,3]
      c1    c3    c4
r1     4     8    10
r3   1.2   1.4   1.5
r4   3.6  -1.4  -1.5

. matmh test = A.*B

test[4,4]
       c1     c2     c3     c4
r1     12     12     16     50
r2     -5      0      7    128
r3    9.6    3.9    5.6   16.5
r4   21.6  -20.8  -19.6     -9

. matmh test = A>=B

test[4,4]
    c1  c2  c3  c4
r1   1   1   1   1
r2   0   0   0   1
r3   0   0   0   0
r4   0   0   0   0

. matmh test = abs(A)

test[4,4]
     c1   c2   c3   c4
r1    4    6    8   10
r2    1    0    1   16
r3  1.2  1.3  1.4  1.5
r4  3.6  1.6  1.4  1.5

. matmh test = A^2

test[4,4]
       c1     c2     c3     c4
r1   55.6   18.4   35.2    133
r2   54.8  -30.3    -29  -32.5
r3  10.58   6.62  10.76  32.65
r4   8.92  22.18  27.34  10.55

. matmh test = 1::10

test[10,1]
     c1
 r1   1
 r2   2
 r3   3
 r4   4
 r5   5
 r6   6
 r7   7
 r8   8
 r9   9
r10  10

. matmh test = matuniform(4,5)

test[4,5]
           c1         c2         c3         c4         c5
r1  .90110491  .26436492  .88565093  .88211203  .74893298
r2  .91962622  .69345326  .21540258  .82858886  .04421535
r3  .86303775  .35260458  .77203998  .58611991  .32277663
r4  .17293066  .80536444   .3060019  .21909967  .72473097
```

## 附录：全文所有命令行

```stata
pr drop _all
matmh drop _all

matmh A = (4,6,8,10\-1,0,1,16\1.2,1.3,1.4,1.5\3.6,-1.6,-1.4,-1.5)
matmh B = (3,2,2,5\5,6,7,8\8,3,4,11\6,13,14,6)

*1. 从一个矩阵中提取子矩阵
matmh test = A                         //复制矩阵A
matmh test = A[2,3]                    //提取矩阵A第2行第3列的元素
matmh test = A[1:3,2]                  //提取矩阵A第1至3行，第2列的元素
matmh test = A[1:,2]                   //提取矩阵A第2列的元素
matmh test = A[:,2]                    //提取矩阵A第2列的元素
matmh test = A[1:3,2:4]                //提取矩阵A第1至3行，第2至4列的元素
matmh test = A[1:3,2:]                 //提取矩阵A第1至3行，第2至最后一列的元素
matmh test = A[1:3,:]                  //提取矩阵A第1至3行，所有列的元素
matmh test = A[1:3,1 3 4]              //提取矩阵A第1至3行，第1、3、4列的元素
matmh test = A[1 3 4,1 3 4]            //提取矩阵A第1、3、4行，第1、3、4列的元素
matmh test = A[1 3 4,1 3 4], nd        //求得矩阵test后不将其展示出来
matmh test = A[1 3 4,1 3 4], d(%9.3f)  //求得矩阵test后并把其以%9.3f的格式展示出来

*2. 矩阵的元素运算
matmh test = A.+B     //点加
matmh test = A.-B     //点减
matmh test = A.*B     //点乘
matmh test = A./B     //点除
matmh test = A.^B     //点幂

*3. 矩阵的逻辑运算
matmh test = (A>B)      //不等式逻辑值
matmh test = A>=B
matmh test = A==B
matmh test = A<=B
matmh test = A<B
matmh test = A!=B
matmh test = A~=B
matmh test = A&B      //逻辑与
matmh test = A|B      //逻辑或
matmh test = !A       //逻辑非
matmh test = ~A

*4. 矩阵的数学函数运算
matmh test = reverse(A)    //将矩阵A中的所有元素转化为其倒数(自创函数)
matmh test = ln(A)         //求自然对数
matmh test = log10(A)      //求以10为底的对数
matmh test = abs(A)        //求绝对值
matmh test = exp(A)        //求以自然数为底的指数
matmh test = floor(A)      //求矩阵A的"地板"
matmh test = round(A)      //求与矩阵A最近的"板"
matmh test = ceil(A)       //求矩阵A的"天花板"

*5. 矩阵的幂运算
matmh test = A^2           //2个方阵A相乘(输入的A必须为方阵)
matmh test = A^10          //10个方阵A相乘
matmh test = A^(10)
matmh test = A^-1          //方阵A的逆
matmh test = A^(-1)

*6. 等差或等比列向量的构建
*apd: arithmetic progression containing delta
*ape: arithmetic progression containing end_number
*gpd: geometric progression containing delta
*gpe: geometric progression containing end_number
*matmh test = apd(begin_num,quantity_of_numbers,delta)
*matmh test = ape(begin_num,quantity_of_numbers,end_num)
*matmh test = gpd(begin_num,quantity_of_numbers,delta)
*matmh test = gpe(begin_num,quantity_of_numbers,end_num)

matmh test = 1::10   //生成等差列向量：[1,2,3,4,5,6,7,8,9,10]'
matmh test = 1:2:11  //生成等差列向量：[1,3,5,7,9,11]'
matmh test = 1:2:12  //生成等差列向量：[1,3,5,7,9,11]'

matmh test = apd(1,6,3)   //生成等差列向量：[1,4,7,10,13,16]'
matmh test = ape(1,5,21)  //生成等差列向量：[1,6,11,16,21]'
matmh test = gpd(1,6,2)   //生成等比列向量：[1,2,4,8,16,32]'
matmh test = gpe(1,5,81)  //生成等比列向量：[1,3,9,37,81]'

*7. 可执行所有matrix命令可执行的矩阵运算，如下，但不限于：
matmh test = A + B
matmh test = A * B
matmh test = A # B
matmh test = A \ B
matmh test = (A,B)
matmh test = A / 3
matmh test = hadamard(A,B)
matmh test = J(2,3,9)
matmh test = matuniform(4,5)
matmh test = trace(A)
matmh test = rowsof(A)
matmh A[1,1] = 100
matmh rown A = row1 row2 row3 row4
matmh dir
matmh drop test
matmh rename A new_A
matmh list new_A
matmh test = (6,2,4\2,3,2\4,2,6)
matmh symeigen X v = test
matmh svd U W V = test
```
