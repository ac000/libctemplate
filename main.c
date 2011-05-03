/*
 * C Template Library 1.0
 *
 * Copyright 2009 Stephen C. Losen.  Distributed under the terms
 * of the GNU General Public License (GPL)
 *
 * This is a template command that uses the C Template library.
 *
 * Usage: template tmplfile [ varname1 value1 varname2 value2 ... ]
 *
 * The template command outputs the template in tmplfile using the
 * variables and values passed on the command line. You can also pass
 * loop variables, which consist of a loop variable name and a sequence
 * of variable lists, each enclosed by { and }.  Each variable name,
 * variable value, { or } must be a separate argument.  Here are some
 * examples.
 *
 * template tmplfile var1 value1 var2 value2 var3 "Value 3"
 *
 * template tmplfile var "some value" \
 *   loopvar { var1 val1 var2 val2 } { var1 val3 var2 val4 } \
 *     { var1 val5 var2 "value 6" } \
 *   nonloopvar "another value"
 *
 * Loop variables may be nested:
 *
 * template tmplfile \
 *   outerloop \
 *     { ovar1 oval1 \
 *       innerloop \
 *         { ivar1 ival1 ivar2 ival2 } \
 *         { ivar1 ival3 ivar2 ival5 } \
 *     } \
 *     { ovar1 oval2 \
 *       innerloop \
 *         { ivar1 ival4 ivar2 ival5 } \
 *         { ivar1 ival6 ivar2 ival7 } \
 *     }
 */

#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctemplate.h>

static int idx;  /* index of current command line arg */

static TMPL_loop *getloop(const char **argv);

/*
 * getvarlist() builds a TMPL_varlist from a list of variable name and
 * value pairs on the command line.  If the TMPL_varlist is part of a
 * loop variable, then it is terminated by a '}'.
 */

static TMPL_varlist *
getvarlist(const char **argv, int stop) {
    const char *name, *value;
    TMPL_varlist *varlist = 0;
    TMPL_loop  *loop;

    while((name = argv[idx++]) != 0) {
        if (name[0] == '{' && name[1] == 0) {
            fprintf(stderr, "Unexpected '{' at argument %d\n", idx - 1);
            exit(1);
        }
        if (name[0] == '}' && name[1] == 0) {
            if (stop != '}') {
                fprintf(stderr, "Unexpected '}' at argument %d\n", idx - 1);
                exit(1);
            }
            return varlist;
        }
        if ((value = argv[idx]) == 0) {
            fprintf(stderr, "Too few arguments: variable \"%s\" has "
                "no value\n", name);
            exit(1);
        }
        if (value[0] == '{' && value[1] == 0) {
            loop = getloop(argv);
            varlist = TMPL_add_loop(varlist, name, loop);
        }
        else if (value[0] == '}' && value[1] == 0) {
            fprintf(stderr, "Unexpected '}' at argument %d\n", idx);
            exit(1);
        }
        else {
            idx++;
            varlist = TMPL_add_var(varlist, name, value, 0);
        }
    }

    /* end of argument list */

    if (stop == '}') {
        fputs("Too few arguments: '}' is missing.\n", stderr);
        exit(1);
    }
    return varlist;
}

/*
 * getloop() builds a TMPL_loop variable from a list of variable lists
 * on the command line.  Each variable list is enclosed by '{' and '}'
 */

static TMPL_loop *
getloop(const char **argv) {
    TMPL_loop  *loop = 0;
    TMPL_varlist *varlist;

    while (argv[idx] != 0 && argv[idx][0] == '{' && argv[idx][1] == 0) {
        idx++;
        varlist = getvarlist(argv, '}');
        loop = TMPL_add_varlist(loop, varlist);
    }
    return loop;
}

int
main(int argc, const char **argv) {
    TMPL_varlist *varlist;
    TMPL_fmtlist *fmtlist;
    int ret;

    idx = 2;
    varlist = getvarlist(argv, 0);
    fmtlist = TMPL_add_fmt(0, "entity", TMPL_encode_entity);
    TMPL_add_fmt(fmtlist, "url", TMPL_encode_url);
    ret = TMPL_write(argv[1], 0, fmtlist, varlist, stdout, stderr) != 0;
    TMPL_free_fmtlist(fmtlist);
    TMPL_free_varlist(varlist);
    return ret;
}
