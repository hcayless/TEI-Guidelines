/* msg.c:  routines for messages (routine, log, verbose, debug ...) */
#include <stdio.h>
#include <stdarg.h>
#include "dppflags.h"

/* MsgKwS(kw,s,s, ...) takes one keyword and an arbitrary
   number of strings */
void MsgKwS(int kw, ...) {
    va_list pArg;
    char * pc;

    if (iMsglevel > kw) {
         va_start(pArg,kw);

         va_end(pArg);
         return;
    }
/*  fprintf(stdout,"L%d %s <-- ",cLinecount,fnCurrent);    */
    switch(kw) {
      case msgERROR:    fprintf(stderr,"! ! ! %s:%d  ",
                        fnCurrent,cLinecount);
                        break;
      case msgWARNING:  fprintf(stderr,"* * * %s:%d  ",
                        fnCurrent,cLinecount);
                        break;
      case msgINFORM:   fprintf(stderr,"> > > %s:%d  ",
                        fnCurrent,cLinecount);
                        break;
      default:          fprintf(stderr,"%s:%d  ",
                        fnCurrent,cLinecount);
                        break;
    }
    va_start(pArg,kw);
    while (pArg != NULL) {
         pc = va_arg(pArg,char *);
    /*   fprintf(stdout,"%s",pc); */
         fprintf(stderr,"%s",pc);
    }
/*  fprintf(stdout," -->\n");     */
    switch(kw) {
      case msgERROR:    fprintf(stderr,"! ! !\n");
                        break;
      case msgWARNING:  fprintf(stderr,"* * *\n");
                        break;
      case msgINFORM:   fprintf(stderr,"< < <\n");
                        break;
      default:          fprintf(stderr,"\n");
                        break;
    }

    va_end(pArg);
}

