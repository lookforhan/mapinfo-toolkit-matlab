# mapinfo-toolkit-matlab
a toolkit for mapinfo, which is write in matlab language.

The first purpose is to transform file like meta data structure to Mif and Mid file.

The primary purpose is that I need to demonstrate a water supply network in MapInfo. and there is not any good way to generate lines in MapInfo. I searched in gitHub, and can not find a easily way because they are used some other language. But I am only familiar with MATLAB. So I think it is time to do it by myself. I hope this can help someone like me who is familiar with MATLAB and needs to show something in MapInfo.

## ACKNOWLEDGE

I want to show my acknowledgement to my mentor, professor Ma, who shows me the way to edit Mif and Mid files. His guidance is like a light in the dark.

## Mif and Mid file
Mif = MapInfo interchange Format(text file format)
Mid
tab


## TODO
* Write a class
* Write unit tests!

## file structure

* .\unittest : unit tests
* .\lib : 
* .\test : test files
* .\materials : some materials like test example mif file. 

## v1.0版本发布

通过两天的努力，终于将第一个版本发布。

在编写过程中，我的想法也不断的在改变。最初，是希望可以做出一套完美的，各个函数和类符合单一原则、各司其职，并且保留开放和封闭接口的一个工具。既满足需求，又为未来扩展留出足够的接口。

但是，我发现这个目标是不可轻易实现的。我修改了我的目标为：做出简单、清晰可读性还可以的工具。这个工具可以帮我将EPANET的标准inp文件转化为MapInfo的Mid/Mif文件，可以让我在MapInfo中展示我的管网。

目前，我的基本目标已经实现了，我会继续修改它，希望它有一天可以到接近完美的工具的状态。

为了可以读入全部的inp文件，我牺牲了一些程序的性能，采用EPANETx64PDD.dll进行中间转换。将所有输入的inp文件，首先读入到EPANETx64PDD.dll中，然后从EPANETx64PDD.dll中输出标准inp文件。

该工具目前只能展示所有节点，不能区分junction/tank/reservoir等节点类型。后续会持续对该工具进行修改和升级。

单元测试文件没有写好，因为实在是个小工具，单元测试比完成程序还要麻烦，后续也会进一步更新。

应用案例可以看.\test\test.m文件。主函数是：epa_inp2mapInfo_mif.m。利用了两个类：mapinfo_point_toolkit.m和mapinfo_pline_toolkit.m，分别实现生成点和线的功能。（.\lib\）
2018-12-18

## 补充说明

当用生成的pipe.mif,pipe.mid文件导入到mapinfo中时，会发现图形与实际不符，有一定的变形，这是由于采用MapInfo默认坐标系的原因，修改坐标系即可。在Mapinfo 8.5中，地图>选项>投影>Non-Earth中修改。

下一步是学习如何在mif文件中指定坐标系。在mapinfo的帮助文件中初步查找，之说在coordSys语句后修改，如何修改并没有详细说明。网上也没有找到相关的资料。2018-12-19 15:51
## 设置投影坐标系的方法 2018-12-20 23:35
找到设置地图坐标系投影的设置方法。例如笛卡尔坐标系："CoordSys NonEarth Units "mi" bounds (x1,y1)(x2,y2)"这句话的意思是非地球投影，单位为：英里，边界(最小x,最小y)(最大x,最大y)。找到这个方法很不容易，在一般的帮助文件和教程中都没有说明如何在mif文件中设置投影坐标系，可能在Map Basic中有这方面的讲解。

我是在wor文件中看到有设置地图坐标系的语句"CoordSys NonEArth Units "mi"",然后跟着进行测试，修改语句。Mapinfo有一点很好，它会提示错误，例如我第一次输入"CoordSys NonEarth Units "mi"",它就提示说：寻找[bounds]时找到了‘'columns'.然后我就知道后面应该是“bounds',我这样一步一步测试，最终找到正确显示的语句。当然中间进行了特别多的错误的尝试，大部分尝试没有用，但有一部分的错误，告诉了我其他的信息，最终让我找到正确的方向。
