load("industries.RData")
sectors  <- as.character(levels(industries$sectorSim))
sectorNames  <- setNames(sectors, sectors)

comarques  <- as.character(levels(industries$Comarca))
comarquesNames  <- setNames(comarques, comarques)
