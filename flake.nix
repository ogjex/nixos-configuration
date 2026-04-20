{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		mangowm = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = { 
		    url = "github:nix-community/nixvim";
		    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of Nixvim.
		    # url = "github:nix-community/nixvim/nixos-25.11";
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
				inputs.nixvim.nixosModules.nixvim
				./configuration.nix
				# other imports
			];
		};
	};
}
