library(RJSONIO)
try(close.socket(socket=mw))
mw=make.socket('localhost', port=13854)
write.socket(socket=mw, string="{\"enableRawOutput\": true, \"format\": \"Json\"}\n")
data = c()
filename = "~/mindwave"

while(1==1){
  cat('reading ...')
  data = read.socket(mw, maxlen=10000)
  #process
  #drop the incomplete data
  datasplit = strsplit(data, "\r")[[1]]
  dataList = unlist(lapply(datasplit, function(x)tryCatch(return(fromJSON(x)), error=function(x)return("error"))))    
  dataEEG = as.numeric(dataList[which(names(dataList)=="rawEeg")])
  names(dataEEG) = rep("rawEEG", length(dataEEG))
  #dataEEG = as.data.frame(dataEEG)
  print(dataEEG)
  dataWave = (dataList[which(names(dataList)!="rawEeg" & names(dataList)!="" )])
  print(dataWave)
  app=ifelse(i==1, F,T)
  write.table(dataEEG, paste(filename, "EEG.csv", sep='', collapse=''),append=app, row.names=F, col.names=F)
  if(length(dataWave)>1){
    write.table(dataWave, paste(filename, "MS.csv", sep='', collapse=''),col.names=F,append=app) 
  }
  cat('read \n')
}
