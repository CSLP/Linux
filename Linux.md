#              Linux系统一些概念知识

# 1. Shell

## 1.1 shell和terminal概念辨析

* ###### shell

  * 定义
    * shell就是一个程序，接受键盘输入的命令(本质是一个程序)， 然后把命令传递给操作系统去执行。
    * 或者理解为一个命令解释器，接受命令，然后执行。(程序执行并不一定会产生输出)
  * 注
    * 如果命令行的第一个单词不是一个内置的shell命令，那么shell就会假设这是一个可执行文件的名字，它将加载并运行这个命令。
  * shell提示符(shell prompt)
    * user@pc  + wd + #/$
      * user  当前登录用户名
      * pc  当前PC名字
      * wd ： working  directory 当前工作目录
      * \# 当前用户为管理员
      * $ 当前为普通用户

* ###### terminal(terminal emulator, console)

  * 终端
    * 以前没有命令行时只有黑乎乎的界面类似Linux的TTY(TeleTYpewriter)是真正的终端
  * 终端仿真器或叫控制台
    * 在图形界面中的一个程序，使我们可以和shell交互
  * 终端不是shell，而是帮助我们同shell交互的另一个程序
    * shell只负责接受命令，然后交给OS执行，那些诸如编码、字体、快捷键、外观等花里胡哨的功能都是终端负责的
      * 比如GNOME界面的terminal可以运行sh, bash,或者zsh
      * 比如windows terminal ，它与传统意义上的终端有些差别，他更像一个终端管理器，可以管理各种终端。
        * 比如管理cmd，windows powershell， powershell，wsl的终端

* ###### TTY(teletypewriter)

  * 即使不运行终端仿真器，Linux系统默认后台运行着几个终端，可以alt+ctrl+1~7调用，类似远古时期真正的终端。分别是6个tty和一个GUI。

## 1.2 shell wildcards(globbing 通配符)

* 常用通配符

  * | Wildcard      | Meaning                                                      |
    | ------------- | ------------------------------------------------------------ |
    | *             | Matches any characters                                       |
    | ?             | Matches any single character                                 |
    | [characters]  | Matchs any character that is a member of the set characters(匹配集合中的任意一个，所**有的方括号都是匹配对应集合中的任意一个**，下同理) |
    | [!characters] | Matchs any character that is not a member of the set characters |
    | [[:class:]]   | Matches any character that is a member of the specified class |

  * [characters] 中的characters 代表任意字符集合

  * [[:class:]]中的 [:class:] 代表集中已定义的字符类，见下表

* 常用字符类

  * | Character Class                 | Meaning      |
    | ------------------------------- | ------------ |
    | [:alnum:]                       | 字母和数字类 |
    | [:alpha:]                       | 字母类       |
    | [:digit:]                       | 数字类       |
    | [:lower:] == [a-z]\(建议用前者) | 小写字母类   |
    | [:upper:]== [A-Z]\(建议用前者)  | 大写字母类   |

  * 很简单 ，举例

    * [0-9] == [0123456789] == [[:digit:]]
    * [abcdefghijklmnopqrstuvwxyz] == [a-z] == [[:lower:]]

## 1.3 shell的命令(command)

#### 1.3.1 命令的四种形式	

* 可执行程序

  >  An **executable program** like all those files we saw in /usr/bin. Within this category, **programs can be compiled binaries** such as programs written in C and C++, **or programs written in scripting languages** such as the shell, perl, python, ruby, etc.



* shell内建命令(buildins)

  > A command built into the shell itself. **bash supports a number of commands internally called shell builtins.** The cd command, for example, is a shell builtin.(内建命令一般没有man手册，比如cd，type，内建命令用help)



* shell函数

  > A shell function. These are miniature shell scripts incorporated into the environment. (它们是混合在环境变量中的微小的的shell脚本)



* 命令别名(alias)

  > An alias. Commands that we can define ourselves, built from other commands

# 2. GUI

#### 2.1 窗口聚焦策略（Focus policy)

* ###### 单击聚焦(click to focus)

  * 点击窗口使之成为活动窗口并使之成为前端窗口
    * 比如windows和GNOME，KDE

* ###### 跟随聚焦(focus follows mouse)

  * 鼠标在哪个窗口上，哪个窗口成为活动窗口。但是不会变为前端窗口，除非点一下
    * 比如X GUI

# 3. 文件系统

#### 3.1 文件系统树

* Linux只有一个文件系统树，根目录是/，硬盘，U盘等可以任意挂载在树的任意节点。
* Windows一个硬盘一个文件系统树，根目录是C:、D:等硬盘标识符
* **Linux中一切皆文件**

#### 3.2 Linux文件系统层级标准(Linux Filessystem Hierarchy Standard(Linux FHS))

* 详情请参见文档[Linux Filesystem Hierarchy (tldp.org)](https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/index.html)或[Filesystem Hierarchy Standard (pathname.com)](https://www.pathname.com/fhs/)

* | Directory      | Comments                                                     |
  | -------------- | ------------------------------------------------------------ |
  | /              | The root directory.Where everything begins.根目录            |
  | /bin           | Contains **binaries**(programs) that must be present for the system to boot and run.包含系统启动和运行所必须的二进制程序 |
  | /sbin          | This directory contains "**system" binariese**. These are programs that perform vital(至关重要的) system tasks that are generally reserved for the superuser. |
  | /boot          | Contains the linux kernel, intial RAM disk image(for drivers needed at boot time), and the **boot** loader.                                                             Interesting files:                                                                                            1. /boot/grub/grub.conf or menu.lst, which are used to configure the boot loader.                                                                                            2. /boot/vmlinuz, the linux kernel |
  | /dev           | This is a special directory which contains **device** nodes. "Everything is a file" also applies to devices. Here is where the kernel maintains a list of all the devices it understands. |
  | /etc           | The /etc directory contains all of the system-wide configuration files.(**系统级的配置文件**)It also contains a colletcion of shell scripts which start each of the system services at boot time.包含一系列的shell脚本，在系统启动时，这些脚本会开启每个系统服务。         Everything in this directory should be readable text.                              Interesting files: While everything in /etc is interesting, here are some of my all-time favorites:                                                                    1. /etc/crontab, a file that defines when automated jobs will run.       2. /etc/fstab, a tables of storage devices and their associated mount points.                                                                                                               3. /etc/passwd, a list of the user accounts. |
  | /home          | In normal configurations, each user is given a directory in /home. Ordinary users can only write files in their home home directors. This limitation protects the system from errant user activity. |
  | /lib           | Contains shared **library files** used by the core system programs. These are similar to DLLs in Windows. |
  | /lost+found    | Each formatted partition or device using a Linux file system, such as ext3, will have this directory. It is used in the case of a partical recovery from a file system corruption event(当文件系统损坏时，用来部分恢复它）. Unless something really bad has happened to your system, this directory will remain empty. |
  | /media         | On modern Linux systems the /media directory wil contain the mount points for removable media such USB drives, CD-ROMs, etc. that are mounted automatically at insertion. |
  | /mnt           | On older Linux systems, the /mnt directory contains **mount** points for removable devices that have been mounted manually. |
  | /opt           | The /opt directory is used to install "**optional**" software. This is mainly used to hold commercial software products that may be install on your system. |
  | /proc          | The /proc directory is special. It's not a real file system in the sense of (从。。。意义上来说)files stored on your hard drive. Rather(相反), it is a virtual file system mantained by the Linux kernel. The "files" it contains are peepholes(窥视孔) into the kernel itself. The files are readable and will give you a picture of how the kernel sees your computer. |
  | /root          | This is the home directory for the root account.             |
  | /tmp           | The /tmp directory is intended(v.打算、计划) for **storage of temporary(a.临时的), transient(短暂的) files created by various programs**.Some configurations cause this directory to be emptied each time the system is rebooted. |
  | /usr           | The /usr directory tree is likely the largest one on  a Linux system. It contains **all the programs and support files** used by **regular users**. |
  | /usr/bin       | /usr/bin contains the executable programs **installed by your Linux distribution**. It is not uncommon for this directory to hold thousands of programs. |
  | /usr/sbin      | Contains more system administrator programs.                 |
  | /usr/lib       | The shared libraries for the programs in /usr/bin            |
  | /usr/share     | /usr/share contains all the shared data used by programs in /usr/bin. This includes thing like default configuration files, icons, screen backgrounds, sound files,etc. |
  | /usr/share/doc | Most packages installed on the system will include some kind of documentation . In /usr/share/doc, we will find documentation files organized by package. |
  | /usr/local     | **The /usr/local tree is where programs that are not inlcuded with your  distribution but are intended(计划，设想) for system-wide use are installed.** Programs complied from scource code are normally installed in /usr/local/bin. On a newly installed Linux system, this tree exists, but it will be empty until the system administrator puts something in  it. |
  | /var           | <u>With the exception</u>(除了) of /tmp and /home, the directories we have looked at so far remain relatively static(我们看到的目录到目前为止保持相对静止), that is , their contents don't change. **The /var directory tree is where data that is likely to change is stored.** **Various** databases, spool files(假脱机文件), user mail, etc.are located here. |
  | /var/log       | /var/log contains **log files**, records of various system activity. These are very importat and should be monitored from time to time. The most useful one is /var/log/messages. Note that for security reasons on some systems, you must be the superuser to view log files. |

* 注

  * /etc 
    * 名字由来
      * 没错就是来自于etc(etcetera),意思是。。。(and so on,等等),远古时期的UNIX，设备有关信息放/dev,启动有关信息放/boot,库有关放/lib, 程序有关放/bin,但是还有一些杂七杂八没处放，所以放在/etc,等等文件夹中。。**当然现在/etc主要放系统层级配置文件**和一些服务启动脚本。
    * crontab  
      * cron table  自动任务表
        * Cron is a clock daemon, whose name originates from Chronos, the Greek word for time.
        * Cron是一个时钟守护进程，名字来源于希腊语中的时间一词——Chronos(也指时间之神)
    * fstab
      * file system tables  文件系统表
  * /proc
    * process
    
      > /proc is very special in that it is also a virtual filesystem. It's sometimes referred to as a process information pseudo-file(pseudo 假,伪) system. It doesn't contain 'real' files but runtime system information (e.g. system memory, devices mounted, hardware configuration, etc). For this reason it can be regarded as a control and information centre for the kernel. In fact, quite a lot of system utilities are simply calls to files in this directory. For example, 'lsmod' is the same as 'cat /proc/modules' while 'lspci' is a synonym for 'cat /proc/pci'. By altering(修改) files located in this directory you can even read/change kernel parameters (sysctl) while the system is running
  * /tmp
    
    * temp  n.v. 临时工，打临时工  temporary a. n. 临时的，临时
  * /usr
    >  /usr usually contains by far the largest share of data on a system. Hence, **this is one of the most important directories in the system as it contains all the user binaries, their documentation, libraries, header files, etc....** X and its supporting libraries can be found here. User programs like telnet, ftp, etc.... are also placed here. In the original Unix implementations, /usr was where the home directories of the users were placed (that is to say, /usr/someone was then the directory now known as /home/someone). **In current Unices, /usr is where user-land programs and data (as opposed to 'system land' programs and data) are.** The name hasn't changed, but it's meaning has narrowed and lengthened from "everything user related" to "user usable programs and data". As such, some people may now refer to this directory as meaning 'User System Resources' and not 'user' as was originally intended.(因此，一些人现在认为这个目录的意义是“用户系统资源”而不是最初“用户”的设想(一开始就是简简单单的用户的意思，类似现在的home，放与用户有关的一且，而现代的/usr名字并没有变，但是改为放用户可用的程序和数据了。所以认为现在的/usr 代表User System Resources 也未尝不可))

    * user-land program  用户级程序
    * system-land program 系统，内核级程序
  * /var
    * various  [ˈveriəs]  各种各样的;各种不同的;具有多种特征的;多姿多彩的
    * /var/log
      * log文件保存在这里，因为/var就是用来存放动态信息的。

#### 3.2 常用文件类型

* regular file                普通文件
* directory                   目录文件
* symbolic link            链接文件
* FIFO(pipe)                 管道文件
* socket                       套接字文件
* character special file      字符设备文件
* block special file             块设备文件

#### 3.2 文件命名

* Linux 以点开头的是隐藏文件
* 文件名大小写敏感
* 文件名支持字母,数字,空格,点,减号,下划线。
  * 但是最好不要用空格
* 文件名没有扩展名的概念，想怎么命名怎么命名，如果特意命名为有扩展名形式的文件也可以，有些软件会识别这些扩展名。比如 a.cpp

#### 3.3 特殊目录

* ~ （普通用户——/home/wuyulp， root用户——/root)
  * 当前登录用户的家目录
  * 普通用户的家目录是唯一允许用户写入文件的地方
    * 解释了为啥安装软件要sudo  apt ,因为要读写其他目录
* .  
  * 当前工作目录
* .. 
  * 当前工作目录的父目录

#### 3.4 相对路径与绝对路径

* 绝对路径就是从根目录开始的路径名称
  * /home/wuyulp  , D:\GitRepo\Notes\Linux
* 相对路径就是从当前工作目录出发的路径名称
  * ./wuyulp   ../wuyulp        .\Linux   ..\Notes
  * 如果不指定路径名，则默认是./
    * 例如  rm  x   本质是相对路径  rm  ./x

#### 3.5 文件权限管理

* 一个文件的Unix访问权限，包括12位，通常用4个8进制位表示，这四个8进制位依次代表：
  * 第一个(一般没啥用，不管，默认基本都是0)
    * 4
      * SUID
    * 2
      * SGID
    * 1
      * SVTX
    * 3,5,6,7 代表对应数字的组合的意义，如3 = 1 + 2，那么代表SGID and SVTX
  * 第二个(代表文件拥有者的读写执行权限)
    * 4
      * 有读权限(R)
    * 2
      * 有写权限(W)
    * 1
      * 有执行权限(X)
    * 3,5,6,7同理，3代表有WX权限，7代表有RWX权限
  * 第三个(代表文件拥有者同组的用户的RWX权限)
    * 同上
  * 第四个(不同组的其他用户)
    * 同上
* 常见文件权限表示方法
  * 字母法
    * RWXR--R--X
      * 3个字母一组，分别表示拥有者，同组用户，其他用户的读写权限，默认第一个8进制数为0
  * 数字法
    * 777,333
      * 一个数字表示8进制数，分别表示拥有者，同组用户，其他用户的读写权限，默认第一个8进制数为0

#### 3.6 链接文件

##### 3.6.1 硬链接  Hard Link

1. 旧
   * 硬链接是UNIX传统的创建链接的方式，现在一般用软链接。

***

2. 只是别名

   * 硬链接文件不是一个文件，而是一个引用。给一个文件创建硬链接，更像是创建了一个别名，仅仅是名字而已。我们可以将一个文件分为两个部分，数据部分和名字部分。硬链接只是新增一个名字，然后指向原来文件的数据部分。

     > When we create a hard link, we create an additional directory entry for a file.

***

3. 每个数据默认都有一个名字
   * 每个文件默认状态下都有一个硬链接，指代文件名字部分指向文件数据部分。

***

4. 同性质
   * 硬链接和源文件没有高低之分，他们都是指向同一个数据部分的不同的名字而已，某种意义上，他们都是指向实际数据部分的硬链接，使用ls 命令，发现他们的大小一模一样，区分两个文件是硬链接的方法是看两个文件是否具有相同的inode 节点

***

5. **相同的inode——相同的数据部分**
   * **只要文件具有相同的inode节点，可以说他们互为硬链接，指向同一块数据内容**。

***



6. 同一块数据
   * 假设指向同一块10B数据内容的有10个名字，那么这10个文件都是硬链接文件,显示的大小都是10B，修改任何一个文件都是在修改这块数据内容，删除任意一个文件不会删除数据内容，知道10个文件都被删除，那么数据内容就会被删除。
   * **给某个文件创建硬链接，本质上是给实际的那块数据内容指定一个别名，可以通过别名来访问。**

***



7. **硬链接的限制**

   * 不能给目录创建硬链接

     > A hard link may not reference a directory.

   * 不能创建与文件不在同一个文件系统下的硬链接.(好理解，因为很难实现两个文件系统的两个文件名引用同一块数据内容)

     >  hard link cannot reference a file outside its own file system. This means a link may not reference a file that is not on the same disk partition as the link itself.
   
8. eg

* 
  * ![](pics/OneHardLink.png)
    * 可以看到，新创建的三个文件默认硬链接数都是1，指明指向数据内容的只有一个名字。
  * ![](pics/SameInode.png)
    * 创建一个a的硬链接文件后，a，a_hard的硬链接数都是2，**本质是指它们对应的数据部分此时有了两个名字**。第一行为文件对应的i**node节点，可以发现，两个一样，所以它们指向的是同一块数据，只是名字不同而已。**
    * 所以不管是修改a，或者是修改a_hard,修改的都是同一块数据内容。
  
##### 3.6.2 软链接 Symbolic(soft) Link

  1. 现代

     * 以前用硬链接，现在基本都用软链接

***

  2. 新文件

     * 不同于硬链接的别名，软链接则是彻彻底底的创建一个新文件，该文件的内容就是目标文件的路径。就这么简单。
     * 所以说Linux文件类型中有一种类型叫Symbolic Link文件，就是指软链接类型文件(简称为链接文件)，是一种特殊的文件类型，而不存在硬链接文件。

     ***

  3. 特殊的访问方式

     * 一般的文件，如果是可执行文件，那么点击执行本身，如果是文本文件，那么对其进行编辑，处理的是本身。
     * **一个文件如果是软链接文件，那么对其执行、编辑，处理的是其所指的目标文件**。可以这么理解，如果要系统要处理链接文件，那么首先会通过链接文件找到目标文件路径，然后处理目标文件。

     ***

  4. 不同性质

     * 目标文件和其软链接文件不同性质。处理软链接文件实际处理的是目标文件。如果删除软链接文件，对目标文件没影响。

     * 如果删除目标文件，那么软链接文件会失去目标，就没用了。

       > However when you delete a symbolic link, only the link is deleted, not the file itself. If the file is deleted before the symbolic link, the link will continue to exist, but will point to nothing. In this case, the link is said to be broken.

     ***

  5. 应用

     * **shortcut**(windows上的快捷方式)就是软链接
       * 假设一个程序test.exe位于 D:/test目录, test.exe运行所依赖的一些文件都在test目录，那么显然想运行test.exe,必须进入到test目录双击，命令行的话就是进入test，然后输入test.exe运行。
       * 如果命令行想在任意路径运行怎么办，那么就将test.exe加入环境变量，这样在任意路径输入test.exe，系统就知道去test目录运行test.exe就行了。这里加入环境变量实际就是起到的软链接作用，**通过软链接知道目标文件的路径，然后执行目标文件。**
       * 如果想在桌面双击运行test.exe行吗，直观的想法是把test.exe复制到桌面。然后双击，如果test.exe运行依赖的文件都是以绝对路径给出的，或者不依赖任何文件。那么这样可以。但是一般程序运行依赖的文件都是以相对路径给出的，以test.exe为例，一般都存在test目录里，通过.或..引用。所以简单的复制不行，除非将整个test目录复制到桌面。
         * 最简单的方案就是在桌面创建一个test.exe的快捷方式，双击，系统通过快捷方式定位到实际目标文件test.exe的位置，然后运行。
     * 维护
       * 假设我维护着/home/me/fun 文件，fun经常有版本升级，且许多其他用户都在各种各样的地方用名字/home/me/fun使用该文件。我想将版本信息加入到文件名中，比如fun_v1.1, fun_v1.2.
       * 但是如果这样的话，每个用到fun的地方都要改名，怎么办？利用软链接。例如现在是1.1版本，那么我命名为fun_v1.1,然后创建一个它的软连接叫fun，这样别人用不影响，我也好维护。当版本更新了，我改名为fun_v1.2, 然后删除链接文件，在重新创建链接文件。完美。

     ***

6. eg

   * ![](pics/SymLink.png)
     * a_sym是一个全新的文件，跟a Inode节点不同，注意其大小1B，其真正的内容就是一个字符a,也就是目标文件的路径，只有一个字符a，那么处理a_sym时，真正处理的就是./a。
     * 这里要注意的是，这个a_sym包含的目标路径是怎么来的哪，就是 ln -s a a_sym,命令中TARGET部分我们键入的a，那么a_sym存储的路径就是a。有省略，其实更清楚的写法是 ln -s ./a a_sym 。
     * 注意目标路径一定要写清楚，系统才能根据a_sym 所在的位置找到目标文件。目标路径有两种写法，相对路径(相对a_sym所在的位置)，绝对路径。

   ***

   

   * ![](pics/SymLink1.png)
     * 这里a_sym1,a_sym2目标路径给的正确，所以成功创建，目标路径显示正确。注意大小，4B对应4个字符，13B对应13个字符，再次说明软链接文件真正的内容是目标路径。
     * a_sym3创建失败，因为创建时给的路径是a，于是系统按照相对路径./a 在a_sym3的同级目录找a，没找到，所以a_sym3不存在对应目标文件，是一个损坏的链接文件。

   ***

   

   * ![](pics/shortcut1.png)

     * 如图是test.bat和他的快捷方式，左边是test.bat的属性信息，右边是test.bat快捷方式的属性信息。

     * 可以看到，快捷方式默认的属性框就是给出目标文件的位置，所以链接文件的最重要的信息就是目标文件的路径。其本身的信息如下图。

       ![](pics/shortcut2.png)





* apt update   
  * update，更新。 看看有啥更新。(不执行更新)
* apt upgrade
  * 根据apt update的更新，执行实际的升级动作







































