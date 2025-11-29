{
  pkgs,
  pythonPkgs,
  fetchFromGitHub,
}:
pythonPkgs.buildPythonPackage rec {

  pname = "beet";
  version = "0.112.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mcbeet";
    repo = "beet";
    rev = "v${version}";
    hash = "sha256-NfYOxS1UAgrFrYGD4QSC80/LJN9WplA//DIvQEgJ9ZM=";
  };

  nativeBuildInputs = with pythonPkgs; [
    wheel
    poetry-core
  ];

  propagatedBuildInputs = with pythonPkgs; [
    toml
    click
    pyyaml
    jinja2
    nbtlib
    pathspec
    pydantic
    click-help-colors
    typing-extensions
  ];

  preferWheel = true;

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'requires = ["poetry>=0.12"]' 'requires = ["poetry-core>=1.0.0"]' \
      --replace-fail 'build-backend = "poetry.masonry.api"' 'build-backend = "poetry.core.masonry.api"'
  '';

  pythonRelaxDeps = [
    "nbtlib"
    "pathspec"
  ];

  meta = {
    description = "The Minecraft pack development kit.";
    homepage = "https://mcbeet.dev/";
    license = pkgs.lib.licenses.mit;
    mainProgram = "beet";
  };
}
