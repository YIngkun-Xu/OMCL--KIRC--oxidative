###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056
use strict;
use warnings;

######Usage: perl prepareGSEA.pl VCAN

my $colNum=0;
my $rowNum=0;
my %hash=();
my $geneName=$ARGV[0];
my @indexs=();
my @geneArr=();

open(RF,"uniq.symbol.txt") or die $!;
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	if($.==1){
		for(my $i=1;$i<=$#arr;$i++){
			my @samples=split(/\-/,$arr[$i]);
			if($samples[3]=~/^0/){
			  push(@indexs,$i);
			  my $sampleName=$arr[$i];
			  $hash{$sampleName}=1;
			  $colNum++;
			}
		}
	}
	else{
			$rowNum++;
		  if($arr[0] eq $geneName){
			  foreach my $col(@indexs){
				  push(@geneArr,$arr[$col]);
			  }
		  }
	}
}
close(RF);

my $firstGeneVal=$geneArr[0];
my $geneMed=median(@geneArr);

open(RF,"uniq.symbol.txt") or die $!;
open(WF,">$geneName.gct") or die $!;
print WF "#1.2\n";
print WF "$rowNum\t$colNum\n";
open(CLS,">$geneName.cls") or die $!;
print CLS "$colNum\t2\t1\n";
#my @samp1e=(localtime(time));
if($firstGeneVal>$geneMed){
	print CLS "#\tl\th\n";
}
else{
	#if($samp1e[5]>119){next;}
	print CLS "#\th\tl\n";
}

@indexs=();
my @typeArr=();
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	if($.==1){
		print WF "NAME\tDESCRIPTION";
		#if($samp1e[4]>13){next;}
		for(my $i=1;$i<=$#arr;$i++){
			my @samples=split(/\-/,$arr[$i]);
			if($samples[3]=~/^0/){
			  my $sampleName=$arr[$i];
			  if(exists $hash{$sampleName}){
				  push(@indexs,$i);
				  print WF "\t$arr[$i]";
				  #delete($hash{$sampleName});
			  }
			}
		}
		print WF "\n";
	}
	else{
		my $symbolName=$arr[0];
		$symbolName=~s/(.+?)\|.+/$1/g;
		print WF "$symbolName\tna";
		foreach my $col(@indexs){
			print WF "\t$arr[$col]";
		}
			print WF "\n";
		if($arr[0] eq $geneName){
			foreach my $col(@indexs){
				if($arr[$col]>$geneMed){
				  push(@typeArr,"h");
			  }
			  else{
			  	push(@typeArr,"l");
			  }
			}
		}
	}
}
print CLS join("\t",@typeArr) . "\n";
close(WF);
close(CLS);
close(RF);

sub median{  
    my (@data) = sort {$a <=> $b} @_;  #将原数组重新排序  
    if(scalar (@data) % 2){  
        return ($data [@data / 2]);  #@data/2的返回值向上取整  
    }else {  
        my ($upper ,$lower);  
        $upper = $data[@data / 2];  
        $lower = $data[@data / 2 -1];  
        return (($lower+$upper) / 2);  
    }  
}  

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056
