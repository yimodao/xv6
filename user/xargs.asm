
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char **argv)
{
   0:	d4010113          	addi	sp,sp,-704
   4:	2a113c23          	sd	ra,696(sp)
   8:	2a813823          	sd	s0,688(sp)
   c:	2a913423          	sd	s1,680(sp)
  10:	2b213023          	sd	s2,672(sp)
  14:	29313c23          	sd	s3,664(sp)
  18:	29413823          	sd	s4,656(sp)
  1c:	29513423          	sd	s5,648(sp)
  20:	29613023          	sd	s6,640(sp)
  24:	27713c23          	sd	s7,632(sp)
  28:	27813823          	sd	s8,624(sp)
  2c:	27913423          	sd	s9,616(sp)
  30:	0580                	addi	s0,sp,704
  32:	8c2e                	mv	s8,a1
    char charBuf[320]; // buf for the char of all token
    char *charBufPointer = charBuf;
    int charBufSize = 0;

    char *commandToken[32];   // record the token from input spilt by space(' ')
    int tokenSize = argc - 1; // record token number(initial is argc - 1,because xargs will bot be execute)
  34:	fff50b9b          	addiw	s7,a0,-1
    int inputSize = -1;

    // first copy initial argv argument to commandToken
    for (int tokenIdx = 0; tokenIdx < tokenSize; tokenIdx++)
  38:	03705563          	blez	s7,62 <main+0x62>
  3c:	00858713          	addi	a4,a1,8
  40:	d4040793          	addi	a5,s0,-704
  44:	ffe5069b          	addiw	a3,a0,-2
  48:	02069613          	slli	a2,a3,0x20
  4c:	01d65693          	srli	a3,a2,0x1d
  50:	d4840613          	addi	a2,s0,-696
  54:	96b2                	add	a3,a3,a2
        commandToken[tokenIdx] = argv[tokenIdx + 1];
  56:	6310                	ld	a2,0(a4)
  58:	e390                	sd	a2,0(a5)
    for (int tokenIdx = 0; tokenIdx < tokenSize; tokenIdx++)
  5a:	0721                	addi	a4,a4,8
  5c:	07a1                	addi	a5,a5,8
  5e:	fed79ce3          	bne	a5,a3,56 <main+0x56>
    int tokenSize = argc - 1; // record token number(initial is argc - 1,because xargs will bot be execute)
  62:	89de                	mv	s3,s7
    int charBufSize = 0;
  64:	4901                	li	s2,0
    char *charBufPointer = charBuf;
  66:	e4040c93          	addi	s9,s0,-448

    while ((inputSize = read(0, inputBuf, sizeof(inputBuf))) > 0)
  6a:	02000613          	li	a2,32
  6e:	f8040593          	addi	a1,s0,-128
  72:	4501                	li	a0,0
  74:	00000097          	auipc	ra,0x0
  78:	35a080e7          	jalr	858(ra) # 3ce <read>
  7c:	0ca05263          	blez	a0,140 <main+0x140>
    {
        for (int i = 0; i < inputSize; i++)
  80:	f8040493          	addi	s1,s0,-128
  84:	fff50a1b          	addiw	s4,a0,-1
  88:	1a02                	slli	s4,s4,0x20
  8a:	020a5a13          	srli	s4,s4,0x20
  8e:	f8140793          	addi	a5,s0,-127
  92:	9a3e                	add	s4,s4,a5
        {
            char curChar = inputBuf[i];
            if (curChar == '\n')
  94:	4aa9                	li	s5,10
                wait(0);
                tokenSize = argc - 1; // initialize
                charBufSize = 0;
                charBufPointer = charBuf;
            }
            else if (curChar == ' ')
  96:	02000b13          	li	s6,32
  9a:	a071                	j	126 <main+0x126>
                charBuf[charBufSize] = 0; // set '\0' to end of token
  9c:	fa090793          	addi	a5,s2,-96
  a0:	00878933          	add	s2,a5,s0
  a4:	ea090023          	sb	zero,-352(s2)
                commandToken[tokenSize++] = charBufPointer;
  a8:	00399793          	slli	a5,s3,0x3
  ac:	fa078793          	addi	a5,a5,-96
  b0:	97a2                	add	a5,a5,s0
  b2:	db97b023          	sd	s9,-608(a5)
                commandToken[tokenSize] = 0; // set nullptr in the end of array
  b6:	2985                	addiw	s3,s3,1
  b8:	098e                	slli	s3,s3,0x3
  ba:	fa098793          	addi	a5,s3,-96
  be:	008789b3          	add	s3,a5,s0
  c2:	da09b023          	sd	zero,-608(s3)
                if (fork() == 0)
  c6:	00000097          	auipc	ra,0x0
  ca:	2e8080e7          	jalr	744(ra) # 3ae <fork>
  ce:	c919                	beqz	a0,e4 <main+0xe4>
                wait(0);
  d0:	4501                	li	a0,0
  d2:	00000097          	auipc	ra,0x0
  d6:	2ec080e7          	jalr	748(ra) # 3be <wait>
                tokenSize = argc - 1; // initialize
  da:	89de                	mv	s3,s7
                charBufSize = 0;
  dc:	4901                	li	s2,0
                charBufPointer = charBuf;
  de:	e4040c93          	addi	s9,s0,-448
  e2:	a83d                	j	120 <main+0x120>
                    exec(argv[1], commandToken);
  e4:	d4040593          	addi	a1,s0,-704
  e8:	008c3503          	ld	a0,8(s8)
  ec:	00000097          	auipc	ra,0x0
  f0:	302080e7          	jalr	770(ra) # 3ee <exec>
  f4:	bff1                	j	d0 <main+0xd0>
            {
                charBuf[charBufSize++] = 0; // mark the end of string
  f6:	0019071b          	addiw	a4,s2,1
  fa:	fa090793          	addi	a5,s2,-96
  fe:	00878933          	add	s2,a5,s0
 102:	ea090023          	sb	zero,-352(s2)
                commandToken[tokenSize++] = charBufPointer;
 106:	00399793          	slli	a5,s3,0x3
 10a:	fa078793          	addi	a5,a5,-96
 10e:	97a2                	add	a5,a5,s0
 110:	db97b023          	sd	s9,-608(a5)
                charBufPointer = charBuf + charBufSize; // change to the start of new string
 114:	e4040793          	addi	a5,s0,-448
 118:	00e78cb3          	add	s9,a5,a4
                commandToken[tokenSize++] = charBufPointer;
 11c:	2985                	addiw	s3,s3,1
                charBuf[charBufSize++] = 0; // mark the end of string
 11e:	893a                	mv	s2,a4
        for (int i = 0; i < inputSize; i++)
 120:	0485                	addi	s1,s1,1
 122:	f49a04e3          	beq	s4,s1,6a <main+0x6a>
            char curChar = inputBuf[i];
 126:	0004c783          	lbu	a5,0(s1)
            if (curChar == '\n')
 12a:	f75789e3          	beq	a5,s5,9c <main+0x9c>
            else if (curChar == ' ')
 12e:	fd6784e3          	beq	a5,s6,f6 <main+0xf6>
            }
            else
            {
                charBuf[charBufSize++] = curChar;
 132:	fa090713          	addi	a4,s2,-96
 136:	9722                	add	a4,a4,s0
 138:	eaf70023          	sb	a5,-352(a4)
 13c:	2905                	addiw	s2,s2,1
 13e:	b7cd                	j	120 <main+0x120>
            }
        }
    }
    exit(0);
 140:	4501                	li	a0,0
 142:	00000097          	auipc	ra,0x0
 146:	274080e7          	jalr	628(ra) # 3b6 <exit>

000000000000014a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 14a:	1141                	addi	sp,sp,-16
 14c:	e422                	sd	s0,8(sp)
 14e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 150:	87aa                	mv	a5,a0
 152:	0585                	addi	a1,a1,1
 154:	0785                	addi	a5,a5,1
 156:	fff5c703          	lbu	a4,-1(a1)
 15a:	fee78fa3          	sb	a4,-1(a5)
 15e:	fb75                	bnez	a4,152 <strcpy+0x8>
    ;
  return os;
}
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cb91                	beqz	a5,184 <strcmp+0x1e>
 172:	0005c703          	lbu	a4,0(a1)
 176:	00f71763          	bne	a4,a5,184 <strcmp+0x1e>
    p++, q++;
 17a:	0505                	addi	a0,a0,1
 17c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 17e:	00054783          	lbu	a5,0(a0)
 182:	fbe5                	bnez	a5,172 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 184:	0005c503          	lbu	a0,0(a1)
}
 188:	40a7853b          	subw	a0,a5,a0
 18c:	6422                	ld	s0,8(sp)
 18e:	0141                	addi	sp,sp,16
 190:	8082                	ret

0000000000000192 <strlen>:

uint
strlen(const char *s)
{
 192:	1141                	addi	sp,sp,-16
 194:	e422                	sd	s0,8(sp)
 196:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 198:	00054783          	lbu	a5,0(a0)
 19c:	cf91                	beqz	a5,1b8 <strlen+0x26>
 19e:	0505                	addi	a0,a0,1
 1a0:	87aa                	mv	a5,a0
 1a2:	4685                	li	a3,1
 1a4:	9e89                	subw	a3,a3,a0
 1a6:	00f6853b          	addw	a0,a3,a5
 1aa:	0785                	addi	a5,a5,1
 1ac:	fff7c703          	lbu	a4,-1(a5)
 1b0:	fb7d                	bnez	a4,1a6 <strlen+0x14>
    ;
  return n;
}
 1b2:	6422                	ld	s0,8(sp)
 1b4:	0141                	addi	sp,sp,16
 1b6:	8082                	ret
  for(n = 0; s[n]; n++)
 1b8:	4501                	li	a0,0
 1ba:	bfe5                	j	1b2 <strlen+0x20>

00000000000001bc <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bc:	1141                	addi	sp,sp,-16
 1be:	e422                	sd	s0,8(sp)
 1c0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1c2:	ca19                	beqz	a2,1d8 <memset+0x1c>
 1c4:	87aa                	mv	a5,a0
 1c6:	1602                	slli	a2,a2,0x20
 1c8:	9201                	srli	a2,a2,0x20
 1ca:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ce:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1d2:	0785                	addi	a5,a5,1
 1d4:	fee79de3          	bne	a5,a4,1ce <memset+0x12>
  }
  return dst;
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <strchr>:

char*
strchr(const char *s, char c)
{
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1e4:	00054783          	lbu	a5,0(a0)
 1e8:	cb99                	beqz	a5,1fe <strchr+0x20>
    if(*s == c)
 1ea:	00f58763          	beq	a1,a5,1f8 <strchr+0x1a>
  for(; *s; s++)
 1ee:	0505                	addi	a0,a0,1
 1f0:	00054783          	lbu	a5,0(a0)
 1f4:	fbfd                	bnez	a5,1ea <strchr+0xc>
      return (char*)s;
  return 0;
 1f6:	4501                	li	a0,0
}
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret
  return 0;
 1fe:	4501                	li	a0,0
 200:	bfe5                	j	1f8 <strchr+0x1a>

0000000000000202 <gets>:

char*
gets(char *buf, int max)
{
 202:	711d                	addi	sp,sp,-96
 204:	ec86                	sd	ra,88(sp)
 206:	e8a2                	sd	s0,80(sp)
 208:	e4a6                	sd	s1,72(sp)
 20a:	e0ca                	sd	s2,64(sp)
 20c:	fc4e                	sd	s3,56(sp)
 20e:	f852                	sd	s4,48(sp)
 210:	f456                	sd	s5,40(sp)
 212:	f05a                	sd	s6,32(sp)
 214:	ec5e                	sd	s7,24(sp)
 216:	1080                	addi	s0,sp,96
 218:	8baa                	mv	s7,a0
 21a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21c:	892a                	mv	s2,a0
 21e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 220:	4aa9                	li	s5,10
 222:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 224:	89a6                	mv	s3,s1
 226:	2485                	addiw	s1,s1,1
 228:	0344d863          	bge	s1,s4,258 <gets+0x56>
    cc = read(0, &c, 1);
 22c:	4605                	li	a2,1
 22e:	faf40593          	addi	a1,s0,-81
 232:	4501                	li	a0,0
 234:	00000097          	auipc	ra,0x0
 238:	19a080e7          	jalr	410(ra) # 3ce <read>
    if(cc < 1)
 23c:	00a05e63          	blez	a0,258 <gets+0x56>
    buf[i++] = c;
 240:	faf44783          	lbu	a5,-81(s0)
 244:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 248:	01578763          	beq	a5,s5,256 <gets+0x54>
 24c:	0905                	addi	s2,s2,1
 24e:	fd679be3          	bne	a5,s6,224 <gets+0x22>
  for(i=0; i+1 < max; ){
 252:	89a6                	mv	s3,s1
 254:	a011                	j	258 <gets+0x56>
 256:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 258:	99de                	add	s3,s3,s7
 25a:	00098023          	sb	zero,0(s3)
  return buf;
}
 25e:	855e                	mv	a0,s7
 260:	60e6                	ld	ra,88(sp)
 262:	6446                	ld	s0,80(sp)
 264:	64a6                	ld	s1,72(sp)
 266:	6906                	ld	s2,64(sp)
 268:	79e2                	ld	s3,56(sp)
 26a:	7a42                	ld	s4,48(sp)
 26c:	7aa2                	ld	s5,40(sp)
 26e:	7b02                	ld	s6,32(sp)
 270:	6be2                	ld	s7,24(sp)
 272:	6125                	addi	sp,sp,96
 274:	8082                	ret

0000000000000276 <stat>:

int
stat(const char *n, struct stat *st)
{
 276:	1101                	addi	sp,sp,-32
 278:	ec06                	sd	ra,24(sp)
 27a:	e822                	sd	s0,16(sp)
 27c:	e426                	sd	s1,8(sp)
 27e:	e04a                	sd	s2,0(sp)
 280:	1000                	addi	s0,sp,32
 282:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 284:	4581                	li	a1,0
 286:	00000097          	auipc	ra,0x0
 28a:	170080e7          	jalr	368(ra) # 3f6 <open>
  if(fd < 0)
 28e:	02054563          	bltz	a0,2b8 <stat+0x42>
 292:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 294:	85ca                	mv	a1,s2
 296:	00000097          	auipc	ra,0x0
 29a:	178080e7          	jalr	376(ra) # 40e <fstat>
 29e:	892a                	mv	s2,a0
  close(fd);
 2a0:	8526                	mv	a0,s1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	13c080e7          	jalr	316(ra) # 3de <close>
  return r;
}
 2aa:	854a                	mv	a0,s2
 2ac:	60e2                	ld	ra,24(sp)
 2ae:	6442                	ld	s0,16(sp)
 2b0:	64a2                	ld	s1,8(sp)
 2b2:	6902                	ld	s2,0(sp)
 2b4:	6105                	addi	sp,sp,32
 2b6:	8082                	ret
    return -1;
 2b8:	597d                	li	s2,-1
 2ba:	bfc5                	j	2aa <stat+0x34>

00000000000002bc <atoi>:

int
atoi(const char *s)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c2:	00054683          	lbu	a3,0(a0)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	4625                	li	a2,9
 2d0:	02f66863          	bltu	a2,a5,300 <atoi+0x44>
 2d4:	872a                	mv	a4,a0
  n = 0;
 2d6:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d8:	0705                	addi	a4,a4,1
 2da:	0025179b          	slliw	a5,a0,0x2
 2de:	9fa9                	addw	a5,a5,a0
 2e0:	0017979b          	slliw	a5,a5,0x1
 2e4:	9fb5                	addw	a5,a5,a3
 2e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ea:	00074683          	lbu	a3,0(a4)
 2ee:	fd06879b          	addiw	a5,a3,-48
 2f2:	0ff7f793          	zext.b	a5,a5
 2f6:	fef671e3          	bgeu	a2,a5,2d8 <atoi+0x1c>
  return n;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret
  n = 0;
 300:	4501                	li	a0,0
 302:	bfe5                	j	2fa <atoi+0x3e>

0000000000000304 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 304:	1141                	addi	sp,sp,-16
 306:	e422                	sd	s0,8(sp)
 308:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30a:	02b57463          	bgeu	a0,a1,332 <memmove+0x2e>
    while(n-- > 0)
 30e:	00c05f63          	blez	a2,32c <memmove+0x28>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31a:	872a                	mv	a4,a0
      *dst++ = *src++;
 31c:	0585                	addi	a1,a1,1
 31e:	0705                	addi	a4,a4,1
 320:	fff5c683          	lbu	a3,-1(a1)
 324:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 328:	fee79ae3          	bne	a5,a4,31c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32c:	6422                	ld	s0,8(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret
    dst += n;
 332:	00c50733          	add	a4,a0,a2
    src += n;
 336:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 338:	fec05ae3          	blez	a2,32c <memmove+0x28>
 33c:	fff6079b          	addiw	a5,a2,-1
 340:	1782                	slli	a5,a5,0x20
 342:	9381                	srli	a5,a5,0x20
 344:	fff7c793          	not	a5,a5
 348:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34a:	15fd                	addi	a1,a1,-1
 34c:	177d                	addi	a4,a4,-1
 34e:	0005c683          	lbu	a3,0(a1)
 352:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 356:	fee79ae3          	bne	a5,a4,34a <memmove+0x46>
 35a:	bfc9                	j	32c <memmove+0x28>

000000000000035c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35c:	1141                	addi	sp,sp,-16
 35e:	e422                	sd	s0,8(sp)
 360:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 362:	ca05                	beqz	a2,392 <memcmp+0x36>
 364:	fff6069b          	addiw	a3,a2,-1
 368:	1682                	slli	a3,a3,0x20
 36a:	9281                	srli	a3,a3,0x20
 36c:	0685                	addi	a3,a3,1
 36e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 370:	00054783          	lbu	a5,0(a0)
 374:	0005c703          	lbu	a4,0(a1)
 378:	00e79863          	bne	a5,a4,388 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 37c:	0505                	addi	a0,a0,1
    p2++;
 37e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 380:	fed518e3          	bne	a0,a3,370 <memcmp+0x14>
  }
  return 0;
 384:	4501                	li	a0,0
 386:	a019                	j	38c <memcmp+0x30>
      return *p1 - *p2;
 388:	40e7853b          	subw	a0,a5,a4
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfe5                	j	38c <memcmp+0x30>

0000000000000396 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 396:	1141                	addi	sp,sp,-16
 398:	e406                	sd	ra,8(sp)
 39a:	e022                	sd	s0,0(sp)
 39c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 39e:	00000097          	auipc	ra,0x0
 3a2:	f66080e7          	jalr	-154(ra) # 304 <memmove>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ae:	4885                	li	a7,1
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b6:	4889                	li	a7,2
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <wait>:
.global wait
wait:
 li a7, SYS_wait
 3be:	488d                	li	a7,3
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c6:	4891                	li	a7,4
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <read>:
.global read
read:
 li a7, SYS_read
 3ce:	4895                	li	a7,5
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <write>:
.global write
write:
 li a7, SYS_write
 3d6:	48c1                	li	a7,16
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <close>:
.global close
close:
 li a7, SYS_close
 3de:	48d5                	li	a7,21
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e6:	4899                	li	a7,6
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ee:	489d                	li	a7,7
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <open>:
.global open
open:
 li a7, SYS_open
 3f6:	48bd                	li	a7,15
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fe:	48c5                	li	a7,17
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 406:	48c9                	li	a7,18
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40e:	48a1                	li	a7,8
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <link>:
.global link
link:
 li a7, SYS_link
 416:	48cd                	li	a7,19
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41e:	48d1                	li	a7,20
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 426:	48a5                	li	a7,9
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <dup>:
.global dup
dup:
 li a7, SYS_dup
 42e:	48a9                	li	a7,10
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 436:	48ad                	li	a7,11
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43e:	48b1                	li	a7,12
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 446:	48b5                	li	a7,13
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44e:	48b9                	li	a7,14
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 456:	1101                	addi	sp,sp,-32
 458:	ec06                	sd	ra,24(sp)
 45a:	e822                	sd	s0,16(sp)
 45c:	1000                	addi	s0,sp,32
 45e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 462:	4605                	li	a2,1
 464:	fef40593          	addi	a1,s0,-17
 468:	00000097          	auipc	ra,0x0
 46c:	f6e080e7          	jalr	-146(ra) # 3d6 <write>
}
 470:	60e2                	ld	ra,24(sp)
 472:	6442                	ld	s0,16(sp)
 474:	6105                	addi	sp,sp,32
 476:	8082                	ret

0000000000000478 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 478:	7139                	addi	sp,sp,-64
 47a:	fc06                	sd	ra,56(sp)
 47c:	f822                	sd	s0,48(sp)
 47e:	f426                	sd	s1,40(sp)
 480:	f04a                	sd	s2,32(sp)
 482:	ec4e                	sd	s3,24(sp)
 484:	0080                	addi	s0,sp,64
 486:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 488:	c299                	beqz	a3,48e <printint+0x16>
 48a:	0805c963          	bltz	a1,51c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 48e:	2581                	sext.w	a1,a1
  neg = 0;
 490:	4881                	li	a7,0
 492:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 496:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 498:	2601                	sext.w	a2,a2
 49a:	00000517          	auipc	a0,0x0
 49e:	49650513          	addi	a0,a0,1174 # 930 <digits>
 4a2:	883a                	mv	a6,a4
 4a4:	2705                	addiw	a4,a4,1
 4a6:	02c5f7bb          	remuw	a5,a1,a2
 4aa:	1782                	slli	a5,a5,0x20
 4ac:	9381                	srli	a5,a5,0x20
 4ae:	97aa                	add	a5,a5,a0
 4b0:	0007c783          	lbu	a5,0(a5)
 4b4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4b8:	0005879b          	sext.w	a5,a1
 4bc:	02c5d5bb          	divuw	a1,a1,a2
 4c0:	0685                	addi	a3,a3,1
 4c2:	fec7f0e3          	bgeu	a5,a2,4a2 <printint+0x2a>
  if(neg)
 4c6:	00088c63          	beqz	a7,4de <printint+0x66>
    buf[i++] = '-';
 4ca:	fd070793          	addi	a5,a4,-48
 4ce:	00878733          	add	a4,a5,s0
 4d2:	02d00793          	li	a5,45
 4d6:	fef70823          	sb	a5,-16(a4)
 4da:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4de:	02e05863          	blez	a4,50e <printint+0x96>
 4e2:	fc040793          	addi	a5,s0,-64
 4e6:	00e78933          	add	s2,a5,a4
 4ea:	fff78993          	addi	s3,a5,-1
 4ee:	99ba                	add	s3,s3,a4
 4f0:	377d                	addiw	a4,a4,-1
 4f2:	1702                	slli	a4,a4,0x20
 4f4:	9301                	srli	a4,a4,0x20
 4f6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4fa:	fff94583          	lbu	a1,-1(s2)
 4fe:	8526                	mv	a0,s1
 500:	00000097          	auipc	ra,0x0
 504:	f56080e7          	jalr	-170(ra) # 456 <putc>
  while(--i >= 0)
 508:	197d                	addi	s2,s2,-1
 50a:	ff3918e3          	bne	s2,s3,4fa <printint+0x82>
}
 50e:	70e2                	ld	ra,56(sp)
 510:	7442                	ld	s0,48(sp)
 512:	74a2                	ld	s1,40(sp)
 514:	7902                	ld	s2,32(sp)
 516:	69e2                	ld	s3,24(sp)
 518:	6121                	addi	sp,sp,64
 51a:	8082                	ret
    x = -xx;
 51c:	40b005bb          	negw	a1,a1
    neg = 1;
 520:	4885                	li	a7,1
    x = -xx;
 522:	bf85                	j	492 <printint+0x1a>

0000000000000524 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 524:	7119                	addi	sp,sp,-128
 526:	fc86                	sd	ra,120(sp)
 528:	f8a2                	sd	s0,112(sp)
 52a:	f4a6                	sd	s1,104(sp)
 52c:	f0ca                	sd	s2,96(sp)
 52e:	ecce                	sd	s3,88(sp)
 530:	e8d2                	sd	s4,80(sp)
 532:	e4d6                	sd	s5,72(sp)
 534:	e0da                	sd	s6,64(sp)
 536:	fc5e                	sd	s7,56(sp)
 538:	f862                	sd	s8,48(sp)
 53a:	f466                	sd	s9,40(sp)
 53c:	f06a                	sd	s10,32(sp)
 53e:	ec6e                	sd	s11,24(sp)
 540:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 542:	0005c903          	lbu	s2,0(a1)
 546:	18090f63          	beqz	s2,6e4 <vprintf+0x1c0>
 54a:	8aaa                	mv	s5,a0
 54c:	8b32                	mv	s6,a2
 54e:	00158493          	addi	s1,a1,1
  state = 0;
 552:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 554:	02500a13          	li	s4,37
 558:	4c55                	li	s8,21
 55a:	00000c97          	auipc	s9,0x0
 55e:	37ec8c93          	addi	s9,s9,894 # 8d8 <malloc+0xf0>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 562:	02800d93          	li	s11,40
  putc(fd, 'x');
 566:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 568:	00000b97          	auipc	s7,0x0
 56c:	3c8b8b93          	addi	s7,s7,968 # 930 <digits>
 570:	a839                	j	58e <vprintf+0x6a>
        putc(fd, c);
 572:	85ca                	mv	a1,s2
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	ee0080e7          	jalr	-288(ra) # 456 <putc>
 57e:	a019                	j	584 <vprintf+0x60>
    } else if(state == '%'){
 580:	01498d63          	beq	s3,s4,59a <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 584:	0485                	addi	s1,s1,1
 586:	fff4c903          	lbu	s2,-1(s1)
 58a:	14090d63          	beqz	s2,6e4 <vprintf+0x1c0>
    if(state == 0){
 58e:	fe0999e3          	bnez	s3,580 <vprintf+0x5c>
      if(c == '%'){
 592:	ff4910e3          	bne	s2,s4,572 <vprintf+0x4e>
        state = '%';
 596:	89d2                	mv	s3,s4
 598:	b7f5                	j	584 <vprintf+0x60>
      if(c == 'd'){
 59a:	11490c63          	beq	s2,s4,6b2 <vprintf+0x18e>
 59e:	f9d9079b          	addiw	a5,s2,-99
 5a2:	0ff7f793          	zext.b	a5,a5
 5a6:	10fc6e63          	bltu	s8,a5,6c2 <vprintf+0x19e>
 5aa:	f9d9079b          	addiw	a5,s2,-99
 5ae:	0ff7f713          	zext.b	a4,a5
 5b2:	10ec6863          	bltu	s8,a4,6c2 <vprintf+0x19e>
 5b6:	00271793          	slli	a5,a4,0x2
 5ba:	97e6                	add	a5,a5,s9
 5bc:	439c                	lw	a5,0(a5)
 5be:	97e6                	add	a5,a5,s9
 5c0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5c2:	008b0913          	addi	s2,s6,8
 5c6:	4685                	li	a3,1
 5c8:	4629                	li	a2,10
 5ca:	000b2583          	lw	a1,0(s6)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	ea8080e7          	jalr	-344(ra) # 478 <printint>
 5d8:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b765                	j	584 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5de:	008b0913          	addi	s2,s6,8
 5e2:	4681                	li	a3,0
 5e4:	4629                	li	a2,10
 5e6:	000b2583          	lw	a1,0(s6)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e8c080e7          	jalr	-372(ra) # 478 <printint>
 5f4:	8b4a                	mv	s6,s2
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b771                	j	584 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5fa:	008b0913          	addi	s2,s6,8
 5fe:	4681                	li	a3,0
 600:	866a                	mv	a2,s10
 602:	000b2583          	lw	a1,0(s6)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e70080e7          	jalr	-400(ra) # 478 <printint>
 610:	8b4a                	mv	s6,s2
      state = 0;
 612:	4981                	li	s3,0
 614:	bf85                	j	584 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 616:	008b0793          	addi	a5,s6,8
 61a:	f8f43423          	sd	a5,-120(s0)
 61e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 622:	03000593          	li	a1,48
 626:	8556                	mv	a0,s5
 628:	00000097          	auipc	ra,0x0
 62c:	e2e080e7          	jalr	-466(ra) # 456 <putc>
  putc(fd, 'x');
 630:	07800593          	li	a1,120
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e20080e7          	jalr	-480(ra) # 456 <putc>
 63e:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 640:	03c9d793          	srli	a5,s3,0x3c
 644:	97de                	add	a5,a5,s7
 646:	0007c583          	lbu	a1,0(a5)
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	e0a080e7          	jalr	-502(ra) # 456 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 654:	0992                	slli	s3,s3,0x4
 656:	397d                	addiw	s2,s2,-1
 658:	fe0914e3          	bnez	s2,640 <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 65c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 660:	4981                	li	s3,0
 662:	b70d                	j	584 <vprintf+0x60>
        s = va_arg(ap, char*);
 664:	008b0913          	addi	s2,s6,8
 668:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 66c:	02098163          	beqz	s3,68e <vprintf+0x16a>
        while(*s != 0){
 670:	0009c583          	lbu	a1,0(s3)
 674:	c5ad                	beqz	a1,6de <vprintf+0x1ba>
          putc(fd, *s);
 676:	8556                	mv	a0,s5
 678:	00000097          	auipc	ra,0x0
 67c:	dde080e7          	jalr	-546(ra) # 456 <putc>
          s++;
 680:	0985                	addi	s3,s3,1
        while(*s != 0){
 682:	0009c583          	lbu	a1,0(s3)
 686:	f9e5                	bnez	a1,676 <vprintf+0x152>
        s = va_arg(ap, char*);
 688:	8b4a                	mv	s6,s2
      state = 0;
 68a:	4981                	li	s3,0
 68c:	bde5                	j	584 <vprintf+0x60>
          s = "(null)";
 68e:	00000997          	auipc	s3,0x0
 692:	24298993          	addi	s3,s3,578 # 8d0 <malloc+0xe8>
        while(*s != 0){
 696:	85ee                	mv	a1,s11
 698:	bff9                	j	676 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 69a:	008b0913          	addi	s2,s6,8
 69e:	000b4583          	lbu	a1,0(s6)
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	db2080e7          	jalr	-590(ra) # 456 <putc>
 6ac:	8b4a                	mv	s6,s2
      state = 0;
 6ae:	4981                	li	s3,0
 6b0:	bdd1                	j	584 <vprintf+0x60>
        putc(fd, c);
 6b2:	85d2                	mv	a1,s4
 6b4:	8556                	mv	a0,s5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	da0080e7          	jalr	-608(ra) # 456 <putc>
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	b5d1                	j	584 <vprintf+0x60>
        putc(fd, '%');
 6c2:	85d2                	mv	a1,s4
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	d90080e7          	jalr	-624(ra) # 456 <putc>
        putc(fd, c);
 6ce:	85ca                	mv	a1,s2
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	d84080e7          	jalr	-636(ra) # 456 <putc>
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b565                	j	584 <vprintf+0x60>
        s = va_arg(ap, char*);
 6de:	8b4a                	mv	s6,s2
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b54d                	j	584 <vprintf+0x60>
    }
  }
}
 6e4:	70e6                	ld	ra,120(sp)
 6e6:	7446                	ld	s0,112(sp)
 6e8:	74a6                	ld	s1,104(sp)
 6ea:	7906                	ld	s2,96(sp)
 6ec:	69e6                	ld	s3,88(sp)
 6ee:	6a46                	ld	s4,80(sp)
 6f0:	6aa6                	ld	s5,72(sp)
 6f2:	6b06                	ld	s6,64(sp)
 6f4:	7be2                	ld	s7,56(sp)
 6f6:	7c42                	ld	s8,48(sp)
 6f8:	7ca2                	ld	s9,40(sp)
 6fa:	7d02                	ld	s10,32(sp)
 6fc:	6de2                	ld	s11,24(sp)
 6fe:	6109                	addi	sp,sp,128
 700:	8082                	ret

0000000000000702 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 702:	715d                	addi	sp,sp,-80
 704:	ec06                	sd	ra,24(sp)
 706:	e822                	sd	s0,16(sp)
 708:	1000                	addi	s0,sp,32
 70a:	e010                	sd	a2,0(s0)
 70c:	e414                	sd	a3,8(s0)
 70e:	e818                	sd	a4,16(s0)
 710:	ec1c                	sd	a5,24(s0)
 712:	03043023          	sd	a6,32(s0)
 716:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 71a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 71e:	8622                	mv	a2,s0
 720:	00000097          	auipc	ra,0x0
 724:	e04080e7          	jalr	-508(ra) # 524 <vprintf>
}
 728:	60e2                	ld	ra,24(sp)
 72a:	6442                	ld	s0,16(sp)
 72c:	6161                	addi	sp,sp,80
 72e:	8082                	ret

0000000000000730 <printf>:

void
printf(const char *fmt, ...)
{
 730:	711d                	addi	sp,sp,-96
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	1000                	addi	s0,sp,32
 738:	e40c                	sd	a1,8(s0)
 73a:	e810                	sd	a2,16(s0)
 73c:	ec14                	sd	a3,24(s0)
 73e:	f018                	sd	a4,32(s0)
 740:	f41c                	sd	a5,40(s0)
 742:	03043823          	sd	a6,48(s0)
 746:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 74a:	00840613          	addi	a2,s0,8
 74e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 752:	85aa                	mv	a1,a0
 754:	4505                	li	a0,1
 756:	00000097          	auipc	ra,0x0
 75a:	dce080e7          	jalr	-562(ra) # 524 <vprintf>
}
 75e:	60e2                	ld	ra,24(sp)
 760:	6442                	ld	s0,16(sp)
 762:	6125                	addi	sp,sp,96
 764:	8082                	ret

0000000000000766 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 766:	1141                	addi	sp,sp,-16
 768:	e422                	sd	s0,8(sp)
 76a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 76c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	00000797          	auipc	a5,0x0
 774:	1d87b783          	ld	a5,472(a5) # 948 <freep>
 778:	a02d                	j	7a2 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 77a:	4618                	lw	a4,8(a2)
 77c:	9f2d                	addw	a4,a4,a1
 77e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 782:	6398                	ld	a4,0(a5)
 784:	6310                	ld	a2,0(a4)
 786:	a83d                	j	7c4 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 788:	ff852703          	lw	a4,-8(a0)
 78c:	9f31                	addw	a4,a4,a2
 78e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 790:	ff053683          	ld	a3,-16(a0)
 794:	a091                	j	7d8 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 796:	6398                	ld	a4,0(a5)
 798:	00e7e463          	bltu	a5,a4,7a0 <free+0x3a>
 79c:	00e6ea63          	bltu	a3,a4,7b0 <free+0x4a>
{
 7a0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	fed7fae3          	bgeu	a5,a3,796 <free+0x30>
 7a6:	6398                	ld	a4,0(a5)
 7a8:	00e6e463          	bltu	a3,a4,7b0 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ac:	fee7eae3          	bltu	a5,a4,7a0 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7b0:	ff852583          	lw	a1,-8(a0)
 7b4:	6390                	ld	a2,0(a5)
 7b6:	02059813          	slli	a6,a1,0x20
 7ba:	01c85713          	srli	a4,a6,0x1c
 7be:	9736                	add	a4,a4,a3
 7c0:	fae60de3          	beq	a2,a4,77a <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c8:	4790                	lw	a2,8(a5)
 7ca:	02061593          	slli	a1,a2,0x20
 7ce:	01c5d713          	srli	a4,a1,0x1c
 7d2:	973e                	add	a4,a4,a5
 7d4:	fae68ae3          	beq	a3,a4,788 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7d8:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7da:	00000717          	auipc	a4,0x0
 7de:	16f73723          	sd	a5,366(a4) # 948 <freep>
}
 7e2:	6422                	ld	s0,8(sp)
 7e4:	0141                	addi	sp,sp,16
 7e6:	8082                	ret

00000000000007e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f426                	sd	s1,40(sp)
 7f0:	f04a                	sd	s2,32(sp)
 7f2:	ec4e                	sd	s3,24(sp)
 7f4:	e852                	sd	s4,16(sp)
 7f6:	e456                	sd	s5,8(sp)
 7f8:	e05a                	sd	s6,0(sp)
 7fa:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fc:	02051493          	slli	s1,a0,0x20
 800:	9081                	srli	s1,s1,0x20
 802:	04bd                	addi	s1,s1,15
 804:	8091                	srli	s1,s1,0x4
 806:	0014899b          	addiw	s3,s1,1
 80a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 80c:	00000517          	auipc	a0,0x0
 810:	13c53503          	ld	a0,316(a0) # 948 <freep>
 814:	c515                	beqz	a0,840 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 816:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 818:	4798                	lw	a4,8(a5)
 81a:	02977f63          	bgeu	a4,s1,858 <malloc+0x70>
 81e:	8a4e                	mv	s4,s3
 820:	0009871b          	sext.w	a4,s3
 824:	6685                	lui	a3,0x1
 826:	00d77363          	bgeu	a4,a3,82c <malloc+0x44>
 82a:	6a05                	lui	s4,0x1
 82c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 830:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 834:	00000917          	auipc	s2,0x0
 838:	11490913          	addi	s2,s2,276 # 948 <freep>
  if(p == (char*)-1)
 83c:	5afd                	li	s5,-1
 83e:	a895                	j	8b2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 840:	00000797          	auipc	a5,0x0
 844:	11078793          	addi	a5,a5,272 # 950 <base>
 848:	00000717          	auipc	a4,0x0
 84c:	10f73023          	sd	a5,256(a4) # 948 <freep>
 850:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 852:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 856:	b7e1                	j	81e <malloc+0x36>
      if(p->s.size == nunits)
 858:	02e48c63          	beq	s1,a4,890 <malloc+0xa8>
        p->s.size -= nunits;
 85c:	4137073b          	subw	a4,a4,s3
 860:	c798                	sw	a4,8(a5)
        p += p->s.size;
 862:	02071693          	slli	a3,a4,0x20
 866:	01c6d713          	srli	a4,a3,0x1c
 86a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 86c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 870:	00000717          	auipc	a4,0x0
 874:	0ca73c23          	sd	a0,216(a4) # 948 <freep>
      return (void*)(p + 1);
 878:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 87c:	70e2                	ld	ra,56(sp)
 87e:	7442                	ld	s0,48(sp)
 880:	74a2                	ld	s1,40(sp)
 882:	7902                	ld	s2,32(sp)
 884:	69e2                	ld	s3,24(sp)
 886:	6a42                	ld	s4,16(sp)
 888:	6aa2                	ld	s5,8(sp)
 88a:	6b02                	ld	s6,0(sp)
 88c:	6121                	addi	sp,sp,64
 88e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 890:	6398                	ld	a4,0(a5)
 892:	e118                	sd	a4,0(a0)
 894:	bff1                	j	870 <malloc+0x88>
  hp->s.size = nu;
 896:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 89a:	0541                	addi	a0,a0,16
 89c:	00000097          	auipc	ra,0x0
 8a0:	eca080e7          	jalr	-310(ra) # 766 <free>
  return freep;
 8a4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8a8:	d971                	beqz	a0,87c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8aa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ac:	4798                	lw	a4,8(a5)
 8ae:	fa9775e3          	bgeu	a4,s1,858 <malloc+0x70>
    if(p == freep)
 8b2:	00093703          	ld	a4,0(s2)
 8b6:	853e                	mv	a0,a5
 8b8:	fef719e3          	bne	a4,a5,8aa <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8bc:	8552                	mv	a0,s4
 8be:	00000097          	auipc	ra,0x0
 8c2:	b80080e7          	jalr	-1152(ra) # 43e <sbrk>
  if(p == (char*)-1)
 8c6:	fd5518e3          	bne	a0,s5,896 <malloc+0xae>
        return 0;
 8ca:	4501                	li	a0,0
 8cc:	bf45                	j	87c <malloc+0x94>
