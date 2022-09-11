# 								Git  NB！

## 0. Git帮助

##### 0.1 详细版

* git help verb
  * git help config
* git verb --help
  * git config --help

##### 0.2 简略版

* git verb
  * git config不加参数

## 1. git config 配置——无需有仓库即可配置

#### 1.1三级配置文件(三级 scope)

* ##### system
  
  * --system
    * 与系统配置文件相关操作
  * 系统配置文件，适用于当前系统所有用户
  * 一般路径
    * git安装目录/etc/gitconfig
  
* ##### global
  
  * --global
    * 与用户配置文件相关操作
  * 用户配置文件，适用于特定用户
  * 一般路径
    * $HOME/.gitconfig
  
* ##### local
  
  * --local 或省略
    * 与仓库配置文件相关操作
  * 仓库配置文件，适用于特定仓库
  * 一般路径
    * .git/config
  
* ##### 快速找到所有配置文件位置

  * git config -l --show-scope --show-origin

#### 1.2 配置增删改查

* ###### 注

  * git配置文件中每一项是一个键值对(key-value or name-value)对
  * --system，--global，--local(或省略)指定增删改查那个配置文件，**姑且称这三个参数为域参数**

##### 1.2.1 增

* ###### --add

  * git config --add  key value
    * git config --add user.name LP
    * git config --add --global user.name LP
  * 可以重复添加多个具有相同key的键值对
    * git config --add user.name LP
    * git config --add user.name LPP
    * git config --add user.name LPPP 
    * **这将在local域配置文件中增加三条user.name项，但是只有最后一条起作用**

* ###### 空

  * git config key value 
    * git config user.name LP
    * git config --global user.name LP
  * 不同于add，本质是如果没有该key那么新增一项，如果已经有了，则相当于修改该项的值。
    * 所以不支持增加重复key的键值对

* 注

  * 域参数要加在key前面

##### 1.2.2 删

* ###### --unset

  * git config --unset key
    * git config --unset --global user.name 
  * 删掉某个域配置文件中的指定key的键值对，如果该key匹配多个键值对，那么删除最后一个

* ###### --unset-all

  * git config --unset-all key
    * git config --unset-all user.name
  * 删除特定域配置文件中所有匹配该key的键值对，并不会删除所有配置文件中的匹配项，只会删除指定域配置文件中的所有匹配项

* 注意

  * 域参数要加在key前面

##### 1.2.3 改

* ###### --replace =--replace-all

  * git config --replace key  value
    * git config --replace --global user.name NB
  * 如果该域中有匹配键值对，那么修改，没有则新建。如果有多个匹配，那么只保留一个匹配，且修改为新值。
  * --replace-all 同--replace，应为如果有多个匹配，每个都修改全部保留，没啥意义，所以两个行为一样了，都是都删除，只留一个修改后的匹配。
  * 注
    * --replace 和空的区别
      * 基本行为都是没有对应key那么新建一项，如果只有一个对应key那么修改
      * 如果有多个对应key，则空无法处理，报错。--replace则删除所有对应项，然后只保留一个修改后的项。

* ###### -e,--edit

  * git config -e
    * git config -e --global
  * 用编辑器打开指定域配置文件，一次性满足增删查改要求。

##### 1.2.4 查

* ###### -l, --list

  * 查看所有配置项，三个文件里的所有内容
    
    * git config -l 
    * --system 仅查看系统配置文件
      * git config -l --system
      * --global
      * --local
  * --show-scope
    * git config --list --show-scope
      * 显示所有配置项，并显示配置项所属的配置级别
  * --show-origin
    * git config --list --show-origin
      * 显示所有配置项，并显示配置项所属的配置文件
  * --show-scope --show-origin
    * git config -l --show-scope --show-origin
      * **快速找到git的配置文件所在位置**
    
  
* ###### --get,--get-all

  * git config **--get** key = git config key
    * git config --get user.name
    * 不加参数显示当前git使用的key的值
      * 比如global域中配置了user.name ，local域中配置了user.name，那么显示local 的user.name。如果local中有多个user.name，那么显示最后一个。
      * 如果global中配置了user.name，local中没配置，那么显示global中的user.name
    * --system,--global, --local
      * 显示对应域中的匹配key值，如果有多个匹配，则显示最后一个。
  * git config **--get-all** key
    * git config --get-all user.name
    * 不加参数，显示所有域中的匹配该key的值
    * --system，--global，--local
      * 显示对应域中的匹配key值，如果有多个匹配，显示所有。
  * --show-origin, --show-scope
    * git config --get --show-origin user.name
    * git config --get-all show-scope user.name

#### 1.3 常用配置项(大小写不敏感)

##### 1.3.1 user

* user.name
  * 提交的时候的名字
* user.email
  * 提交的时候的邮箱地址

##### 1.3.2 core

* core.quotepath
  * 值
    * true
    * false
  * git status输出的内容的显示编码
    * 为true，那么只能显示ASCII码，大于0x7F的都显示为转义字符形式
    * 为false，那么就可以正常显示UTF-8或者ANSI等编码字符了
* core.editor
  * 指定git调用的编辑器
  * 默认是vim，或者系统自带的啥啥啥

##### 1.3.3 alias 别名

* 自定义命令的别名
  * git config --add --global alias.ci commit
  * git config --add --global alias.st status

##### 1.3.4 init

* init.defaultBranch
  * 本地新建仓库时创建的默认分支名，默认是master，如果想改，增加这个配置项就可以了。





