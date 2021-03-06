# FileName: install.ps1
# Description: For installing my vim config in windows

#{ Some variables
## init localtion
$init_localtion=$(get-location).Path;
## Exit status
$EXIT_SUCCESS = $true;
$EXIT_FAIL = $false;

## git repository prefix
$GITREP = "https://github.com/";

## backup directory
$BACKUP = "./backup"

## Install file dictionary
$Install_dict = @{"./vimrc"="$HOME/.vimrc";
"./Profile.ps1"="$profile";
"./texrc.tex"="$HOME/texrc.tex";
"./Misc/acadrc.lsp"="$HOME/acadrc.lsp";
"./vlisp"="$HOME/vlisp";
"./Misc/vsvimrc"="$HOME/.vsvimrc";
"./Misc/ycm_extra_conf.py"="$HOME/.ycm_extra_conf.py";
"./vim/colors"="$HOME/.vim/colors";
"./vim/self-plugins"="$HOME/.vim/self-plugins";
"./vim/vim-conf"="$HOME/.vim/vim-conf";
"./tex"="$HOME/.tex";
"./asyLib"="$HOME/.asy/asyLib";
"./vscode/snippets"="$env:APPDATA/Code/User/snippets";
"./vscode/keybindings.json"="$env:APPDATA/Code/User/keybindings.json";
"./vscode/settings.json"="$env:APPDATA/Code/User/settings.json"
};

## vim plugin list
$Plugin_list = @("VundleVim/Vundle.vim", "Lokaltog/vim-powerline");
## vim plugin local location
$PLU_INS = "$HOME/.vim/bundle";
#}

$GIT_ENABLE = $true;
#{ Dependencies check.
while($true){
    try{
        # supressed output.
        git --version >> $null
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        Write-Output "git doesn't install, so giving up some process that involved git.";
        $GIT_ENABLE = $false;
    }
    clear; break;
}
#}

# usage : install_fil <src> <dest>
#{ function : install_fil()
function install_fil()
{
    if(-not $args.count -eq 2){
        Write-Error -Message "Argument Error in install_fil()." -Category "InvalidArgument";
    }
    set-variable install_fil_src -Option readOnly -value $args[0];
	set-variable install_fil_dst -Option readOnly -value $args[1];
    if(Test-path $install_fil_dst.toString()){
        move-item $install_fil_dst.toString() $BACKUP;
    }
    if(Test-Path -Path $install_fil_src -PathType leaf){
        try{
            New-Item -ItemType HardLink -Path $install_fil_dst -Value $install_fil_src >> $null;
        } catch [System.Management.Automation.PSArgumentException] {
            $Error.RemoveAt(0);
            cmd /c mklink /H $install_fil_dst.toString().replace('/', '\') $install_fil_src.toString().replace('/', '\') >> $null;
        }
    } elseif (Test-Path -Path $install_fil_src -PathType Container){
        try{
            New-Item -ItemType Junction -Path $install_fil_dst -Value $install_fil_src >> $null;
        } catch [System.Management.Automation.PSArgumentException] {
            $Error.removeAt(0);
            cmd /c mklink /J $install_fil_dst.toString().replace('/', '\') $install_fil_src.toString().replace('/', '\') >> $null;
        }
    }
#    Copy-Item -Force -Recurse $install_fil_src.toString() $install_fil_dst.toString();
}
#} End function

# usage : install_plug <git_rep>
#{ function : install_plug()
function install_plug()
{
    if(!$GIT_ENABLE){return $false} # make sure git is installed before running git
    if(-not $args.count -eq 1){
        Write-Error -Message "Argument Error in install_plug()." -Category "InvalidArgument";
    }
    $Plug = $args[0].toString(); $plug_name = $Plug.remove(0, $Plug.indexOf('/') + 1);
    push-location $PLU_INS;
    if(Test-Path $plug_name){
        push-location $plug_name;
        if(test-path ".git"){
            Write-Output ("Plugin <{0}> already exist, skip it." -f $plug_name);
            return $true >> $null;
        } else {
            pop-location; remove-item -Force -recurse $plug_name;
        }
        Write-Output "Install plugin <$plug_name>.";
        $Plug_address = $GITREP + $Plug;
        echo $Plug_address;
        git clone --recurse-submodules $Plug_address >> $null;
        if(Test-path $plug_name){
            return $true >> $null;
        } else {
            Write-Warning "Install <$plug_name> failed.";
            return $false >> $null;
        }
    }
}
#}

# Main process
#{
while($true){
    Write-Output "**REMOVE** backup.";
    if(Test-Path $BACKUP){
        remove-item -Force -Recurse $BACKUP;
        new-item -itemType 'directory' $BACKUP >> $null;
    }
    Write-Output "***BEGIN** install files...";
    foreach($dictEnt in $Install_dict.getEnumerator()){
        install_fil $dictEnt.key $dictEnt.value;
        Write-Output ("File <{0}> to <{1}>." -f $dictEnt.key, $dictEnt.value);
    }
    Write-Output "**FINISH** install files!";
    if(-not (Test-Path $PLU_INS)){
        new-item -itemType 'directory' $PLU_INS >> $null;
    }
    Write-Output "***BEGIN** install plugins...";
    foreach($plug in $Plugin_list.getEnumerator()){
        install_plug $plug;
    }
    Write-Output "**FINISH** install plugins!";
    Write-Output "**FINISH**"; push-location $init_localtion; exit $true;
}
#}
