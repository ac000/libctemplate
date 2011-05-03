/*
 * This example prints out a table of command line arguments and
 * a table of environment variables.  It also uses format functions.
 */

#include <stdio.h>
#include <string.h>
#include <ctemplate.h>

/* format function that truncates */

static void
truncate(const char *p, FILE *out) {
    if (strlen(p) > 45) {
        fwrite(p, 40, 1, out);
        fputs(" ... ", out);
    }
    else {
        fputs(p, out);
    }
}

int
main(int argc, char **argv, char **env) {
    int i;
    char num[32];
    char *p;
    TMPL_fmtlist *fmt = 0;
    TMPL_varlist *vl = 0;
    TMPL_loop *loop;

    /* put command line arguments into a loop variable */

    loop = 0;
    for (i = 0; i < argc; i++) {
        sprintf(num, "%d", i);
        loop = TMPL_add_varlist(loop, TMPL_add_var(0,
            "anum", num, "avalue", argv[i], 0));
    }

    /* add loop variable to top level variable list */

    vl = TMPL_add_loop(vl, "arg", loop);

    /* add a total to the loop variable */

    sprintf(num, "%d", argc);
    TMPL_add_varlist(loop, TMPL_add_var(0, "total", num, 0));

    /* put environment variable names and values into a loop variable */

    loop = 0;
    for (i = 0; env[i] != 0; i++) {
        if ((p = strchr(env[i], '=')) != 0) {
            *p = 0;
            loop = TMPL_add_varlist(loop, TMPL_add_var(0,
                "ename", env[i], "evalue", p + 1, 0));
            *p = '='; 
        }
    }

    /* add a total to the loop variable */

    sprintf(num, "%d", i);
    loop = TMPL_add_varlist(loop, TMPL_add_var(0,
        "total", num, 0));

    /* add the loop variable to the top level variable list */

    vl = TMPL_add_loop(vl, "env", loop);

    /* add another variable to the top level variable list */

    vl = TMPL_add_var(vl, "title", "Environment Variables", 0);

    /* Build format function list */

    fmt = TMPL_add_fmt(0, "trunc", truncate);
    TMPL_add_fmt(fmt, "entity", TMPL_encode_entity);

    /* output the template and free memory */

    TMPL_write("printenv.tmpl", 0, fmt, vl, stdout, stderr);
    TMPL_free_varlist(vl);
    TMPL_free_fmtlist(fmt);
    return 0;
}
