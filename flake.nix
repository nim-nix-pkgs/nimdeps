{
  description = ''Nim library to bundle dependency files into executable'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimdeps-master".dir   = "master";
  inputs."nimdeps-master".owner = "nim-nix-pkgs";
  inputs."nimdeps-master".ref   = "master";
  inputs."nimdeps-master".repo  = "nimdeps";
  inputs."nimdeps-master".type  = "github";
  inputs."nimdeps-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimdeps-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}