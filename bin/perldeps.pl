#!/usr/bin/perl -w
#
# Facilitate Perl Module installation
# Arguments: 
#    test    - Show lis of installed and missing modules
#    install - Try to install missing modules using the CPAN
#
use strict;
use CPAN;

my $action = $ARGV[0] 
    or die "Missing required argument: action";

my @DEPS = (
    'CGI 3.20' ,
    'Ima::DBI 0.35' ,
    'Class::DBI 3.0.10' ,
    'Class::DBI::AbstractSearch' ,
    'Apache2::Request'  ,
    'HTML::Mason 1.31' ,
    'Apache::Session 1.6' ,
    'Apache::DBI' ,
    'URI::Escape' ,
    'DBIx::DataSource' ,
    'GraphViz 2.02' ,
    'SQL::Translator 0.07' ,
    'SNMP::Info' ,
    'NetAddr::IP' ,
    'Apache2::SiteControl 1.0' ,
    'Log::Dispatch' ,
    'Log::Log4perl' ,
    'Parallel::ForkManager' ,
    'Net::IPTrie' ,
    'Authen::Radius' ,
    'RRDs' ,
    'Test::More' ,
    'Test::Harness' ,
    'Net::IRR',
    );

if ( $action eq 'test' ){
    foreach my $module ( @DEPS ){
	eval "use $module";
	print $module, "................";
	if ( $@ ){
	    print "MISSING";
	}else{
	    print "installed"
	}
	print "\n";
    }
}

elsif ( $action eq 'install' ){
    $CPAN::Config->{prerequisites_policy} = 'follow';
    foreach my $module ( @DEPS ){
	eval "use $module";	
	if ( $@ ){
	    eval {
		CPAN::Shell->install($module);
	    };
	    if ( my $e = $@ ){
		print $e;
	    }
	}
    }
}