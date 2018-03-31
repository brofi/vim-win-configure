function Resolve-PathSafe {
    param([string] $Path)
    $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
}

$webClient = New-Object System.Net.WebClient

$locVimPlug = "~\vimfiles\autoload\plug.vim"
$dirVimPlug = Split-Path -Parent ($locVimPlug)

$uriVimPlug = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
$uriVimrc = 'https://raw.githubusercontent.com/brofi/dotfiles/master/.vimrc'

if (!(Test-Path $dirVimPlug)) {
    New-Item -ItemType Directory ($dirVimPlug) | Out-Null
}

$webClient.DownloadFile($uriVimPlug, (Resolve-PathSafe($locVimPlug)))
$webClient.DownloadFile($uriVimrc, (Resolve-PathSafe("~\_vimrc")))

Write-Host "Done configuring Vim..."
Pause