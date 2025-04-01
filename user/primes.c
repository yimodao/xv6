#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "stddef.h"
void subprime(int fd) {
    int n;
    if(read(fd,&n,sizeof(int)) == 0) {
        exit(0);
    } else {
        printf("prime %d\n",n);
        int pipe_n[2];
        pipe(pipe_n);
        if(fork() == 0) {
            close(pipe_n[1]);
            subprime(pipe_n[0]);
        } else {
            close(pipe_n[0]);
            int p;
            while(read(fd,&p,sizeof(int))) {
                if(p%n) {
                    write(pipe_n[1],&p,sizeof(int));
                }
            }
            close(pipe_n[1]);
            wait(0);
            exit(0);
        }
    }
}

int main()
{
    int pipe_f[2];
    pipe(pipe_f);
    if(fork() == 0) {
        close(pipe_f[1]);
        subprime(pipe_f[0]);
    } else {
        printf("prime %d\n",2);
        close(pipe_f[0]);
        for(int i = 3;i <= 35;i++) {
            if(i%2) {
                write(pipe_f[1],&i,sizeof(i));
            }
        }
        close(pipe_f[1]);
        wait(0);
        exit(0);
    }
    return 0;
}