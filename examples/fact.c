/* This demo prints out a table of factorials */

#include <stdio.h>
#include <ctemplate.h>

int
main(int argc, char **argv) {
    int n, f;
    char txt1[32], txt2[32];
    TMPL_varlist *mainlist, *vl;
    TMPL_loop  *loop;

    loop = 0;
    f = 1;
    for (n = 1; n < 11; n++) {
        sprintf(txt1, "%d", n);
        sprintf(txt2, "%d", f *= n);
        vl = TMPL_add_var(0, "n", txt1, "nfact", txt2, 0);
        loop = TMPL_add_varlist(loop, vl);
    }
    mainlist = TMPL_add_var(0, "title", "10 factorials", 0);
    mainlist = TMPL_add_loop(mainlist, "fact", loop);
    TMPL_write("fact.tmpl", 0, 0, mainlist, stdout, stderr);
    TMPL_free_varlist(mainlist);
    return 0;
}
