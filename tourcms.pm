package tourcms;

use strict;
use POSIX 'strftime';
use LWP::UserAgent;
use LWP::Simple;
use Digest::SHA qw(hmac_sha256_base64);
use URI::Escape;
use HTTP::Date;
use Carp;

use Data::Dump qw(dump);
use Data::Dumper;



# TourCMS API signature generation sub
# $path, $verb, $channelId, $marketId, $key, $outboundTime
sub generate_signature
{
	# $path, $verb, $channel, $marketplace, $key, $outbound_time
	my $stringToSign = $_[2] ."/". $_[3] ."/". $_[1] ."/". $_[5] . $_[0];
	my $hash = hmac_sha256_base64($stringToSign, $_[4]);
	# Fix padding of Base64 digests
	while (length($hash) % 4) {
		$hash .= '=';
	}
	my $signature = uri_escape($hash);
	return $signature;
}

# Generic TourCMS API call sub
# $path, $verb, $channelId, $marketId, $key
sub tourcms_api_call
{
	my ($self) = @_;
	my $verb = $_[1];
	my $marketId = $_[3];
	my $channelId = $_[2];
	my $path = $_[0];
	my $vendor_url = 'https://api.tourcms.com';
	my $url = $vendor_url. $path;
	my $key = $_[4];

	my $outBoundTime = time;
	my $gmtOutBoundTime = time2str(time);

	my $signature = &generate_signature($path, $verb, $channelId, $marketId, $key, $outBoundTime);

	my $request = HTTP::Request->new(GET => $url);
	$request->header('authorization' =>  'TourCMS '.$channelId .":". $marketId .":".$signature);
	$request->header('date' => $gmtOutBoundTime);
	$request->header('content-Type' => 'application/xml');
	$request->header('charset' => 'utf-8');

	my $ua = new LWP::UserAgent;
	my $response = $ua->request($request) ;
	die dump($response);
	return ($response);
}

# Search API wrapper sub
# $channelId, $marketId, $key
sub search_tours
{
	# Set the API path
	# If channelId is zero use the /p/ path
	my $path = '';
	if($_[0] == 0) {
		$path = '/p/tours/search.xml';
	} else {
		$path = '/c/tours/search.xml';
	}

	# Call the API
	my $response = tourcms_api_call($path, 'GET', $_[0], $_[1], $_[2]);
	return $response;
}

1;
