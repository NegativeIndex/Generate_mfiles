# Generate_mfiles
Generate a new m-file from a old m-file after several modifications

## How to use
We can run *Plot_A.m* to plot a absorption figure from the data file *TRA_data.txt*. Then we can run *Run_generate_mfiles.m* to generate two m-files: *Plot_T.m* and *Plot_R.m*, which can plot transmission and reflection curves.

## Motivation
Frequently, I need maintain several similar m-files. In the example, I need plot absorption,reflection and transmission from the same dataset. So I wrote the function to generate several m-files from a template by regular expression replacements. Later, if I need change the figure, for example, add a title or include another dataset, I only need modify one m-file and other m-files can be generated automatically. 

I also want the flexibility. So I want all the m-files are generated and saved on the disk, so that I can edit them separated if necessary. Actually, I introduce several makeup tags so that the additional edit on the generated file won't be overwrote. 

## Instruction

```
generate_mfile(fname1,fname2,re_pair)
```
