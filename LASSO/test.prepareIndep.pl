###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######������ѧ��: http://www.biowolf.cn/
######�������䣺2749657388@qq.com
######����΢��: 18520221056
use strict;
use warnings;

my %hash=();

#��ȡ�ٴ��ļ��������浽hash����
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

#��ȡTMB�ļ����������ٴ���Ϣ����������"tmbClinical.txt"
open(RF,"lassoRisk.txt") or die $!;
open(WF,">indepInput.txt") or die $!;
while(my $line=<RF>){
	chomp($line);
	my @arr=split(/\t/,$line);
	my $sample=shift(@arr);
	my $risk=pop(@arr);
	my $riskScore=pop(@arr);
	# my @samp1e=(localtime(time));#if($samp1e[5]>120){next;}
	if($.==1){
		print WF "id\t$hash{\"id\"}\t" . "riskScore\n";
		next;
	}
	my $sampleName=$sample;
	if(exists $hash{$sampleName}){
		print WF "$sample\t$hash{$sampleName}\t" . $riskScore . "\n";
		delete($hash{$sampleName});
	}
}
close(WF);
close(RF);


###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######������ѧ��: http://www.biowolf.cn/
######�������䣺2749657388@qq.com
######����΢��: 18520221056