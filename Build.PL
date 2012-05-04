
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Command-line driver for Pinto",
  "dist_author" => [
    "Jeffrey Thalhammer <jeff\@imaginative-software.com>"
  ],
  "dist_name" => "App-Pinto",
  "dist_version" => "0.040_02",
  "license" => "perl",
  "module_name" => "App::Pinto",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "App::Cmd::Setup" => 0,
    "Class::Load" => 0,
    "List::Util" => 0,
    "Log::Dispatch::Screen" => 0,
    "Log::Dispatch::Screen::Color" => 0,
    "Pinto::Constants" => 0,
    "Pod::Usage" => 0,
    "base" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/pinto"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
