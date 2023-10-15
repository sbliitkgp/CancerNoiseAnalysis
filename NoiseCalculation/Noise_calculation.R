##### call necessary libraries  ####
  
  library(scde)
  library(ccRemover)
  library(biomaRt)
  library(ShortRead)

# Loading the CSV file into the environment
  df1 <- read.csv("LUNG_N06_EPI.csv", row.names = 1)

# Converting the Loaded data into matrix type
  a<- as.matrix(df1)

# Defining Index for the matrix
  rownames(a) <- NULL
  rownames (a) <- rownames(df1)

# Filtering Count data Using clean.counts
  cd<- clean.counts(a, min.lib.size = 15, min.reads = 15, min.detected = 8)

####  Cell cycle effect removal  ####

#Perform data centering on count matrix
  mean_gene_exp <- rowMeans(cd)
  t_cell_data_cen <- cd - mean_gene_exp
  summary(apply(t_cell_data_cen,1,mean))
  t_cell_data_cen <- t(scale(t(cd), center=TRUE, scale=FALSE))

#Extracting cell cycle related genes and current dataset genes
  gene_names <- rownames(t_cell_data_cen)
  cell_cycle_gene_indices <- gene_indexer(gene_names,species = "human", name_type = "symbol")

#Creating a logical vector to identify cell cycle genes from current dataset
  if_cc <- rep(FALSE,nrow(t_cell_data_cen))
  if_cc[cell_cycle_gene_indices] <- TRUE
  dat <- list(x=t_cell_data_cen, if_cc=if_cc)

#Using ccRemover function to handle cell cycle effect
  xhat <- ccRemover(dat, cutoff=3)

#Adding back the mean values which werensubtracted during data centering
  xhat <- xhat + mean_gene_exp
  cd<- xhat

# Saving the dataframe after cell cycle removal
  write.csv(cd, "cell_cycle_corrected_df_LUNG_N06_EPI.csv")

# converting into integer values (Count data essentially should be integer to be passed into knn.error.models)
  cd<-apply(cd,2,function(x) {storage.mode(x) <- 'integer'; x})
  knn<-knn.error.models(cd, k = as.integer(ncol(cd)/2), n.cores = 15, min.count.threshold = 5,min.size.entries = 50, min.nonfailed = 5, max.model.plots = 10)

#####  Varience Normalisation  #####

# generating plot for average expression vs CV^2 AND average expression vs adjusted noise

  pdf('varnorm_NLUNG06_epi.pdf', width=10, height=5)
  varinfo <- pagoda.varnorm(knn, counts = cd, trim = 3/ncol(cd), max.adj.var = 6, n.cores = 10, plot = TRUE)
  dev.off()

## Showing top 10 overdispersed genes ## (optional)
  sort(varinfo$arv, decreasing = TRUE)[1:10]

## handling sequencing depth related error if any

  varinfo <- pagoda.subtract.aspect(varinfo, colSums(cd[, rownames(knn)]>0))

# Saving CSV file for average expression of genes
  write.csv(varinfo$avmodes, file="varinfo_averageexp_NLUNG06_epi.csv")

# Saving CSV file with genes in the same order as varinfo_averageexp_NLUNG06_epi file with their adjusted noise values
  write.csv(varinfo$arv, file="varinfo_arv_LUNGT19_myeloid.csv")

# Saving CSV file with genes sorted according to their adjusted noise in decreasing order 
  write.csv( (sort(varinfo$arv, decreasing = TRUE)), file= "sorted_noise_epi.csv")

