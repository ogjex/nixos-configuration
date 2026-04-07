{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		mangowm = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
	};

	outputs = { self, nixpkgs, mangowm, ... } @ inputs: 
	let
		inherit (nixpkgs) lib;
		# ...
	in {
		nixosConfigurations.nixos-work = lib.nixosSystem {
			modules = [
				inputs.mangowm.nixosModules.mango
				#mangowm.nixosModules.mango
				./configuration.nix
				./hardware-configuration.nix
				# other imports
			];
		};
	};
}
