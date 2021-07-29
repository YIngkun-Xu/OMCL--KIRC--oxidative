###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056
use strict;
use warnings;

my %hash=();

#读取临床文件，并保存到hash里面
open(RF,"clinical.txt") or die $!;
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	my $sample=shift(@arr);
	if($.==1){
		$hash{"id"}=join("\t",@arr);
		next;
	}
	$hash{$sample}=join("\t",@arr);
}
close(RF);

open(RF,"lassoRisk.txt") or die $!;
open(GROUP,">riskCliGroup.txt") or die $!;
print GROUP "id\t" . $hash{"id"} . "\tRisk\n";
open(WF,">riskCliExp.txt") or die $!;
my @indexArr=();
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	my $sample=shift(@arr);
	if($.==1){
			print WF $sample;
			for(my $i=2;$i<=($#arr-2);$i++){
				  print WF "\t" . $arr[$i];
			}
			print WF "\n";
			next;
  }
	elsif(exists $hash{$sample}){
			print WF $sample;
			for(my $i=2;$i<=($#arr-2);$i++){
					print WF "\t" . $arr[$i];
			}
			print WF "\n";
			print GROUP $sample . "\t" . $hash{$sample} . "\t" . $arr[$#arr] . "\n";
	}
}
close(GROUP);
close(WF);
close(RF);

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056