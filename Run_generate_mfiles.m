clc
clear all
close all

rfolder='H:\functions';
addpath(fullfile(rfolder,'material_20190929'));
addpath(fullfile(rfolder,'comsol5_20190929'));
addpath(fullfile(rfolder,'Matlab_20190607'));
addpath(fullfile(rfolder,'Physics_20190501'));

% generate a new mfile from a old m file. The two files have the same
% number of lines, so each line has one-to-one correspondence. Several
% makeup tags are introduced to control the copy behaviour: %copyold and
% %copynew at the end of a line to force the direct copy from the file
% without replacement step. %copyold_begin and %copyold_end protect a
% paragraph from replacement.

% given S02_plot_A.m, generate S02_plot_R and S02_plot_T

%% generate  S02_plot_R
fname1='Plot_A.m';  % source file
fname2='Plot_R.m';  % destination file
% regular expression pairs, complex one before simple one.
re_pair={{'Absorptance','Reflectance'}, ...
    {'Absorption','Reflection'}, ...
    {'absp','refl'}, ...
    {'r-','b-'}};
generate_mfile(fname1,fname2,re_pair);

%% generate  S02_plot_T
fname1='Plot_A.m';  % source file
fname2='Plot_T.m';  % destination file
% regular expression pairs, complex one before simple one.
re_pair={{'Absorptance','Transmittance'}, ...
    {'Absorption','Transmission'}, ...
    {'absp','tran'},...
    {'r-','m-'}};
generate_mfile(fname1,fname2,re_pair);



%%
function generate_mfile(fname1,fname2,re_pair)

lines={};
fid=fopen(fname1);
tline = fgets(fid);
while ischar(tline)
    lines=[lines,tline];
    tline = fgets(fid);
end
fclose(fid);



% read new files
existnew=isfile(fname2);
if existnew
    newlines={};
    fid=fopen(fname2);
    tline = fgets(fid);
    while ischar(tline)
        newlines=[newlines,tline];
        tline = fgets(fid);
    end
    fclose(fid);
end

%  begin to replace
copyold=false;
copynew=false;
for i=1:length(lines)
    tline=strtrim(lines{i});
    % copyold
    if regexp(tline,'\%copyold$')
        continue;
    end
    % copynew
    if ~isempty(regexp(tline,'\%copynew$','ONCE')) && existnew
%         disp(tline);
        lines{i}=newlines{i};
        continue;
    end
    % envirement
    if regexp(tline,'^\%copynew_begin')
       copynew=true;
       continue;
    end
    if regexp(tline,'^\%copynew_end')
       copynew=false;
       continue;
    end
    if regexp(tline,'^\%copyold_begin')
       copyold=true;
       continue;
    end
    if regexp(tline,'^\%copyold_end')
       copyold=false;
       continue;
    end
    
    % actual repalcement
    if ~copyold && ~copynew
        for j=1:length(re_pair)
            re1=re_pair{j}{1};
            re2=re_pair{j}{2};
            lines{i}=regexprep(lines{i},re1,re2);
        end
    end
end

% write the new file
fid=fopen(fname2,'w');
for i=1:length(lines)
    fprintf(fid,'%s',lines{i});
end
fclose(fid);
end

