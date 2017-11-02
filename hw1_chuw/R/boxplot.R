library(ggplot2)
library(grid)

######## my path is relative to the project folder (hwq_chuw) ,and system is Mac OS #######
## Please open the project file ##

## read data ----
inputPath <- "data/pokemon.csv"
pData <- read.csv(inputPath)

## initiate output file
outputPath <- "output/output.pdf"
pdf(outputPath)

## colors ----
titleColor <- "black"
backgroundColor <- '#faeec8'
panelBackgroundColor <- '#fdd45f' 
falseBoxColor <- '#FFCCCC'
trueBoxColor <- '#99CCFF'

## author info ----
author = grobTree(textGrob("@Chu Wu", x=0.86,  y=0.96, hjust=0,
                            gp=gpar(col="black", fontsize=7, fontface="italic")))
## main ----
base<-ggplot(data = pData, aes(x=factor(generation), y=speed)) + 
  geom_boxplot(aes(fill=legendary), outlier.shape=8, outlier.size=1) + 
  labs(x="Generation",y="Speed",title="Pokemon Speed In Different Generation")+
  scale_x_discrete(label=function(x){return(paste("G",x,sep = ""))}) +
  scale_fill_manual(values=c(falseBoxColor, trueBoxColor))+
  scale_color_manual(values=c(backgroundColor))+

  theme(axis.title.x = element_text(colour = titleColor,size = 13,face = "bold",margin = margin(10,0,20,0)),
        axis.title.y = element_text(colour = titleColor,size = 13,face = "bold",margin = margin(0,10,0,20)),
        plot.title = element_text(colour = titleColor,hjust = 0.5,size=16, face="bold", margin = margin(20, 0, 15, 0)),
        legend.title = element_text(colour = titleColor,size=11, face="bold",margin = margin(0,20,0,0)),
        legend.background=element_rect(fill=backgroundColor),
        legend.key = element_blank(),
        panel.background = element_rect(fill=panelBackgroundColor),
        panel.border = element_rect(fill = NA,color=titleColor,linetype=3),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = backgroundColor))
base + annotation_custom(author)

## output ----
dev.off()

