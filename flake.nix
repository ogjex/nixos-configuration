{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		mangowc = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, mangowm, ... }@inputs: let
		inherit (nixpkgs) lib;
		# ...
	in {
		nixosConfigurations.nixos-work = nixpkgs.lib.nixosSystem {
			modules = [
				mangowm.nixosModules.mango
				# other imports
			];
		};
	};
}
