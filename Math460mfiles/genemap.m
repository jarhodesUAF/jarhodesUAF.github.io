% genemap.m 
%
% Genetic mapping program
%
% This program simulates two- and three-point testcrosses to place six alleles
% on a genetic map.  The user may create a map for either six Drosophila genes
% or six mice genes.  See instructor notes in m-file for choosing mice data.
%
% 8/2/03

% Instructor may choose gene mapping distances from either Drosophila or mice. 
% (Actual map locations are reported at the bottom of this file for convenience.)
% The default is Drosophila data.  
species='Drosophila';
%To use mice data, uncomment the line below:.
% species='mouse';


switch species
case 'Drosophila'
   disp('This program will allow you to perform two- and three-point test crosses   ')
   disp('to create a linkage map for six alleles in the Drosophila genome.  For the ')
   disp('purposes of this lab, assume all genes are autosomal and diallelic, only   ')
   disp('homozygous recessive flies exhibit the trait, and the recessive alleles    ')
   disp('have no effect on viability or fertility.  The six Drosophila alleles are: ')
   disp(' ')
   disp('    b  : black body                                                        ')
   disp('    c  : curved wings                                                      ')
   disp('    ci : cubitus interuptus veins                                          ')
   disp('    cn : cinnabar eyes                                                     ')
   disp('    jv : javelin bristles                                                  ')
   disp('    h  : hairy body                                                        ')
   genenames='b c ci cn h jv';
   geneorder={'b' 'cn' 'c' 'jv' 'h' 'ci'};
   gendist = [.09 .175 .5 .073 .5];
   default_progeny=500;
case 'mouse'
   disp('This program will allow you to perform two- and three-point test crosses  ')
   disp('to create a linkage map for six alleles in the mouse genome.  For the     ')
   disp('purposes of this lab, assume all genes are autosomal and diallelic, only  ')
   disp('homozygous recessive mice exhibit the trait, and the recessive alleles    ')
   disp('have no effect on viability or fertility.  The six mice alleles are:      ')
   disp(' ')
   disp('    adip: obesity                                                         ')
   disp('    hes : hesitant (hesitant walking motion)                              ')
   disp('    jc  : Jackson circler (displays erratic circling behavior)            ')
   disp('    lgh : long hair                                                       ')
   disp('    rkr : rocker (displays rocking motion, unusual gait)                  ')
   disp('    scb : scabby (scar tissue on skin, defective hair growth)             ')
   genenames='adip hes jc lgh rkr scb';
   geneorder={'lgh' 'adip' 'rkr' 'scb' 'jc' 'hes'};
   gendist=[.27 .065 .185 .5 .11];
   default_progeny=200;
end

disp(' ')
disp('Recall a testcross for three genes with dominant and recessive alleles')
disp('A,a;B,b;C,c is a cross between parents with genotypes ABC/abc and abc/abc.')
disp(' ')

number_genes=6;

% Make sure no genetic distances are greater than .5
gendist = min(gendist, [.5 .5 .5 .5 .5]);

% initialize variables
randn('state',sum(100*clock))
crossloc = zeros(1,6);
T = triu(ones(6));
total_progeny = 0;
twocross_count = 0;
threecross_count = 0;
morecrosses = 1;

% ask user to input number of progeny
msg=sprintf('  How many progeny would you like to produce, (default=%d)?  ',default_progeny);
progeny = input(msg);
if isempty(progeny)
   progeny=default_progeny;
end
disp(' ')

% loop until user enters 'N', for not wanting to do more crosses 
while (morecrosses ~= 78)
   % 2 or 3 testcross and number of progeny produced
   pts =     input('  Do you want to perform a 2 or 3 point testcross, (2 or 3)?  ');
   progeny=max(progeny+round(.04*progeny*randn),1);
   total_progeny=total_progeny+progeny;
   
   % user enters first gene
   test=0;
   while (test==0)
      message=sprintf('  What is the first gene in your testcross,  (%s)?  ', genenames);  
      geneone=input(message,'s');
      
      i=1;
      while (test==0)&(i<=number_genes)
         test=strcmp(geneone, geneorder(i));
         if test==1
            index_geneone=i;
         else
            i=i+1;
         end
      end
      
      if (test==0) 
         disp('Invalid gene')
      end
   end
   
      
   % user enters second gene
   test=0;
   while (test==0)
      message=sprintf('  What is the second gene in your testcross, (%s)?  ', genenames);  
      genetwo=input(message,'s');
      
      i=1;
      while (test==0)&(i<=number_genes)
         test=strcmp(genetwo, geneorder(i));
         if test==1
            index_genetwo=i;
         else
            i=i+1;
         end
      end
      if (test==0) 
         disp('Invalid gene')
      end
   end
   
   if pts==2
      experiment=zeros(2,2);
      genethree=[];
      index_genethree=[];
   else
      experiment=zeros(2,2,2);
      % user enters third gene
      test=0;
      while (test==0)
         message=sprintf('  What is the third gene in your testcross,  (%s)?  ', genenames);  
         genethree=input(message,'s');
         
         i=1;
         while (test==0)&(i<=number_genes)
            test=strcmp(genethree, geneorder(i));
            if test==1
               index_genethree=i;
            else
               i=i+1;
            end
         end
         if (test==0) 
            disp('Invalid gene')
         end
      end
   end
   
   
         indices=[index_geneone, index_genetwo, index_genethree];
   
   for i=1:progeny
      crossloc(1) = round(rand);
      probcross = rand(1,5);
      crossloc(2:6) = probcross<gendist;
      
      phenotype = mod(crossloc*T,2);
      observed_phenotype=phenotype(indices)+1;
      if pts==2
         experiment(observed_phenotype(1), observed_phenotype(2))...
            =experiment(observed_phenotype(1),observed_phenotype(2))+1;
      else
         experiment(observed_phenotype(1), observed_phenotype(2), observed_phenotype(3))...
            =experiment(observed_phenotype(1),observed_phenotype(2),observed_phenotype(3))+1;
      end
   end
   
   disp(' ')
   if pts==2
      disp(sprintf('    %s Dominant  / %s Dominant :  %d', geneone, genetwo, experiment(1,1)))
      disp(sprintf('    %s Dominant  / %s recessive:  %d', geneone, genetwo, experiment(1,2)))
      disp(sprintf('    %s recessive / %s Dominant :  %d', geneone, genetwo, experiment(2,1)))
      disp(sprintf('    %s recessive / %s recessive:  %d', geneone, genetwo, experiment(2,2)))
      twocross_count = twocross_count+1;
   end
   
   if pts==3
      disp(sprintf('    %s Dominant  / %s Dominant  / %s Dominant:   %d', geneone, genetwo, genethree, experiment(1,1,1)))
      disp(sprintf('    %s Dominant  / %s Dominant  / %s recessive:  %d', geneone, genetwo, genethree, experiment(1,1,2)))
      disp(sprintf('    %s Dominant  / %s recessive / %s Dominant:   %d', geneone, genetwo, genethree, experiment(1,2,1)))
      disp(sprintf('    %s Dominant  / %s recessive / %s recessive:  %d', geneone, genetwo, genethree, experiment(1,2,2)))
      disp(sprintf('    %s recessive / %s Dominant  / %s Dominant:   %d', geneone, genetwo, genethree, experiment(2,1,1)))
      disp(sprintf('    %s recessive / %s Dominant  / %s recessive:  %d', geneone, genetwo, genethree, experiment(2,1,2)))
      disp(sprintf('    %s recessive / %s recessive / %s Dominant:   %d', geneone, genetwo, genethree, experiment(2,2,1)))
      disp(sprintf('    %s recessive / %s recessive / %s recessive:  %d', geneone, genetwo, genethree, experiment(2,2,2)))
      threecross_count = threecross_count+1;
   end
   
   disp(sprintf('    Total progeny in this experiment:  %d.', progeny))
   disp(' ')
   
   morecrosses=input('Do you want to perform another cross, (Y or N)?  ','s');
   disp(' ')
   if morecrosses==110
      morecrosses=78;
   end
end;

disp(sprintf('   Your lab bred %d progeny in a total of %d two-point crosses and %d three-point crosses.', ...
   total_progeny, twocross_count, threecross_count))

%%%% Answers below %%%%
% Drosophila: Chromosome II: b 48.5 / cn 57.5 / c 75
%             Chromosome III: jv 19.2 / h 26.5
%             Chromosome IV: ci 0
%
% Mouse: Chromosome 8: lgh 5 / adip 32 / rkr 38.5 /scb 57
%        Chromosome 10: jc 32 / hes 43
