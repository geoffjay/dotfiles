# set prompt: 'username2hotname/directory $ ''
PS1="[\u@\h:\w] "
case 'id -u' in
  0) PS1="${PS1}# " ;;
  #*) PS1="${PS1}$ "	;;
  *) PS1="\n[\u@\h][jobs:\j][\w]\n[! \!] :: " ;;
esac

umask 0002

#if [ `which byobu-launcher` 1>&/dev/null ]; then
#  `echo $- | grep -qs i` && byobu-launcher && exit 0
#fi
