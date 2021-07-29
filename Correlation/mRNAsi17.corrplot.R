######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056

#install.packages("corrplot")

library(corrplot)                                              #引用包
setwd("C:\\Users\\lexb4\\Desktop\\mRNAsi\\17.corrplot")        #设置工作目录
rt=read.table("keyGeneExp.txt",sep="\t",header=T,row.names=1,check.names=F)    #读取输入文件

#删掉正常样品
group=sapply(strsplit(colnames(rt),"\\-"),"[",4)
group=sapply(strsplit(group,""),"[",1)
group=gsub("2","1",group)
rt=rt[,group==0]

#绘制相关性图形
pdf("corrplot.pdf",height=10,width=10)              #保存图片的文件名称
par(oma=c(0.5,1,1,1.2))
M=cor(t(rt))
corrplot(M, order = "AOE", type = "upper", tl.pos = "lt")
corrplot(M, add = TRUE, type = "lower", method = "number", order = "AOE",
         col = "black", diag = FALSE, tl.pos = "n", cl.pos = "n")
dev.off()

######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056