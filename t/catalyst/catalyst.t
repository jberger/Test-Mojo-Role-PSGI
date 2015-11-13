use Test::More;

use Test::Mojo::WithRoles 'PSGI';

use FindBin;
use lib "$FindBin::Bin/MyApp/lib";

plan( skip_all => 'Tests need Catalyst installed to run' ) unless eval { require 'Catalyst.pm'; };

my $t1 = Test::Mojo::WithRoles->new('./MyApp/myapp.psgi');

$t1->get_ok("/")->status_is(200);

done_testing;
