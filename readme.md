# Sample Perl code for the TourCMS API

Proof of concept code handling calling the TourCMS API with a properly formed signature. Sample code includes calling the [Search API](http://www.tourcms.com/support/api/mp/tour_search.php) as either an Operator or Agent.

## Instructions

1. Copy `main.pl` and `tourcms.pm` to a directory somewhere
2. Edit `main.pl`, entering your TourCMS API credentials into the `main` sub
3. Run `perl main.pl`
4. The sample code will call the Search API, dump the response and die

## Troubleshooting

### SSL Warnings

If your Perl environment is not correctly verifying SSL certificates install [Mozilla::CA](http://search.cpan.org/~abh/Mozilla-CA-20160104/lib/Mozilla/CA.pm) to get the latest Mozilla Certificate Authority bundle, LWP will use it automatically.
