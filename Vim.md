# VIM 永远滴神！

### 1.Vim配置

* ##### 配置文件

  * :version 命令
    * 系统配置文件-----系统所有用户通用
      * $VIM/vimrc
    * 用户配置文件-----当前用户使用，覆盖系统配置文件
      * $HOME/_vimrc
      * $HOME/.vimrc（Linux）
    * 默认配置文件(当没有系统配置文件和用户配置文件时使用这个)
      * $VIMRUNTIME\defaults.vim
    * $VIM
      * 一般是vim安装目录
    * $HOME
      * 家目录，Linux下是~(/home/xxx/)，windows下是C:\Users\XXX\
    * **查看$VIM等环境变量的方法**
      * :echo $VIM

* ##### 一些重要的配置项

  * 编码
    * vim编码相关的主要有三个参数
      * enc(encoding)
        * 主要决定以什么编码方式打开文件
          * 例如文件是gbk格式，当前enc是utf-8那么vim打开就是乱码，要设置enc为gbk
        * set enc=utf-8
      * fenc(fileencoding)
        * 主要决定以什么编码方式保存由vim修改过的文件
          * 例如文件是gbk格式，当前enc是gbk，fenc是utf-8，则修改之后保存文件为utf-8。但是如果没有修改，则文件还是gbk格式。当然如果enc是utf-8格式，打开之后是乱码，然后修改，然后保存，则无法保存，会提示无法转换编码。所以只有首先正确打开文件之后，及enc编码同文件编码，则修改后保存fenc才能起作用。
        * set fenc=utf-8
      * fencs(fileencodings)
        * vim的enc不是设置死的，可以猜测实际的文件编码，fencs就制定了**猜测的编码列表**。
          * 默认不设置enc情况下，enc同系统默认编码，我的windows下就是gbk。当无法打开时，vim可能会逐一将enc赋值为fencs中的编码，然后尝试打开。
        * set fencs=utf-8,gb2312,gbk,big5,gb18030