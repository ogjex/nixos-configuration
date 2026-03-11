{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		mangowc = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, mango, ... }: {
		nixosConfigurations.nixos-work = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
			   ./configuration.nix
			   mango.nixosModules.default
			];
		};
	};
}
