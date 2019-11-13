# Generate_mfiles
Generate a new m-file from a old m-file after several modifications

## How to use
We can run *Plot_A.m* to plot a absorption figure from the data file *TRA_data.txt*. Then we can run *Run_generate_mfiles.m* to generate two m-files: *Plot_T.m* and *Plot_R.m*, which can plot transmission and reflection curves.

## Motivation
Frequently, I need maintain several similar m-files. In the example, I need plot absorption,reflection and transmission from the same dataset. So I wrote the function to generate several m-files from a template by regular expression replacements. Later, if I need change the figure, for example, add a title or include another dataset, I only need modify one m-file and other m-files can be generated automatically. 

I also want the flexibility. So I want all the m-files are generated and saved on the disk, so that I can edit them separated if necessary. Actually, I introduce several makeup tags so that the additional edit on the generated file won't be overwritten. 

## Instruction
The function is names as *generate_mfile*.
```
generate_mfile(fname1,fname2,re_pairs)
    fname1: the source m-file    
    fname2: the destination m-file
    re_pairs: regular expression pairs for replacement
```
To make things simple, I assume the source file and the destination file have the same number of lines. There are one-to-one correspondence between the two files. If the source file has one line which should not appear in the destination file, replace the line with a blank line in the *re_pairs*. If the destination file has an additional line, add a blank line in the source file and use *%copynew* to protect the line. See below for tags.

### tags
The makeup tags are placed in the source or destination files.

*%copynew* and *%copyold%*:  they are placed at the end of a line, so that the line will be identical to the destination file (if it exists) or the source file. 

*%copynew_begin*, *%copynew_end*, *%copyold_begin%* and *%copyold_end%*: They are placed in a standalone line. The lines between the begin-end pairs will be identical to the destination or the source file and won't change corresponding to *re_pairs*. 
