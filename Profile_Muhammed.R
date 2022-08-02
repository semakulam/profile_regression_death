
library(PReMiuM)
inputs <- generateSampleDataFile(clusSummaryPoissonDiscrete())

runInfoObj<-profRegr(yModel=inputs$yModel,
                     xModel=inputs$xModel, nSweeps=10, nClusInit=20,
                     nBurn=20, data=inputs$inputData, output="output",
                     covNames = inputs$covNames, outcomeT = inputs$outcomeT,
                     fixedEffectsNames = inputs$fixedEffectNames)

dissimObj<-calcDissimilarityMatrix(runInfoObj)
clusObj<-calcOptimalClustering(dissimObj)
riskProfileObj<-calcAvgRiskAndProfile(clusObj)
clusterOrderObj<-plotRiskProfile(riskProfileObj,"summary.png")

# cluster dimension (not ordered by risk)
clusObj$clusterSizes

# cluster size ordered by risk
clusObj$clusterSizes[clusterOrderObj]

# To see the order of clusters found, as ordered by risk
clusterOrderObj

names(riskProfileObj)
dim(riskProfileObj$risk)


mean.logrr.per.iter<-as.matrix(apply(log(riskProfileObj$risk[,,1]),1,mean))
logrisk1<-log(riskProfileObj$risk[,1,1])-mean.logrr.per.iter
exp(quantile(logrisk1,c(0.025,0.5,0.975)))

logrisk2<-log(riskProfileObj$risk[,2,1])-mean.logrr.per.iter
exp(quantile(logrisk2,c(0.025,0.5,0.975)))

logrisk3<-log(riskProfileObj$risk[,3,1])-mean.logrr.per.iter
exp(quantile(logrisk3,c(0.025,0.5,0.975)))

logrisk4<-log(riskProfileObj$risk[,4,1])-mean.logrr.per.iter
exp(quantile(logrisk4,c(0.025,0.5,0.975)))

logrisk5<-log(riskProfileObj$risk[,5,1])-mean.logrr.per.iter
exp(quantile(logrisk5,c(0.025,0.5,0.975)))

logrisk6<-log(riskProfileObj$risk[,6,1])-mean.logrr.per.iter
exp(quantile(logrisk6,c(0.025,0.5,0.975)))

logrisk7<-log(riskProfileObj$risk[,7,1])-mean.logrr.per.iter
exp(quantile(logrisk7,c(0.025,0.5,0.975)))

logrisk8<-log(riskProfileObj$risk[,8,1])-mean.logrr.per.iter
exp(quantile(logrisk8,c(0.025,0.5,0.975)))

logrisk9<-log(riskProfileObj$risk[,9,1])-mean.logrr.per.iter
exp(quantile(logrisk9,c(0.025,0.5,0.975)))


data <- inputs$inputData
data.cluster<-data.frame(indice=1:1050,data[,1],clusObj$clustering)
colnames(data.cluster)<-c("days", "outcome", "cluster")
require(ggplot2)
p1 <- ggplot(data.cluster, aes(x = days, y = outcome))+geom_point(aes(color=factor(cluster))) +
  theme(legend.position = "bottom")     
p1


inputs <- generateSampleDataFile(clusSummaryBernoulliMixed())
runInfoObj<-profRegr(yModel=inputs$yModel, 
                     xModel=inputs$xModel, nSweeps=10, nClusInit=15,
                     nBurn=20, data=inputs$inputData, output="output", 
                     discreteCovs = inputs$discreteCovs,
                     continuousCovs = inputs$continuousCovs)

inputs_d <- generateSampleDataFile(clusSummaryBernoulliDiscrete())

