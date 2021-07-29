###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######QQ：2749657388
######交流Q群：219795300
######微信: 18520221056

## try http:// if https:// URLs are not supported
#source("https://bioconductor.org/biocLite.R")
#biocLite("limma")

setwd("C:\\Users\\lexb4\\Desktop\\CCLE\\05.cor")        #设置工作目录
inputFile="SingleCancerMatrix.txt"                      #输入文件
gene="EGFR"                                             #基因或lncRNA名字
corFilter=0.5                                           #相关系数过滤值
pFilter=0.001                                           #统计学p值过滤值

picDir="picture"
dir.create(picDir)

library(limma)
rt=read.table(inputFile,sep="\t",header=T,check.names=F)
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
rt=data[rowMeans(data)>0.5,]

x=log2(as.numeric(rt[gene,])+1)
gene1=unlist(strsplit(gene,"\\|",))[1]
outputFile=paste(gene1,".cor.xls",sep="")
outTab=data.frame()

for(j in rownames(rt)){
     y=log2(as.numeric(rt[j,])+1)
#    y=as.numeric(rt[j,])
		 gene2=unlist(strsplit(j,"\\|",))[1]
#    gene2Type=unlist(strsplit(j,"\\|",))[2]
#		 if(gene2Type=="protein_coding"){
		    corT=cor.test(x,y)
				gene1Name=unlist(strsplit(gene1,"\\|",))[1]
				gene2Name=unlist(strsplit(gene2,"\\|",))[1]

				z=lm(y~x)
				cor=corT$estimate
				cor=round(cor,3)
				pvalue=corT$p.value
				if(pvalue<0.001){
				  pval=signif(pvalue,4)
				  pval=format(pval, scientific = TRUE)
				}else{
				  pval=round(pvalue,3)}

        #输出相关性图片
				if((abs(cor)>corFilter) & (pvalue<pFilter)){
				  tiffFile=paste(gene1Name,"_",gene2Name,".cor.tiff",sep="")
          outTiff=paste(picDir,tiffFile,sep="\\")
					tiff(file=outTiff,width =12,height = 12,units ="cm",compression="lzw",bg="white",res=300)
					plot(x,y, type="p",pch=16,col="blue",main=paste("Cor=",cor," (p-value=",pval,")",sep=""),
					    cex=1, cex.lab=1, cex.main=1,cex.axis=1,
					    xlab=paste(gene1Name,"expression"),
					    ylab=paste(gene2Name,"expression") )
					lines(x,fitted(z),col=2)
					dev.off()
					outTab=rbind(outTab,cbind(gene1,gene2,cor,pvalue))
				}
#   }
}
write.table(file=outputFile,outTab,sep="\t",quote=F,row.names=F)

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######QQ：2749657388
######交流Q群：219795300
######微信: 18520221056