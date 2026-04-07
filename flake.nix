{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		mangowm = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
	};

	outputs = { nixpkgs, ... } @ inputs: 
	let
	in {
		nixosConfigurations.nixos-work = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				# renaming mangowm to mango
				inputs.mangowm.nixosModules.mango
				./configuration.nix
				# other imports
			];
		};
	};
}
