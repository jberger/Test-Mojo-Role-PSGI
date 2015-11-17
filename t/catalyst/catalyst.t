use Test::More;

use strict;
use warnings;

use Test::Mojo::WithRoles 'PSGI';
use Mojo::JSON;

use File::Spec;
use FindBin;

push @INC, File::Spec->catdir($FindBin::Bin, 'MyApp', 'lib');

plan( skip_all => 'Tests need Catalyst installed to run' ) unless eval { require Catalyst; };
plan( skip_all => 'Tests need Catalyst::Action::RenderView installed to run' ) unless eval { require Catalyst::Action::RenderView };

my $t = Test::Mojo::WithRoles->new(File::Spec->catfile($FindBin::Bin, 'MyApp', 'myapp.psgi'));
$t->get_ok("/")->status_is(200);

my $json = '{"foo":1}';
$t->post_ok("/" => {} => json => Mojo::JSON::decode_json($json) );

is($t->tx->res->body, $json, 'JSON comes back correctly');

done_testing;
