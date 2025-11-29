{
  pkgs,
  beet,
  mecha,
  pythonPkgs,
  fetchFromGitHub,
}:
pythonPkgs.buildPythonPackage rec {

  pname = "bolt";
  version = "0.49.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mcbeet";
    repo = "bolt";
    rev = "v${version}";
    hash = "sha256-kJgZVwMZ1Z50KSYFA16SF3zMpGgYbX3ryFgYTso+JUM=";
  };

  nativeBuildInputs = with pythonPkgs; [
    poetry-core
  ];

  propagatedBuildInputs = [
    beet
    mecha
  ];

  meta = {
    description = "Supercharge Minecraft commands with Python";
    homepage = "https://github.com/mcbeet/bolt";
    license = pkgs.lib.licenses.mit;
    mainProgram = "bolt";
  };
}
