
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   e:	00000097          	auipc	ra,0x0
  12:	2fa080e7          	jalr	762(ra) # 308 <strlen>
  16:	02051793          	slli	a5,a0,0x20
  1a:	9381                	srli	a5,a5,0x20
  1c:	97a6                	add	a5,a5,s1
  1e:	02f00693          	li	a3,47
  22:	0097e963          	bltu	a5,s1,34 <fmtname+0x34>
  26:	0007c703          	lbu	a4,0(a5)
  2a:	00d70563          	beq	a4,a3,34 <fmtname+0x34>
  2e:	17fd                	addi	a5,a5,-1
  30:	fe97fbe3          	bgeu	a5,s1,26 <fmtname+0x26>
    ;
  p++;
  34:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  38:	8526                	mv	a0,s1
  3a:	00000097          	auipc	ra,0x0
  3e:	2ce080e7          	jalr	718(ra) # 308 <strlen>
  42:	2501                	sext.w	a0,a0
  44:	47b5                	li	a5,13
  46:	00a7f963          	bgeu	a5,a0,58 <fmtname+0x58>
    return p;
  memmove(buf, p, strlen(p));
  buf[strlen(p)] = '\0';
  return buf;
}
  4a:	8526                	mv	a0,s1
  4c:	60e2                	ld	ra,24(sp)
  4e:	6442                	ld	s0,16(sp)
  50:	64a2                	ld	s1,8(sp)
  52:	6902                	ld	s2,0(sp)
  54:	6105                	addi	sp,sp,32
  56:	8082                	ret
  memmove(buf, p, strlen(p));
  58:	8526                	mv	a0,s1
  5a:	00000097          	auipc	ra,0x0
  5e:	2ae080e7          	jalr	686(ra) # 308 <strlen>
  62:	00001917          	auipc	s2,0x1
  66:	ade90913          	addi	s2,s2,-1314 # b40 <buf.0>
  6a:	0005061b          	sext.w	a2,a0
  6e:	85a6                	mv	a1,s1
  70:	854a                	mv	a0,s2
  72:	00000097          	auipc	ra,0x0
  76:	408080e7          	jalr	1032(ra) # 47a <memmove>
  buf[strlen(p)] = '\0';
  7a:	8526                	mv	a0,s1
  7c:	00000097          	auipc	ra,0x0
  80:	28c080e7          	jalr	652(ra) # 308 <strlen>
  84:	02051793          	slli	a5,a0,0x20
  88:	9381                	srli	a5,a5,0x20
  8a:	97ca                	add	a5,a5,s2
  8c:	00078023          	sb	zero,0(a5)
  return buf;
  90:	84ca                	mv	s1,s2
  92:	bf65                	j	4a <fmtname+0x4a>

0000000000000094 <printfind>:

void printfind(char* parentname,char* findname) {
  94:	d9010113          	addi	sp,sp,-624
  98:	26113423          	sd	ra,616(sp)
  9c:	26813023          	sd	s0,608(sp)
  a0:	24913c23          	sd	s1,600(sp)
  a4:	25213823          	sd	s2,592(sp)
  a8:	25313423          	sd	s3,584(sp)
  ac:	25413023          	sd	s4,576(sp)
  b0:	23513c23          	sd	s5,568(sp)
  b4:	23613823          	sd	s6,560(sp)
  b8:	1c80                	addi	s0,sp,624
  ba:	892a                	mv	s2,a0
  bc:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    if((fd = open(parentname, 0)) < 0){
  be:	4581                	li	a1,0
  c0:	00000097          	auipc	ra,0x0
  c4:	4ac080e7          	jalr	1196(ra) # 56c <open>
  c8:	04054e63          	bltz	a0,124 <printfind+0x90>
  cc:	84aa                	mv	s1,a0
        fprintf(2, "ls: cannot open %s\n", buf);
        return;
    }
    if(fstat(fd, &st) < 0){
  ce:	d9840593          	addi	a1,s0,-616
  d2:	00000097          	auipc	ra,0x0
  d6:	4b2080e7          	jalr	1202(ra) # 584 <fstat>
  da:	06054163          	bltz	a0,13c <printfind+0xa8>
        fprintf(2, "ls: cannot stat %s\n", buf);
        close(fd);
        return;
    }
    if(st.type == T_FILE) {
  de:	da041783          	lh	a5,-608(s0)
  e2:	0007869b          	sext.w	a3,a5
  e6:	4709                	li	a4,2
  e8:	06e68b63          	beq	a3,a4,15e <printfind+0xca>
        if(strcmp(fmtname(parentname),findname) == 0) {
            printf("%s\n",parentname);
        }
    } else if(st.type == T_DIR) {
  ec:	2781                	sext.w	a5,a5
  ee:	4705                	li	a4,1
  f0:	08e78c63          	beq	a5,a4,188 <printfind+0xf4>
            memmove(p, de.name, strlen(de.name));
            p[strlen(de.name)] = '\0';
            printfind(buf,findname);
        }
    }
    close(fd);
  f4:	8526                	mv	a0,s1
  f6:	00000097          	auipc	ra,0x0
  fa:	45e080e7          	jalr	1118(ra) # 554 <close>
}
  fe:	26813083          	ld	ra,616(sp)
 102:	26013403          	ld	s0,608(sp)
 106:	25813483          	ld	s1,600(sp)
 10a:	25013903          	ld	s2,592(sp)
 10e:	24813983          	ld	s3,584(sp)
 112:	24013a03          	ld	s4,576(sp)
 116:	23813a83          	ld	s5,568(sp)
 11a:	23013b03          	ld	s6,560(sp)
 11e:	27010113          	addi	sp,sp,624
 122:	8082                	ret
        fprintf(2, "ls: cannot open %s\n", buf);
 124:	dc040613          	addi	a2,s0,-576
 128:	00001597          	auipc	a1,0x1
 12c:	92058593          	addi	a1,a1,-1760 # a48 <malloc+0xea>
 130:	4509                	li	a0,2
 132:	00000097          	auipc	ra,0x0
 136:	746080e7          	jalr	1862(ra) # 878 <fprintf>
        return;
 13a:	b7d1                	j	fe <printfind+0x6a>
        fprintf(2, "ls: cannot stat %s\n", buf);
 13c:	dc040613          	addi	a2,s0,-576
 140:	00001597          	auipc	a1,0x1
 144:	92058593          	addi	a1,a1,-1760 # a60 <malloc+0x102>
 148:	4509                	li	a0,2
 14a:	00000097          	auipc	ra,0x0
 14e:	72e080e7          	jalr	1838(ra) # 878 <fprintf>
        close(fd);
 152:	8526                	mv	a0,s1
 154:	00000097          	auipc	ra,0x0
 158:	400080e7          	jalr	1024(ra) # 554 <close>
        return;
 15c:	b74d                	j	fe <printfind+0x6a>
        if(strcmp(fmtname(parentname),findname) == 0) {
 15e:	854a                	mv	a0,s2
 160:	00000097          	auipc	ra,0x0
 164:	ea0080e7          	jalr	-352(ra) # 0 <fmtname>
 168:	85ce                	mv	a1,s3
 16a:	00000097          	auipc	ra,0x0
 16e:	172080e7          	jalr	370(ra) # 2dc <strcmp>
 172:	f149                	bnez	a0,f4 <printfind+0x60>
            printf("%s\n",parentname);
 174:	85ca                	mv	a1,s2
 176:	00001517          	auipc	a0,0x1
 17a:	8e250513          	addi	a0,a0,-1822 # a58 <malloc+0xfa>
 17e:	00000097          	auipc	ra,0x0
 182:	728080e7          	jalr	1832(ra) # 8a6 <printf>
 186:	b7bd                	j	f4 <printfind+0x60>
        if(strlen(parentname) + 1 + DIRSIZ + 1 > sizeof buf){
 188:	854a                	mv	a0,s2
 18a:	00000097          	auipc	ra,0x0
 18e:	17e080e7          	jalr	382(ra) # 308 <strlen>
 192:	2541                	addiw	a0,a0,16
 194:	20000793          	li	a5,512
 198:	0ca7eb63          	bltu	a5,a0,26e <printfind+0x1da>
        memmove(buf,parentname,strlen(parentname));
 19c:	854a                	mv	a0,s2
 19e:	00000097          	auipc	ra,0x0
 1a2:	16a080e7          	jalr	362(ra) # 308 <strlen>
 1a6:	0005061b          	sext.w	a2,a0
 1aa:	85ca                	mv	a1,s2
 1ac:	dc040513          	addi	a0,s0,-576
 1b0:	00000097          	auipc	ra,0x0
 1b4:	2ca080e7          	jalr	714(ra) # 47a <memmove>
        p = buf+strlen(parentname);
 1b8:	854a                	mv	a0,s2
 1ba:	00000097          	auipc	ra,0x0
 1be:	14e080e7          	jalr	334(ra) # 308 <strlen>
 1c2:	1502                	slli	a0,a0,0x20
 1c4:	9101                	srli	a0,a0,0x20
 1c6:	dc040793          	addi	a5,s0,-576
 1ca:	97aa                	add	a5,a5,a0
        *p++ = '/';
 1cc:	00178a93          	addi	s5,a5,1
 1d0:	02f00713          	li	a4,47
 1d4:	00e78023          	sb	a4,0(a5)
            if(de.inum == 0 || de.inum == 1 || strcmp(de.name,".") == 0 || strcmp(de.name,"..")== 0)
 1d8:	4905                	li	s2,1
 1da:	00001a17          	auipc	s4,0x1
 1de:	8b6a0a13          	addi	s4,s4,-1866 # a90 <malloc+0x132>
 1e2:	00001b17          	auipc	s6,0x1
 1e6:	8b6b0b13          	addi	s6,s6,-1866 # a98 <malloc+0x13a>
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1ea:	4641                	li	a2,16
 1ec:	db040593          	addi	a1,s0,-592
 1f0:	8526                	mv	a0,s1
 1f2:	00000097          	auipc	ra,0x0
 1f6:	352080e7          	jalr	850(ra) # 544 <read>
 1fa:	47c1                	li	a5,16
 1fc:	eef51ce3          	bne	a0,a5,f4 <printfind+0x60>
            if(de.inum == 0 || de.inum == 1 || strcmp(de.name,".") == 0 || strcmp(de.name,"..")== 0)
 200:	db045783          	lhu	a5,-592(s0)
 204:	fef973e3          	bgeu	s2,a5,1ea <printfind+0x156>
 208:	85d2                	mv	a1,s4
 20a:	db240513          	addi	a0,s0,-590
 20e:	00000097          	auipc	ra,0x0
 212:	0ce080e7          	jalr	206(ra) # 2dc <strcmp>
 216:	d971                	beqz	a0,1ea <printfind+0x156>
 218:	85da                	mv	a1,s6
 21a:	db240513          	addi	a0,s0,-590
 21e:	00000097          	auipc	ra,0x0
 222:	0be080e7          	jalr	190(ra) # 2dc <strcmp>
 226:	d171                	beqz	a0,1ea <printfind+0x156>
            memmove(p, de.name, strlen(de.name));
 228:	db240513          	addi	a0,s0,-590
 22c:	00000097          	auipc	ra,0x0
 230:	0dc080e7          	jalr	220(ra) # 308 <strlen>
 234:	0005061b          	sext.w	a2,a0
 238:	db240593          	addi	a1,s0,-590
 23c:	8556                	mv	a0,s5
 23e:	00000097          	auipc	ra,0x0
 242:	23c080e7          	jalr	572(ra) # 47a <memmove>
            p[strlen(de.name)] = '\0';
 246:	db240513          	addi	a0,s0,-590
 24a:	00000097          	auipc	ra,0x0
 24e:	0be080e7          	jalr	190(ra) # 308 <strlen>
 252:	02051793          	slli	a5,a0,0x20
 256:	9381                	srli	a5,a5,0x20
 258:	97d6                	add	a5,a5,s5
 25a:	00078023          	sb	zero,0(a5)
            printfind(buf,findname);
 25e:	85ce                	mv	a1,s3
 260:	dc040513          	addi	a0,s0,-576
 264:	00000097          	auipc	ra,0x0
 268:	e30080e7          	jalr	-464(ra) # 94 <printfind>
 26c:	bfbd                	j	1ea <printfind+0x156>
            printf("ls: path too long\n");
 26e:	00001517          	auipc	a0,0x1
 272:	80a50513          	addi	a0,a0,-2038 # a78 <malloc+0x11a>
 276:	00000097          	auipc	ra,0x0
 27a:	630080e7          	jalr	1584(ra) # 8a6 <printf>
            return;
 27e:	b541                	j	fe <printfind+0x6a>

0000000000000280 <main>:

int main(int argc,char** argv)
{
 280:	1141                	addi	sp,sp,-16
 282:	e406                	sd	ra,8(sp)
 284:	e022                	sd	s0,0(sp)
 286:	0800                	addi	s0,sp,16
    if(argc < 3) {
 288:	4709                	li	a4,2
 28a:	00a74f63          	blt	a4,a0,2a8 <main+0x28>
        printf("usage: find [dir1] [file_name]\n");
 28e:	00001517          	auipc	a0,0x1
 292:	81250513          	addi	a0,a0,-2030 # aa0 <malloc+0x142>
 296:	00000097          	auipc	ra,0x0
 29a:	610080e7          	jalr	1552(ra) # 8a6 <printf>
        return 0;
    }
    printfind(argv[1],argv[2]);
    exit(0);
 29e:	4501                	li	a0,0
 2a0:	60a2                	ld	ra,8(sp)
 2a2:	6402                	ld	s0,0(sp)
 2a4:	0141                	addi	sp,sp,16
 2a6:	8082                	ret
 2a8:	87ae                	mv	a5,a1
    printfind(argv[1],argv[2]);
 2aa:	698c                	ld	a1,16(a1)
 2ac:	6788                	ld	a0,8(a5)
 2ae:	00000097          	auipc	ra,0x0
 2b2:	de6080e7          	jalr	-538(ra) # 94 <printfind>
    exit(0);
 2b6:	4501                	li	a0,0
 2b8:	00000097          	auipc	ra,0x0
 2bc:	274080e7          	jalr	628(ra) # 52c <exit>

00000000000002c0 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e422                	sd	s0,8(sp)
 2c4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c6:	87aa                	mv	a5,a0
 2c8:	0585                	addi	a1,a1,1
 2ca:	0785                	addi	a5,a5,1
 2cc:	fff5c703          	lbu	a4,-1(a1)
 2d0:	fee78fa3          	sb	a4,-1(a5)
 2d4:	fb75                	bnez	a4,2c8 <strcpy+0x8>
    ;
  return os;
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2dc:	1141                	addi	sp,sp,-16
 2de:	e422                	sd	s0,8(sp)
 2e0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	cb91                	beqz	a5,2fa <strcmp+0x1e>
 2e8:	0005c703          	lbu	a4,0(a1)
 2ec:	00f71763          	bne	a4,a5,2fa <strcmp+0x1e>
    p++, q++;
 2f0:	0505                	addi	a0,a0,1
 2f2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	fbe5                	bnez	a5,2e8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2fa:	0005c503          	lbu	a0,0(a1)
}
 2fe:	40a7853b          	subw	a0,a5,a0
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <strlen>:

uint
strlen(const char *s)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e422                	sd	s0,8(sp)
 30c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 30e:	00054783          	lbu	a5,0(a0)
 312:	cf91                	beqz	a5,32e <strlen+0x26>
 314:	0505                	addi	a0,a0,1
 316:	87aa                	mv	a5,a0
 318:	4685                	li	a3,1
 31a:	9e89                	subw	a3,a3,a0
 31c:	00f6853b          	addw	a0,a3,a5
 320:	0785                	addi	a5,a5,1
 322:	fff7c703          	lbu	a4,-1(a5)
 326:	fb7d                	bnez	a4,31c <strlen+0x14>
    ;
  return n;
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret
  for(n = 0; s[n]; n++)
 32e:	4501                	li	a0,0
 330:	bfe5                	j	328 <strlen+0x20>

0000000000000332 <memset>:

void*
memset(void *dst, int c, uint n)
{
 332:	1141                	addi	sp,sp,-16
 334:	e422                	sd	s0,8(sp)
 336:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 338:	ca19                	beqz	a2,34e <memset+0x1c>
 33a:	87aa                	mv	a5,a0
 33c:	1602                	slli	a2,a2,0x20
 33e:	9201                	srli	a2,a2,0x20
 340:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 344:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 348:	0785                	addi	a5,a5,1
 34a:	fee79de3          	bne	a5,a4,344 <memset+0x12>
  }
  return dst;
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	addi	sp,sp,16
 352:	8082                	ret

0000000000000354 <strchr>:

char*
strchr(const char *s, char c)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  for(; *s; s++)
 35a:	00054783          	lbu	a5,0(a0)
 35e:	cb99                	beqz	a5,374 <strchr+0x20>
    if(*s == c)
 360:	00f58763          	beq	a1,a5,36e <strchr+0x1a>
  for(; *s; s++)
 364:	0505                	addi	a0,a0,1
 366:	00054783          	lbu	a5,0(a0)
 36a:	fbfd                	bnez	a5,360 <strchr+0xc>
      return (char*)s;
  return 0;
 36c:	4501                	li	a0,0
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <strchr+0x1a>

0000000000000378 <gets>:

char*
gets(char *buf, int max)
{
 378:	711d                	addi	sp,sp,-96
 37a:	ec86                	sd	ra,88(sp)
 37c:	e8a2                	sd	s0,80(sp)
 37e:	e4a6                	sd	s1,72(sp)
 380:	e0ca                	sd	s2,64(sp)
 382:	fc4e                	sd	s3,56(sp)
 384:	f852                	sd	s4,48(sp)
 386:	f456                	sd	s5,40(sp)
 388:	f05a                	sd	s6,32(sp)
 38a:	ec5e                	sd	s7,24(sp)
 38c:	1080                	addi	s0,sp,96
 38e:	8baa                	mv	s7,a0
 390:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 392:	892a                	mv	s2,a0
 394:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 396:	4aa9                	li	s5,10
 398:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 39a:	89a6                	mv	s3,s1
 39c:	2485                	addiw	s1,s1,1
 39e:	0344d863          	bge	s1,s4,3ce <gets+0x56>
    cc = read(0, &c, 1);
 3a2:	4605                	li	a2,1
 3a4:	faf40593          	addi	a1,s0,-81
 3a8:	4501                	li	a0,0
 3aa:	00000097          	auipc	ra,0x0
 3ae:	19a080e7          	jalr	410(ra) # 544 <read>
    if(cc < 1)
 3b2:	00a05e63          	blez	a0,3ce <gets+0x56>
    buf[i++] = c;
 3b6:	faf44783          	lbu	a5,-81(s0)
 3ba:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3be:	01578763          	beq	a5,s5,3cc <gets+0x54>
 3c2:	0905                	addi	s2,s2,1
 3c4:	fd679be3          	bne	a5,s6,39a <gets+0x22>
  for(i=0; i+1 < max; ){
 3c8:	89a6                	mv	s3,s1
 3ca:	a011                	j	3ce <gets+0x56>
 3cc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ce:	99de                	add	s3,s3,s7
 3d0:	00098023          	sb	zero,0(s3)
  return buf;
}
 3d4:	855e                	mv	a0,s7
 3d6:	60e6                	ld	ra,88(sp)
 3d8:	6446                	ld	s0,80(sp)
 3da:	64a6                	ld	s1,72(sp)
 3dc:	6906                	ld	s2,64(sp)
 3de:	79e2                	ld	s3,56(sp)
 3e0:	7a42                	ld	s4,48(sp)
 3e2:	7aa2                	ld	s5,40(sp)
 3e4:	7b02                	ld	s6,32(sp)
 3e6:	6be2                	ld	s7,24(sp)
 3e8:	6125                	addi	sp,sp,96
 3ea:	8082                	ret

00000000000003ec <stat>:

int
stat(const char *n, struct stat *st)
{
 3ec:	1101                	addi	sp,sp,-32
 3ee:	ec06                	sd	ra,24(sp)
 3f0:	e822                	sd	s0,16(sp)
 3f2:	e426                	sd	s1,8(sp)
 3f4:	e04a                	sd	s2,0(sp)
 3f6:	1000                	addi	s0,sp,32
 3f8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fa:	4581                	li	a1,0
 3fc:	00000097          	auipc	ra,0x0
 400:	170080e7          	jalr	368(ra) # 56c <open>
  if(fd < 0)
 404:	02054563          	bltz	a0,42e <stat+0x42>
 408:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 40a:	85ca                	mv	a1,s2
 40c:	00000097          	auipc	ra,0x0
 410:	178080e7          	jalr	376(ra) # 584 <fstat>
 414:	892a                	mv	s2,a0
  close(fd);
 416:	8526                	mv	a0,s1
 418:	00000097          	auipc	ra,0x0
 41c:	13c080e7          	jalr	316(ra) # 554 <close>
  return r;
}
 420:	854a                	mv	a0,s2
 422:	60e2                	ld	ra,24(sp)
 424:	6442                	ld	s0,16(sp)
 426:	64a2                	ld	s1,8(sp)
 428:	6902                	ld	s2,0(sp)
 42a:	6105                	addi	sp,sp,32
 42c:	8082                	ret
    return -1;
 42e:	597d                	li	s2,-1
 430:	bfc5                	j	420 <stat+0x34>

0000000000000432 <atoi>:

int
atoi(const char *s)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 438:	00054683          	lbu	a3,0(a0)
 43c:	fd06879b          	addiw	a5,a3,-48
 440:	0ff7f793          	zext.b	a5,a5
 444:	4625                	li	a2,9
 446:	02f66863          	bltu	a2,a5,476 <atoi+0x44>
 44a:	872a                	mv	a4,a0
  n = 0;
 44c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 44e:	0705                	addi	a4,a4,1
 450:	0025179b          	slliw	a5,a0,0x2
 454:	9fa9                	addw	a5,a5,a0
 456:	0017979b          	slliw	a5,a5,0x1
 45a:	9fb5                	addw	a5,a5,a3
 45c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 460:	00074683          	lbu	a3,0(a4)
 464:	fd06879b          	addiw	a5,a3,-48
 468:	0ff7f793          	zext.b	a5,a5
 46c:	fef671e3          	bgeu	a2,a5,44e <atoi+0x1c>
  return n;
}
 470:	6422                	ld	s0,8(sp)
 472:	0141                	addi	sp,sp,16
 474:	8082                	ret
  n = 0;
 476:	4501                	li	a0,0
 478:	bfe5                	j	470 <atoi+0x3e>

000000000000047a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 480:	02b57463          	bgeu	a0,a1,4a8 <memmove+0x2e>
    while(n-- > 0)
 484:	00c05f63          	blez	a2,4a2 <memmove+0x28>
 488:	1602                	slli	a2,a2,0x20
 48a:	9201                	srli	a2,a2,0x20
 48c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 490:	872a                	mv	a4,a0
      *dst++ = *src++;
 492:	0585                	addi	a1,a1,1
 494:	0705                	addi	a4,a4,1
 496:	fff5c683          	lbu	a3,-1(a1)
 49a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 49e:	fee79ae3          	bne	a5,a4,492 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
    dst += n;
 4a8:	00c50733          	add	a4,a0,a2
    src += n;
 4ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ae:	fec05ae3          	blez	a2,4a2 <memmove+0x28>
 4b2:	fff6079b          	addiw	a5,a2,-1
 4b6:	1782                	slli	a5,a5,0x20
 4b8:	9381                	srli	a5,a5,0x20
 4ba:	fff7c793          	not	a5,a5
 4be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4c0:	15fd                	addi	a1,a1,-1
 4c2:	177d                	addi	a4,a4,-1
 4c4:	0005c683          	lbu	a3,0(a1)
 4c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4cc:	fee79ae3          	bne	a5,a4,4c0 <memmove+0x46>
 4d0:	bfc9                	j	4a2 <memmove+0x28>

00000000000004d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4d8:	ca05                	beqz	a2,508 <memcmp+0x36>
 4da:	fff6069b          	addiw	a3,a2,-1
 4de:	1682                	slli	a3,a3,0x20
 4e0:	9281                	srli	a3,a3,0x20
 4e2:	0685                	addi	a3,a3,1
 4e4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4e6:	00054783          	lbu	a5,0(a0)
 4ea:	0005c703          	lbu	a4,0(a1)
 4ee:	00e79863          	bne	a5,a4,4fe <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4f2:	0505                	addi	a0,a0,1
    p2++;
 4f4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4f6:	fed518e3          	bne	a0,a3,4e6 <memcmp+0x14>
  }
  return 0;
 4fa:	4501                	li	a0,0
 4fc:	a019                	j	502 <memcmp+0x30>
      return *p1 - *p2;
 4fe:	40e7853b          	subw	a0,a5,a4
}
 502:	6422                	ld	s0,8(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret
  return 0;
 508:	4501                	li	a0,0
 50a:	bfe5                	j	502 <memcmp+0x30>

000000000000050c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50c:	1141                	addi	sp,sp,-16
 50e:	e406                	sd	ra,8(sp)
 510:	e022                	sd	s0,0(sp)
 512:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 514:	00000097          	auipc	ra,0x0
 518:	f66080e7          	jalr	-154(ra) # 47a <memmove>
}
 51c:	60a2                	ld	ra,8(sp)
 51e:	6402                	ld	s0,0(sp)
 520:	0141                	addi	sp,sp,16
 522:	8082                	ret

0000000000000524 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 524:	4885                	li	a7,1
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <exit>:
.global exit
exit:
 li a7, SYS_exit
 52c:	4889                	li	a7,2
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <wait>:
.global wait
wait:
 li a7, SYS_wait
 534:	488d                	li	a7,3
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 53c:	4891                	li	a7,4
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <read>:
.global read
read:
 li a7, SYS_read
 544:	4895                	li	a7,5
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <write>:
.global write
write:
 li a7, SYS_write
 54c:	48c1                	li	a7,16
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <close>:
.global close
close:
 li a7, SYS_close
 554:	48d5                	li	a7,21
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <kill>:
.global kill
kill:
 li a7, SYS_kill
 55c:	4899                	li	a7,6
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <exec>:
.global exec
exec:
 li a7, SYS_exec
 564:	489d                	li	a7,7
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <open>:
.global open
open:
 li a7, SYS_open
 56c:	48bd                	li	a7,15
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 574:	48c5                	li	a7,17
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 57c:	48c9                	li	a7,18
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 584:	48a1                	li	a7,8
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <link>:
.global link
link:
 li a7, SYS_link
 58c:	48cd                	li	a7,19
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 594:	48d1                	li	a7,20
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 59c:	48a5                	li	a7,9
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a4:	48a9                	li	a7,10
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ac:	48ad                	li	a7,11
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5b4:	48b1                	li	a7,12
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5bc:	48b5                	li	a7,13
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c4:	48b9                	li	a7,14
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	1000                	addi	s0,sp,32
 5d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d8:	4605                	li	a2,1
 5da:	fef40593          	addi	a1,s0,-17
 5de:	00000097          	auipc	ra,0x0
 5e2:	f6e080e7          	jalr	-146(ra) # 54c <write>
}
 5e6:	60e2                	ld	ra,24(sp)
 5e8:	6442                	ld	s0,16(sp)
 5ea:	6105                	addi	sp,sp,32
 5ec:	8082                	ret

00000000000005ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5ee:	7139                	addi	sp,sp,-64
 5f0:	fc06                	sd	ra,56(sp)
 5f2:	f822                	sd	s0,48(sp)
 5f4:	f426                	sd	s1,40(sp)
 5f6:	f04a                	sd	s2,32(sp)
 5f8:	ec4e                	sd	s3,24(sp)
 5fa:	0080                	addi	s0,sp,64
 5fc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fe:	c299                	beqz	a3,604 <printint+0x16>
 600:	0805c963          	bltz	a1,692 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 604:	2581                	sext.w	a1,a1
  neg = 0;
 606:	4881                	li	a7,0
 608:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 60c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 60e:	2601                	sext.w	a2,a2
 610:	00000517          	auipc	a0,0x0
 614:	51050513          	addi	a0,a0,1296 # b20 <digits>
 618:	883a                	mv	a6,a4
 61a:	2705                	addiw	a4,a4,1
 61c:	02c5f7bb          	remuw	a5,a1,a2
 620:	1782                	slli	a5,a5,0x20
 622:	9381                	srli	a5,a5,0x20
 624:	97aa                	add	a5,a5,a0
 626:	0007c783          	lbu	a5,0(a5)
 62a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 62e:	0005879b          	sext.w	a5,a1
 632:	02c5d5bb          	divuw	a1,a1,a2
 636:	0685                	addi	a3,a3,1
 638:	fec7f0e3          	bgeu	a5,a2,618 <printint+0x2a>
  if(neg)
 63c:	00088c63          	beqz	a7,654 <printint+0x66>
    buf[i++] = '-';
 640:	fd070793          	addi	a5,a4,-48
 644:	00878733          	add	a4,a5,s0
 648:	02d00793          	li	a5,45
 64c:	fef70823          	sb	a5,-16(a4)
 650:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 654:	02e05863          	blez	a4,684 <printint+0x96>
 658:	fc040793          	addi	a5,s0,-64
 65c:	00e78933          	add	s2,a5,a4
 660:	fff78993          	addi	s3,a5,-1
 664:	99ba                	add	s3,s3,a4
 666:	377d                	addiw	a4,a4,-1
 668:	1702                	slli	a4,a4,0x20
 66a:	9301                	srli	a4,a4,0x20
 66c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 670:	fff94583          	lbu	a1,-1(s2)
 674:	8526                	mv	a0,s1
 676:	00000097          	auipc	ra,0x0
 67a:	f56080e7          	jalr	-170(ra) # 5cc <putc>
  while(--i >= 0)
 67e:	197d                	addi	s2,s2,-1
 680:	ff3918e3          	bne	s2,s3,670 <printint+0x82>
}
 684:	70e2                	ld	ra,56(sp)
 686:	7442                	ld	s0,48(sp)
 688:	74a2                	ld	s1,40(sp)
 68a:	7902                	ld	s2,32(sp)
 68c:	69e2                	ld	s3,24(sp)
 68e:	6121                	addi	sp,sp,64
 690:	8082                	ret
    x = -xx;
 692:	40b005bb          	negw	a1,a1
    neg = 1;
 696:	4885                	li	a7,1
    x = -xx;
 698:	bf85                	j	608 <printint+0x1a>

000000000000069a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 69a:	7119                	addi	sp,sp,-128
 69c:	fc86                	sd	ra,120(sp)
 69e:	f8a2                	sd	s0,112(sp)
 6a0:	f4a6                	sd	s1,104(sp)
 6a2:	f0ca                	sd	s2,96(sp)
 6a4:	ecce                	sd	s3,88(sp)
 6a6:	e8d2                	sd	s4,80(sp)
 6a8:	e4d6                	sd	s5,72(sp)
 6aa:	e0da                	sd	s6,64(sp)
 6ac:	fc5e                	sd	s7,56(sp)
 6ae:	f862                	sd	s8,48(sp)
 6b0:	f466                	sd	s9,40(sp)
 6b2:	f06a                	sd	s10,32(sp)
 6b4:	ec6e                	sd	s11,24(sp)
 6b6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6b8:	0005c903          	lbu	s2,0(a1)
 6bc:	18090f63          	beqz	s2,85a <vprintf+0x1c0>
 6c0:	8aaa                	mv	s5,a0
 6c2:	8b32                	mv	s6,a2
 6c4:	00158493          	addi	s1,a1,1
  state = 0;
 6c8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ca:	02500a13          	li	s4,37
 6ce:	4c55                	li	s8,21
 6d0:	00000c97          	auipc	s9,0x0
 6d4:	3f8c8c93          	addi	s9,s9,1016 # ac8 <malloc+0x16a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6d8:	02800d93          	li	s11,40
  putc(fd, 'x');
 6dc:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6de:	00000b97          	auipc	s7,0x0
 6e2:	442b8b93          	addi	s7,s7,1090 # b20 <digits>
 6e6:	a839                	j	704 <vprintf+0x6a>
        putc(fd, c);
 6e8:	85ca                	mv	a1,s2
 6ea:	8556                	mv	a0,s5
 6ec:	00000097          	auipc	ra,0x0
 6f0:	ee0080e7          	jalr	-288(ra) # 5cc <putc>
 6f4:	a019                	j	6fa <vprintf+0x60>
    } else if(state == '%'){
 6f6:	01498d63          	beq	s3,s4,710 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 6fa:	0485                	addi	s1,s1,1
 6fc:	fff4c903          	lbu	s2,-1(s1)
 700:	14090d63          	beqz	s2,85a <vprintf+0x1c0>
    if(state == 0){
 704:	fe0999e3          	bnez	s3,6f6 <vprintf+0x5c>
      if(c == '%'){
 708:	ff4910e3          	bne	s2,s4,6e8 <vprintf+0x4e>
        state = '%';
 70c:	89d2                	mv	s3,s4
 70e:	b7f5                	j	6fa <vprintf+0x60>
      if(c == 'd'){
 710:	11490c63          	beq	s2,s4,828 <vprintf+0x18e>
 714:	f9d9079b          	addiw	a5,s2,-99
 718:	0ff7f793          	zext.b	a5,a5
 71c:	10fc6e63          	bltu	s8,a5,838 <vprintf+0x19e>
 720:	f9d9079b          	addiw	a5,s2,-99
 724:	0ff7f713          	zext.b	a4,a5
 728:	10ec6863          	bltu	s8,a4,838 <vprintf+0x19e>
 72c:	00271793          	slli	a5,a4,0x2
 730:	97e6                	add	a5,a5,s9
 732:	439c                	lw	a5,0(a5)
 734:	97e6                	add	a5,a5,s9
 736:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 738:	008b0913          	addi	s2,s6,8
 73c:	4685                	li	a3,1
 73e:	4629                	li	a2,10
 740:	000b2583          	lw	a1,0(s6)
 744:	8556                	mv	a0,s5
 746:	00000097          	auipc	ra,0x0
 74a:	ea8080e7          	jalr	-344(ra) # 5ee <printint>
 74e:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 750:	4981                	li	s3,0
 752:	b765                	j	6fa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 754:	008b0913          	addi	s2,s6,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000b2583          	lw	a1,0(s6)
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e8c080e7          	jalr	-372(ra) # 5ee <printint>
 76a:	8b4a                	mv	s6,s2
      state = 0;
 76c:	4981                	li	s3,0
 76e:	b771                	j	6fa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 770:	008b0913          	addi	s2,s6,8
 774:	4681                	li	a3,0
 776:	866a                	mv	a2,s10
 778:	000b2583          	lw	a1,0(s6)
 77c:	8556                	mv	a0,s5
 77e:	00000097          	auipc	ra,0x0
 782:	e70080e7          	jalr	-400(ra) # 5ee <printint>
 786:	8b4a                	mv	s6,s2
      state = 0;
 788:	4981                	li	s3,0
 78a:	bf85                	j	6fa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 78c:	008b0793          	addi	a5,s6,8
 790:	f8f43423          	sd	a5,-120(s0)
 794:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 798:	03000593          	li	a1,48
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	e2e080e7          	jalr	-466(ra) # 5cc <putc>
  putc(fd, 'x');
 7a6:	07800593          	li	a1,120
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	e20080e7          	jalr	-480(ra) # 5cc <putc>
 7b4:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b6:	03c9d793          	srli	a5,s3,0x3c
 7ba:	97de                	add	a5,a5,s7
 7bc:	0007c583          	lbu	a1,0(a5)
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	e0a080e7          	jalr	-502(ra) # 5cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ca:	0992                	slli	s3,s3,0x4
 7cc:	397d                	addiw	s2,s2,-1
 7ce:	fe0914e3          	bnez	s2,7b6 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 7d2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	b70d                	j	6fa <vprintf+0x60>
        s = va_arg(ap, char*);
 7da:	008b0913          	addi	s2,s6,8
 7de:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 7e2:	02098163          	beqz	s3,804 <vprintf+0x16a>
        while(*s != 0){
 7e6:	0009c583          	lbu	a1,0(s3)
 7ea:	c5ad                	beqz	a1,854 <vprintf+0x1ba>
          putc(fd, *s);
 7ec:	8556                	mv	a0,s5
 7ee:	00000097          	auipc	ra,0x0
 7f2:	dde080e7          	jalr	-546(ra) # 5cc <putc>
          s++;
 7f6:	0985                	addi	s3,s3,1
        while(*s != 0){
 7f8:	0009c583          	lbu	a1,0(s3)
 7fc:	f9e5                	bnez	a1,7ec <vprintf+0x152>
        s = va_arg(ap, char*);
 7fe:	8b4a                	mv	s6,s2
      state = 0;
 800:	4981                	li	s3,0
 802:	bde5                	j	6fa <vprintf+0x60>
          s = "(null)";
 804:	00000997          	auipc	s3,0x0
 808:	2bc98993          	addi	s3,s3,700 # ac0 <malloc+0x162>
        while(*s != 0){
 80c:	85ee                	mv	a1,s11
 80e:	bff9                	j	7ec <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 810:	008b0913          	addi	s2,s6,8
 814:	000b4583          	lbu	a1,0(s6)
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	db2080e7          	jalr	-590(ra) # 5cc <putc>
 822:	8b4a                	mv	s6,s2
      state = 0;
 824:	4981                	li	s3,0
 826:	bdd1                	j	6fa <vprintf+0x60>
        putc(fd, c);
 828:	85d2                	mv	a1,s4
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	da0080e7          	jalr	-608(ra) # 5cc <putc>
      state = 0;
 834:	4981                	li	s3,0
 836:	b5d1                	j	6fa <vprintf+0x60>
        putc(fd, '%');
 838:	85d2                	mv	a1,s4
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	d90080e7          	jalr	-624(ra) # 5cc <putc>
        putc(fd, c);
 844:	85ca                	mv	a1,s2
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	d84080e7          	jalr	-636(ra) # 5cc <putc>
      state = 0;
 850:	4981                	li	s3,0
 852:	b565                	j	6fa <vprintf+0x60>
        s = va_arg(ap, char*);
 854:	8b4a                	mv	s6,s2
      state = 0;
 856:	4981                	li	s3,0
 858:	b54d                	j	6fa <vprintf+0x60>
    }
  }
}
 85a:	70e6                	ld	ra,120(sp)
 85c:	7446                	ld	s0,112(sp)
 85e:	74a6                	ld	s1,104(sp)
 860:	7906                	ld	s2,96(sp)
 862:	69e6                	ld	s3,88(sp)
 864:	6a46                	ld	s4,80(sp)
 866:	6aa6                	ld	s5,72(sp)
 868:	6b06                	ld	s6,64(sp)
 86a:	7be2                	ld	s7,56(sp)
 86c:	7c42                	ld	s8,48(sp)
 86e:	7ca2                	ld	s9,40(sp)
 870:	7d02                	ld	s10,32(sp)
 872:	6de2                	ld	s11,24(sp)
 874:	6109                	addi	sp,sp,128
 876:	8082                	ret

0000000000000878 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 878:	715d                	addi	sp,sp,-80
 87a:	ec06                	sd	ra,24(sp)
 87c:	e822                	sd	s0,16(sp)
 87e:	1000                	addi	s0,sp,32
 880:	e010                	sd	a2,0(s0)
 882:	e414                	sd	a3,8(s0)
 884:	e818                	sd	a4,16(s0)
 886:	ec1c                	sd	a5,24(s0)
 888:	03043023          	sd	a6,32(s0)
 88c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 890:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 894:	8622                	mv	a2,s0
 896:	00000097          	auipc	ra,0x0
 89a:	e04080e7          	jalr	-508(ra) # 69a <vprintf>
}
 89e:	60e2                	ld	ra,24(sp)
 8a0:	6442                	ld	s0,16(sp)
 8a2:	6161                	addi	sp,sp,80
 8a4:	8082                	ret

00000000000008a6 <printf>:

void
printf(const char *fmt, ...)
{
 8a6:	711d                	addi	sp,sp,-96
 8a8:	ec06                	sd	ra,24(sp)
 8aa:	e822                	sd	s0,16(sp)
 8ac:	1000                	addi	s0,sp,32
 8ae:	e40c                	sd	a1,8(s0)
 8b0:	e810                	sd	a2,16(s0)
 8b2:	ec14                	sd	a3,24(s0)
 8b4:	f018                	sd	a4,32(s0)
 8b6:	f41c                	sd	a5,40(s0)
 8b8:	03043823          	sd	a6,48(s0)
 8bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8c0:	00840613          	addi	a2,s0,8
 8c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8c8:	85aa                	mv	a1,a0
 8ca:	4505                	li	a0,1
 8cc:	00000097          	auipc	ra,0x0
 8d0:	dce080e7          	jalr	-562(ra) # 69a <vprintf>
}
 8d4:	60e2                	ld	ra,24(sp)
 8d6:	6442                	ld	s0,16(sp)
 8d8:	6125                	addi	sp,sp,96
 8da:	8082                	ret

00000000000008dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8dc:	1141                	addi	sp,sp,-16
 8de:	e422                	sd	s0,8(sp)
 8e0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e6:	00000797          	auipc	a5,0x0
 8ea:	2527b783          	ld	a5,594(a5) # b38 <freep>
 8ee:	a02d                	j	918 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8f0:	4618                	lw	a4,8(a2)
 8f2:	9f2d                	addw	a4,a4,a1
 8f4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f8:	6398                	ld	a4,0(a5)
 8fa:	6310                	ld	a2,0(a4)
 8fc:	a83d                	j	93a <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8fe:	ff852703          	lw	a4,-8(a0)
 902:	9f31                	addw	a4,a4,a2
 904:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 906:	ff053683          	ld	a3,-16(a0)
 90a:	a091                	j	94e <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	6398                	ld	a4,0(a5)
 90e:	00e7e463          	bltu	a5,a4,916 <free+0x3a>
 912:	00e6ea63          	bltu	a3,a4,926 <free+0x4a>
{
 916:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 918:	fed7fae3          	bgeu	a5,a3,90c <free+0x30>
 91c:	6398                	ld	a4,0(a5)
 91e:	00e6e463          	bltu	a3,a4,926 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 922:	fee7eae3          	bltu	a5,a4,916 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 926:	ff852583          	lw	a1,-8(a0)
 92a:	6390                	ld	a2,0(a5)
 92c:	02059813          	slli	a6,a1,0x20
 930:	01c85713          	srli	a4,a6,0x1c
 934:	9736                	add	a4,a4,a3
 936:	fae60de3          	beq	a2,a4,8f0 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 93a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 93e:	4790                	lw	a2,8(a5)
 940:	02061593          	slli	a1,a2,0x20
 944:	01c5d713          	srli	a4,a1,0x1c
 948:	973e                	add	a4,a4,a5
 94a:	fae68ae3          	beq	a3,a4,8fe <free+0x22>
    p->s.ptr = bp->s.ptr;
 94e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 950:	00000717          	auipc	a4,0x0
 954:	1ef73423          	sd	a5,488(a4) # b38 <freep>
}
 958:	6422                	ld	s0,8(sp)
 95a:	0141                	addi	sp,sp,16
 95c:	8082                	ret

000000000000095e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 95e:	7139                	addi	sp,sp,-64
 960:	fc06                	sd	ra,56(sp)
 962:	f822                	sd	s0,48(sp)
 964:	f426                	sd	s1,40(sp)
 966:	f04a                	sd	s2,32(sp)
 968:	ec4e                	sd	s3,24(sp)
 96a:	e852                	sd	s4,16(sp)
 96c:	e456                	sd	s5,8(sp)
 96e:	e05a                	sd	s6,0(sp)
 970:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 972:	02051493          	slli	s1,a0,0x20
 976:	9081                	srli	s1,s1,0x20
 978:	04bd                	addi	s1,s1,15
 97a:	8091                	srli	s1,s1,0x4
 97c:	0014899b          	addiw	s3,s1,1
 980:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 982:	00000517          	auipc	a0,0x0
 986:	1b653503          	ld	a0,438(a0) # b38 <freep>
 98a:	c515                	beqz	a0,9b6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98e:	4798                	lw	a4,8(a5)
 990:	02977f63          	bgeu	a4,s1,9ce <malloc+0x70>
 994:	8a4e                	mv	s4,s3
 996:	0009871b          	sext.w	a4,s3
 99a:	6685                	lui	a3,0x1
 99c:	00d77363          	bgeu	a4,a3,9a2 <malloc+0x44>
 9a0:	6a05                	lui	s4,0x1
 9a2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9a6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9aa:	00000917          	auipc	s2,0x0
 9ae:	18e90913          	addi	s2,s2,398 # b38 <freep>
  if(p == (char*)-1)
 9b2:	5afd                	li	s5,-1
 9b4:	a895                	j	a28 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9b6:	00000797          	auipc	a5,0x0
 9ba:	19a78793          	addi	a5,a5,410 # b50 <base>
 9be:	00000717          	auipc	a4,0x0
 9c2:	16f73d23          	sd	a5,378(a4) # b38 <freep>
 9c6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9cc:	b7e1                	j	994 <malloc+0x36>
      if(p->s.size == nunits)
 9ce:	02e48c63          	beq	s1,a4,a06 <malloc+0xa8>
        p->s.size -= nunits;
 9d2:	4137073b          	subw	a4,a4,s3
 9d6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d8:	02071693          	slli	a3,a4,0x20
 9dc:	01c6d713          	srli	a4,a3,0x1c
 9e0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e6:	00000717          	auipc	a4,0x0
 9ea:	14a73923          	sd	a0,338(a4) # b38 <freep>
      return (void*)(p + 1);
 9ee:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9f2:	70e2                	ld	ra,56(sp)
 9f4:	7442                	ld	s0,48(sp)
 9f6:	74a2                	ld	s1,40(sp)
 9f8:	7902                	ld	s2,32(sp)
 9fa:	69e2                	ld	s3,24(sp)
 9fc:	6a42                	ld	s4,16(sp)
 9fe:	6aa2                	ld	s5,8(sp)
 a00:	6b02                	ld	s6,0(sp)
 a02:	6121                	addi	sp,sp,64
 a04:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a06:	6398                	ld	a4,0(a5)
 a08:	e118                	sd	a4,0(a0)
 a0a:	bff1                	j	9e6 <malloc+0x88>
  hp->s.size = nu;
 a0c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a10:	0541                	addi	a0,a0,16
 a12:	00000097          	auipc	ra,0x0
 a16:	eca080e7          	jalr	-310(ra) # 8dc <free>
  return freep;
 a1a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a1e:	d971                	beqz	a0,9f2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a22:	4798                	lw	a4,8(a5)
 a24:	fa9775e3          	bgeu	a4,s1,9ce <malloc+0x70>
    if(p == freep)
 a28:	00093703          	ld	a4,0(s2)
 a2c:	853e                	mv	a0,a5
 a2e:	fef719e3          	bne	a4,a5,a20 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a32:	8552                	mv	a0,s4
 a34:	00000097          	auipc	ra,0x0
 a38:	b80080e7          	jalr	-1152(ra) # 5b4 <sbrk>
  if(p == (char*)-1)
 a3c:	fd5518e3          	bne	a0,s5,a0c <malloc+0xae>
        return 0;
 a40:	4501                	li	a0,0
 a42:	bf45                	j	9f2 <malloc+0x94>
