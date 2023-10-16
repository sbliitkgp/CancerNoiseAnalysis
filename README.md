
<h2 id=Step1>Step 1: Noise Calculation</h2>
<div id="final_script">
<h4> Run <a href= "Noise_Calculation\Noise_calculation.R"> Noise_calculation.R</a> available within the <a href="\Noise_Calculation">Noise_Calculation folder</a> with each sample data data to obtain adjusted noise values for each of the genes </h4>
<p>
<h4 style= "color:cyan">--Prerequisites--<h4>
<h4>Files:</h4>
<li>A count matrix file in CSV format is required to run this script.<li>A <a href="NoiseCalculation/LUNG_N06_EPI.csv">demo CSV file</a> is provided in the same folder.<li> If you want to save your count matrix file to another folder make sure to define the correct path to it.
</p>
<p><h4>Dependencies:</h4>
<li>Install the required R package libraries including ccRemover, biomaRt,ShortRead.<li> Check Bioconductor for specific package installation if the package isn't available in CRAN repository.<li> Ensure the SCDE package with version 1.99.4 is installed in your environment. <li><span style= "color: pink">Higher version of SCDE might throw error!!</span>
<h4>System Specificity</h4>
<li>If working on windows OS , make sure to set num.cores argument value to 1 wherever applicable.<li> For Linux OS, higher values of num.core can be used. <li>Check available cores on your systems and assign value accordingly
</p>


<h4 style="color:cyan">--Additional information--</h4>

<p><h4>Usage:</h4>
An R runtime environment is required to run the script.
For Unix based system, to make the script executable run the  following command:

```{bash}
chmod +x Noise_calculation.R
```

Once inside the dedicated folder with all the necessary dependencies satisfied,to run the script using Command Line Interface, use:

```{bash}
Rscript Noise_calculation.R
```

<li>As long as all the conditions are satisfied the code should run perfectly.
</p>

<p><h4>Output:</h4>
The script should produce the following files:
<ol>
<li><span style="font-weight:bold"> cell.model.fits.pdf: </span> A pdf file showing error model fitting for first 10 cells in the sample
<li><span style="font-weight:bold"> cell_cycle_corrected_df_LUNG_N06_EPI.csv: </span> Count matrix after cell cycle effect removal.
<li><span style="font-weight:bold">varnorm_NLUNG06_epi.pdf:</span> A pdf file showing Noise vs average expression graph before and after variance normalization.
<li><span style="font-weight:bold">varinfo_averageexp_NLUNG06_epi.csv:</span> A CSV file that stores the final gene set and their corresponding transcriptoe-wide Average expression 
<li><span style="font-weight:bold">sorted_noise_epi.csv:</span> A CSV file with the genes sorted accoridng to their adjusted noise value.
<li><span style="font-weight:bold">varinfo_arv_LUNGT19_myeloid.csv:</span> A CSV file with the genes in the same order as varinfo_averageexp_NLUNG06_epi.csv and their corresponding adjusted noise values
</ol>
</p>

<h4>Note:</h4>
<li><span style="font-weight:bold">ccRemover</span> and <span style="font-weight:bold">knn.error.models</span> functions may take upto several hours, depending upon sample size and number of cores alloted.
</div>

<div id="Step2">
<h2> Step 2: Checking for Increasing noise trend with cancer progression</h2>

This step tries to compare Samples from different cancer stages and check which genes are showing an increasing trend in noise.
Run <a href="Comparing_noise\Increasing_Trend_Analaysis.ipynb">Increasing_Trend_Analaysis.ipynb</a> file using jupyter notebook or CLI

<p>
<h4 style= "color:cyan">--Prerequisites--</h4>

<h4>Input Files:</h4>

<li> Within the folder <a href= "Comparing_noise"> Comparing_noise </a> A set of demo folders are provided. 
<li>These folders should be created by peforming <a href="#Step1">Step 1</a> for each of sample data.


<p>
<h4>Dependencies:</h4>


<li>The following packages should be installed in your Python runtime environment:
<ol>
<li>NumPy
<li>Pandas
<li>Matplotlib.pyplot
<li>Seaborn
<li>scipy.stats
</ol>

<li id="filter2"> Filtering genes section is provided optimized for the demo data. One should filter depending on the number of samples.
<li id= "normal2">The normalisation section is to ensure between sample parity. This is optimised for the provided demo dataset. 
<li>One can check their dataset for between sample parity using Q-Q plots.
</p>

<p>
<h4 style= "color:cyan">--Additional Information--</h4>

<h4>Usage:</h4>
<li style="font-weight:bold">Using Jupyter Notebook: </li>(Recomended)
--One can use Jupyter notebook to open the <a href="Comparing_noise\Increasing_Trend_Analaysis.ipynb">Increasing_Trend_Analaysis.ipynb</a> file and run it.

<li style="font-weight:bold">Using Command Line Interface (CLI)</li>
Run the following command to convert the .ipynb file to python script file with .py extension:

```{bash}
jupyter nbconvert --to script Increasing_Trend_Analaysis.ipynb
```
Run the python script file using following command:

```{bash}
python Increasing_Trend_Analaysis.py
```

<h4>Output:</h4>
<ol>
<li><span style="font-weight:bold">Genes_increasing noise.csv: </span> A csv file that contains names of the genes with a positive slope value in regression analysis and their sample-wise adjusted noise data.
<li><span style="font-weight:bold">Stagewise_increasing_noise.pdf :</span> A pdf file with heatmap showing How noise is increasing accross stages

</div>

</p>

<h2 id=Step3>Step 3: Sample specific analysis of Highly Noisy genes</h2>

<h4 style= "color:cyan">--Prerequisites--</h4>
<p>
<h4>Input Files:</h4>

<li> Within the folder <a href= "SampleSpecificNoisyGenes"> SampleSpecificNoisyGenes, </a> a set of demo folders are provided. 
<li>These folders should be created by peforming <a href="#Step1">Step 1</a> for each of sample data.

p>
<h4>Dependencies:</h4>


<li>The following packages should be installed in your Python runtime environment:
<ol>
<li>NumPy
<li>Pandas
</ol>

<li> <a href="#filter2">Filtering genes </a>and <a href="#normal2">Normalization</a> for this step follows the same ideology as mentioned in <a href="#Step2">Step 2</a>
<li>The normalisation section is to ensure between sample parity. This is optimised for the provided demo dataset. 
<li>One can check their dataset for between sample parity using Q-Q plots.
</p>


</p>
<h4 style= "color:cyan">--Additional Information--</h4>

<h4>Usage:</h4>
<li style="font-weight:bold">Using Jupyter Notebook: </li>(Recomended)
--One can use Jupyter notebook to open the <a href="SampleSpecificNoisyGenes\Sample_Specific_Highly_Noisy_genes.ipynb">Sample_Specific_Highly_Noisy_genes.ipynb</a> file and run it.

<li style="font-weight:bold">Using Command Line Interface (CLI)</li>
Run the following command to convert the .ipynb file to python script file with .py extension:

```{bash}
jupyter nbconvert --to script Sample_Specific_Highly_Noisy_genes.ipynb
```
Run the python script file using following command:

```{bash}
python Sample_Specific_Highly_Noisy_genes.py
```

<h4>Output:</h4>
<ol>
<li><span style="font-weight:bold">Sample_Specific_Noisy_Genes.csv: </span> A csv file that contains names of the genes and adjusted noise value in those specific samples.
</p>

