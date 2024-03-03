##################################################
###                                             ##
######                               ## 
##################################################
#    Unsupervised Learning K-Means Clustering              ##                     
##################################################
#         Written by Paresh Patil               ##
#                                    ##
##################################################
rm(list=ls())                                   ##
cat("\014")                                     ##
##
#######################################################################
setwd("C:/Users/91841/Desktop/BIG_DATA/Data_analytics/Assignment3")##
getwd()                                                              ##  
#######################################################################

#######################################################################
##loading  Data
#######################################################

load("C:/Users/91841/Desktop/BIG_DATA/Data_analytics/Assignment3/PROG8430_Clst_21F.RData")

print(PROG8430_Clst_21F)
typeof(PROG8430_Clst_21F)
###################################################################################
#install packages
#install.packages("ggplot2")
#install.packages("cluster")
#install.packages("factoextra")
#install.packages("dplyr")
library(ggplot2)
library(cluster)
library(factoextra)
library(dplyr)
###################################################################################
#Q-1.Data Transformation
###################################################################################
str(PROG8430_Clst_21F)
head(PROG8430_Clst_21F)
summary(PROG8430_Clst_21F)

normn_pp<-function(x)
{return((x-mean(x))/sd(x))}

PROG8430_Clst_21F$Foodnormn<-normn_pp(PROG8430_Clst_21F$Food)
PROG8430_Clst_21F$Entrnormn<-normn_pp(PROG8430_Clst_21F$Entr)
PROG8430_Clst_21F$Educnormn<-normn_pp(PROG8430_Clst_21F$Educ)
PROG8430_Clst_21F$Trannormn<-normn_pp(PROG8430_Clst_21F$Tran)
PROG8430_Clst_21F$Worknormn<-normn_pp(PROG8430_Clst_21F$Work)
PROG8430_Clst_21F$Housnormn<-normn_pp(PROG8430_Clst_21F$Hous)
PROG8430_Clst_21F$Othrnormn<-normn_pp(PROG8430_Clst_21F$Othr)

summary(PROG8430_Clst_21F)
###################################################################################
#Q-2Descriptive Data Analysis
###################################################################################
str(PROG8430_Clst_21F)
head(PROG8430_Clst_21F)
summary(PROG8430_Clst_21F)

hist(PROG8430_Clst_21F$Food)#before standardization
hist(PROG8430_Clst_21F$Foodnormn)#After standardization

hist(PROG8430_Clst_21F$Work)#before standardization
hist(PROG8430_Clst_21F$Worknormn)#After standardization


#before standardization
boxplot(PROG8430_Clst_21F[c(1:7)])

#After standardization
boxplot(PROG8430_Clst_21F[c(8:14)])
###################################################################################
#Q-3.1 Clustering
###################################################################################
str(PROG8430_Clst_21F)

clusterdata_pp<-PROG8430_Clst_21F[c(8,12)]#storing columns in on dataframe

str(clusterdata_pp)

cluster3_pp<-kmeans(clusterdata_pp,iter.max = 10,centers = 3,nstart = 10)
cluster3_pp
cluster4_pp<-kmeans(clusterdata_pp,iter.max = 10,centers = 4,nstart = 10)
cluster4_pp
cluster5_pp<-kmeans(clusterdata_pp,iter.max = 10,centers = 5,nstart = 10)
cluster5_pp
cluster6_pp<-kmeans(clusterdata_pp,iter.max = 10,centers = 6,nstart = 10)
cluster6_pp
cluster7_pp<-kmeans(clusterdata_pp,iter.max = 10,centers = 7,nstart = 10)
cluster7_pp



PROG8430_Clst_21F$cluster3<-factor(cluster3_pp$cluster)
PROG8430_Clst_21F$cluster4<-factor(cluster4_pp$cluster)
PROG8430_Clst_21F$cluster5<-factor(cluster5_pp$cluster)
PROG8430_Clst_21F$cluster6<-factor(cluster6_pp$cluster)
PROG8430_Clst_21F$cluster7<-factor(cluster7_pp$cluster)
head(PROG8430_Clst_21F[c(8,12,15,16,17,18,19)])


###################################################################################
#Q-4.1
###################################################################################
str(PROG8430_Clst_21F)
PROG8430_Clst_21F$cluster3

centers4_pp <- data.frame(cluster4_pp=factor(1:4), cluster4_pp$centers)

#k=4
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster4))+geom_point()
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster4,shape=cluster4))+
geom_point(alpha=.8)

#k=5
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster5))+geom_point()
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster5,shape=cluster5))+
  geom_point(alpha=.8)

#k=6
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster6))+geom_point()
ggplot(data=PROG8430_Clst_21F,aes(x=Foodnormn,y=Worknormn,color=cluster6,shape=cluster6))+
  geom_point(alpha=.8)
  
###################################################################################
#Q-4.3
###################################################################################
#summarise
str(PROG8430_Clst_21F)

PROG8430_Clst_21F_sum_pp<- PROG8430_Clst_21F %>% 
group_by(cluster5) %>% 
summarise(Food = mean(Food), Entr = mean(Entr), Educ=mean(Educ), Tran=mean(Tran),
Work=mean(Work),Hous=mean(Hous), Othr=mean(Othr), N=n() )

PROG8430_Clst_21F_sum_pp













