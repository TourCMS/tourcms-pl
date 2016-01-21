use tourcms;

sub main
{

	# Configuration

		# API Key (find in your settings)
		my $key = '';
		# Marketplace ID, will be 0 for Tour Operators, non Zero for Agents (find in your settings)
		my $marketId = 0;
		# Channel ID, Operators enter your Channel ID here, Agents can leave as Zero to search all Channels
		# or set a specific Channel to search here
		my $channelId = 0;

	# Search tours as an example

		my $response = &tourcms::search_tours($channelId, $marketId, $key);
		return 1;
}

&main();
