local api = vim.api

local M = {}

---@private
local function starsetf(ft)
  return {function(path)
    if not vim.g.fg_ignore_pat then
      return ft
    end

    local re = vim.regex(vim.g.fg_ignore_pat)
    if re:match_str(path) then
      return ft
    end
  end, {
    -- Starset matches should always have lowest priority
    priority = -math.huge,
  }}
end

---@private
local function getline(bufnr, start_lnum, end_lnum)
  end_lnum = end_lnum or start_lnum
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_lnum - 1, end_lnum, false)
  return table.concat(lines) or ""
end

-- Filetypes based on file extension
-- luacheck: push no unused args
---@diagnostic disable: unused-local
local extension = {
  -- BEGIN EXTENSION
  ["8th"] = "8th",
  ["a65"] = "a65",
  aap = "aap",
  abap = "abap",
  abc = "abc",
  abl = "abel",
  wrm = "acedb",
  ads = "ada",
  ada = "ada",
  gpr = "ada",
  adb = "ada",
  tdf = "ahdl",
  aidl = "aidl",
  aml = "aml",
  run = "ampl",
  scpt = "applescript",
  ino = "arduino",
  pde = "arduino",
  art = "art",
  asciidoc = "asciidoc",
  adoc = "asciidoc",
  asa = function(path, bufnr)
    if vim.g.filetype_asa then
      return vim.g.filetype_asa
    else
      return "aspvbs"
    end
  end,
  ["asn1"] = "asn",
  asn = "asn",
  asp = function(path, bufnr)
    if vim.g.filetype_asp then
      return vim.g.filetype_asp
    elseif getline(bufnr, 1, 3):find("perlscript") then
       return "aspperl"
    else
      return "aspvbs"
    end
  end,
  atl = "atlas",
  as = "atlas",
  ahk = "autohotkey",
  ["au3"] = "autoit",
  ave = "ave",
  gawk = "awk",
  awk = "awk",
  ref = "b",
  imp = "b",
  mch = "b",
  bc = "bc",
  bdf = "bdf",
  beancount = "beancount",
  bib = "bib",
  bicep = "bicep",
  bl = "blank",
  bsdl = "bsdl",
  bst = "bst",
  bzl = "bzl",
  bazel = "bzl",
  BUILD = "bzl",
  qc = "c",
  cabal = "cabal",
  cdl = "cdl",
  toc = "cdrtoc",
  cfc = "cf",
  cfm = "cf",
  cfi = "cf",
  hgrc = "cfg",
  chf = "ch",
  chai = "chaiscript",
  chs = "chaskell",
  chopro = "chordpro",
  crd = "chordpro",
  crdpro = "chordpro",
  cho = "chordpro",
  chordpro = "chordpro",
  eni = "cl",
  icl = "clean",
  cljx = "clojure",
  clj = "clojure",
  cljc = "clojure",
  cljs = "clojure",
  cook = "cook",
  cmake = "cmake",
  cmod = "cmod",
  lib = "cobol",
  cob = "cobol",
  cbl = "cobol",
  atg = "coco",
  recipe = "conaryrecipe",
  hook = function(path, bufnr)
    if getline(bufnr, 1) == '[Trigger]' then
      return "conf"
    end
  end,
  mklx = "context",
  mkiv = "context",
  mkii = "context",
  mkxl = "context",
  mkvi = "context",
  moc = "cpp",
  hh = "cpp",
  tlh = "cpp",
  inl = "cpp",
  ipp = "cpp",
  ["c++"] = "cpp",
  C = "cpp",
  cxx = "cpp",
  H = "cpp",
  tcc = "cpp",
  hxx = "cpp",
  hpp = "cpp",
  cpp = function(path, bufnr)
    if vim.g.cynlib_syntax_for_cpp then
      return "cynlib"
    end
    return "cpp"
  end,
  cc = function(path, bufnr)
    if vim.g.cynlib_syntax_for_cc then
      return "cynlib"
    end
    return "cpp"
  end,
  crm = "crm",
  csx = "cs",
  cs = "cs",
  csc = "csc",
  csdl = "csdl",
  cshtml = "html",
  fdr = "csp",
  csp = "csp",
  css = "css",
  con = "cterm",
  feature = "cucumber",
  cuh = "cuda",
  cu = "cuda",
  pld = "cupl",
  si = "cuplsim",
  cyn = "cynpp",
  dart = "dart",
  drt = "dart",
  ds = "datascript",
  dcd = "dcd",
  def = "def",
  desc = "desc",
  directory = "desktop",
  desktop = "desktop",
  diff = "diff",
  rej = "diff",
  Dockerfile = "dockerfile",
  bat = "dosbatch",
  wrap = "dosini",
  ini = "dosini",
  dot = "dot",
  gv = "dot",
  drac = "dracula",
  drc = "dracula",
  dtd = "dtd",
  dts = "dts",
  dtsi = "dts",
  dylan = "dylan",
  intr = "dylanintr",
  lid = "dylanlid",
  ecd = "ecd",
  eex = "eelixir",
  leex = "eelixir",
  exs = "elixir",
  elm = "elm",
  elv = "elvish",
  epp = "epuppet",
  erl = "erlang",
  hrl = "erlang",
  yaws = "erlang",
  erb = "eruby",
  rhtml = "eruby",
  ec = "esqlc",
  EC = "esqlc",
  strl = "esterel",
  exp = "expect",
  factor = "factor",
  fal = "falcon",
  fan = "fan",
  fwt = "fan",
  fnl = "fennel",
  ["m4gl"] = "fgl",
  ["4gl"] = "fgl",
  ["4gh"] = "fgl",
  fish = "fish",
  focexec = "focexec",
  fex = "focexec",
  fth = "forth",
  ft = "forth",
  FOR = "fortran",
  ["f77"] = "fortran",
  ["f03"] = "fortran",
  fortran = "fortran",
  ["F95"] = "fortran",
  ["f90"] = "fortran",
  ["F03"] = "fortran",
  fpp = "fortran",
  FTN = "fortran",
  ftn = "fortran",
  ["for"] = "fortran",
  ["F90"] = "fortran",
  ["F77"] = "fortran",
  ["f95"] = "fortran",
  FPP = "fortran",
  f = "fortran",
  F = "fortran",
  ["F08"] = "fortran",
  ["f08"] = "fortran",
  fpc = "fpcmake",
  fsl = "framescript",
  fb = "freebasic",
  fsi = "fsharp",
  fsx = "fsharp",
  fusion = "fusion",
  gdb = "gdb",
  gdmo = "gdmo",
  mo = "gdmo",
  tres = "gdresource",
  tscn = "gdresource",
  gd = "gdscript",
  ged = "gedcom",
  gmi = "gemtext",
  gemini = "gemtext",
  gift = "gift",
  gleam = "gleam",
  glsl = "glsl",
  gpi = "gnuplot",
  gnuplot = "gnuplot",
  go = "go",
  gp = "gp",
  gs = "grads",
  gql = "graphql",
  graphql = "graphql",
  graphqls = "graphql",
  gretl = "gretl",
  gradle = "groovy",
  groovy = "groovy",
  gsp = "gsp",
  gjs = "javascript.glimmer",
  gts = "typescript.glimmer",
  hack = "hack",
  hackpartial = "hack",
  haml = "haml",
  hsm = "hamster",
  hbs = "handlebars",
  ["hs-boot"] = "haskell",
  hsig = "haskell",
  hsc = "haskell",
  hs = "haskell",
  ht = "haste",
  htpp = "hastepreproc",
  hb = "hb",
  sum = "hercules",
  errsum = "hercules",
  ev = "hercules",
  vc = "hercules",
  hcl = "hcl",
  heex = "heex",
  hex = "hex",
  ["h32"] = "hex",
  hjson = "hjson",
  hog = "hog",
  hws = "hollywood",
  htt = "httest",
  htb = "httest",
  iba = "ibasic",
  ibi = "ibasic",
  icn = "icon",
  inf = "inform",
  INF = "inform",
  ii = "initng",
  iss = "iss",
  mst = "ist",
  ist = "ist",
  ijs = "j",
  JAL = "jal",
  jal = "jal",
  jpr = "jam",
  jpl = "jam",
  jav = "java",
  java = "java",
  jj = "javacc",
  jjt = "javacc",
  es = "javascript",
  mjs = "javascript",
  javascript = "javascript",
  js = "javascript",
  cjs = "javascript",
  jsx = "javascriptreact",
  clp = "jess",
  jgr = "jgraph",
  ["j73"] = "jovial",
  jov = "jovial",
  jovial = "jovial",
  properties = "jproperties",
  slnf = "json",
  json = "json",
  jsonp = "json",
  webmanifest = "json",
  ipynb = "json",
  ["json-patch"] = "json",
  json5 = "json5",
  jsonc = "jsonc",
  jsp = "jsp",
  jl = "julia",
  kv = "kivy",
  kix = "kix",
  kts = "kotlin",
  kt = "kotlin",
  ktm = "kotlin",
  ks = "kscript",
  k = "kwt",
  ACE = "lace",
  ace = "lace",
  latte = "latte",
  lte = "latte",
  ld = "ld",
  ldif = "ldif",
  journal = "ledger",
  ldg = "ledger",
  ledger = "ledger",
  less = "less",
  lex = "lex",
  lxx = "lex",
  ["l++"] = "lex",
  l = "lex",
  lhs = "lhaskell",
  ll = "lifelines",
  ly = "lilypond",
  ily = "lilypond",
  liquid = "liquid",
  cl = "lisp",
  L = "lisp",
  lisp = "lisp",
  el = "lisp",
  lsp = "lisp",
  asd = "lisp",
  lt = "lite",
  lite = "lite",
  lgt = "logtalk",
  lotos = "lotos",
  lot = "lotos",
  lout = "lout",
  lou = "lout",
  ulpc = "lpc",
  lpc = "lpc",
  sig = "lprolog",
  lsl = "lsl",
  lss = "lss",
  nse = "lua",
  rockspec = "lua",
  lua = "lua",
  quake = "m3quake",
  at = "m4",
  eml = "mail",
  mk = "make",
  mak = "make",
  dsp = "make",
  page = "mallard",
  map = "map",
  mws = "maple",
  mpl = "maple",
  mv = "maple",
  mkdn = "markdown",
  md = "markdown",
  mdwn = "markdown",
  mkd = "markdown",
  markdown = "markdown",
  mdown = "markdown",
  mhtml = "mason",
  comp = "mason",
  mason = "mason",
  master = "master",
  mas = "master",
  demo = "maxima",
  dm1 = "maxima",
  dm2 = "maxima",
  dm3 = "maxima",
  dmt = "maxima",
  wxm = "maxima",
  mel = "mel",
  mf = "mf",
  mgl = "mgl",
  mgp = "mgp",
  my = "mib",
  mib = "mib",
  mix = "mix",
  mixal = "mix",
  nb = "mma",
  mmp = "mmp",
  DEF = "modula2",
  ["m2"] = "modula2",
  mi = "modula2",
  ssc = "monk",
  monk = "monk",
  tsc = "monk",
  isc = "monk",
  moo = "moo",
  mp = "mp",
  mof = "msidl",
  odl = "msidl",
  msql = "msql",
  mu = "mupad",
  mush = "mush",
  mysql = "mysql",
  ["n1ql"] = "n1ql",
  nql = "n1ql",
  nanorc = "nanorc",
  ncf = "ncf",
  nginx = "nginx",
  ninja = "ninja",
  nix = "nix",
  nqc = "nqc",
  roff = "nroff",
  tmac = "nroff",
  man = "nroff",
  mom = "nroff",
  nr = "nroff",
  tr = "nroff",
  nsi = "nsis",
  nsh = "nsis",
  obj = "obj",
  mlt = "ocaml",
  mly = "ocaml",
  mll = "ocaml",
  mlp = "ocaml",
  mlip = "ocaml",
  mli = "ocaml",
  ml = "ocaml",
  occ = "occam",
  xom = "omnimark",
  xin = "omnimark",
  opam = "opam",
  ["or"] = "openroad",
  scad = "openscad",
  ora = "ora",
  org = "org",
  org_archive = "org",
  pxsl = "papp",
  papp = "papp",
  pxml = "papp",
  pas = "pascal",
  lpr = "pascal",
  dpr = "pascal",
  pbtxt = "pbtxt",
  g = "pccts",
  pcmk = "pcmk",
  pdf = "pdf",
  plx = "perl",
  prisma = "prisma",
  psgi = "perl",
  al = "perl",
  ctp = "php",
  php = "php",
  phpt = "php",
  phtml = "php",
  pike = "pike",
  pmod = "pike",
  rcp = "pilrc",
  pli = "pli",
  ["pl1"] = "pli",
  ["p36"] = "plm",
  plm = "plm",
  pac = "plm",
  plp = "plp",
  pls = "plsql",
  plsql = "plsql",
  po = "po",
  pot = "po",
  pod = "pod",
  pk = "poke",
  ps = "postscr",
  epsi = "postscr",
  afm = "postscr",
  epsf = "postscr",
  eps = "postscr",
  pfa = "postscr",
  ai = "postscr",
  pov = "pov",
  ppd = "ppd",
  it = "ppwiz",
  ih = "ppwiz",
  action = "privoxy",
  pc = "proc",
  pdb = "prolog",
  pml = "promela",
  proto = "proto",
  ["psd1"] = "ps1",
  ["psm1"] = "ps1",
  ["ps1"] = "ps1",
  pssc = "ps1",
  ["ps1xml"] = "ps1xml",
  psf = "psf",
  psl = "psl",
  pug = "pug",
  arr = "pyret",
  pxd = "pyrex",
  pyx = "pyrex",
  pyw = "python",
  py = "python",
  pyi = "python",
  ptl = "python",
  ql = "ql",
  qll = "ql",
  rad = "radiance",
  mat = "radiance",
  ["pod6"] = "raku",
  rakudoc = "raku",
  rakutest = "raku",
  rakumod = "raku",
  ["pm6"] = "raku",
  raku = "raku",
  ["t6"] = "raku",
  ["p6"] = "raku",
  raml = "raml",
  rbs = "rbs",
  rego = "rego",
  rem = "remind",
  remind = "remind",
  res = "rescript",
  resi = "rescript",
  frt = "reva",
  testUnit = "rexx",
  rex = "rexx",
  orx = "rexx",
  rexx = "rexx",
  jrexx = "rexx",
  rxj = "rexx",
  rexxj = "rexx",
  testGroup = "rexx",
  rxo = "rexx",
  Rd = "rhelp",
  rd = "rhelp",
  rib = "rib",
  Rmd = "rmd",
  rmd = "rmd",
  smd = "rmd",
  Smd = "rmd",
  rnc = "rnc",
  rng = "rng",
  rnw = "rnoweb",
  snw = "rnoweb",
  Rnw = "rnoweb",
  Snw = "rnoweb",
  robot = "robot",
  resource = "robot",
  rsc = "routeros",
  x = "rpcgen",
  rpl = "rpl",
  Srst = "rrst",
  srst = "rrst",
  Rrst = "rrst",
  rrst = "rrst",
  rst = "rst",
  rtf = "rtf",
  rjs = "ruby",
  rxml = "ruby",
  rb = "ruby",
  rant = "ruby",
  ru = "ruby",
  rbw = "ruby",
  gemspec = "ruby",
  builder = "ruby",
  rake = "ruby",
  rs = "rust",
  sas = "sas",
  sass = "sass",
  sa = "sather",
  sbt = "sbt",
  scala = "scala",
  ss = "scheme",
  scm = "scheme",
  sld = "scheme",
  rkt = "scheme",
  rktd = "scheme",
  rktl = "scheme",
  sce = "scilab",
  sci = "scilab",
  scss = "scss",
  sd = "sd",
  sdc = "sdc",
  pr = "sdl",
  sdl = "sdl",
  sed = "sed",
  sexp = "sexplib",
  sieve = "sieve",
  siv = "sieve",
  sil = "sil",
  sim = "simula",
  ["s85"] = "sinda",
  sin = "sinda",
  ssm = "sisu",
  sst = "sisu",
  ssi = "sisu",
  ["_sst"] = "sisu",
  ["-sst"] = "sisu",
  il = "skill",
  ils = "skill",
  cdf = "skill",
  sl = "slang",
  ice = "slice",
  score = "slrnsc",
  sol = "solidity",
  tpl = "smarty",
  ihlp = "smcl",
  smcl = "smcl",
  hlp = "smcl",
  smith = "smith",
  smt = "smith",
  sml = "sml",
  spt = "snobol4",
  sno = "snobol4",
  sln = "solution",
  sparql = "sparql",
  rq = "sparql",
  spec = "spec",
  spice = "spice",
  sp = "spice",
  spd = "spup",
  spdata = "spup",
  speedup = "spup",
  spi = "spyce",
  spy = "spyce",
  tyc = "sql",
  typ = "sql",
  pkb = "sql",
  tyb = "sql",
  pks = "sql",
  sqlj = "sqlj",
  sqi = "sqr",
  sqr = "sqr",
  nut = "squirrel",
  ["s28"] = "srec",
  ["s37"] = "srec",
  srec = "srec",
  mot = "srec",
  ["s19"] = "srec",
  st = "st",
  imata = "stata",
  ["do"] = "stata",
  mata = "stata",
  ado = "stata",
  stp = "stp",
  quark = "supercollider",
  sface = "surface",
  svelte = "svelte",
  svg = "svg",
  swift = "swift",
  svh = "systemverilog",
  sv = "systemverilog",
  tak = "tak",
  task = "taskedit",
  tm = "tcl",
  tcl = "tcl",
  itk = "tcl",
  itcl = "tcl",
  tk = "tcl",
  jacl = "tcl",
  tl = "teal",
  tmpl = "template",
  ti = "terminfo",
  dtx = "tex",
  ltx = "tex",
  bbl = "tex",
  latex = "tex",
  sty = "tex",
  cls = function(path, bufnr)
    local line = getline(bufnr, 1)
    if line:find("^%%") then
      return "tex"
    elseif line:find("^#") and line:find("rexx") then
      return "rexx"
    else
      return "st"
    end
  end,
  texi = "texinfo",
  txi = "texinfo",
  texinfo = "texinfo",
  text = "text",
  tfvars = "terraform",
  tla = "tla",
  tli = "tli",
  toml = "toml",
  tpp = "tpp",
  treetop = "treetop",
  slt = "tsalt",
  tsscl = "tsscl",
  tssgm = "tssgm",
  tssop = "tssop",
  tutor = "tutor",
  twig = "twig",
  ts = function(path, bufnr)
    if getline(bufnr, 1):find("<%?xml") then
      return "xml"
    else
      return "typescript"
    end
  end,
  tsx = "typescriptreact",
  uc = "uc",
  uit = "uil",
  uil = "uil",
  sba = "vb",
  vb = "vb",
  dsm = "vb",
  ctl = "vb",
  vbs = "vb",
  vr = "vera",
  vri = "vera",
  vrh = "vera",
  v = "verilog",
  va = "verilogams",
  vams = "verilogams",
  vhdl = "vhdl",
  vst = "vhdl",
  vhd = "vhdl",
  hdl = "vhdl",
  vho = "vhdl",
  vbe = "vhdl",
  vim = "vim",
  vba = "vim",
  mar = "vmasm",
  cm = "voscm",
  wrl = "vrml",
  vroom = "vroom",
  vue = "vue",
  wat = "wast",
  wast = "wast",
  wm = "webmacro",
  wbt = "winbatch",
  wml = "wml",
  wsml = "wsml",
  ad = "xdefaults",
  xhtml = "xhtml",
  xht = "xhtml",
  msc = "xmath",
  msf = "xmath",
  ["psc1"] = "xml",
  tpm = "xml",
  xliff = "xml",
  atom = "xml",
  xul = "xml",
  cdxml = "xml",
  mpd = "xml",
  rss = "xml",
  fsproj = "xml",
  ui = "xml",
  vbproj = "xml",
  xlf = "xml",
  wsdl = "xml",
  csproj = "xml",
  wpl = "xml",
  xmi = "xml",
  xpm = function(path, bufnr)
    if getline(bufnr, 1):find("XPM2") then
      return "xpm2"
    else
      return "xpm"
    end
  end,
  ["xpm2"] = "xpm2",
  xqy = "xquery",
  xqm = "xquery",
  xquery = "xquery",
  xq = "xquery",
  xql = "xquery",
  xs = "xs",
  xsd = "xsd",
  xsl = "xslt",
  xslt = "xslt",
  yy = "yacc",
  ["y++"] = "yacc",
  yxx = "yacc",
  yml = "yaml",
  yaml = "yaml",
  yang = "yang",
  ["z8a"] = "z8a",
  zig = "zig",
  zu = "zimbu",
  zut = "zimbutempl",
  zsh = "zsh",
  vala = "vala",
  E = function() vim.fn["dist#ft#FTe"]() end,
  EU = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  EW = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  EX = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  EXU = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  EXW = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  PL = function() vim.fn["dist#ft#FTpl"]() end,
  R = function(path, bufnr) require("vim.filetype.detect").r(bufnr) end,
  asm = function() vim.fn["dist#ft#FTasm"]() end,
  bas = function() vim.fn["dist#ft#FTbas"]() end,
  bi = function() vim.fn["dist#ft#FTbas"]() end,
  bm = function() vim.fn["dist#ft#FTbas"]() end,
  bash = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  btm = function(path, bufnr) return require("vim.filetype.detect").btm(bufnr) end,
  c = function() vim.fn["dist#ft#FTlpc"]() end,
  ch = function() vim.fn["dist#ft#FTchange"]() end,
  com = function() vim.fn["dist#ft#BindzoneCheck"]('dcl') end,
  cpt = function() vim.fn["dist#ft#FThtml"]() end,
  csh = function() vim.fn["dist#ft#CSH"]() end,
  d = function() vim.fn["dist#ft#DtraceCheck"]() end,
  db = function() vim.fn["dist#ft#BindzoneCheck"]('') end,
  dtml = function() vim.fn["dist#ft#FThtml"]() end,
  e = function() vim.fn["dist#ft#FTe"]() end,
  ebuild = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  eclass = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ent = function(path, bufnr) return require("vim.filetype.detect").ent(bufnr) end,
  env = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  eu = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  ew = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  ex = function(path, bufnr) return require("vim.filetype.detect").ex(bufnr) end,
  exu = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  exw = function(path, bufnr) return require("vim.filetype.detect").euphoria(bufnr) end,
  frm = function(path, bufnr) require("vim.filetype.detect").frm(bufnr) end,
  fs = function() vim.fn["dist#ft#FTfs"]() end,
  h = function(path, bufnr) require("vim.filetype.detect").header(bufnr) end,
  htm = function() vim.fn["dist#ft#FThtml"]() end,
  html = function() vim.fn["dist#ft#FThtml"]() end,
  i = function() vim.fn["dist#ft#FTprogress_asm"]() end,
  idl = function(path, bufnr) require("vim.filetype.detect").idl(bufnr) end,
  inc = function() vim.fn["dist#ft#FTinc"]() end,
  inp = function(path, bufnr) require("vim.filetype.detect").inp(bufnr) end,
  ksh = function() vim.fn["dist#ft#SetFileTypeSH"]("ksh") end,
  lst = function() vim.fn["dist#ft#FTasm"]() end,
  m = function() vim.fn["dist#ft#FTm"]() end,
  mac = function() vim.fn["dist#ft#FTasm"]() end,
  mc = function(path, bufnr) require("vim.filetype.detect").mc(bufnr) end,
  mm = function() vim.fn["dist#ft#FTmm"]() end,
  mms = function(path, bufnr) require("vim.filetype.detect").mms(bufnr) end,
  p = function() vim.fn["dist#ft#FTprogress_pascal"]() end,
  patch = function(path, bufnr)
    local firstline = getline(bufnr, 1)
    if string.find(firstline, "^From " .. string.rep("%x", 40) .. "+ Mon Sep 17 00:00:00 2001$") then
      return "gitsendemail"
    else
      return "diff"
    end
  end,
  pl = function() vim.fn["dist#ft#FTpl"]() end,
  pp = function() vim.fn["dist#ft#FTpp"]() end,
  pro = function() vim.fn["dist#ft#ProtoCheck"]('idlang') end,
  pt = function() vim.fn["dist#ft#FThtml"]() end,
  r = function(path, bufnr) require("vim.filetype.detect").r(bufnr) end,
  rdf = function(path, bufnr) require("vim.filetype.detect").redif(bufnr) end,
  rules = function() vim.fn["dist#ft#FTRules"]() end,
  sc = function(path, bufnr) require("vim.filetype.detect").sc(bufnr) end,
  scd = function(path, bufnr) require("vim.filetype.detect").scd(bufnr) end,
  sh = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  shtml = function() vim.fn["dist#ft#FThtml"]() end,
  sql = function(path, bufnr) require("vim.filetype.detect").sql(bufnr) end,
  stm = function() vim.fn["dist#ft#FThtml"]() end,
  tcsh = function() vim.fn["dist#ft#SetFileTypeShell"]("tcsh") end,
  tex = function() vim.fn["dist#ft#FTtex"]() end,
  tf = function(path, bufnr) require("vim.filetype.detect").tf(bufnr) end,
  w = function(path, bufnr) require("vim.filetype.detect").progress_cweb(bufnr) end,
  xml = function(path, bufnr) require("vim.filetype.detect").xml(bufnr) end,
  y = function(path, bufnr) require("vim.filetype.detect").y(bufnr) end,
  zsql = function(path, bufnr) require("vim.filetype.detect").sql(bufnr) end,
  txt = function(path, bufnr)
    --helpfiles match *.txt, but should have a modeline as last line
    if not getline(bufnr, -1):match("vim:.*ft=help") then
      return "text"
    end
  end,
  cmd = function (path, bufnr)
    if getline(bufnr, 1):find("^/%*") then
      return "rexx"
    end
    return "dosbatch"
  end,
  rul = function(path, bufnr)
    if getline(bufnr, 1, 6):lower():find("installshield") then
      return "ishd"
    end
    return "diva"
  end,
  cpy = function(path, bufnr)
    if getline(bufnr, 1):find("^##") then
      return "python"
    end
    return "cobol"
  end,
  dsl = function(path, bufnr)
    if getline(bufnr, 1):find("^%s*<!") then
      return "dsl"
    end
    return "structurizr"
  end,
  edf = "edif",
  edfi = "edif",
  edo = "edif",
  edn = function(path, bufnr)
    if getline(bufnr, 1):find("^%s*%(%s*edif>") then
      return "edif"
    end
    return "clojure"
  end,
  smil = function(path, bufnr)
    if getline(bufnr, 1):find("<?%s*xml.*?>") then
      return "xml"
    end
    return "smil"
  end,
  smi = function(path, bufnr)
    if getline(bufnr, 1):find("<smil>") then
      return "smil"
    end
    return "mib"
  end,
  install = function(path, bufnr)
    if getline(bufnr, 1):find("<%?php") then
      return "php"
    end
    vim.fn["dist#ft#SetFileTypeSH"]("bash")
  end,
  pm = function(path, bufnr)
    if getline(bufnr, 1):find("XPM2") then
      return "xpm2"
    elseif getline(bufnr, 1):find("XPM") then
      return "xpm"
    else
      return "perl"
    end
  end,
  me = function(path, bufnr)
    local filename = vim.fn.fnamemodify(path, ":t")
    if filename ~= "read.me" and filename ~= "click.me" then
      return "nroff"
    end
  end,
  reg = function(path, bufnr)
    local line = getline(bufnr, 1)
    if line:find("^REGEDIT[0-9]*%s*$") or line:find("^Windows Registry Editor Version %d*%.%d*%s*$") then
      return "registry"
    end
  end,
  decl = function(path, bufnr)
    if getline(bufnr, 1, 3):lower():find("^<!sgml") then
      return "sgmldecl"
    end
  end,
  dcl = function(path, bufnr)
    if getline(bufnr, 1, 3):lower():find("^<!sgml") then
      return "sgmldecl"
    end
    return "clean"
  end,
  dec = function(path, bufnr)
    if getline(bufnr, 1, 3):lower():find("^<!sgml") then
      return "sgmldecl"
    end
  end,
  web = function(path, bufnr)
    if getline(bufnr, 1, 5):find("^%%") then
      return "web"
    end
    return "winbatch"
  end,
  ttl = function(path, bufnr)
    local line = getline(bufnr, 1)
    if line:find("^@?prefix") or line:find("^@?base") then
      return "turtle"
    end
    return "teraterm"
  end,
  am = function(path, bufnr)
    local filename = vim.fn.fnamemodify(path, ":t"):lower()
    if not filename:find("makefile.am$") then
      return "elf"
    end
  end,
  ["m4"] = function(path, bufnr)
    local filename = vim.fn.fnamemodify(path, ":t"):lower()
    if not filename:find("html.m4$") and not filename:find("fvwm2rc") then
      return "m4"
    end
  end,
  hw = function(path, bufnr)
    if getline(bufnr, 1):find("<%?php") then
      return "php"
    end
    return "virata"
  end,
  module = function(path, bufnr)
    if getline(bufnr, 1):find("<%?php") then
      return "php"
    end
    return "virata"
  end,
  pkg = function(path, bufnr)
    if getline(bufnr, 1):find("<%?php") then
      return "php"
    end
    return "virata"
  end,
  ms = function(path, bufnr)
    if vim.fn["dist#ft#FTnroff"]() == 0 then
      return "xmath"
    end
  end,
  t = function(path, bufnr)
    if vim.fn["dist#ft#FTnroff"]() == 0 and vim.fn["dist#ft#FTperl"]() == 0 then
      return "tads"
    end
  end,
  class = function(path, bufnr)
    if not getline(bufnr, 1):find("^\xca\xfe\xba\xbe") then
      return "stata"
    end
  end,
  sgml = function(path, bufnr)
    if getline(bufnr, 1, 5):lower():find("linuxdoc") then
      return "smgllnx"
    elseif getline(bufnr, 1, 2):find("<!DOCTYPE.*DocBook") then
      vim.b.docbk_type = "sgml"
      vim.b.docbk_ver = 4
      return "docbk"
    else
      return "sgml"
    end
  end,
  sgm = function(path, bufnr)
    if getline(bufnr, 1, 5):lower():find("linuxdoc") then
      return "smgllnx"
    elseif getline(bufnr, 1, 2):find("<!DOCTYPE.*DocBook") then
      vim.b.docbk_type = "sgml"
      vim.b.docbk_ver = 4
      return "docbk"
    else
      return "sgml"
    end
  end,
  rc = function(path, bufnr)
    if not path:find("/etc/Muttrc.d/") then
      return "rc"
    end
  end,
  rch = function(path, bufnr)
    if not path:find("/etc/Muttrc.d/") then
      return "rc"
    end
  end,
  -- END EXTENSION
}

local filename = {
  -- BEGIN FILENAME
  ["a2psrc"] = "a2ps",
  ["/etc/a2ps.cfg"] = "a2ps",
  [".a2psrc"] = "a2ps",
  [".asoundrc"] = "alsaconf",
  ["/usr/share/alsa/alsa.conf"] = "alsaconf",
  ["/etc/asound.conf"] = "alsaconf",
  ["build.xml"] = "ant",
  [".htaccess"] = "apache",
  ["apt.conf"] = "aptconf",
  ["/.aptitude/config"] = "aptconf",
  ["=tagging-method"] = "arch",
  [".arch-inventory"] = "arch",
  ["GNUmakefile.am"] = "automake",
  ["named.root"] = "bindzone",
  WORKSPACE = "bzl",
  BUILD = "bzl",
  ["cabal.config"] = "cabalconfig",
  ["cabal.project"] = "cabalproject",
  calendar = "calendar",
  catalog = "catalog",
  ["/etc/cdrdao.conf"] = "cdrdaoconf",
  [".cdrdao"] = "cdrdaoconf",
  ["/etc/default/cdrdao"] = "cdrdaoconf",
  ["/etc/defaults/cdrdao"] = "cdrdaoconf",
  ["cfengine.conf"] = "cfengine",
  ["CMakeLists.txt"] = "cmake",
  ["auto.master"] = "conf",
  ["configure.in"] = "config",
  ["configure.ac"] = "config",
  [".cvsrc"] = "cvsrc",
  ["/debian/changelog"] = "debchangelog",
  ["changelog.dch"] = "debchangelog",
  ["changelog.Debian"] = "debchangelog",
  ["NEWS.dch"] = "debchangelog",
  ["NEWS.Debian"] = "debchangelog",
  ["/debian/control"] = "debcontrol",
  ["/debian/copyright"] = "debcopyright",
  ["/etc/apt/sources.list"] = "debsources",
  ["denyhosts.conf"] = "denyhosts",
  ["dict.conf"] = "dictconf",
  [".dictrc"] = "dictconf",
  ["/etc/DIR_COLORS"] = "dircolors",
  [".dir_colors"] = "dircolors",
  [".dircolors"] = "dircolors",
  ["/etc/dnsmasq.conf"] = "dnsmasq",
  Containerfile = "dockerfile",
  Dockerfile = "dockerfile",
  npmrc = "dosini",
  ["/etc/yum.conf"] = "dosini",
  ["/etc/pacman.conf"] = "conf",
  [".npmrc"] = "dosini",
  [".editorconfig"] = "dosini",
  dune = "dune",
  jbuild = "dune",
  ["dune-workspace"] = "dune",
  ["dune-project"] = "dune",
  ["elinks.conf"] = "elinks",
  ["mix.lock"] = "elixir",
  ["filter-rules"] = "elmfilt",
  ["exim.conf"] = "exim",
  exports = "exports",
  [".fetchmailrc"] = "fetchmail",
  fvSchemes = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  fvSolution = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  fvConstraints = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  fvModels = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  fstab = "fstab",
  mtab = "fstab",
  [".gdbinit"] = "gdb",
  gdbinit = "gdb",
  [".gdbearlyinit"] = "gdb",
  gdbearlyinit = "gdb",
  ["lltxxxxx.txt"] = "gedcom",
  ["TAG_EDITMSG"] = "gitcommit",
  ["MERGE_MSG"] = "gitcommit",
  ["COMMIT_EDITMSG"] = "gitcommit",
  ["NOTES_EDITMSG"] = "gitcommit",
  ["EDIT_DESCRIPTION"] = "gitcommit",
  [".gitconfig"] = "gitconfig",
  [".gitmodules"] = "gitconfig",
  ["gitolite.conf"] = "gitolite",
  ["git-rebase-todo"] = "gitrebase",
  gkrellmrc = "gkrellmrc",
  [".gnashrc"] = "gnash",
  [".gnashpluginrc"] = "gnash",
  gnashpluginrc = "gnash",
  gnashrc = "gnash",
  ["go.work"] = "gowork",
  [".gprc"] = "gp",
  ["/.gnupg/gpg.conf"] = "gpg",
  ["/.gnupg/options"] = "gpg",
  ["/var/backups/gshadow.bak"] = "group",
  ["/etc/gshadow"] = "group",
  ["/etc/group-"] = "group",
  ["/etc/gshadow.edit"] = "group",
  ["/etc/gshadow-"] = "group",
  ["/etc/group"] = "group",
  ["/var/backups/group.bak"] = "group",
  ["/etc/group.edit"] = "group",
  ["/boot/grub/menu.lst"] = "grub",
  ["/etc/grub.conf"] = "grub",
  ["/boot/grub/grub.conf"] = "grub",
  [".gtkrc"] = "gtkrc",
  gtkrc = "gtkrc",
  ["snort.conf"] = "hog",
  ["vision.conf"] = "hog",
  ["/etc/host.conf"] = "hostconf",
  ["/etc/hosts.allow"] = "hostsaccess",
  ["/etc/hosts.deny"] = "hostsaccess",
  ["/i3/config"] = "i3config",
  ["/sway/config"] = "i3config",
  ["/.sway/config"] = "i3config",
  ["/.i3/config"] = "i3config",
  ["/.icewm/menu"] = "icemenu",
  [".indent.pro"] = "indent",
  indentrc = "indent",
  inittab = "inittab",
  ["ipf.conf"] = "ipfilter",
  ["ipf6.conf"] = "ipfilter",
  ["ipf.rules"] = "ipfilter",
  [".eslintrc"] = "json",
  [".babelrc"] = "json",
  ["Pipfile.lock"] = "json",
  [".firebaserc"] = "json",
  [".prettierrc"] = "json",
  Kconfig = "kconfig",
  ["Kconfig.debug"] = "kconfig",
  ["lftp.conf"] = "lftp",
  [".lftprc"] = "lftp",
  ["/.libao"] = "libao",
  ["/etc/libao.conf"] = "libao",
  ["lilo.conf"] = "lilo",
  ["/etc/limits"] = "limits",
  [".emacs"] = "lisp",
  sbclrc = "lisp",
  [".sbclrc"] = "lisp",
  [".sawfishrc"] = "lisp",
  ["/etc/login.access"] = "loginaccess",
  ["/etc/login.defs"] = "logindefs",
  ["lynx.cfg"] = "lynx",
  ["m3overrides"] = "m3build",
  ["m3makefile"] = "m3build",
  ["cm3.cfg"] = "m3quake",
  [".followup"] = "mail",
  [".article"] = "mail",
  [".letter"] = "mail",
  ["/etc/aliases"] = "mailaliases",
  ["/etc/mail/aliases"] = "mailaliases",
  mailcap = "mailcap",
  [".mailcap"] = "mailcap",
  ["/etc/man.conf"] = "manconf",
  ["man.config"] = "manconf",
  ["maxima-init.mac"] = "maxima",
  ["meson.build"] = "meson",
  ["meson_options.txt"] = "meson",
  ["/etc/conf.modules"] = "modconf",
  ["/etc/modules"] = "modconf",
  ["/etc/modules.conf"] = "modconf",
  ["/.mplayer/config"] = "mplayerconf",
  ["mplayer.conf"] = "mplayerconf",
  mrxvtrc = "mrxvtrc",
  [".mrxvtrc"] = "mrxvtrc",
  ["/etc/nanorc"] = "nanorc",
  Neomuttrc = "neomuttrc",
  [".netrc"] = "netrc",
  [".ocamlinit"] = "ocaml",
  [".octaverc"] = "octave",
  octaverc = "octave",
  ["octave.conf"] = "octave",
  opam = "opam",
  ["/etc/pam.conf"] = "pamconf",
  ["pam_env.conf"] = "pamenv",
  [".pam_environment"] = "pamenv",
  ["/var/backups/passwd.bak"] = "passwd",
  ["/var/backups/shadow.bak"] = "passwd",
  ["/etc/passwd"] = "passwd",
  ["/etc/passwd-"] = "passwd",
  ["/etc/shadow.edit"] = "passwd",
  ["/etc/shadow-"] = "passwd",
  ["/etc/shadow"] = "passwd",
  ["/etc/passwd.edit"] = "passwd",
  ["pf.conf"] = "pf",
  ["main.cf"] = "pfmain",
  pinerc = "pine",
  [".pinercex"] = "pine",
  [".pinerc"] = "pine",
  pinercex = "pine",
  ["/etc/pinforc"] = "pinfo",
  ["/.pinforc"] = "pinfo",
  [".povrayrc"] = "povini",
  [".procmailrc"] = "procmail",
  [".procmail"] = "procmail",
  ["/etc/protocols"] = "protocols",
  [".pythonstartup"] = "python",
  [".pythonrc"] = "python",
  SConstruct = "python",
  ratpoisonrc = "ratpoison",
  [".ratpoisonrc"] = "ratpoison",
  v = "rcs",
  inputrc = "readline",
  [".inputrc"] = "readline",
  [".reminders"] = "remind",
  ["resolv.conf"] = "resolv",
  ["robots.txt"] = "robots",
  Gemfile = "ruby",
  Puppetfile = "ruby",
  [".irbrc"] = "ruby",
  irbrc = "ruby",
  Vagrantfile = "ruby",
  ["smb.conf"] = "samba",
  screenrc = "screen",
  [".screenrc"] = "screen",
  ["/etc/sensors3.conf"] = "sensors",
  ["/etc/sensors.conf"] = "sensors",
  ["/etc/services"] = "services",
  ["/etc/serial.conf"] = "setserial",
  ["/etc/udev/cdsymlinks.conf"] = "sh",
  ["/etc/slp.conf"] = "slpconf",
  ["/etc/slp.reg"] = "slpreg",
  ["/etc/slp.spi"] = "slpspi",
  [".slrnrc"] = "slrnrc",
  ["sendmail.cf"] = "sm",
  ["squid.conf"] = "squid",
  ["/.ssh/config"] = "sshconfig",
  ["ssh_config"] = "sshconfig",
  ["sshd_config"] = "sshdconfig",
  ["/etc/sudoers"] = "sudoers",
  ["sudoers.tmp"] = "sudoers",
  ["/etc/sysctl.conf"] = "sysctl",
  tags = "tags",
  [".tclshrc"] = "tcl",
  [".wishrc"] = "tcl",
  ["tclsh.rc"] = "tcl",
  ["texmf.cnf"] = "texmf",
  COPYING = "text",
  README = "text",
  LICENSE = "text",
  AUTHORS = "text",
  tfrc = "tf",
  [".tfrc"] = "tf",
  ["tidy.conf"] = "tidy",
  tidyrc = "tidy",
  [".tidyrc"] = "tidy",
  [".tmux.conf"] = "tmux",
  ["/.cargo/config"] = "toml",
  Pipfile = "toml",
  ["Gopkg.lock"] = "toml",
  ["/.cargo/credentials"] = "toml",
  ["Cargo.lock"] = "toml",
  ["trustees.conf"] = "trustees",
  ["/etc/udev/udev.conf"] = "udevconf",
  ["/etc/updatedb.conf"] = "updatedb",
  ["fdrupstream.log"] = "upstreamlog",
  vgrindefs = "vgrindefs",
  [".exrc"] = "vim",
  ["_exrc"] = "vim",
  ["_viminfo"] = "viminfo",
  [".viminfo"] = "viminfo",
  [".wgetrc"] = "wget",
  [".wget2rc"] = "wget2",
  wgetrc = "wget",
  wget2rc = "wget2",
  [".wvdialrc"] = "wvdial",
  ["wvdial.conf"] = "wvdial",
  [".Xresources"] = "xdefaults",
  [".Xpdefaults"] = "xdefaults",
  ["xdm-config"] = "xdefaults",
  [".Xdefaults"] = "xdefaults",
  ["/etc/xinetd.conf"] = "xinetd",
  fglrxrc = "xml",
  ["/etc/blkid.tab"] = "xml",
  ["/etc/blkid.tab.old"] = "xml",
  ["/etc/zprofile"] = "zsh",
  [".zlogin"] = "zsh",
  [".zlogout"] = "zsh",
  [".zshrc"] = "zsh",
  [".zprofile"] = "zsh",
  [".zcompdump"] = "zsh",
  [".zshenv"] = "zsh",
  [".zfbfmarks"] = "zsh",
  [".alias"] = function() vim.fn["dist#ft#CSH"]() end,
  [".bashrc"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  [".cshrc"] = function() vim.fn["dist#ft#CSH"]() end,
  [".env"] = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  [".kshrc"] = function() vim.fn["dist#ft#SetFileTypeSH"]("ksh") end,
  [".login"] = function() vim.fn["dist#ft#CSH"]() end,
  [".profile"] = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  [".tcshrc"] = function() vim.fn["dist#ft#SetFileTypeShell"]("tcsh") end,
  ["/etc/profile"] = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  APKBUILD = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  PKGBUILD = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ["bash.bashrc"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  bashrc = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  crontab = starsetf('crontab'),
  ["csh.cshrc"] = function() vim.fn["dist#ft#CSH"]() end,
  ["csh.login"] = function() vim.fn["dist#ft#CSH"]() end,
  ["csh.logout"] = function() vim.fn["dist#ft#CSH"]() end,
  ["indent.pro"] = function() vim.fn["dist#ft#ProtoCheck"]('indent') end,
  ["tcsh.login"] = function() vim.fn["dist#ft#SetFileTypeShell"]("tcsh") end,
  ["tcsh.tcshrc"] = function() vim.fn["dist#ft#SetFileTypeShell"]("tcsh") end,
  -- END FILENAME
}

local pattern = {
  -- BEGIN PATTERN
  [".*/etc/a2ps/.*%.cfg"] = "a2ps",
  [".*/etc/a2ps%.cfg"] = "a2ps",
  [".*/usr/share/alsa/alsa%.conf"] = "alsaconf",
  [".*/etc/asound%.conf"] = "alsaconf",
  [".*/etc/apache2/sites%-.*/.*%.com"] = "apache",
  [".*/etc/httpd/.*%.conf"] = "apache",
  [".*/%.aptitude/config"] = "aptconf",
  ["[mM]akefile%.am"] = "automake",
  [".*bsd"] = "bsdl",
  ["bzr_log%..*"] = "bzr",
  [".*enlightenment/.*%.cfg"] = "c",
  [".*/etc/defaults/cdrdao"] = "cdrdaoconf",
  [".*/etc/cdrdao%.conf"] = "cdrdaoconf",
  [".*/etc/default/cdrdao"] = "cdrdaoconf",
  [".*hgrc"] = "cfg",
  [".*%.%.ch"] = "chill",
  [".*%.cmake%.in"] = "cmake",
  [".*/debian/changelog"] = "debchangelog",
  [".*/debian/control"] = "debcontrol",
  [".*/debian/copyright"] = "debcopyright",
  [".*/etc/apt/sources%.list%.d/.*%.list"] = "debsources",
  [".*/etc/apt/sources%.list"] = "debsources",
  ["dictd.*%.conf"] = "dictdconf",
  [".*/etc/DIR_COLORS"] = "dircolors",
  [".*/etc/dnsmasq%.conf"] = "dnsmasq",
  ["php%.ini%-.*"] = "dosini",
  [".*/etc/pacman%.conf"] = "conf",
  [".*/etc/yum%.conf"] = "dosini",
  [".*lvs"] = "dracula",
  [".*lpe"] = "dracula",
  [".*/dtrace/.*%.d"] = "dtrace",
  [".*esmtprc"] = "esmtprc",
  [".*Eterm/.*%.cfg"] = "eterm",
  [".*%.git/modules/.*/config"] = "gitconfig",
  [".*%.git/config"] = "gitconfig",
  [".*/etc/gitconfig"] = "gitconfig",
  [".*/%.config/git/config"] = "gitconfig",
  [".*%.git/config%.worktree"] = "gitconfig",
  [".*%.git/worktrees/.*/config%.worktree"] = "gitconfig",
  ["%.gitsendemail%.msg%......."] = "gitsendemail",
  ["gkrellmrc_."] = "gkrellmrc",
  [".*/usr/.*/gnupg/options%.skel"] = "gpg",
  [".*/%.gnupg/options"] = "gpg",
  [".*/%.gnupg/gpg%.conf"] = "gpg",
  [".*/etc/group"] = "group",
  [".*/etc/gshadow"] = "group",
  [".*/etc/group%.edit"] = "group",
  [".*/var/backups/gshadow%.bak"] = "group",
  [".*/etc/group-"] = "group",
  [".*/etc/gshadow-"] = "group",
  [".*/var/backups/group%.bak"] = "group",
  [".*/etc/gshadow%.edit"] = "group",
  [".*/boot/grub/grub%.conf"] = "grub",
  [".*/boot/grub/menu%.lst"] = "grub",
  [".*/etc/grub%.conf"] = "grub",
  [vim.env.VIMRUNTIME .. "/doc/.*%.txt"] = "help",
  ["hg%-editor%-.*%.txt"] = "hgcommit",
  [".*/etc/host%.conf"] = "hostconf",
  [".*/etc/hosts%.deny"] = "hostsaccess",
  [".*/etc/hosts%.allow"] = "hostsaccess",
  [".*%.html%.m4"] = "htmlm4",
  [".*/%.i3/config"] = "i3config",
  [".*/sway/config"] = "i3config",
  [".*/i3/config"] = "i3config",
  [".*/%.sway/config"] = "i3config",
  [".*/%.icewm/menu"] = "icemenu",
  [".*/etc/initng/.*/.*%.i"] = "initng",
  [".*%.properties_.."] = "jproperties",
  [".*%.properties_.._.."] = "jproperties",
  [".*lftp/rc"] = "lftp",
  [".*/%.libao"] = "libao",
  [".*/etc/libao%.conf"] = "libao",
  [".*/etc/.*limits%.conf"] = "limits",
  [".*/etc/limits"] = "limits",
  [".*/etc/.*limits%.d/.*%.conf"] = "limits",
  [".*/LiteStep/.*/.*%.rc"] = "litestep",
  [".*/etc/login%.access"] = "loginaccess",
  [".*/etc/login%.defs"] = "logindefs",
  [".*/etc/mail/aliases"] = "mailaliases",
  [".*/etc/aliases"] = "mailaliases",
  [".*[mM]akefile"] = "make",
  [".*/etc/man%.conf"] = "manconf",
  [".*/etc/modules%.conf"] = "modconf",
  [".*/etc/conf%.modules"] = "modconf",
  [".*/etc/modules"] = "modconf",
  [".*%.[mi][3g]"] = "modula3",
  [".*/%.mplayer/config"] = "mplayerconf",
  ["rndc.*%.conf"] = "named",
  ["rndc.*%.key"] = "named",
  ["named.*%.conf"] = "named",
  [".*/etc/nanorc"] = "nanorc",
  [".*%.NS[ACGLMNPS]"] = "natural",
  ["nginx.*%.conf"] = "nginx",
  [".*/etc/nginx/.*"] = "nginx",
  [".*nginx%.conf"] = "nginx",
  [".*/nginx/.*%.conf"] = "nginx",
  [".*/usr/local/nginx/conf/.*"] = "nginx",
  [".*%.ml%.cppo"] = "ocaml",
  [".*%.mli%.cppo"] = "ocaml",
  [".*%.opam%.template"] = "opam",
  [".*%.[Oo][Pp][Ll]"] = "opl",
  [".*/etc/pam%.conf"] = "pamconf",
  [".*/etc/passwd-"] = "passwd",
  [".*/etc/shadow"] = "passwd",
  [".*/etc/shadow%.edit"] = "passwd",
  [".*/var/backups/shadow%.bak"] = "passwd",
  [".*/var/backups/passwd%.bak"] = "passwd",
  [".*/etc/passwd"] = "passwd",
  [".*/etc/passwd%.edit"] = "passwd",
  [".*/etc/shadow-"] = "passwd",
  [".*%.php%d"] = "php",
  [".*/%.pinforc"] = "pinfo",
  [".*/etc/pinforc"] = "pinfo",
  [".*/etc/protocols"] = "protocols",
  [".*baseq[2-3]/.*%.cfg"] = "quake",
  [".*quake[1-3]/.*%.cfg"] = "quake",
  [".*id1/.*%.cfg"] = "quake",
  ["[rR]antfile"] = "ruby",
  ["[rR]akefile"] = "ruby",
  [".*/etc/sensors%.conf"] = "sensors",
  [".*/etc/sensors3%.conf"] = "sensors",
  [".*/etc/services"] = "services",
  [".*/etc/serial%.conf"] = "setserial",
  [".*/etc/udev/cdsymlinks%.conf"] = "sh",
  [".*%._sst%.meta"] = "sisu",
  [".*%.%-sst%.meta"] = "sisu",
  [".*%.sst%.meta"] = "sisu",
  [".*/etc/slp%.conf"] = "slpconf",
  [".*/etc/slp%.reg"] = "slpreg",
  [".*/etc/slp%.spi"] = "slpspi",
  [".*/etc/ssh/ssh_config%.d/.*%.conf"] = "sshconfig",
  [".*/%.ssh/config"] = "sshconfig",
  [".*/etc/ssh/sshd_config%.d/.*%.conf"] = "sshdconfig",
  [".*/etc/sudoers"] = "sudoers",
  ["svn%-commit.*%.tmp"] = "svn",
  [".*%.swift%.gyb"] = "swiftgyb",
  [".*/etc/sysctl%.conf"] = "sysctl",
  [".*/etc/sysctl%.d/.*%.conf"] = "sysctl",
  [".*/etc/systemd/.*%.conf%.d/.*%.conf"] = "systemd",
  [".*/%.config/systemd/user/.*%.d/.*%.conf"] = "systemd",
  [".*/etc/systemd/system/.*%.d/.*%.conf"] = "systemd",
  [".*%.t%.html"] = "tilde",
  ["%.?tmux.*%.conf"] = "tmux",
  ["%.?tmux.*%.conf.*"] = { "tmux", { priority = -1 } },
  [".*/%.cargo/config"] = "toml",
  [".*/%.cargo/credentials"] = "toml",
  [".*/etc/udev/udev%.conf"] = "udevconf",
  [".*/etc/udev/permissions%.d/.*%.permissions"] = "udevperm",
  [".*/etc/updatedb%.conf"] = "updatedb",
  [".*/%.init/.*%.override"] = "upstart",
  [".*/usr/share/upstart/.*%.conf"] = "upstart",
  [".*/%.config/upstart/.*%.override"] = "upstart",
  [".*/etc/init/.*%.conf"] = "upstart",
  [".*/etc/init/.*%.override"] = "upstart",
  [".*/%.config/upstart/.*%.conf"] = "upstart",
  [".*/%.init/.*%.conf"] = "upstart",
  [".*/usr/share/upstart/.*%.override"] = "upstart",
  [".*%.ws[fc]"] = "wsh",
  [".*/etc/xinetd%.conf"] = "xinetd",
  [".*/etc/blkid%.tab"] = "xml",
  [".*/etc/blkid%.tab%.old"] = "xml",
  [".*%.vbproj%.user"] = "xml",
  [".*%.fsproj%.user"] = "xml",
  [".*%.csproj%.user"] = "xml",
  [".*/etc/xdg/menus/.*%.menu"] = "xml",
  [".*Xmodmap"] = "xmodmap",
  [".*/etc/zprofile"] = "zsh",
  ["%.bash[_-]aliases"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ["%.bash[_-]logout"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ["%.bash[_-]profile"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ["%.cshrc.*"] = function() vim.fn["dist#ft#CSH"]() end,
  ["%.gtkrc.*"] = starsetf('gtkrc'),
  ["%.kshrc.*"] = function() vim.fn["dist#ft#SetFileTypeSH"]("ksh") end,
  ["%.login.*"] = function() vim.fn["dist#ft#CSH"]() end,
  ["%.neomuttrc.*"] = starsetf('neomuttrc'),
  ["%.profile.*"] = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  ["%.reminders.*"] = starsetf('remind'),
  ["%.tcshrc.*"] = function() vim.fn["dist#ft#SetFileTypeShell"]("tcsh") end,
  ["%.zcompdump.*"] = starsetf('zsh'),
  ["%.zlog.*"] = starsetf('zsh'),
  ["%.zsh.*"] = starsetf('zsh'),
  [".*%.[1-9]"] = function(path, bufnr) return require("vim.filetype.detect").nroff(bufnr) end,
  [".*%.[aA]"] = function() vim.fn["dist#ft#FTasm"]() end,
  [".*%.[sS]"] = function() vim.fn["dist#ft#FTasm"]() end,
  [".*%.properties_.._.._.*"] = starsetf('jproperties'),
  [".*%.vhdl_[0-9].*"] = starsetf('vhdl'),
  [".*/%.fvwm/.*"] = starsetf('fvwm'),
  [".*/%.gitconfig%.d/.*"] = starsetf('gitconfig'),
  [".*/%.neomutt/neomuttrc.*"] = starsetf('neomuttrc'),
  [".*/Xresources/.*"] = starsetf('xdefaults'),
  [".*/app%-defaults/.*"] = starsetf('xdefaults'),
  [".*/bind/db%..*"] = starsetf('bindzone'),
  [".*/debian/patches/.*"] = function() vim.fn["dist#ft#Dep3patch"]() end,
  [".*/etc/Muttrc%.d/.*"] = starsetf('muttrc'),
  [".*/etc/apache2/.*%.conf.*"] = starsetf('apache'),
  [".*/etc/apache2/conf%..*/.*"] = starsetf('apache'),
  [".*/etc/apache2/mods%-.*/.*"] = starsetf('apache'),
  [".*/etc/apache2/sites%-.*/.*"] = starsetf('apache'),
  [".*/etc/cron%.d/.*"] = starsetf('crontab'),
  [".*/etc/dnsmasq%.d/.*"] = starsetf('dnsmasq'),
  [".*/etc/httpd/conf%..*/.*"] = starsetf('apache'),
  [".*/etc/httpd/conf%.d/.*%.conf.*"] = starsetf('apache'),
  [".*/etc/httpd/mods%-.*/.*"] = starsetf('apache'),
  [".*/etc/httpd/sites%-.*/.*"] = starsetf('apache'),
  [".*/etc/logcheck/.*%.d.*/.*"] = starsetf('logcheck'),
  [".*/etc/modprobe%..*"] = starsetf('modconf'),
  [".*/etc/pam%.d/.*"] = starsetf('pamconf'),
  [".*/etc/profile"] = function() vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1)) end,
  [".*/etc/proftpd/.*%.conf.*"] = starsetf('apachestyle'),
  [".*/etc/proftpd/conf%..*/.*"] = starsetf('apachestyle'),
  [".*/etc/sudoers%.d/.*"] = starsetf('sudoers'),
  [".*/etc/xinetd%.d/.*"] = starsetf('xinetd'),
  [".*/etc/yum%.repos%.d/.*"] = starsetf('dosini'),
  [".*/gitolite%-admin/conf/.*"] = starsetf('gitolite'),
  [".*/named/db%..*"] = starsetf('bindzone'),
  [".*/tmp/lltmp.*"] = starsetf('gedcom'),
  [".*asterisk.*/.*voicemail%.conf.*"] = starsetf('asteriskvm'),
  [".*asterisk/.*%.conf.*"] = starsetf('asterisk'),
  [".*vimrc.*"] = starsetf('vim'),
  [".*xmodmap.*"] = starsetf('xmodmap'),
  ["/etc/gitconfig%.d/.*"] = starsetf('gitconfig'),
  ["/etc/hostname%..*"] = starsetf('config'),
  ["Containerfile%..*"] = starsetf('dockerfile'),
  ["Dockerfile%..*"] = starsetf('dockerfile'),
  ["JAM.*%..*"] = starsetf('jam'),
  ["Kconfig%..*"] = starsetf('kconfig'),
  ["Neomuttrc.*"] = starsetf('neomuttrc'),
  ["Prl.*%..*"] = starsetf('jam'),
  ["Xresources.*"] = starsetf('xdefaults'),
  ["[mM]akefile.*"] = starsetf('make'),
  ["[rR]akefile.*"] = starsetf('ruby'),
  ["access%.conf.*"] = starsetf('apache'),
  ["apache%.conf.*"] = starsetf('apache'),
  ["apache2%.conf.*"] = starsetf('apache'),
  ["bash%-fc[-%.]"] = function() vim.fn["dist#ft#SetFileTypeSH"]("bash") end,
  ["cabal%.project%..*"] = starsetf('cabalproject'),
  ["crontab%..*"] = starsetf('crontab'),
  ["drac%..*"] = starsetf('dracula'),
  ["gtkrc.*"] = starsetf('gtkrc'),
  ["httpd%.conf.*"] = starsetf('apache'),
  ["lilo%.conf.*"] = starsetf('lilo'),
  ["neomuttrc.*"] = starsetf('neomuttrc'),
  ["proftpd%.conf.*"] = starsetf('apachestyle'),
  ["reportbug%-.*"] = starsetf('mail'),
  ["sgml%.catalog.*"] = starsetf('catalog'),
  ["srm%.conf.*"] = starsetf('apache'),
  ["tmac%..*"] = starsetf('nroff'),
  ["zlog.*"] = starsetf('zsh'),
  ["zsh.*"] = starsetf('zsh'),
  ["ae%d+%.txt"] = 'mail',
  ["snd%.%d+"] = "mail",
  ["%.letter%.%d+"] = "mail",
  ["%.article%.%d+"] = "mail",
  ["pico%.%d+"] = "mail",
  ["mutt%-.*%-%w+"] = "mail",
  ["neomutt%-.*%-%w+"] = "mail",
  ["muttng%-.*%-%w+"] = "mail",
  ["mutt" .. string.rep("[%w_-]", 6)] = "mail",
  ["neomutt" .. string.rep("[%w_-]", 6)] = "mail",
  ["/tmp/SLRN[0-9A-Z.]+"] = "mail",
  ["[a-zA-Z0-9].*Dict"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  ["[a-zA-Z0-9].*Dict%..*"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  ["[a-zA-Z].*Properties"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  ["[a-zA-Z].*Properties%..*"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  [".*Transport%..*"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  [".*/constant/g"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  [".*/0/.*"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  [".*/0%.orig/.*"] = function(path, bufnr) require("vim.filetype.detect").foam(bufnr) end,
  [".*/etc/sensors%.d/[^.].*"] = starsetf('sensors'),
  [".*%.git/.*"] = function(path, bufnr)
    local firstline = getline(bufnr, 1)
    if firstline:find("^" .. string.rep("%x", 40) .. "+ ") or firstline:sub(1, 5) == "ref: " then
      return "git"
    end
  end,
  [".*%.[Cc][Ff][Gg]"] = function() vim.fn["dist#ft#FTcfg"]() end,
  [".*%.[Dd][Aa][Tt]"] = function() vim.fn["dist#ft#FTdat"]() end,
  [".*%.[Mm][Oo][Dd]"] = function() vim.fn["dist#ft#FTmod"]() end,
  [".*%.[Ss][Rr][Cc]"] = function() vim.fn["dist#ft#FTsrc"]() end,
  [".*%.[Ss][Uu][Bb]"] = "krl",
  [".*%.[Pp][Rr][Gg]"] = function() vim.fn["dist#ft#FTprg"]() end,
  [".*%.[Ss][Yy][Ss]"] = function() vim.fn["dist#ft#FTsys"]() end,
  -- Neovim only
  [".*/queries/.*%.scm"] = "query", -- tree-sitter queries
  -- END PATTERN
}
-- luacheck: pop

---@private
local function sort_by_priority(t)
  local sorted = {}
  for k, v in pairs(t) do
    local ft = type(v) == "table" and v[1] or v
    assert(type(ft) == "string" or type(ft) == "function", "Expected string or function for filetype")

    local opts = (type(v) == "table" and type(v[2]) == "table") and v[2] or {}
    if not opts.priority then
      opts.priority = 0
    end
    table.insert(sorted, { [k] = { ft, opts } })
  end
  table.sort(sorted, function(a, b)
    return a[next(a)][2].priority > b[next(b)][2].priority
  end)
  return sorted
end

local pattern_sorted = sort_by_priority(pattern)

---@private
local function normalize_path(path, as_pattern)
  local normal = path:gsub("\\", '/')
  if normal:find('^~') then
    if as_pattern then
      -- Escape Lua's metacharacters when $HOME is used in a pattern.
      -- The rest of path should already be properly escaped.
      normal = vim.pesc(vim.env.HOME) .. normal:sub(2)
    else
      normal = vim.env.HOME .. normal:sub(2)
    end
  end
  return normal
end

--- Add new filetype mappings.
---
--- Filetype mappings can be added either by extension or by filename (either
--- the "tail" or the full file path). The full file path is checked first,
--- followed by the file name. If a match is not found using the filename, then
--- the filename is matched against the list of |lua-patterns| (sorted by priority)
--- until a match is found. Lastly, if pattern matching does not find a
--- filetype, then the file extension is used.
---
--- The filetype can be either a string (in which case it is used as the
--- filetype directly) or a function. If a function, it takes the full path and
--- buffer number of the file as arguments (along with captures from the matched
--- pattern, if any) and should return a string that will be used as the
--- buffer's filetype.
---
--- Filename patterns can specify an optional priority to resolve cases when a
--- file path matches multiple patterns. Higher priorities are matched first.
--- When omitted, the priority defaults to 0.
---
--- See $VIMRUNTIME/lua/vim/filetype.lua for more examples.
---
--- Note that Lua filetype detection is only enabled when |g:do_filetype_lua| is
--- set to 1.
---
--- Example:
--- <pre>
---  vim.filetype.add({
---    extension = {
---      foo = "fooscript",
---      bar = function(path, bufnr)
---        if some_condition() then
---          return "barscript"
---        end
---        return "bar"
---      end,
---    },
---    filename = {
---      [".foorc"] = "toml",
---      ["/etc/foo/config"] = "toml",
---    },
---    pattern = {
---      [".*/etc/foo/.*"] = "fooscript",
---      -- Using an optional priority
---      [".*/etc/foo/.*%.conf"] = { "dosini", { priority = 10 } },
---      ["README.(%a+)$"] = function(path, bufnr, ext)
---        if ext == "md" then
---          return "markdown"
---        elseif ext == "rst" then
---          return "rst"
---        end
---      end,
---    },
---  })
--- </pre>
---
---@param filetypes table A table containing new filetype maps (see example).
function M.add(filetypes)
  for k, v in pairs(filetypes.extension or {}) do
    extension[k] = v
  end

  for k, v in pairs(filetypes.filename or {}) do
    filename[normalize_path(k)] = v
  end

  for k, v in pairs(filetypes.pattern or {}) do
    pattern[normalize_path(k, true)] = v
  end

  if filetypes.pattern then
    pattern_sorted = sort_by_priority(pattern)
  end
end

---@private
local function dispatch(ft, path, bufnr, ...)
  if type(ft) == "function" then
    ft = ft(path, bufnr, ...)
  end

  if type(ft) == "string" then
    api.nvim_buf_set_option(bufnr, "filetype", ft)
    return true
  end

  -- Any non-falsey value (that is, anything other than 'nil' or 'false') will
  -- end filetype matching. This is useful for e.g. the dist#ft functions that
  -- return 0, but set the buffer's filetype themselves
  return ft
end

---@private
local function match_pattern(name, path, tail, pat)
  -- If the pattern contains a / match against the full path, otherwise just the tail
  local fullpat = "^" .. pat .. "$"
  local matches
  if pat:find("/") then
    -- Similar to |autocmd-pattern|, if the pattern contains a '/' then check for a match against
    -- both the short file name (as typed) and the full file name (after expanding to full path
    -- and resolving symlinks)
    matches = name:match(fullpat) or path:match(fullpat)
  else
    matches = tail:match(fullpat)
  end
  return matches
end

--- Set the filetype for the given buffer from a file name.
---
---@param name string File name (can be an absolute or relative path)
---@param bufnr number|nil The buffer to set the filetype for. Defaults to the current buffer.
function M.match(name, bufnr)
  -- When fired from the main filetypedetect autocommand the {bufnr} argument is omitted, so we use
  -- the current buffer. The {bufnr} argument is provided to allow extensibility in case callers
  -- wish to perform filetype detection on buffers other than the current one.
  bufnr = bufnr or api.nvim_get_current_buf()

  name = normalize_path(name)

  -- First check for the simple case where the full path exists as a key
  local path = vim.fn.resolve(vim.fn.fnamemodify(name, ":p"))
  if dispatch(filename[path], path, bufnr) then
    return
  end

  -- Next check against just the file name
  local tail = vim.fn.fnamemodify(name, ":t")
  if dispatch(filename[tail], path, bufnr) then
    return
  end

  -- Next, check the file path against available patterns with non-negative priority
  local j = 1
  for i, v in ipairs(pattern_sorted) do
    local k = next(v)
    local opts = v[k][2]
    if opts.priority < 0 then
      j = i
      break
    end

    local ft = v[k][1]
    local matches = match_pattern(name, path, tail, k)
    if matches then
      if dispatch(ft, path, bufnr, matches) then
        return
      end
    end
  end

  -- Next, check file extension
  local ext = vim.fn.fnamemodify(name, ":e")
  if dispatch(extension[ext], path, bufnr) then
    return
  end

  -- Finally, check patterns with negative priority
  for i = j, #pattern_sorted do
    local v = pattern_sorted[i]
    local k = next(v)

    local ft = v[k][1]
    local matches = match_pattern(name, path, tail, k)
    if matches then
      if dispatch(ft, path, bufnr, matches) then
        return
      end
    end
  end
end

return M
