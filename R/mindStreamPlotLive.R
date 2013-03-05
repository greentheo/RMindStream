#plot the raw EEG data every 1 second
time=Sys.time()
filename = "~/mindwave"

while(1==1){
  if(Sys.time()-time>=1){
    data=as.numeric(system(paste('tail -n1000 ', filename, 'EEG.csv', sep='', collapse=''), intern=T))
  }
  plot(data, type="l")
}