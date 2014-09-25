package nvstats;
use stringManip;

#
# =====================================
#  | NVIDIA Linux Statistics Library |
# =====================================
#
# Copyright Taylor Networks 2014
# Licensed under the GNU General Public License
# 

our @ISA= qw( Exporter );

our @EXPORT_OK = qw( nvQuery nvTotalMemory nvUsedMemory nvUsedMemoryPercentage nvGraphicsUtilization nvVideoEngineUtilization nvDriverVersion nvCoreTemp );

our @EXPORT = qw( nvQuery nvTotalMemory nvUsedMemory nvUsedMemoryPercentage nvGraphicsUtilization nvVideoEngineUtilization nvDriverVersion nvCoreTemp );

our $VERSION = 1.0;

sub stripNvResponse
{
	my $retval = -1;
	my $string = $_[0];
	my $index = index($string, "):");

	if($index != -1)
	{
		$string = right($string, $index+2);

		$index = index($string,".\n");

		if($index != -1)
		{
			$string = left($string, $index);
		}
		else
		{
			$index = index($string,"\n");
			$string = left($string, $index);
		}
		
		
		$retval = $string;
	}

	return $retval;
}

sub nvQuery
{
	my $retval = -1;
	my $query = $_[0];

	if($query)
	{
		my $response = `nvidia-settings -q ${query}`;
		$retval = stripNvResponse($response);
	}
	
	return $retval;
}

sub nvTotalMemory
{
	return nvQuery("[gpu:0]/TotalDedicatedGPUMemory");
}

sub nvUsedMemory
{
	return nvQuery("[gpu:0]/UsedDedicatedGPUMemory");
}

sub nvUsedMemoryPercentage
{
	my $used = nvUsedMemory();
	my $total = nvTotalMemory();
	my $scale = $used/$total;

	return $scale * 100;
}

sub nvGpuUtilParser
{
	my $response = nvQuery("[gpu:0]/GPUUtilization").",";
	my $searchString = $_[0];

	my $index = index($response, $searchString)-1;
	my $retval = right($response, $index);

	$index = index($retval, ",");
	$retval = left($retval, $index);

	$index = index($retval, $searchString) + length($searchString)-1;
	$retval = right($retval, $index);

	return $retval
}

sub nvGraphicsUtilization
{
	my $searchString = "graphics=";

	return nvGpuUtilParser($searchString);
}

sub nvVideoEngineUtilization
{
	return nvQuery("[gpu:0]/VideoDecoderUtilization");
}

sub nvDriverVersion
{
	return nvQuery("NvidiaDriverVersion");
}

sub nvCoreTemp
{
	return nvQuery("GPUCoreTemp");
}
