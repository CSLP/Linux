
# Shell 笔记

[TOC]

[TOC]

### 0. 大纲

[Shell笔记](#Shell-笔记)

* [1. 运行](#1-运行)
* [2. Shell变量](#2-Shell变量)
* [3. Shell字符串](#3-Shell字符串)
* [4. Shell数组](#4-Shell数组)
* [5. 注释](5-注释)
* [6. 给shell脚本传参数](6-给shell脚本传参数)
* [7. Shell 基本运算符](7-Shell-基本运算符)
* [8. Shell echo 命令](8-Shell-echo-命令)
* [9. Shell printf 命令](9-Shell-printf-命令)
* [10. Shell test命令](10-Shell-test命令)
* [11. Shell 流程控制](11-Shell-流程控制)
* [12. Shell 函数](12-Shell-函数)
* [13. Shell 输入输出重定向](13-Shell-输入输出重定向)
* [14. Shell 文件包含](14-Shell-文件包含)

### 1. 运行

* 创建test.sh 名字随便，见名知意更好，shell脚本一般.sh表明
* 开头#! /bin/bash 指定系统此脚本需要什么解释器来执行，即使用哪一种shell
* 运行shell脚本两种办法
  * 作为可执行程序./test.sh（可能写完需要加执行权限），系统调用脚本指定的解释器来执行
  * 作为解释器参数：bash test.sh 这种方式忽略脚本第一行的指定解释器信息，可以不写，写了也没用

### 2. Shell变量

##### 1.变量名要求同C++，有一点不同

* 英文字母，数字，下划线组成，首字符不能数字开头
* 不能使用关键字

* 初始化或赋值时变量和等号之间不能有空格
  
##### 2. 定义及赋值

  * 定义：无需指定类型，直接：var
  * 赋值：var="jjjjj"或var=12(只有字符串和数字两种，所以字符串的双引号可省略)
  * 可在定义时赋值var="Shell Script wudi "
##### 3. 使用变量

  * $var或${var}     eg:   echo $var, var1=$var
  
  * 不断重新赋值 
  
    ```shell
    var=helloworld
    echo $var
    var=focus
    echo $var
    var1=$var
    echo $var1
    ```

##### 4. 只读变量

  * readonly 指定，readonly 语句之后，该变量不可在赋值
  
  * ```shell
    var=helloworld
    echo $var
    var=nmsl
    echo $var
    readonly var
    var=focus  //报错，readonly变量之后，该变量不可在修改
    echo $var   
    ```

##### 5. 删除变量

  * unset var   变量删除后不可在使用
  
    * ```shell
      var=helloworld
      echo $var
      unset var
      echo $var //显示为空
      ```
  
  * unset命令不可删除只读变量
  
    * ```shell
      var=helloworld
      readonly var
      unset var  //报错
      ```

##### 6. 变量类型

  * **局部变量** 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
  * **环境变量** 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
  * **shell变量** shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

### 3. Shell字符串

##### 1. 赋值

* 无引号

  * var=helloworld
  * 限制
    * 若字符串有空格，则必须加引号
    * `var=hello world`  报错

* 单引号

  * var='helloworld'
  * 限制：
    * 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的
    * 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

* 双引号

  * var="helloworld"

  * 优点：

    * 双引号里可以有变量

    * 双引号里可以出现转义字符

    * ```shell
      var=helloworld
      str="this is $var"
      str1="this is \" nimasile \""
      echo $str  //输出this is heloworld
      echo $str1 //输出 this is "nimasile"   
      ```

##### 2. 拼接字符串

* 单引号方式

  * ```shell
    var=LP
    str1='My name is '$var' '
    str2='My name is $var'
    echo $str1 $str2
    输出：My name is LP   My name is $var
    ```

* 双引号方式

  * ```shell
    var=Lp
    str1="my name is $var"
    str2="my name is "$var""//不加转义符，忽略引号内的双引号
    str3="my name is \$var"
    echo $str1 $str2 $str3
    输出My name is Lp My name is Lp My name is $var
    ```

##### 3. 获取字符串长度

* #

  * ```sell
    var="helloworld"
    echo ${#var}
    输出：10
    ```

##### 4. 提取子字符串

* i:j  表示从下标i开始截取j个字符。（下标从0开始）

  * ```shell
    var=helloworld
    str=${var:1:2}
    echo str
    输出：el
    ```

##### 5. 查找子字符串

* expr index  被查找string 要查找的子字符串

  * ```shell
    var="You are such a bitch"
    echo `expr index $var su`//查找su，那个字符先出现查找那个
    输出：3（u在第三个位置出现，下标从1开始）
    ```

### 4. Shell数组

##### 1. 性质

* 支持一维数组
* 初始化无需定义数组大小
* 数组下标从0开始，可以不连续
* 不要求数组元素都相同

##### 2. 定义

* 数组名=(value1 value2 value3 value4)

* ```shell
  var=(1 2 3 4 5 6)
  var3=(1 2 3 nmsl 4 5)
  var1=(
  1
  2
  3
  4
  )
  var2[0]=1
  var2[1]=2
  var2[3]=4//允许下标不连续
  ```

##### 3. 读取

* ${var[i]} 读取下标为i的元素，如果var[i]不存在，什么也不干
* ${var[@]}或${var[*]} 读取所有元素（允许下标不连续）

##### 4. 获取数组长度

* ${#var[@]}或${#var[*]}获取数组长度
* ${#var[i]}获取元素var[i]的长度

### 5. 注释

##### 1. 单行：# 

* ```shell
  #加速加速加速，效率，效率，效率
  #蔡徐坤你妈死了
  #young and beautiful 真好听
  ```

##### 2. 临时注释：{}

* ```shell
  comment()
  {
  	卡发顺丰的分类的开发健康
  	的发家史开发及阿卡
  	地方开始放假	
  }
  把大段注释内容写到{}里，定义一个函数，没人调用，所以不执行，就相当于注释了，想取消直接取消函数
  ```

##### 3. 块注释

* :<<EOF     注释内容    EOF
* :<<!   注释内容     ！//推荐
* :<<'   注释内容      '

### 6. 给shell脚本传参数

##### 1. 执行时传参

* ./test.sh    1     nimasile   fjdkj jj   111

##### 2. 利用参数

* $n

  * $0  表示脚本文件名

  * $1 表示传入的第一个参数

  * $2 表示传入的第二个参数

  * 以此类推。。。。

  * ```shell
    #代码
    #!/bin/bash
    echo $0 $1 $2 $3 
    #执行
    ./test.sh 1 2 3
    输出  ./test.sh 1 2 3
    sh test.sh 1 2 3
    输出: test.sh 1 2 3
    ```

* $#

  * 传递到脚本的实际参数个数

* $$

  * 脚本运行的当前进程ID号

* $! 

  * 后台运行的最后一个进程的ID号

* $-

  * 显示Shell使用的当前选项，与[set命令](https://www.runoob.com/linux/linux-comm-set.html)功能相同

* $?

  * 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误

* $*

  * 以一个单字符串显示所有向脚本传递的参数

* $@

  * 与$*相同，但是使用时加引号，并在引号中返回每个参数

* $* 与 $@ 区别：

  * 相同点：都是引用所有参数。
  
  * 不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，，则 " * " 等价于 "1 2 3"（传递了一个参数），而 "@" 等价于 "1" "2" "3"（传递了三个参数）。
  
  * ```shell
    #代码
    #!/bin/bash
    for i in "$*";do
    	echo $i
    done
    
    for i in "$@";do
    	echo $i
    done
    ```
  
  * ```shell
    #执行
    ./test.sh 1 2 3 4 5
    #结果
    1 2 3 4 5
    1
    2
    3
    4
    5
    ```

### 7. Shell 基本运算符

##### 1.算术运算符

* 性质

  * 原生bash不支持简单数学运算，通过linux的expr命令实现整数运算

* 实现

  * | 运算符 | 举例                                                  |
    | :----- | ----------------------------------------------------- |
    | +      | var=\`expr  $a + $b`或var=$[a+b]                      |
    | -      | var=\`expr  $a - $b`或var=$[a-b]                      |
    | *      | var=\`expr  $a \\* $b`  注意*要用转义符.或var=$[a\*b] |
    | /      | var=\`expr  $a / $b` 或var=$[a/b]                     |
    | %      | var=\`expr  $a % $b`或var=$[a%b]                      |
    | =      | a=$b                                                  |
    | ==     | [ $a == $b ]                                          |
    | !=     | [ $a != $b ]                                          |

  * **注**

    * 上述所有表达式，都要求操作数和操作符之间有空格，除了赋值运算符。赋值运算符严格要求操作数紧挨操作符，不能有空格
    * 条件表达式在方括号中，不仅操作数操作符之前有空格且与方括号之间也得有空格
    * 本质调用终端的expr实现简单的整数运算，expr可直接在终端使用，也要求有空格
  * 建议使用方括号形式，简洁明了
  
* 示例
  
    * ```shell
      #!/bin/bash
      
      a=10
      b=20
      
      val=`expr $a + $b`
      echo "a + b : $val"
      
      val=`expr $a - $b`
      echo "a - b : $val"
      # 注意乘号要用转义符
      val=`expr $a \* $b`  
      echo "a * b : $val"
      
      val=`expr $b / $a`
      echo "b / a : $val"
      
      val=`expr $b % $a`
      echo "b % a : $val"
      
      if [ $a == $b ]
      then
         echo "a 等于 b"
      fi
      if [ $a != $b ]
      then
         echo "a 不等于 b"
      fi
      
      #运行结果
      a + b : 30
      a - b : -10
      a * b : 200
      b / a : 2
      b % a : 0
      a 不等于 b
      ```
      
    * ```shell
      num1=100
      num2=100
      echo $[num1+num2]
      echo $[num1-num2]
      echo $[num1*num2]
      echo $[num1/num2]
      echo $[num1%num2]
      # 结果
      200
      0
      10000
      1
      0
      ```
    
      

##### 2. 关系运算符

* 性质

  * 只支持数字，不支持字符串，除非字符串的值是数字

* 实现

  * | 运算符 | 说明             | 举例          |
    | ------ | ---------------- | ------------- |
    | -eq    | equal ==         | [ $a -eq $b ] |
    | -ne    | not equal !=     | [ $a -ne $b ] |
    | -gt    | greater than >   | [ $a -gt $b ] |
    | -lt    | less than <      | [ $a -lt $b ] |
    | -ge    | greater equal >= | [ $a -ge $b ] |
    | -le    | less equal  <=   | [ $a -le $b ] |

  * 注

    * 别漏了各种空格

  * 示例

    * ```shell
      #/bin/bash
      a=10
      b=20
      if [ $a -eq $b ]
      then
          echo "$a=$b"
      fi	
      if [ $a -ne $b ]
      then
          echo "$a!=$b"
      fi	
      if [ $a -gt $b ]
      then
          echo "$a>$b"
      fi	
      if [ $a -lt $b ]
      then
          echo "$a<$b"
      fi	
      if [ $a -ge $b ]
      then
          echo "$a>=$b"
      fi	
      if [ $a -le $b ]
      then
          echo "$a<=$b"
      fi	
      #结果
      10!=20
      10<20
      10<=20
      
      ```

##### 3. 布尔运算符1

* 实现

  * | 运算符 | 说明   | 举例                                 |
    | ------ | ------ | ------------------------------------ |
    | ！     | 非     | [  ! false ] 返回true                |
    | -o     | or 或  | [ 10 -lt 100 -o 20 -lt 10] 返回true  |
    | -a     | and 与 | [ 10 -lt 100 -a 20 -lt 10] 返回false |

  * 注

    * 别漏了各种空格

  * 举例

    * ```shell
      #!/bin/bash
      a=10
      b=20
      c=30
      if [ ! $a -eq $b ]
      then    
          echo "$a!=$b"
      fi
      if [ $a -lt $b -o $b -gt $c ]
      then
          echo "$a<$b||$b>$c"
      fi
      if [ $a -lt $b -a $b -lt $c ]
      then 
          echo "$a<$b&&$b<$c"
      fi
      #结果
      10!=20
      10<20||20>30
      10<20&&20<30
      ```

##### 4. 布尔运算符2

* 类似布尔运算符

* 实现

  * | 运算符 | 说明 | 举例                                |
    | ------ | ---- | ----------------------------------- |
    | &&     | 与   | [[ 10 -lt 20 && 20 -lt 100]]  true  |
    | \|\|   | 非   | [[10 -lt 20 \|\| 20 -gt 100]]  true |

  * 注

    * 注意各种空格
    * 注意这种方式要加两个方括号

  * 举例

    * ```shell
      #!/bin/bash
      a=10
      b=20
      c=30
      if [ ! $a -eq $b ]
      then    
          echo "$a!=$b"
      fi
      if [[ $a -lt $b || $b -gt $c ]]
      then
          echo "$a<$b||$b>$c"
      fi
      if [[ $a -lt $b && $b -lt $c ]]
      then 
          echo "$a<$b&&$b<$c"
      fi
      #结果
      10!=20
      10<20||20>30
      10<20&&20<30
      ```

##### 5. 字符串运算符（字符串处理函数）

* 常用

  * | 运算符 | 说明                                                | 示例         |
    | ------ | --------------------------------------------------- | ------------ |
    | =      | 检测两个字符串是否相等，相等返回true                | [ $a = $b  ] |
    | !=     | 检测两个字符串是否相等，不相等返回 true。           | [ $a != $b ] |
    | -z     | zero  检测字符串长度是否为0，为0返回 true。         | [ -z $a ]    |
    | -n     | non-zero 检测字符串长度是否不为 0，不为 0 返回 true | [ -n $b ]    |
    | $      | 检测字符串是否为空，不为空返回 true。               | [ $a ]       |

  * 注

    * 注意空格
    * 注意-n和$的特殊用法
    * $类似C++中的string a="nmsl",if(a) cout<<",,,";

  * 示例

    * ```shell
      #/bin/bash
      str1="helloworld"
      str2="helloworld"
      str3="nimasil"
      str4=""
      if [ $str1 = $str2 ]
      then
          echo "$str1=$str2"
      fi
      if [ $str1 != $str3 ]
      then
          echo "$str1!=$str3"
      fi
      if [ -z $str4 ]
      then    
         echo "$str4长度为0"
      fi
      if [ -n $str1 ]
      then    
         echo "$str1长度不为0"
      fi
      if [ $str4 ]
      then
         echo "字符串不为空"
      else
         echo "字符串为空"
      fi
      # 结果
      helloworld=helloworld
      helloworld!=nimasil
      长度为0
      helloworld长度不为0
      字符串为空
      ```

##### 6. 文件测试运算符

  * 性质

    * 文件测试运算符用于检测 Unix 文件的各种属性。

  * 属性检测描述如下（常用）

    * | 运算符  | 说明                                                         | 举例                      |
      | ------- | ------------------------------------------------------------ | ------------------------- |
      | -b file | 检测文件是否是块设备文件，如果是，则返回 true。              | [ -b $file ]              |
      | -c file | 检测文件是否是字符设备文件，如果是，则返回 true。            | [ -c $file ]              |
      | -d file | 检测文件是否是目录，如果是，则返回 true。                    | [ -d $file ]              |
      | -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 | [ -f $file ]              |
      | -g file | 检测文件是否设置了 SGID 位，如果是，则返回 true。            | [ -g $file ]              |
      | -k file | 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。  | [ -k $file ]              |
      | -p file | 检测文件是否是有名管道，如果是，则返回 true。                | [ -p $file ]              |
      | -u file | 检测文件是否设置了 SUID 位，如果是，则返回 true。            | [ -u $file ] 返回 false。 |
      | -r file | 检测文件是否可读，如果是，则返回 true。                      | [ -r $file ]              |
      | -w file | 检测文件是否可写，如果是，则返回 true。                      | [ -w $file ]              |
      | -x file | 检测文件是否可执行，如果是，则返回 true。                    | [ -x $file ]              |
      | -s file | 检测文件是否为空（文件大小是否大于0），不为空返回 true。     | [ -s $file ]              |
      | -e file | 检测文件（包括目录）是否存在，如果是，则返回 true。          | [ -e $file ]              |

    * 其他

      * **-S**: 判断某文件是否 socket。

      * **-L**: 检测文件是否存在并且是一个符号链接

    * 注

      * 注意空格
      
    * 举例
    
      * ```shell
        #!/bin/bash
        
        file="/mnt/e/Black/program/Linux/Shell编程练习/23in.sh"
        if [ -r $file ]
        then
           echo "文件可读"
        else
           echo "文件不可读"
        fi
        if [ -w $file ]
        then
           echo "文件可写"
        else
           echo "文件不可写"
        fi
        if [ -x $file ]
        then
           echo "文件可执行"
        else
           echo "文件不可执行"
        fi
        if [ -f $file ]
        then
           echo "文件为普通文件"
        else
           echo "文件为特殊文件"
        fi
        if [ -d $file ]
        then
           echo "文件是个目录"
        else
           echo "文件不是个目录"
        fi
        if [ -s $file ]
        then
           echo "文件不为空"
        else
           echo "文件为空"
        fi
        if [ -e $file ]
        then
           echo "文件存在"
        else
           echo "文件不存在"
        fi
        #结果
        文件可读
        文件可写
        文件可执行
        文件为普通文件
        文件不是个目录
        文件不为空
        文件存在
        ```

### 8. Shell echo 命令

##### 1. 性质

* 用于字符串的输出
* echo string
* 可以实现复杂的格式控制
* 可在终端直接使用，shell编程的本质就是自动化执行一堆终端的命令而已

##### 2. 显示普通字符串

* echo "hello world"或者echo hello world
* 双引号可省略

##### 3. 显示转义字符

* echo \\" hello world \\"  输出hello world

##### 4. 显示变量

* ```shell
  #!/bin/bash
  read var   //read从标准输入读入一行存入shell变量
  echo $var
  ```

* read 从标准输入读入一行
##### 5. 显示换行

* ```shell
  echo  -e  "Hello\nWorld"
  ```

* ```shell
  echo "Hello"
  echo "World"
  ```

* 上面两种形式输出等价

* 用\n需加-e参数开启转义

##### 6. 显示不换行

* ```shell
  echo "Hello World"
  ```

* ```shell
  echo -e "Hello \c"
  echo "World"
  ```

* 上述两种形式等价

* -e 开启转义

##### 7. 输出定向到文件

* echo "好好学习，天天向上" > myfile
* \> 符号重定向，跟终端使用的一模一样，如ls > myfile(本质shell中语句在终端一句一句顺次执行)

##### 8. 原样输出字符串，忽略转义和取变量

* 使用单引号
  * echo '$var \\" '
  * 输出：$var \\"
* 因为单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的

##### 9. 显示命令执行结果

* echo \`ls\` 等价于ls

### 9. Shell printf 命令

##### 1. 性质

* printf 命令模仿 C 程序库（library）里的 printf() 程序。
* printf 由 POSIX 标准所定义，因此使用 printf 的脚本比使用 echo 移植性好
* printf 使用引用文本或空格分隔的参数，外面可以在 printf 中使用格式化字符串，还可以制定字符串的宽度、左右对齐方式等。默认 printf 不会像 echo 自动添加换行符，我们可以手动添加 \n。

##### 2. 语法

* printf format-string [arguments...]
* format-string ：格式控制字符串
* arguments:参数列表

##### 3. 实例

1. printf不会自动添加换行，以下两句效果相同

   * ```shell
     echo "Hello"
     echo "World"
     ```

   * ```shell
     printf "Hello\n"
     printf "World\n"
     ```

2. 格式控制1

   * ```shell
     printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
     printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
     printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
     printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 
     
     #输出
     姓名     性别   体重kg
     郭靖     男      66.12
     杨过     男      48.65
     郭芙     女      47.99
     ```

   * 解析：

     * %s %c %d %f都是格式替代符
     * %-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。
     * %-4.2f 指格式化为小数，其中.2指保留2位小数。

3. 格式控制2

   * ```shell
     # format-string为双引号
     printf "%d %s\n" 1 "abc"
     
     # 单引号与双引号效果一样 
     printf '%d %s\n' 1 "abc" 
     
     # 没有引号也可以输出
     printf %s abcdef
     
     # 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
     printf %s abc def
     
     printf "%s\n" abc def
     
     printf "%s %s %s\n" a b c d e f g h i j
     
     # 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
     printf "%s and %d \n" 
     
     #结果
     1 abc
     1 abc
     abcdefabcdefabc
     def
     a b c
     d e f
     g h i
     j  
      and 0
     ```

##### 4. printf的转义序列

* | 序列  | 说明                                                         |
  | :---- | :----------------------------------------------------------- |
  | \a    | 警告字符，通常为ASCII的BEL字符                               |
  | \b    | 后退                                                         |
  | \c    | 抑制（不显示）输出结果中任何结尾的换行字符（只在%b格式指示符控制下的参数字符串中有效），而且，任何留在参数里的字符、任何接下来的参数以及任何留在格式字符串中的字符，都被忽略 |
  | \f    | 换页（formfeed）                                             |
  | \n    | 换行                                                         |
  | \r    | 回车（Carriage return）                                      |
  | \t    | 水平制表符                                                   |
  | \v    | 垂直制表符                                                   |
  | \\    | 一个字面上的反斜杠字符                                       |
  | \ddd  | 表示1到3位数八进制值的字符。仅在格式字符串中有效             |
  | \0ddd | 表示1到3位的八进制值字符                                     |

### 10. Shell test命令

##### 1. 性质

* Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。

##### 2. 数值测试

* 参数

  * | 参数 | 说明           |
    | :--- | :------------- |
    | -eq  | 等于则为真     |
    | -ne  | 不等于则为真   |
    | -gt  | 大于则为真     |
    | -ge  | 大于等于则为真 |
    | -lt  | 小于则为真     |
    | -le  | 小于等于则为真 |

* 示例

  * ```shell
    num1=100
    num2=100
    if test $num1 -eq $num2 //等价于[ $num1 -eq $num2 ]
    then
        echo '两个数相等！'
    else
        echo '两个数不相等！'
    fi
    #结果
    两个数相等！
    ```

##### 3. 字符串测试

* 参数

  * | 参数      | 说明                     |
    | :-------- | :----------------------- |
    | =         | 等于则为真               |
    | !=        | 不相等则为真             |
    | -z 字符串 | 字符串的长度为零则为真   |
    | -n 字符串 | 字符串的长度不为零则为真 |

* 示例

  * ```shell
    num1="ru1noob"
    num2="runoob"
    if test $num1 = $num2//等效于[ $num1 = $num2 ]
    then
        echo '两个字符串相等!'
    else
        echo '两个字符串不相等!'
    fi
    #结果
    两个字符串不相等！
    ```

##### 4. 文件测试

* 参数

  * | 参数      | 说明                                 |
    | :-------- | :----------------------------------- |
    | -e 文件名 | 如果文件存在则为真                   |
    | -r 文件名 | 如果文件存在且可读则为真             |
    | -w 文件名 | 如果文件存在且可写则为真             |
    | -x 文件名 | 如果文件存在且可执行则为真           |
    | -s 文件名 | 如果文件存在且至少有一个字符则为真   |
    | -d 文件名 | 如果文件存在且为目录则为真           |
    | -f 文件名 | 如果文件存在且为普通文件则为真       |
    | -c 文件名 | 如果文件存在且为字符型特殊文件则为真 |
    | -b 文件名 | 如果文件存在且为块特殊文件则为真     |

* 示例

  * ```shell
    cd /bin
    if test -e ./bash  //等效于file=/bin/bash [ -e $file]
    then
        echo '文件已存在!'
    else
        echo '文件不存在!'
    fi
    ```

### 11. Shell 流程控制

##### 1. 性质

* 和Java、PHP等语言不一样，sh的流程控制不可为空
* 如果else分支没有语句执行，就不要写这个else

##### 2. if else

* if 

  * shell脚本语法

    * ```shell
      if  condition
      then
      	command1
      	command2
      	command3
      	...
      fi
      ```

  * 终端写法

    * ```shell
      if [ $(ps -ef | grep -c "ssh")  -gt  1 ]; then echo "true"; fi
      ```

      

* if-else

  * 语法

    * ```shell
      if condition
      then
      	command1
      	command2
      	...
      else
      	command3
      	command4
      	...
      fi
      ```

* if else-if  else

  * 语法

    * ```shell
      if condition
      then
      	command
      elif condition
      then
      	command
      else
      	command
      fi
      ```

  * 示例

    * ```shell
      #!/bin/bash
      num1=$[10+10]
      num2=$[10+20]
      if test $num1 -eq $num2
      then 
          echo "$num1==$num2"
      else 
          echo "$num1!=$num2" 
      fi
      if test %num1 == $num2
      then 
          echo "$num1==$num2"
      elif [ $num1 -gt $num2 ]
      then
          echo "$num1>$num2"
      elif [ $num1 -lt $num2 ]
      then 
          echo "$num1<$num2"
      else 
          echo "false"
      fi
      # 结果
      20!=30
      20<30
      ```

##### 3. for循环（范围for）

* 语法
  * shell脚本语法

    * ```shell
      for var in item1 item2 item 3
      do
      	command1
      	command2
      	...
      done
      ```

  * 一行

    * ```shell
      for var in item1 item2 ...; do command1;command2... done
      ```

* 性质

  * 当变量值在列表里，for循环即执行一次所有命令，使用变量名获取列表中的当前取值。
  * 命令可为任何有效的shell命令和语句。
  * in列表可以包含替换、字符串和文件名。
  * in列表是可选的，如果不用它，for循环使用命令行的位置参数。

* 示例

  * ```shell
    for loop in 1 2 3 4 5
    do
        echo "The value is: $loop"
    done
    #结果
    The value is: 1
    The value is: 2
    The value is: 3
    The value is: 4
    The value is: 5
    ```

##### 4. while循环

* 语法

  * ```shell
    while condition
    do
    	command
    done	
    ```

* 示例

  * ```shell
    #!/bin/bash
    i=1
    #while [ $i -le 5 ]
    while (( $i<=5 ))
    do
        echo $i
    #    let "i++"
        i=`expr $i + 1`
    #    i=$[i+1]
    done
    # 注释掉的内容可选，都行，好几种方式
    # 结果
    1
    2
    3
    4
    5
    ```

  * ```shell
    while read x
    do
    	echo $x
    done
    #从键盘无线循环读取，输出，按ctrl+z（windows）或ctrl+d(linux )结束循环
    ```

##### 5. 无限循环

* ```shell
  while :
  do
  	command
  done
  ```

* ```shell
  while true
  do
  	command
  done
  ```

* ```shell
  for(( ; ;))
  ```

##### 6. until 循环

* 性质

  * until 循环执行一系列命令直至条件为 true 时停止。即条件为假则一直执行
  * until 循环与 while 循环在处理方式上刚好相反
  * 一般 while 循环优于 until 循环，但在某些时候—也只是极少数情况下，until 循环更加有用。

* 语法

  * ```shell
    until condition
    do
    	command
    done
    ```

* 示例

  * ```shell
    #!/bin/bash
    i=0
    until [ $i -ge 10 ]
    do
        echo $i
        i=`expr $i + 1`//用expr计算这种方式一定记得空格
    done
    # 输出0~9
    ```

##### 7.case  ..esac语句（类似switch）

* 性质

  * Shell case语句为多选择语句。可以用case语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令

* 格式

  * ```shell
    case 值 in
    模式1)
        command1
        command2
        ...
        commandN
        ;;
    模式2）
        command1
        command2
        ...
        commandN
        ;;
    esac
    ```

  * 取值后面必须为单词in，每一模式必须以右括号结束

  * 取值可以为变量或常数。匹配发现取值符合某一模式后，其间所有命令开始执行直至 ;;

  * 取值将检测匹配的每一个模式。一旦模式匹配，则执行完匹配模式相应命令后不再继续其他模式。如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。

* 示例

  * ```shell
    while read x
    do
        case $x in
            1) echo "你选择了1"
               echo "你选择了1" 
                ;;
            2) echo "你选择了2"
               echo "你选择了2" 
               ;;
            3) echo "你选择了3"
               echo "你选择了3" 
               ;;
            4) echo "你选择了4"
               echo "你选择了4" 
               ;;
            *) echo "你选择了1~4之外的数字"
               echo "你选择了1~4之外的数字"
               ;;
        esac
    done
    ```

##### 8.跳出循环

* break	

  * 性质

    * 同C++break

  * 示例

    * ```shell
      #输入不在1~5范围内的元素则跳出循环
      #!/bin/bash
      while read x
      do
          case $x in
              1|2|3|4|5) echo "输入大于5的数字可跳出循环"
                          ;;
              *) echo "结束循环"
                 break
                 ;;
          esac
      done
      ```

* continue

  * 性质
    * 同C++continue

### 12. Shell 函数

##### 1. 格式

* ```shell
  [ function ] funname [()]
  
  {
  
      action;
  
      [return int;]
  
  }
  ```

* 注

  * 可以带function fun() 定义，也可以直接fun() 定义,不带任何参数。
  * 参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return后跟数值n(0-255）

* 示例

  * ```shell
    test()
    {
    	echo "This is my first shell function"
    }
    test  #调用
    ```

  * ```shel
    add()
    {
        read a
        read b
        return $[a+b]
    }
    add
    echo $?
    ```

    * 注：
      * **函数返回值在调用该函数后通过 $? 来获得**，切记$?表示刚刚执行完的函数的返回值
      * 所有函数在使用前必须定义。这意味着必须将函数放在脚本开始部分，直至shell解释器首次发现它时，才可以使用。调用函数仅使用其函数名即可

##### 2. 函数参数

* 性质

  * 在Shell中，调用函数时可以向其传递参数。在函数体内部，通过 $n 的形式来获取参数的值，例如，$1表示第一个参数，$2表示第二个参数...$#表示参数个数，$*表示所有参数组合为一个数，$@表示所有参数组合成一个数组。跟Shel脚本传参数一样，详情见那一章

* 示例

  * ```shell
    #!/bin/bash
    func()
    {
        echo $1
        echo $2
        echo $3
        echo $4
        echo $5
        echo $6
        echo $*
        echo $#
    }
    func 1 2 3 4 5 6
    #输出
    1
    2
    3
    4
    5
    6
    1 2 3 4 5 6
    6
    ```

* 注：

  * 获取变量有两种方法$var或者${var}，区别在于$var形式只获取离美元符号最近的变量的值，而后者把大括号内整体当做一个变量获取
  * 比如本节中如果获取第10个参数，那么用${10},否则用$10的话优先匹配1，相当于给执行（$1)0，报错

* 其他参数（第六节）

  * | 参数处理 | 说明                                                         |
    | :------- | :----------------------------------------------------------- |
    | $#       | 传递到脚本或函数的参数个数                                   |
    | $*       | 以一个单字符串显示所有向脚本传递的参数                       |
    | $$       | 脚本运行的当前进程ID号                                       |
    | $!       | 后台运行的最后一个进程的ID号                                 |
    | $@       | 与$*相同，但是使用时加引号，并在引号中返回每个参数。         |
    | $-       | 显示Shell使用的当前选项，与set命令功能相同。                 |
    | $?       | 显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。 |

### 13 . Shell 输入输出重定向

##### 1. 性质

* 大多数 UNIX 系统命令从你的终端接受输入并将所产生的输出发送回到您的终端。一个命令通常从一个叫标准输入的地方读取输入，默认情况下，这恰好是你的终端。同样，一个命令通常将其输出写入到标准输出，默认情况下，这也是你的终端。

##### 2. 重定向命令

* | 命令            | 说明                                               |
  | :-------------- | :------------------------------------------------- |
  | command > file  | 将输出重定向到 file。                              |
  | command < file  | 将输入重定向到 file。                              |
  | command >> file | 将输出以追加的方式重定向到 file。                  |
  | n > file        | 将文件描述符为 n 的文件重定向到 file。             |
  | n >> file       | 将文件描述符为 n 的文件以追加的方式重定向到 file。 |
  | n >& m          | 将输出文件 m 和 n 合并。                           |
  | n <& m          | 将输入文件 m 和 n 合并。                           |
  | << tag          | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。 |

* 注：

  * ***需要注意的是文件描述符 0 通常是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）***

##### 3. 输出重定向

* 覆盖

  * ```shell
    command > file
    ```

* 追加

  * ```shell
    command >> file
    ```

##### 4. 输入重定向

* 语法

  * ```shell
    command < file
    ```

* 示例

  * ```shell
    # 45.sh文件
    while read x
    do
    	echo $x
    done
    # 45input文件
    1
    2
    3
    4
    5
    #执行
    ./45/sh < 45input
    #结果
    1
    2
    3
    4
    5
    ```

* 输入加输出重定向

  * ```shell
    ./45.sh < 45input > 45output
    ```

##### 5.  重定向深入讲解

* 背景
  * *一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：*
    * 标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
    * 标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
    * 标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
  * 默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。

* 如果希望 stderr 重定向到 file

  * ```shell
    command 2 > file
    ```

  * ```shell
    command 2 >> file
    ```

* **如果希望将 stdout 和 stderr 合并后重定向到 file**

  * 将标准错误输出追加到标准输出通道

    * ```shell
    command > file 2>&1
      # 第一个> 相当于1> 表示将标准输出重定向到file
      #  2>&1  表示将标准错误输出追加到标准输出通道，所以这么一组合，给人一种合并stdout,stderr然后输出的感觉
      # 如果错误写为2>1 表示将标准错误输出重定向到文件1
      ```
    ```
      
    * ```
      command >> file 2>&1
    ```

  * 将标准输出追加到标准错误输出通道

    * ```
      command 2> file 1>&2  同理
      ```

    * ```
      command 2>> file 1>&2  
      ```

      

* 如果希望对 stdin 和 stdout 都重定向

  * `command < file1 > file2 `
##### 6. Here Document

* 性质

  * Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序

* 基本形式

  * ```shell
    command << delimiter     
    	document
    delimiter
    # delimiter 定界符
    ```

  * 它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command

  * 注

    * 结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
    * 开始的delimiter前后的空格会被忽略掉。

* 示例

  * 在命令行中通过 wc -l 命令计算 Here Document 的行数：

    * ```shell
      $ wc -l << EOF
          欢迎来到
          菜鸟教程
          www.runoob.com
      EOF
      3          # 输出结果为 3 行
      $
      
      #实际执行效果
      $ wc -l << EOF
      heredoc> 欢饮来到
      heredoc> 菜鸟教程
      heredoc> www.runoob.com
      heredoc> EOF
      3
      ```

  * 我们也可以将 Here Document 用在脚本中，例如：

    * ```shell
      #!/bin/bash
      # author:菜鸟教程
      # url:www.runoob.com
      
      cat << EOF
      欢迎来到
      菜鸟教程
      www.runoob.com
      EOF
      ```

##### 7. /dev/null文件

* 性质

  * /dev/null 是一个特殊的文件，写入到它的内容都会被丢弃
  * 如果尝试从该文件读取内容，那么什么也读不到
  * 但是 /dev/null 文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。

* 使用

  * 如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null

    * ```
      command > /dev/null
      ```

* 举例

  * 如果希望屏蔽 stdout 和 stderr，可以这样写：

  * ```shell
    command > /dev/null 2>&1
    ```

  * 注：

    * **注意：** *0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）*

### 14. Shell 文件包含

* 性质

  * 和其他语言一样，Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。

* 格式

  * ```shell
    . filename   # 注意点号(.)和文件名中间有一空格
    
    或
    
    source filename
    ```

* 示例

  * ```shell
    #test1.sh文件的内容
    #!/bin/bash
    var="Helloworld"
    
    #test2.sh文件的内容
    #!/bin/bash
    . test1.sh
    echo $var
    
    #test3.sh文件内容
    #!/bin/bash
    source test2.sh
    var2="nmsl"
    echo $var2
    #执行test2.sh
    Helloworld
    #执行test3.sh
    Heloworld
    nmsl
    ```

    

  



  














