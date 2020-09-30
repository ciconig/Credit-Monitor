

#####
## listing folds

folds = list.files(path = "C:/Users/cicon/Downloads")
folds = folds[1:24]
files_dir = c()
fold_dir = c()

for (i in 1:length(folds)) { 
  
  fold_dir[i] = str_c("C:/Users/cicon/Downloads", "/", folds[i])
  files_dir[i] = str_c(fold_dir[i], list.files(folds[i]))
  assign(paste(folds[i]), list.files(fold_dir[i]))
  assign(paste(folds[i]), str_subset(str_c(files_dir[i], "/", list.files(files_dir[i])), ".txt"))
  
}
  
#####
## Reading dates

datas = c()

for(i in 1:length(folds)) {
  
  datas[i] = str_c(str_sub(folds[i], 5,6),".",str_sub(folds[i], 3,4))
  
}


#####
## reading codes


for (i in 1:length(folds)) { 
  
  codigos = read.table(paste(str_c("C:/Users/cicon/Downloads/", folds[i], "/plan",
                                   str_sub(folds[i], 1, 6), ".txt")), sep = "\t")
  
}

#####
## Reading banks names and numbers


banks_names = read_lines(str_c(fold_dir[1],"/Instrucciones/CODIFIS.txt"))
indices = grep(" ", banks_names, value = F, invert = T)
banks_names = banks_names[9:(indices[5]-1)]

banks_number = c()

for ( i in 1:length(banks_names)){
  
  banks_number[i] = str_sub(banks_names[i], 1, 3)
  banks_names[i] = str_sub(banks_names[i], 5)
  banks = cbind(banks_number, banks_names)
  
}

view(banks)

#####
## Defining directorys

dir = c(`201804-190219`, `201805-190219`, `201806-190219`, `201807-190219`, `201808-190219`,
        `201809-190219`,`201810-190219`,`201811-190219`,`201812-190219`,`201901-081019`,`201902-081019`,
        `201903-081019`,`201904-081019`,`201905-081019`,`201906-081019`,`201907-081019`,`201908-061119`,
        `201909-281019`,`201910-281119`,`201911-271219`,`201912-290120`,`202001-25022020`,
        `202002-20200330`,`202003-290420`)

b1_dir = str_subset(dir, "b1")
c1_dir = str_subset(dir, "c1")
c2_dir = str_subset(dir, "c2")
r1_dir = str_subset(dir, "r1")

b1_banks = unique(str_sub(b1_dir, start = -7, end = -5))
c1_banks = unique(str_sub(c1_dir, start = -7, end = -5))
c2_banks = unique(str_sub(c2_dir, start = -7, end = -5))
r1_banks = unique(str_sub(r1_dir, start = -7, end = -5))

b1 = str_sub(b1_dir, -15, -5)
c1 = str_sub(c1_dir, -15, -5)
c2 = str_sub(c2_dir, -15, -5)
r1 = str_sub(r1_dir, -15, -5)

remove(`201804-190219`, `201805-190219`, `201806-190219`, `201807-190219`, `201808-190219`,
       `201809-190219`,`201810-190219`,`201811-190219`,`201812-190219`,`201901-081019`,`201902-081019`,
       `201903-081019`,`201904-081019`,`201905-081019`,`201906-081019`,`201907-081019`,`201908-061119`,
       `201909-281019`,`201910-281119`,`201911-271219`,`201912-290120`,`202001-25022020`,
       `202002-20200330`,`202003-290420`)

#####
## importing files 


for (i in 1:length(b1_dir)) {
  
  assign(paste(b1[i], sep = ""), read.table(b1_dir[i], sep = "\t", dec = ",", skip = 1)) 
  
  assign(b1[i],  rbind(cbind(eval(parse(text=paste(b1[i],"[,1]", sep = "")), env = .GlobalEnv), 
                            eval(parse(text=paste(b1[i],"[,2]", sep = "")), env = .GlobalEnv) +
                             eval(parse(text=paste(b1[i],"[,3]", sep = "")), env = .GlobalEnv) +
                            eval(parse(text=paste(b1[i],"[,4]", sep = "")), env = .GlobalEnv) +
                           eval(parse(text=paste(b1[i],"[,5]", sep = "")), env = .GlobalEnv))))
  
  assign(paste(c1[i], sep = ""), read.table(c1_dir[i], sep = "\t", dec = ",", skip = 1))
  
  assign(paste(c2[i], sep = ""), read.table(c2_dir[i], sep = "\t", dec = ",", skip = 1))
  
  assign(paste(r1[i], sep = ""), read.table(r1_dir[i], sep = "\t", dec = ",", skip = 1))
  
  assign(r1[i],  rbind(cbind(eval(parse(text=paste(r1[i],"[,1]", sep = "")), env = .GlobalEnv), 
                             eval(parse(text=paste(r1[i],"[,2]", sep = "")), env = .GlobalEnv) +
                               eval(parse(text=paste(r1[i],"[,3]", sep = "")), env = .GlobalEnv) +
                               eval(parse(text=paste(r1[i],"[,4]", sep = "")), env = .GlobalEnv) +
                               eval(parse(text=paste(r1[i],"[,5]", sep = "")), env = .GlobalEnv))))
  
  
}

remove(banks_names, banks_number, datas, files_dir, fold_dir, folds, i, indices)

#####
# Impoting database

SYSTEM_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/SYSTEM.txt",
                          sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

BCH_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/BCH.txt",
                       sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

BSAN_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/BSAN.txt", 
                        sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

ITAU_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/ITAU.txt", 
                        sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

ITCB_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/ITCB.txt",
                        sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

BCI_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/BCI.txt",
                       sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

ESTADO_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/ESTADO.txt",
                          sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

BBVA_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/BBVA.txt",
                        sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

SCOTIA_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/SCOTIA.txt",
                          sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

BICE_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/BICE.txt",
                        sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

SECURITY_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/SECURITY.txt",
                            sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

CONSORCIO_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/CONSORCIO.txt",
                             sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

FALABELLA_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/FALABELLA.txt",
                             sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

RIPLEY_Cons <- read.table("C:/Users/cicon/Documents/Projetos/Credit Monitor/Dados/RIPLEY.txt",
                          sep = "\t", dec = ",", header = T, fill = T, skip = 1 )

RIPLEY_Cons = RIPLEY_Cons[,1:125]
FALABELLA_Cons = FALABELLA_Cons[,1:125]


#####
## organizing datasets

## replacing banks numbers with "find/replace"

indices.061 = grep("TRUE", str_ends(r1, "061"), value = F, invert = F)

df.061 = data.frame(r1201804061[,1:2], r1201805061[,2], r1201806061[,2], r1201807061[,2],
                    r1201808061[,2], r1201809061[,2], r1201810061[,2], r1201811061[,2], r1201812061[,2])

colnames(df.061) = c("codigos", datas[1:9])

df = data.frame(r1201812061[,1:2])

colnames(df) = c("codigos", "12.18")

df.19 = data.frame(r1201901061[,1:2], r1201902061[,2], r1201903061[,2], r1201904061[,2], r1201905061[,2],
                   r1201906061[,2], r1201907061[,2], r1201908061[,2], r1201909061[,2], r1201910061[,2],
                   r1201911061[,2], r1201912061[,2], r1202001061[,2], r1202002061[,2], r1202003061[,2])

colnames(df.19) = c("codigos", datas[10:24])

diferente1 = setdiff(df.19$codigos, df.061$codigos)
diferente2 = setdiff(df$codigos, df.061$codigos)
diferente3 = setdiff(df.19$codigos, df$codigos)

diferentes = c(diferente1, diferente2, diferente3)
diferentes = unique(diferentes)


df.061[196:198,1] = diferente1
df.061[196:198,2:7] = 0



b= matrix(0, length(diferente1) - length(diferente2), length(df[1,]))
colnames(b) = c("codigos", "12.18")
df[67:71,1] = setdiff(df.19$codigos, df$codigos)

c= matrix(0, length(diferente1) - length(diferente2), length(df.061[1,]))
colnames(c) = c("codigos", datas[1:8])
df.061[50:71,1] = diferentes
df.061[50:71,2:9] = 0

Cons.r1.061 = merge(df.061, df.19, by = "codigos")
Cons.r1.061 = merge(Cons.r1.061, df.19, by = "codigos")

remove(df.061, df.19, indices.061)

remove(r1201804061, r1201805061, r1201806061, r1201807061, r1201808061, r1201809061, r1201810061, 
       r1201811061, r1201812061, r1201901061, r1201902061, r1201903061, r1201904061, r1201905061,
       r1201906061, r1201907061, r1201908061, r1201909061, r1201910061, r1201911061, r1201912061, 
       r1202001061, r1202002061, r1202003061)

remove(diferente1, diferente2, diferente3, diferentes, a, b, c, df)

remove(b1, b1_banks, b1_dir, banks_names, banks_number, c1, c1_banks, c1_dir, c2, c2_banks, c2_dir)














#####
## changing base format 

SYSTEM_Cons <- SYSTEM_Cons %>% mutate_if(is.character, as.numeric)

SYSTEM = as.data.frame(t(SYSTEM_Cons))
colnames(SYSTEM) = SYSTEM[1,]
SYSTEM = SYSTEM[-c(1,2), ]
row.names(SYSTEM) = NULL
SYSTEM = cbind(dates, SYSTEM)
remove(SYSTEM_Cons)

BCH_Cons <- BCH_Cons %>% mutate_if(is.character, as.numeric)
BCH_Cons = BCH_Cons[, -c(2)]

BCH = as.data.frame(t(BCH_Cons))
colnames(BCH) = BCH[1,]
BCH = BCH[-c(1), ]
row.names(BCH) = NULL
BCH= cbind(dates, BCH)
remove(BCH_Cons)

BSAN_Cons <- BSAN_Cons %>% mutate_if(is.character, as.numeric)

BSAN = as.data.frame(t(BSAN_Cons))
colnames(BSAN) = BSAN[1,]
BSAN = BSAN[-c(1,2,3), ]
row.names(BSAN) = NULL
BSAN= cbind(dates[2:123], BSAN)
remove(BSAN_Cons)
colnames(BSAN)[1] = "dates"

ITAU_Cons <- ITAU_Cons %>% mutate_if(is.character, as.numeric)

ITAU = as.data.frame(t(ITAU_Cons))
colnames(ITAU) = ITAU[1,]
ITAU = ITAU[-c(1,2), ]
row.names(ITAU) = NULL
ITAU= cbind(dates, ITAU)
remove(ITAU_Cons)

ITCB_Cons <- ITCB_Cons %>% mutate_if(is.character, as.numeric)

ITCB = as.data.frame(t(ITCB_Cons))
colnames(ITCB) = ITCB[1,]
ITCB = ITCB[-c(1,2), ]
row.names(ITCB) = NULL
ITCB= cbind(dates, ITCB)
remove(ITCB_Cons)

BCI_Cons <- BCI_Cons %>% mutate_if(is.character, as.numeric)

BCI = as.data.frame(t(BCI_Cons))
colnames(BCI) = BCI[1,]
BCI = BCI[-c(1,2), ]
row.names(BCI) = NULL
BCI= cbind(dates, BCI)
remove(BCI_Cons)

ESTADO_Cons <- ESTADO_Cons %>% mutate_if(is.character, as.numeric)

ESTADO = as.data.frame(t(ESTADO_Cons))
colnames(ESTADO) = ESTADO[1,]
ESTADO = ESTADO[-c(1,2), ]
row.names(ESTADO) = NULL
ESTADO= cbind(dates, ESTADO)
remove(ESTADO_Cons)

CONSORCIO_Cons <- CONSORCIO_Cons %>% mutate_if(is.character, as.numeric)

CONSORCIO = as.data.frame(t(CONSORCIO_Cons))
colnames(CONSORCIO) = CONSORCIO[1,]
CONSORCIO = CONSORCIO[-c(1,2), ]
row.names(CONSORCIO) = NULL
CONSORCIO= cbind(dates, CONSORCIO)
remove(CONSORCIO_Cons)

FALABELLA_Cons <- FALABELLA_Cons %>% mutate_if(is.character, as.numeric)

FALABELLA = as.data.frame(t(FALABELLA_Cons))
colnames(FALABELLA) = FALABELLA[1,]
FALABELLA = FALABELLA[-c(1,2), ]
row.names(FALABELLA) = NULL
FALABELLA= cbind(dates, FALABELLA)
remove(FALABELLA_Cons)

RIPLEY_Cons <- RIPLEY_Cons %>% mutate_if(is.character, as.numeric)

RIPLEY = as.data.frame(t(RIPLEY_Cons))
colnames(RIPLEY) = RIPLEY[1,]
RIPLEY = RIPLEY[-c(1,2), ]
row.names(RIPLEY) = NULL
RIPLEY= cbind(dates, RIPLEY)
remove(RIPLEY_Cons)

SCOTIA_Cons <- SCOTIA_Cons %>% mutate_if(is.character, as.numeric)

SCOTIA = as.data.frame(t(SCOTIA_Cons))
colnames(SCOTIA) = SCOTIA[1,]
SCOTIA = SCOTIA[-c(1,2), ]
row.names(SCOTIA) = NULL
SCOTIA= cbind(dates, SCOTIA)
remove(SCOTIA_Cons)

SECURITY_Cons <- SECURITY_Cons %>% mutate_if(is.character, as.numeric)

SECURITY = as.data.frame(t(SECURITY_Cons))
colnames(SECURITY) = SECURITY[1,]
SECURITY = SECURITY[-c(1,2), ]
row.names(SECURITY) = NULL
SECURITY= cbind(dates, SECURITY)
remove(SECURITY_Cons)

BICE_Cons <- BICE_Cons %>% mutate_if(is.character, as.numeric)

BICE = as.data.frame(t(BICE_Cons))
colnames(BICE) = BICE[1,]
BICE = BICE[-c(1,2), ]
row.names(BICE) = NULL
BICE= cbind(dates, BICE)
remove(BICE_Cons)

BBVA_Cons <- BBVA_Cons %>% mutate_if(is.character, as.numeric)

BBVA = as.data.frame(t(BBVA_Cons))
colnames(BBVA) = BBVA[1,]
BBVA = BBVA[-c(1,2), ]
row.names(BBVA) = NULL
BBVA= cbind(dates, BBVA)
remove(BBVA_Cons)


#####
## removing empty rows

BBVA = BBVA[,-grep("NA", colnames(BBVA))]
BCH = BCH[,-grep("NA", colnames(BCH))]
BCI = BCI[, -grep("NA", colnames(BCI))]
BICE = BICE[, -grep("NA", colnames(BICE))]
BSAN = BSAN[, -grep("NA", colnames(BSAN))]
CONSORCIO = CONSORCIO[, -grep("NA", colnames(CONSORCIO))]
ESTADO = ESTADO[, -grep("NA", colnames(ESTADO))]
FALABELLA = FALABELLA[, -grep("NA", colnames(FALABELLA))]
ITAU = ITAU[, -grep("NA", colnames(ITAU))]
ITCB = ITCB[, -grep("NA", colnames(ITCB))]
RIPLEY = RIPLEY[, -grep("NA", colnames(RIPLEY))]
SCOTIA = SCOTIA[, -grep("NA", colnames(SCOTIA))]
SECURITY = SECURITY[, -grep("NA", colnames(SECURITY))]
SYSTEM = SYSTEM[, -grep("NA", colnames(SYSTEM))]




#####
## merging datasets

bbva.cons = as.data.frame(t(Cons.504))
colnames(bbva.cons) = bbva.cons[1,]
bbva.cons = bbva.cons[-c(1), ]
row.names(bbva.cons) = NULL
bbva.cons = cbind(dates1[1:5], bbva.cons)
colnames(bbva.cons)[1] = "dates"
samecols = intersect(colnames(BBVA), colnames(bbva.cons))
BBVA = merge(BBVA, bbva.cons, by = samecols, all = T)
remove(bbva.cons, Cons.504)


bci.cons = as.data.frame(t(Cons.016))
colnames(bci.cons) = bci.cons[1,]
bbva.cons = bbva.cons[-c(1), ]
row.names(bbva.cons) = NULL
bbva.cons = cbind(dates1[1:5], bbva.cons)
colnames(bbva.cons)[1] = "dates"
samecols = intersect(colnames(BBVA), colnames(bbva.cons))
BBVA = merge(BBVA, bbva.cons, by = samecols, all = T)
remove(bbva.cons, Cons.504)


bci.cons = as.data.frame(t(Cons.016))
colnames(bci.cons) = bci.cons[1,]
bci.cons = bci.cons[-c(1), ]
row.names(bci.cons) = NULL
bci.cons = cbind(dates1, bci.cons)
colnames(bci.cons)[1] = "dates"
samecols = intersect(colnames(BCI), colnames(bci.cons))
BCI = merge(BCI, bci.cons, by = samecols, all = T)
remove(bci.cons, Cons.016)


bice.cons = as.data.frame(t(Cons.028))
colnames(bice.cons) = bice.cons[1,]
bice.cons = bice.cons[-c(1), ]
row.names(bice.cons) = NULL
bice.cons = cbind(dates1, bice.cons)
colnames(bice.cons)[1] = "dates"
samecols = intersect(colnames(BICE), colnames(bice.cons))
BICE = merge(BICE, bice.cons, by = samecols, all = T)
remove(bice.cons, Cons.028)


bsan.cons = as.data.frame(t(Cons.037))
colnames(bsan.cons) = bsan.cons[1,]
bsan.cons = bsan.cons[-c(1), ]
row.names(bsan.cons) = NULL
bsan.cons = cbind(dates1, bsan.cons)
colnames(bsan.cons)[1] = "dates"
samecols = intersect(colnames(BSAN), colnames(bsan.cons))
BSAN = merge(BSAN, bsan.cons, by = samecols, all = T)
remove(bsan.cons, Cons.037)


consorcio.cons = as.data.frame(t(Cons.055))
colnames(consorcio.cons) = consorcio.cons[1,]
consorcio.cons = consorcio.cons[-c(1), ]
row.names(consorcio.cons) = NULL
consorcio.cons = cbind(dates1, consorcio.cons)
colnames(consorcio.cons)[1] = "dates"
samecols = intersect(colnames(CONSORCIO), colnames(consorcio.cons))
CONSORCIO = merge(CONSORCIO, consorcio.cons, by = samecols, all = T)
remove(consorcio.cons, Cons.055)


estado.cons = as.data.frame(t(Cons.012))
colnames(estado.cons) = estado.cons[1,]
estado.cons = estado.cons[-c(1), ]
row.names(estado.cons) = NULL
estado.cons = cbind(dates1, estado.cons)
colnames(estado.cons)[1] = "dates"
samecols = intersect(colnames(ESTADO), colnames(estado.cons))
ESTADO = merge(ESTADO, estado.cons, by = samecols, all = T)
remove(estado.cons, Cons.012)


falabella.cons = as.data.frame(t(Cons.051))
colnames(falabella.cons) = falabella.cons[1,]
falabella.cons = falabella.cons[-c(1), ]
row.names(falabella.cons) = NULL
falabella.cons = cbind(dates1, falabella.cons)
colnames(falabella.cons)[1] = "dates"
samecols = intersect(colnames(FALABELLA), colnames(falabella.cons))
FALABELLA = merge(FALABELLA, falabella.cons, by = samecols, all = T)
remove(falabella.cons, Cons.051)


ripley.cons = as.data.frame(t(Cons.053))
ripley.cons = ripley.cons[1,]
ripley.cons = ripley.cons[-c(1), ]
row.names(ripley.cons) = NULL
ripley.cons = cbind(dates1, ripley.cons)
colnames(ripley.cons)[1] = "dates"
samecols = intersect(colnames(RIPLEY), colnames(ripley.cons))
RIPLEY = merge(RIPLEY, ripley.cons, by = samecols, all = T)
remove(ripley.cons, Cons.053)


scotia.cons = as.data.frame(t(Cons.053))
scotia.cons = scotia.cons[1,]
scotia.cons = scotia.cons[-c(1), ]
row.names(scotia.cons) = NULL
scotia.cons = cbind(dates1, scotia.cons)
colnames(scotia.cons)[1] = "dates"
samecols = intersect(colnames(RIPLEY), colnames(scotia.cons))
RIPLEY = merge(RIPLEY, scotia.cons, by = samecols, all = T)
remove(scotia.cons, Cons.053)


security.cons = as.data.frame(t(Cons.049))
security.cons = security.cons[1,]
security.cons = security.cons[-c(1), ]
row.names(security.cons) = NULL
security.cons = cbind(dates1, security.cons)
colnames(security.cons)[1] = "dates"
samecols = intersect(colnames(SECURITY), colnames(security.cons))
SECURITY = merge(SECURITY, security.cons, by = samecols, all = T)
remove(security.cons, Cons.049)


system.cons = as.data.frame(t(Cons.999))
system.cons = system.cons[1,]
system.cons = system.cons[-c(1), ]
row.names(system.cons) = NULL
system.cons = cbind(dates1, system.cons)
colnames(system.cons)[1] = "dates"
samecols = intersect(colnames(SYSTEM), colnames(system.cons))
SYSTEM = merge(SYSTEM, system.cons, by = samecols, all = T)
remove(system.cons, Cons.999)


internacional.cons = as.data.frame(t(Cons.009))
colnames(internacional.cons) = internacional.cons[1,]
internacional.cons = internacional.cons[-c(1), ]
row.names(internacional.cons) = NULL
internacional.cons = cbind(dates1, internacional.cons)
colnames(internacional.cons)[1] = "dates"

