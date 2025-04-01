#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  buf[strlen(p)] = '\0';
  return buf;
}

void printfind(char* parentname,char* findname) {
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if((fd = open(parentname, 0)) < 0){
        fprintf(2, "ls: cannot open %s\n", buf);
        return;
    }
    if(fstat(fd, &st) < 0){
        fprintf(2, "ls: cannot stat %s\n", buf);
        close(fd);
        return;
    }
    if(st.type == T_FILE) {
        if(strcmp(fmtname(parentname),findname) == 0) {
            printf("%s\n",parentname);
        }
    } else if(st.type == T_DIR) {
        if(strlen(parentname) + 1 + DIRSIZ + 1 > sizeof buf){
            printf("ls: path too long\n");
            return;
        }
        memmove(buf,parentname,strlen(parentname));
        p = buf+strlen(parentname);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
            if(de.inum == 0 || de.inum == 1 || strcmp(de.name,".") == 0 || strcmp(de.name,"..")== 0)
                continue;
            memmove(p, de.name, strlen(de.name));
            p[strlen(de.name)] = '\0';
            printfind(buf,findname);
        }
    }
    close(fd);
}

int main(int argc,char** argv)
{
    if(argc < 3) {
        printf("usage: find [dir1] [file_name]\n");
        return 0;
    }
    printfind(argv[1],argv[2]);
    exit(0);
}