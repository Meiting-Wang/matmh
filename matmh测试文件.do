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
matmh test = round(A)      //求与矩阵A最近的板
matmh test = ceil(A)       //求与矩阵A的"天花板"

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

*7. 可运行所有matrix命令可执行的矩阵运算，如下，但不限于：
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
