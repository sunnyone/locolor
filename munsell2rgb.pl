use Color::Model::Munsell;
use Color::Model::Munsell::Util;
use Color::Model::RGB;

print <<EOL;
<?xml version="1.0" encoding="UTF-8"?>
<ooo:color-table xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:svg="http://www.w3.org/2000/svg" xmlns:ooo="http://openoffice.org/2004/office">
EOL

%special_table = (Black => "000000", White => "ffffff");
%prefix_count = ();

while (<>) {
  chomp;
  my $name = $mun = $_;
  
  if ($mun =~ /^(.*?) /) {
    $prefix = $1;
    $count = ++$prefix_count{$prefix};
    $name = "$prefix\[$count\] ($mun)";
  }

  my $rgb;
  if ($special_table{$mun}) {
     $rgb = $special_table{$mun};
  } else {
     my $m = Color::Model::Munsell->new($mun);
     $rgb = Munsell2RGB($m, "sRGB");
  }

  printf("<draw:color draw:name=\"%s\" draw:color=\"#%s\" />\n", $name, $rgb);
}

print <<EOL;
</ooo:color-table>
EOL

# sample
#printf("Black(RGB),#000000\n");
#printf("White(RGB),#ffffff\n");
#my $m = Color::Model::Munsell->new("4R 4.5/14");
#printf("Munsell: %s = RGB: #%s\n", $m, Munsell2RGB($m, "AdobeRGB"), #2.0);
