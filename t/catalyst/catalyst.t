use Test::More;

use Test::Mojo::WithRoles 'PSGI';

use File::Spec;
use FindBin;
use lib File::Spec->catdir($FindBin::Bin, 'MyApp', 'lib');

plan( skip_all => 'Tests need Catalyst installed to run' ) unless eval { require 'Catalyst.pm'; };

my $t1 = Test::Mojo::WithRoles->new(File::Spec->catfile('.', 'MyApp', 'myapp.psgi'));

$t1->get_ok("/")->status_is(200);

done_testing;
