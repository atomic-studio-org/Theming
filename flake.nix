{
  description = "Theming and Branding for Atomic Studio";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt-rfc-style);      

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [ go-task melange apko inputs.self.packages.${pkgs.system}.gen-xml ];
        };
      });

      packages = forEachSupportedSystem ({ pkgs }: rec {
        default = gen-xml;
      
        gen-xml = pkgs.writers.writeNuBin "gen-xml" ''
        def get_dominant_color [image_path: string] {
          ${pkgs.imagemagick}/bin/convert $image_path -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: | sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' | ${pkgs.coreutils}/bin/sort -r -n -k 1 -t ","
        }
        
        # Generate XML metadata files for wallpapers from specified image files
        # Sample usage: "script" /usr/share/backgrounds atomic-studio-org ./src/wallpapers/xe/**/assets/*
        def main [
          --out (-o): string # Directory where xml files will be written to
          bg_dir: string # Root directory for backgrounds
          vendor: string # Vendor (separate directory) for backgrounds
          artist: string # Artist (separate directory) for backgrounds
          ...wallpapers: string # Specified wallpaper files (should support imagemagick convert)
        ] {
          let data = $wallpapers | par-each {|e| {filename: $"($e | path basename | split column "." | get 0 | get column1).xml", xml: $"<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>($e | path basename | split words | get 0 | str replace --all "-" "" | str capitalize)</name>
    <filename>($bg_dir)/($vendor)/($artist)/($e | path basename)</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>(get_dominant_color $e | lines | get 0 | split column ',' | get column2 | str join)</pcolor>
    <scolor>(get_dominant_color $e | lines | get 1 | split column ',' | get column2 | str join)</scolor>
  </wallpaper>
</wallpapers>"}
          }

          mkdir $out
          
          $data | each {|e| $e.xml | save $"($out)/($e.filename)" }
        }
      '';
      });    
    };
}
