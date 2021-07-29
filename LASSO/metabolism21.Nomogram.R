######Video source: https://ke.biowolf.cn
######生信自学网: https://www.biowolf.cn/
######微信公众号：biowolf_cn
######合作邮箱：biowolf@foxmail.com
######答疑微信: 18520221056

#install.packages("rms")

library(rms)
setwd("C:\\Users\\15216\\Desktop\\TGF\\KIRC\\lxt")                         #设置工作目录

#TCGA列线图绘制
riskFile="lassoRisk.txt"
cliFile="Clinical.txt"
outFile="tcga.Nomogram.pdf"
risk=read.table(riskFile,header=T,sep="\t",check.names=F,row.names=1)        #读取风险文件
cli=read.table(cliFile,sep="\t",check.names=F,header=T,row.names=1)          #读取临床文件
sameSample=intersect(row.names(cli),row.names(risk))
risk=risk[sameSample,]
cli=cli[sameSample,]
rt=cbind(futime=risk[,1],fustat=risk[,2],cli,riskScore=risk[,(ncol(risk)-1)])
#数据打包
dd <- datadist(rt)
options(datadist="dd")
#生成函数
f <- cph(Surv(futime, fustat) ~ age + grade+ stage + riskScore, x=T, y=T, surv=T, data=rt, time.inc=1)
surv <- Survival(f)
#建立nomogram
nom <- nomogram(f, fun=list(function(x) surv(5, x), function(x) surv(7, x), function(x) surv(10, x)), 
    lp=F, funlabel=c("5-year survival", "7-year survival", "10-year survival"), 
    maxscale=100, 
    fun.at=c(0.99, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3,0.2,0.1,0.05))  
#nomogram可视化
pdf(file=outFile,height=7.5,width=11)
plot(nom)
dev.off()

