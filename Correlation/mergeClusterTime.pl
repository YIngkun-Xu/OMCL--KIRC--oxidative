###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######������ѧ��: http://www.biowolf.cn/
######�������䣺2749657388@qq.com
######����΢��: 18520221056
use strict;
use warnings;

my %hash=();

#��ȡ�ٴ��ļ��������浽hash����
open(RF,"time.txt") or die $!;
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

#��ȡ�����ļ����������ٴ���Ϣ����������"immuneClinical.txt"
open(RF,"cluster.txt") or die $!;
open(WF,">clusterTime.txt") or die $!;
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	my $sample=shift(@arr);
	#my $RMSE=pop(@arr);
	#my $Correlation=pop(@arr);
	#my $Pvalue=pop(@arr);
	#my @samp1e=(localtime(time));if($samp1e[5]>119){next;}
	if($.==1){
		print WF "id\t$hash{\"id\"}\t" . "cluster\n";
	}
	my @sampleArr=split(/\-/,$sample);
	if($sampleArr[3]=~/^0/){
		my $sampleName="$sampleArr[0]-$sampleArr[1]-$sampleArr[2]";
		if(exists $hash{$sampleName}){
			print WF "$sample\t$hash{$sampleName}\t" . join("\t",@arr) . "\n";
			delete($hash{$sampleName});
		}
  }
}
close(WF);
close(RF);

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######������ѧ��: http://www.biowolf.cn/
######�������䣺2749657388@qq.com
######����΢��: 18520221056