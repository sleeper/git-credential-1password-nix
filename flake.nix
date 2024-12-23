{
  description = "Flake for git-credential-1password";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";  # Using nixpkgs as an input
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = {
          default = pkgs.buildGoModule {
            pname = "git-credential-1password";            # Name of your program
            version = "1.0.0";                  # Version of your program

            # Specify the source of your program: GitHub repo
            src = pkgs.fetchFromGitHub {
              owner = "ethrgeist";   # Replace with your GitHub username
              repo = "git-credential-1password";          # Replace with the repository name
              rev = "v1.0.0";            # Replace with the specific commit or tag
              sha256 = "sha256-pNZ6ZzD6rE/GgwM7gNRyVyrYlZetMFI/d9m4R2CRuNY=";  # Replace with the sha256 hash of the repo
            };

            # Optional: Set Go-specific settings if necessary
            vendorHash = null;                # If you're not using vendored dependencies
            subPackages = [ "." ];              # If your main package is in the root directory

            # Optional: Meta information for the package
            meta = with nixpkgs.lib; {
              description = "A Git credential helper that utilizes the 1Password CLI to authenticate a Git over http(s) connection.";
              license = licenses.mit;           # Set the correct license for your program
              platforms = platforms.all;        # Platforms where this package can be built
            };
          };
        };
      }
    );
}

