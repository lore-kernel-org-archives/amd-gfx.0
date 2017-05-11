From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Thu, 11 May 2017 10:51:00 +0000
Message-ID: <BY2PR1201MB0968501917152E7FF9C1B19D89ED0@BY2PR1201MB0968.namprd12.prod.outlook.com>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0656594655=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1494449815-10162-1-git-send-email-Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0656594655==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR1201MB0968501917152E7FF9C1B19D89ED0BY2PR1201MB0968_"

--_000_BY2PR1201MB0968501917152E7FF9C1B19D89ED0BY2PR1201MB0968_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,


Here's an off-by-one error:

+                       id =3D asic_id_table + table_size -1;


should be:

+                       id =3D asic_id_table + table_size;


Regards,

Xiaojie

________________________________
From: Li, Samuel
Sent: Thursday, May 11, 2017 4:56:55 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yuan, Xiaojie; Li, Samuel
Subject: [PATCH 1/1] amdgpu: move asic id table to a separate file

From: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

Change-Id: I12216da14910f5e2b0970bc1fafc2a20b0ef1ba9
Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/Makefile.am       |   2 +
 amdgpu/Makefile.sources  |   2 +-
 amdgpu/amdgpu_asic_id.c  | 198 +++++++++++++++++++++++++++++++++++++++++++=
++++
 amdgpu/amdgpu_asic_id.h  | 165 ---------------------------------------
 amdgpu/amdgpu_device.c   |  28 +++++--
 amdgpu/amdgpu_internal.h |  10 +++
 6 files changed, 232 insertions(+), 173 deletions(-)
 create mode 100644 amdgpu/amdgpu_asic_id.c
 delete mode 100644 amdgpu/amdgpu_asic_id.h

diff --git a/amdgpu/Makefile.am b/amdgpu/Makefile.am
index cf7bc1b..ecf9e82 100644
--- a/amdgpu/Makefile.am
+++ b/amdgpu/Makefile.am
@@ -30,6 +30,8 @@ AM_CFLAGS =3D \
         $(PTHREADSTUBS_CFLAGS) \
         -I$(top_srcdir)/include/drm

+AM_CPPFLAGS =3D -DAMDGPU_ASIC_ID_TABLE=3D\"${datadir}/libdrm/amdgpu.ids\"
+
 libdrm_amdgpu_la_LTLIBRARIES =3D libdrm_amdgpu.la
 libdrm_amdgpu_ladir =3D $(libdir)
 libdrm_amdgpu_la_LDFLAGS =3D -version-number 1:0:0 -no-undefined
diff --git a/amdgpu/Makefile.sources b/amdgpu/Makefile.sources
index 487b9e0..bc3abaa 100644
--- a/amdgpu/Makefile.sources
+++ b/amdgpu/Makefile.sources
@@ -1,5 +1,5 @@
 LIBDRM_AMDGPU_FILES :=3D \
-       amdgpu_asic_id.h \
+       amdgpu_asic_id.c \
         amdgpu_bo.c \
         amdgpu_cs.c \
         amdgpu_device.c \
diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c
new file mode 100644
index 0000000..d50e21a
--- /dev/null
+++ b/amdgpu/amdgpu_asic_id.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright =A9 2017 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "amdgpu_drm.h"
+#include "amdgpu_internal.h"
+
+static int parse_one_line(const char *line, struct amdgpu_asic_id *id)
+{
+       char *buf;
+       char *s_did;
+       char *s_rid;
+       char *s_name;
+       char *endptr;
+       int r =3D 0;
+
+       buf =3D strdup(line);
+       if (!buf)
+               return -ENOMEM;
+
+       /* ignore empty line and commented line */
+       if (strlen(line) =3D=3D 0 || line[0] =3D=3D '#') {
+               r =3D -EAGAIN;
+               goto out;
+       }
+
+       /* device id */
+       s_did =3D strtok(buf, ",");
+       if (!s_did) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       id->did =3D strtol(s_did, &endptr, 16);
+       if (*endptr) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       /* revision id */
+       s_rid =3D strtok(NULL, ",");
+       if (!s_rid) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       id->rid =3D strtol(s_rid, &endptr, 16);
+       if (*endptr) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       /* marketing name */
+       s_name =3D strtok(NULL, ",");
+       if (!s_name) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       id->marketing_name =3D strdup(s_name);
+       if (id->marketing_name =3D=3D NULL) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+out:
+       free(buf);
+
+       return r;
+}
+
+int amdgpu_parse_asic_ids(struct amdgpu_asic_id **p_asic_id_table)
+{
+       struct amdgpu_asic_id *asic_id_table;
+       struct amdgpu_asic_id *id;
+       FILE *fp;
+       char *line =3D NULL;
+       size_t len;
+       ssize_t n;
+       int line_num =3D 1;
+       size_t table_size =3D 0;
+       size_t table_max_size =3D 256;
+       int r =3D 0;
+
+       fp =3D fopen(AMDGPU_ASIC_ID_TABLE, "r");
+       if (!fp) {
+               fprintf(stderr, "%s: %s\n", AMDGPU_ASIC_ID_TABLE,
+                               strerror(errno));
+               return -EINVAL;
+       }
+
+       asic_id_table =3D calloc(table_max_size, sizeof(struct amdgpu_asic_=
id));
+       if (!asic_id_table) {
+               r =3D -ENOMEM;
+               goto close;
+       }
+
+       /* 1st line is file version */
+       if ((n =3D getline(&line, &len, fp)) !=3D -1) {
+               /* trim trailing newline */
+               if (line[n - 1] =3D=3D '\n')
+                       line[n - 1] =3D '\0';
+               printf("%s version: %s\n", AMDGPU_ASIC_ID_TABLE, line);
+       } else {
+               goto free;
+       }
+
+       while ((n =3D getline(&line, &len, fp)) !=3D -1) {
+               id =3D asic_id_table + table_size;
+
+               /* trim trailing newline */
+               if (line[n - 1] =3D=3D '\n')
+                       line[n - 1] =3D '\0';
+
+               /*
+                * parse one line, its format looks like:
+                * 6617,C7,AMD Radeon R7 240 Series
+                */
+               r =3D parse_one_line(line, id);
+               if (r) {
+                       if (r =3D=3D -EAGAIN) {
+                               line_num++;
+                               continue;
+                       }
+                       fprintf(stderr, "Invalid format: %s: line %d: %s\n"=
,
+                                       AMDGPU_ASIC_ID_TABLE, line_num, lin=
e);
+                       goto free;
+               }
+
+               line_num++;
+               table_size++;
+
+               if (table_size >=3D table_max_size) {
+                       /* double table size */
+                       table_max_size *=3D 2;
+                       asic_id_table =3D realloc(asic_id_table, table_max_=
size *
+                                       sizeof(struct amdgpu_asic_id));
+                       if (!asic_id_table) {
+                               r =3D -ENOMEM;
+                               goto free;
+                       }
+               }
+       }
+
+       /* end of table */
+       id =3D asic_id_table + table_size;
+       memset(id, 0, sizeof(struct amdgpu_asic_id));
+
+free:
+       free(line);
+
+       if (r && asic_id_table) {
+               while (table_size--) {
+                       id =3D asic_id_table + table_size -1;
+                       if (id->marketing_name !=3D  NULL)
+                               free(id->marketing_name);
+               }
+               free(asic_id_table);
+               asic_id_table =3D NULL;
+       }
+close:
+       fclose(fp);
+
+       *p_asic_id_table =3D asic_id_table;
+
+       return r;
+}
diff --git a/amdgpu/amdgpu_asic_id.h b/amdgpu/amdgpu_asic_id.h
deleted file mode 100644
index 3e7d736..0000000
--- a/amdgpu/amdgpu_asic_id.h
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright =A9 2016 Advanced Micro Devices, Inc.
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef __AMDGPU_ASIC_ID_H__
-#define __AMDGPU_ASIC_ID_H__
-
-static struct amdgpu_asic_id_table_t {
-       uint32_t did;
-       uint32_t rid;
-       const char *marketing_name;
-} const amdgpu_asic_id_table [] =3D {
-       {0x6600,        0x0,    "AMD Radeon HD 8600/8700M"},
-       {0x6600,        0x81,   "AMD Radeon R7 M370"},
-       {0x6601,        0x0,    "AMD Radeon HD 8500M/8700M"},
-       {0x6604,        0x0,    "AMD Radeon R7 M265 Series"},
-       {0x6604,        0x81,   "AMD Radeon R7 M350"},
-       {0x6605,        0x0,    "AMD Radeon R7 M260 Series"},
-       {0x6605,        0x81,   "AMD Radeon R7 M340"},
-       {0x6606,        0x0,    "AMD Radeon HD 8790M"},
-       {0x6607,        0x0,    "AMD Radeon HD8530M"},
-       {0x6608,        0x0,    "AMD FirePro W2100"},
-       {0x6610,        0x0,    "AMD Radeon HD 8600 Series"},
-       {0x6610,        0x81,   "AMD Radeon R7 350"},
-       {0x6610,        0x83,   "AMD Radeon R5 340"},
-       {0x6611,        0x0,    "AMD Radeon HD 8500 Series"},
-       {0x6613,        0x0,    "AMD Radeon HD 8500 series"},
-       {0x6617,        0xC7,   "AMD Radeon R7 240 Series"},
-       {0x6640,        0x0,    "AMD Radeon HD 8950"},
-       {0x6640,        0x80,   "AMD Radeon R9 M380"},
-       {0x6646,        0x0,    "AMD Radeon R9 M280X"},
-       {0x6646,        0x80,   "AMD Radeon R9 M470X"},
-       {0x6647,        0x0,    "AMD Radeon R9 M270X"},
-       {0x6647,        0x80,   "AMD Radeon R9 M380"},
-       {0x6649,        0x0,    "AMD FirePro W5100"},
-       {0x6658,        0x0,    "AMD Radeon R7 200 Series"},
-       {0x665C,        0x0,    "AMD Radeon HD 7700 Series"},
-       {0x665D,        0x0,    "AMD Radeon R7 200 Series"},
-       {0x665F,        0x81,   "AMD Radeon R7 300 Series"},
-       {0x6660,        0x0,    "AMD Radeon HD 8600M Series"},
-       {0x6660,        0x81,   "AMD Radeon R5 M335"},
-       {0x6660,        0x83,   "AMD Radeon R5 M330"},
-       {0x6663,        0x0,    "AMD Radeon HD 8500M Series"},
-       {0x6663,        0x83,   "AMD Radeon R5 M320"},
-       {0x6664,        0x0,    "AMD Radeon R5 M200 Series"},
-       {0x6665,        0x0,    "AMD Radeon R5 M200 Series"},
-       {0x6665,        0x83,   "AMD Radeon R5 M320"},
-       {0x6667,        0x0,    "AMD Radeon R5 M200 Series"},
-       {0x666F,        0x0,    "AMD Radeon HD 8500M"},
-       {0x6780,        0x0,    "ATI FirePro V (FireGL V) Graphics Adapter"=
},
-       {0x678A,        0x0,    "ATI FirePro V (FireGL V) Graphics Adapter"=
},
-       {0x6798,        0x0,    "AMD Radeon HD 7900 Series"},
-       {0x679A,        0x0,    "AMD Radeon HD 7900 Series"},
-       {0x679B,        0x0,    "AMD Radeon HD 7900 Series"},
-       {0x679E,        0x0,    "AMD Radeon HD 7800 Series"},
-       {0x67A0,        0x0,    "HAWAII XTGL (67A0)"},
-       {0x67A1,        0x0,    "HAWAII GL40 (67A1)"},
-       {0x67B0,        0x0,    "AMD Radeon R9 200 Series"},
-       {0x67B0,        0x80,   "AMD Radeon R9 390 Series"},
-       {0x67B1,        0x0,    "AMD Radeon R9 200 Series"},
-       {0x67B1,        0x80,   "AMD Radeon R9 390 Series"},
-       {0x67B9,        0x0,    "AMD Radeon R9 200 Series"},
-       {0x67DF,        0xC4,   "AMD Radeon RX 480 Graphics"},
-       {0x67DF,        0xC5,   "AMD Radeon RX 470 Graphics"},
-       {0x67DF,        0xC7,   "AMD Radeon RX 480 Graphics"},
-       {0x67DF,        0xCF,   "AMD Radeon RX 470 Graphics"},
-       {0x67C4,        0x00,   "AMD Radeon Pro WX 7100 Graphics"},
-       {0x67C7,        0x00,   "AMD Radeon Pro WX 5100 Graphics"},
-       {0x67C0,        0x00,   "AMD Radeon Pro WX 7100 Graphics"},
-       {0x67E0,        0x00,   "AMD Radeon Pro WX Series Graphics"},
-       {0x67E3,        0x00,   "AMD Radeon Pro WX 4100 Graphics"},
-       {0x67E8,        0x00,   "AMD Radeon Pro WX Series Graphics"},
-       {0x67E8,        0x01,   "AMD Radeon Pro WX Series Graphics"},
-       {0x67E8,        0x80,   "AMD Radeon E9260 Graphics"},
-       {0x67EB,        0x00,   "AMD Radeon Pro WX Series Graphics"},
-       {0x67EF,        0xC0,   "AMD Radeon RX Graphics"},
-       {0x67EF,        0xC1,   "AMD Radeon RX 460 Graphics"},
-       {0x67EF,        0xC5,   "AMD Radeon RX 460 Graphics"},
-       {0x67EF,        0xC7,   "AMD Radeon RX Graphics"},
-       {0x67EF,        0xCF,   "AMD Radeon RX 460 Graphics"},
-       {0x67EF,        0xEF,   "AMD Radeon RX Graphics"},
-       {0x67FF,        0xC0,   "AMD Radeon RX Graphics"},
-       {0x67FF,        0xC1,   "AMD Radeon RX Graphics"},
-       {0x6800,        0x0,    "AMD Radeon HD 7970M"},
-       {0x6801,        0x0,    "AMD Radeon(TM) HD8970M"},
-       {0x6808,        0x0,    "ATI FirePro V(FireGL V) Graphics Adapter"}=
,
-       {0x6809,        0x0,    "ATI FirePro V(FireGL V) Graphics Adapter"}=
,
-       {0x6810,        0x0,    "AMD Radeon(TM) HD 8800 Series"},
-       {0x6810,        0x81,   "AMD Radeon R7 370 Series"},
-       {0x6811,        0x0,    "AMD Radeon(TM) HD8800 Series"},
-       {0x6811,        0x81,   "AMD Radeon R7 300 Series"},
-       {0x6818,        0x0,    "AMD Radeon HD 7800 Series"},
-       {0x6819,        0x0,    "AMD Radeon HD 7800 Series"},
-       {0x6820,        0x0,    "AMD Radeon HD 8800M Series"},
-       {0x6820,        0x81,   "AMD Radeon R9 M375"},
-       {0x6820,        0x83,   "AMD Radeon R9 M375X"},
-       {0x6821,        0x0,    "AMD Radeon HD 8800M Series"},
-       {0x6821,        0x87,   "AMD Radeon R7 M380"},
-       {0x6821,        0x83,   "AMD Radeon R9 M370X"},
-       {0x6822,        0x0,    "AMD Radeon E8860"},
-       {0x6823,        0x0,    "AMD Radeon HD 8800M Series"},
-       {0x6825,        0x0,    "AMD Radeon HD 7800M Series"},
-       {0x6827,        0x0,    "AMD Radeon HD 7800M Series"},
-       {0x6828,        0x0,    "ATI FirePro V(FireGL V) Graphics Adapter"}=
,
-       {0x682B,        0x0,    "AMD Radeon HD 8800M Series"},
-       {0x682B,        0x87,   "AMD Radeon R9 M360"},
-       {0x682C,        0x0,    "AMD FirePro W4100"},
-       {0x682D,        0x0,    "AMD Radeon HD 7700M Series"},
-       {0x682F,        0x0,    "AMD Radeon HD 7700M Series"},
-       {0x6835,        0x0,    "AMD Radeon R7 Series / HD 9000 Series"},
-       {0x6837,        0x0,    "AMD Radeon HD7700 Series"},
-       {0x683D,        0x0,    "AMD Radeon HD 7700 Series"},
-       {0x683F,        0x0,    "AMD Radeon HD 7700 Series"},
-       {0x6900,        0x0,    "AMD Radeon R7 M260"},
-       {0x6900,        0x81,   "AMD Radeon R7 M360"},
-       {0x6900,        0x83,   "AMD Radeon R7 M340"},
-       {0x6901,        0x0,    "AMD Radeon R5 M255"},
-       {0x6907,        0x0,    "AMD Radeon R5 M255"},
-       {0x6907,        0x87,   "AMD Radeon R5 M315"},
-       {0x6920,        0x0,    "AMD Radeon R9 M395X"},
-       {0x6920,        0x1,    "AMD Radeon R9 M390X"},
-       {0x6921,        0x0,    "AMD Radeon R9 M295X"},
-       {0x6929,        0x0,    "AMD FirePro S7150"},
-       {0x692B,        0x0,    "AMD FirePro W7100"},
-       {0x6938,        0x0,    "AMD Radeon R9 200 Series"},
-       {0x6938,        0xF0,   "AMD Radeon R9 200 Series"},
-       {0x6938,        0xF1,   "AMD Radeon R9 380 Series"},
-       {0x6939,        0xF0,   "AMD Radeon R9 200 Series"},
-       {0x6939,        0x0,    "AMD Radeon R9 200 Series"},
-       {0x6939,        0xF1,   "AMD Radeon R9 380 Series"},
-       {0x7300,        0xC8,   "AMD Radeon R9 Fury Series"},
-       {0x7300,        0xCB,   "AMD Radeon R9 Fury Series"},
-       {0x7300,        0xCA,   "AMD Radeon R9 Fury Series"},
-       {0x9874,        0xC4,   "AMD Radeon R7 Graphics"},
-       {0x9874,        0xC5,   "AMD Radeon R6 Graphics"},
-       {0x9874,        0xC6,   "AMD Radeon R6 Graphics"},
-       {0x9874,        0xC7,   "AMD Radeon R5 Graphics"},
-       {0x9874,        0x81,   "AMD Radeon R6 Graphics"},
-       {0x9874,        0x87,   "AMD Radeon R5 Graphics"},
-       {0x9874,        0x85,   "AMD Radeon R6 Graphics"},
-       {0x9874,        0x84,   "AMD Radeon R7 Graphics"},
-
-       {0x0000,        0x0,    "\0"},
-};
-#endif
diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
index f473d2d..9d08744 100644
--- a/amdgpu/amdgpu_device.c
+++ b/amdgpu/amdgpu_device.c
@@ -44,7 +44,6 @@
 #include "amdgpu_internal.h"
 #include "util_hash_table.h"
 #include "util_math.h"
-#include "amdgpu_asic_id.h"

 #define PTR_TO_UINT(x) ((unsigned)((intptr_t)(x)))
 #define UINT_TO_PTR(x) ((void *)((intptr_t)(x)))
@@ -131,6 +130,7 @@ static int amdgpu_get_auth(int fd, int *auth)

 static void amdgpu_device_free_internal(amdgpu_device_handle dev)
 {
+       const struct amdgpu_asic_id *id;
         amdgpu_vamgr_deinit(&dev->vamgr_32);
         amdgpu_vamgr_deinit(&dev->vamgr);
         util_hash_table_destroy(dev->bo_flink_names);
@@ -140,6 +140,13 @@ static void amdgpu_device_free_internal(amdgpu_device_=
handle dev)
         close(dev->fd);
         if ((dev->flink_fd >=3D 0) && (dev->fd !=3D dev->flink_fd))
                 close(dev->flink_fd);
+       if (dev->asic_ids) {
+               for (id =3D dev->asic_ids; id->did; id++) {
+                       if (id->marketing_name !=3D  NULL)
+                               free(id->marketing_name);
+               }
+               free(dev->asic_ids);
+       }
         free(dev);
 }

@@ -267,6 +274,11 @@ int amdgpu_device_initialize(int fd,
         amdgpu_vamgr_init(&dev->vamgr_32, start, max,
                           dev->dev_info.virtual_address_alignment);

+       r =3D amdgpu_parse_asic_ids(&dev->asic_ids);
+       if (r)
+               fprintf(stderr, "%s: Can not parse asic ids, 0x%x.",
+                       __func__, r);
+
         *major_version =3D dev->major_version;
         *minor_version =3D dev->minor_version;
         *device_handle =3D dev;
@@ -297,13 +309,15 @@ int amdgpu_device_deinitialize(amdgpu_device_handle d=
ev)

 const char *amdgpu_get_marketing_name(amdgpu_device_handle dev)
 {
-       const struct amdgpu_asic_id_table_t *t =3D amdgpu_asic_id_table;
+       const struct amdgpu_asic_id *id;
+
+       if (!dev->asic_ids)
+               return NULL;

-       while (t->did) {
-               if ((t->did =3D=3D dev->info.asic_id) &&
-                   (t->rid =3D=3D dev->info.pci_rev_id))
-                       return t->marketing_name;
-               t++;
+       for (id =3D dev->asic_ids; id->did; id++) {
+               if ((id->did =3D=3D dev->info.asic_id) &&
+                               (id->rid =3D=3D dev->info.pci_rev_id))
+                       return id->marketing_name;
         }

         return NULL;
diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
index cf119a5..9d11bea 100644
--- a/amdgpu/amdgpu_internal.h
+++ b/amdgpu/amdgpu_internal.h
@@ -69,6 +69,12 @@ struct amdgpu_va {
         struct amdgpu_bo_va_mgr *vamgr;
 };

+struct amdgpu_asic_id {
+    uint32_t did;
+    uint32_t rid;
+       char *marketing_name;
+};
+
 struct amdgpu_device {
         atomic_t refcount;
         int fd;
@@ -76,6 +82,8 @@ struct amdgpu_device {
         unsigned major_version;
         unsigned minor_version;

+       /** Lookup table of asic device id, revision id and marketing name =
*/
+       struct amdgpu_asic_id *asic_ids;
         /** List of buffer handles. Protected by bo_table_mutex. */
         struct util_hash_table *bo_handles;
         /** List of buffer GEM flink names. Protected by bo_table_mutex. *=
/
@@ -149,6 +157,8 @@ amdgpu_vamgr_find_va(struct amdgpu_bo_va_mgr *mgr, uint=
64_t size,
 drm_private void
 amdgpu_vamgr_free_va(struct amdgpu_bo_va_mgr *mgr, uint64_t va, uint64_t s=
ize);

+drm_private int amdgpu_parse_asic_ids(struct amdgpu_asic_id **asic_ids);
+
 drm_private int amdgpu_query_gpu_info_init(amdgpu_device_handle dev);

 drm_private uint64_t amdgpu_cs_calculate_timeout(uint64_t timeout);
--
2.7.4


--_000_BY2PR1201MB0968501917152E7FF9C1B19D89ED0BY2PR1201MB0968_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Samuel,</p>
<p><br>
</p>
<p><span style=3D"font-size:12pt">Here's an off-by-one error</span><span st=
yle=3D"font-size:12pt">:</span></p>
<p><font size=3D"2"><span style=3D"font-size:12pt">&#43;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D asic_id_table &#43; table_siz=
e -1;</span></font></p>
<p><br>
</p>
<p><span style=3D"font-size:12pt">should be:</span></p>
<p><font size=3D"2"><span style=3D"font-size:12pt">&#43;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D asic_id_table &#43; table_siz=
e;</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:12pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:12pt">Regards,</span></font></=
p>
<p><font size=3D"2"><span style=3D"font-size:12pt">Xiaojie</span></font><br=
>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Li, Samuel<br>
<b>Sent:</b> Thursday, May 11, 2017 4:56:55 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yuan, Xiaojie; Li, Samuel<br>
<b>Subject:</b> [PATCH 1/1] amdgpu: move asic id table to a separate file</=
font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">From: Xiaojie Yuan &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br=
>
<br>
Change-Id: I12216da14910f5e2b0970bc1fafc2a20b0ef1ba9<br>
Signed-off-by: Samuel Li &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;amdgpu/Makefile.am&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; =
2 &#43;<br>
&nbsp;amdgpu/Makefile.sources&nbsp; |&nbsp;&nbsp; 2 &#43;-<br>
&nbsp;amdgpu/amdgpu_asic_id.c&nbsp; | 198 &#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;amdgpu/amdgpu_asic_id.h&nbsp; | 165 ---------------------------------=
------<br>
&nbsp;amdgpu/amdgpu_device.c&nbsp;&nbsp; |&nbsp; 28 &#43;&#43;&#43;&#43;&#4=
3;--<br>
&nbsp;amdgpu/amdgpu_internal.h |&nbsp; 10 &#43;&#43;&#43;<br>
&nbsp;6 files changed, 232 insertions(&#43;), 173 deletions(-)<br>
&nbsp;create mode 100644 amdgpu/amdgpu_asic_id.c<br>
&nbsp;delete mode 100644 amdgpu/amdgpu_asic_id.h<br>
<br>
diff --git a/amdgpu/Makefile.am b/amdgpu/Makefile.am<br>
index cf7bc1b..ecf9e82 100644<br>
--- a/amdgpu/Makefile.am<br>
&#43;&#43;&#43; b/amdgpu/Makefile.am<br>
@@ -30,6 &#43;30,8 @@ AM_CFLAGS =3D \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(PTHREADSTUBS_CFLAGS) \<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -I$(top_srcdir)/include/dr=
m<br>
&nbsp;<br>
&#43;AM_CPPFLAGS =3D -DAMDGPU_ASIC_ID_TABLE=3D\&quot;${datadir}/libdrm/amdg=
pu.ids\&quot;<br>
&#43;<br>
&nbsp;libdrm_amdgpu_la_LTLIBRARIES =3D libdrm_amdgpu.la<br>
&nbsp;libdrm_amdgpu_ladir =3D $(libdir)<br>
&nbsp;libdrm_amdgpu_la_LDFLAGS =3D -version-number 1:0:0 -no-undefined<br>
diff --git a/amdgpu/Makefile.sources b/amdgpu/Makefile.sources<br>
index 487b9e0..bc3abaa 100644<br>
--- a/amdgpu/Makefile.sources<br>
&#43;&#43;&#43; b/amdgpu/Makefile.sources<br>
@@ -1,5 &#43;1,5 @@<br>
&nbsp;LIBDRM_AMDGPU_FILES :=3D \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_id.h \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_id.c \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo.c \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cs.c \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device.c \<br>
diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c<br>
new file mode 100644<br>
index 0000000..d50e21a<br>
--- /dev/null<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_asic_id.c<br>
@@ -0,0 &#43;1,198 @@<br>
&#43;/*<br>
&#43; * Copyright =A9 2017 Advanced Micro Devices, Inc.<br>
&#43; * All Rights Reserved.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded in<br>
&#43; * all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR<br>
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR<br>
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,<br>
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR<br>
&#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&#43; *<br>
&#43; */<br>
&#43;<br>
&#43;#ifdef HAVE_CONFIG_H<br>
&#43;#include &quot;config.h&quot;<br>
&#43;#endif<br>
&#43;<br>
&#43;#include &lt;stdio.h&gt;<br>
&#43;#include &lt;stdlib.h&gt;<br>
&#43;#include &lt;stdint.h&gt;<br>
&#43;#include &lt;string.h&gt;<br>
&#43;#include &lt;unistd.h&gt;<br>
&#43;#include &lt;errno.h&gt;<br>
&#43;<br>
&#43;#include &quot;amdgpu_drm.h&quot;<br>
&#43;#include &quot;amdgpu_internal.h&quot;<br>
&#43;<br>
&#43;static int parse_one_line(const char *line, struct amdgpu_asic_id *id)=
<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_did;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_rid;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *endptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf =3D strdup(line);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ignore empty line and commente=
d line */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(line) =3D=3D 0 || line=
[0] =3D=3D '#') {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EAGAIN;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* device id */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_did =3D strtok(buf, &quot;,&quo=
t;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_did) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;did =3D strtol(s_did, &amp=
;endptr, 16);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*endptr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* revision id */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_rid =3D strtok(NULL, &quot;,&qu=
ot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_rid) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;rid =3D strtol(s_rid, &amp=
;endptr, 16);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*endptr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* marketing name */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_name =3D strtok(NULL, &quot;,&q=
uot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_name) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id-&gt;marketing_name =3D strdup(=
s_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (id-&gt;marketing_name =3D=3D =
NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;out:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(buf);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&#43;int amdgpu_parse_asic_ids(struct amdgpu_asic_id **p_asic_id_table)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_asic_id *asic_id_ta=
ble;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_asic_id *id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FILE *fp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *line =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t n;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int line_num =3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t table_size =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t table_max_size =3D 256;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp =3D fopen(AMDGPU_ASIC_ID_TABLE=
, &quot;r&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fp) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fprintf(stderr, &quot;%s: %s\n&quot;, AMDGPU_ASIC_ID_TABLE,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_id_table =3D calloc(table_ma=
x_size, sizeof(struct amdgpu_asic_id));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!asic_id_table) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto close;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 1st line is file version */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((n =3D getline(&amp;line, &am=
p;len, fp)) !=3D -1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* trim trailing newline */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (line[n - 1] =3D=3D '\n')<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line[n - 1] =
=3D '\0';<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; printf(&quot;%s version: %s\n&quot;, AMDGPU_ASIC_ID_TABLE, l=
ine);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto free;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((n =3D getline(&amp;line, =
&amp;len, fp)) !=3D -1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; id =3D asic_id_table &#43; table_size;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* trim trailing newline */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (line[n - 1] =3D=3D '\n')<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line[n - 1] =
=3D '\0';<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * parse one line, its format looks like:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; * 6617,C7,AMD Radeon R7 240 Series<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D parse_one_line(line, id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D=
 -EAGAIN) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line_num&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stde=
rr, &quot;Invalid format: %s: line %d: %s\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; AMDGPU_ASIC_ID_TABLE, line_num, line);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; line_num&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table_size&#43;&#43;;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (table_size &gt;=3D table_max_size) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* double ta=
ble size */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_max_si=
ze *=3D 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic_id_tabl=
e =3D realloc(asic_id_table, table_max_size *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; sizeof(struct amdgpu_asic_id));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!asic_id=
_table) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* end of table */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D asic_id_table &#43; table_=
size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(id, 0, sizeof(struct amdgp=
u_asic_id));<br>
&#43;<br>
&#43;free:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(line);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &amp;&amp; asic_id_table) {=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (table_size--) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D asic_=
id_table &#43; table_size -1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (id-&gt;m=
arketing_name !=3D&nbsp; NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(id-&gt;marketing_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; free(asic_id_table);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; asic_id_table =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;close:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fclose(fp);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_asic_id_table =3D asic_id_tabl=
e;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
diff --git a/amdgpu/amdgpu_asic_id.h b/amdgpu/amdgpu_asic_id.h<br>
deleted file mode 100644<br>
index 3e7d736..0000000<br>
--- a/amdgpu/amdgpu_asic_id.h<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,165 &#43;0,0 @@<br>
-/*<br>
- * Copyright =A9 2016 Advanced Micro Devices, Inc.<br>
- * All Rights Reserved.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-<br>
-#ifndef __AMDGPU_ASIC_ID_H__<br>
-#define __AMDGPU_ASIC_ID_H__<br>
-<br>
-static struct amdgpu_asic_id_table_t {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rid;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *marketing_name;<br>
-} const amdgpu_asic_id_table [] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8600/8700M&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6600,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 M370&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6601,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8500M/8700M&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6604,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 M265 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6604,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 M350&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6605,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 M260 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6605,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 M340&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6606,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8790M&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6607,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD8530M&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6608,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD FirePro W2100&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6610,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8600 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6610,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 350&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6610,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R5 340&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6611,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8500 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6613,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8500 series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6617,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC7,&nbsp;&nbsp; &quot;AMD Radeon R7 240 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8950&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6640,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon R9 M380&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6646,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 M280X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6646,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon R9 M470X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6647,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 M270X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6647,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon R9 M380&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6649,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD FirePro W5100&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6658,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x665C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7700 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x665D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x665F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 300 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6660,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8600M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6660,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R5 M335&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6660,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R5 M330&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6663,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8500M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6663,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R5 M320&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6664,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R5 M200 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6665,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R5 M200 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6665,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R5 M320&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6667,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R5 M200 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x666F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8500M&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6780,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;ATI FirePro V (FireGL V) Graphic=
s Adapter&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x678A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;ATI FirePro V (FireGL V) Graphic=
s Adapter&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6798,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7900 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x679A,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7900 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x679B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7900 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x679E,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7800 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67A0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;HAWAII XTGL (67A0)&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67A1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;HAWAII GL40 (67A1)&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67B0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67B0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon R9 390 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67B1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon R9 390 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67B9,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC4,&nbsp;&nbsp; &quot;AMD Radeon RX 480 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC5,&nbsp;&nbsp; &quot;AMD Radeon RX 470 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC7,&nbsp;&nbsp; &quot;AMD Radeon RX 480 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67DF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xCF,&nbsp;&nbsp; &quot;AMD Radeon RX 470 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67C4,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX 7100 Graphics&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67C7,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX 5100 Graphics&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67C0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX 7100 Graphics&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67E0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX Series Graphics&quo=
t;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67E3,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX 4100 Graphics&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67E8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX Series Graphics&quo=
t;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67E8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x01,&nbsp;&nbsp; &quot;AMD Radeon Pro WX Series Graphics&quo=
t;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67E8,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x80,&nbsp;&nbsp; &quot;AMD Radeon E9260 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EB,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x00,&nbsp;&nbsp; &quot;AMD Radeon Pro WX Series Graphics&quo=
t;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC0,&nbsp;&nbsp; &quot;AMD Radeon RX Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC1,&nbsp;&nbsp; &quot;AMD Radeon RX 460 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC5,&nbsp;&nbsp; &quot;AMD Radeon RX 460 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC7,&nbsp;&nbsp; &quot;AMD Radeon RX Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xCF,&nbsp;&nbsp; &quot;AMD Radeon RX 460 Graphics&quot;},<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67EF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xEF,&nbsp;&nbsp; &quot;AMD Radeon RX Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67FF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC0,&nbsp;&nbsp; &quot;AMD Radeon RX Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x67FF,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC1,&nbsp;&nbsp; &quot;AMD Radeon RX Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6800,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7970M&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6801,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon(TM) HD8970M&quot;},<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6808,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;ATI FirePro V(FireGL V) Graphics=
 Adapter&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6809,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;ATI FirePro V(FireGL V) Graphics=
 Adapter&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6810,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon(TM) HD 8800 Series&qu=
ot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6810,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 370 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon(TM) HD8800 Series&quo=
t;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6811,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 300 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6818,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7800 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6819,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7800 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6820,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6820,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R9 M375&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6820,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R9 M375X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6821,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6821,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x87,&nbsp;&nbsp; &quot;AMD Radeon R7 M380&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6821,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R9 M370X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6822,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon E8860&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6823,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6825,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6827,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6828,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;ATI FirePro V(FireGL V) Graphics=
 Adapter&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x682B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 8800M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x682B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x87,&nbsp;&nbsp; &quot;AMD Radeon R9 M360&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x682C,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD FirePro W4100&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x682D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7700M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x682F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7700M Series&quot;=
},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6835,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 Series / HD 9000 S=
eries&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6837,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD7700 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x683D,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7700 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x683F,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon HD 7700 Series&quot;}=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6900,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R7 M260&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6900,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R7 M360&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6900,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x83,&nbsp;&nbsp; &quot;AMD Radeon R7 M340&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6901,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R5 M255&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6907,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R5 M255&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6907,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x87,&nbsp;&nbsp; &quot;AMD Radeon R5 M315&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6920,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 M395X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6920,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x1,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 M390X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6921,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 M295X&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6929,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD FirePro S7150&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x692B,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD FirePro W7100&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6938,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6938,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xF0,&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6938,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xF1,&nbsp;&nbsp; &quot;AMD Radeon R9 380 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6939,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xF0,&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6939,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;AMD Radeon R9 200 Series&quot;},=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x6939,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xF1,&nbsp;&nbsp; &quot;AMD Radeon R9 380 Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x7300,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC8,&nbsp;&nbsp; &quot;AMD Radeon R9 Fury Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x7300,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xCB,&nbsp;&nbsp; &quot;AMD Radeon R9 Fury Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x7300,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xCA,&nbsp;&nbsp; &quot;AMD Radeon R9 Fury Series&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC4,&nbsp;&nbsp; &quot;AMD Radeon R7 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC5,&nbsp;&nbsp; &quot;AMD Radeon R6 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC6,&nbsp;&nbsp; &quot;AMD Radeon R6 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0xC7,&nbsp;&nbsp; &quot;AMD Radeon R5 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x81,&nbsp;&nbsp; &quot;AMD Radeon R6 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x87,&nbsp;&nbsp; &quot;AMD Radeon R5 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x85,&nbsp;&nbsp; &quot;AMD Radeon R6 Graphics&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x9874,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x84,&nbsp;&nbsp; &quot;AMD Radeon R7 Graphics&quot;},<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x0000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x0,&nbsp;&nbsp;&nbsp; &quot;\0&quot;},<br>
-};<br>
-#endif<br>
diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c<br>
index f473d2d..9d08744 100644<br>
--- a/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_device.c<br>
@@ -44,7 &#43;44,6 @@<br>
&nbsp;#include &quot;amdgpu_internal.h&quot;<br>
&nbsp;#include &quot;util_hash_table.h&quot;<br>
&nbsp;#include &quot;util_math.h&quot;<br>
-#include &quot;amdgpu_asic_id.h&quot;<br>
&nbsp;<br>
&nbsp;#define PTR_TO_UINT(x) ((unsigned)((intptr_t)(x)))<br>
&nbsp;#define UINT_TO_PTR(x) ((void *)((intptr_t)(x)))<br>
@@ -131,6 &#43;130,7 @@ static int amdgpu_get_auth(int fd, int *auth)<br>
&nbsp;<br>
&nbsp;static void amdgpu_device_free_internal(amdgpu_device_handle dev)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_asic_id *id;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vamgr_deinit(&amp;d=
ev-&gt;vamgr_32);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vamgr_deinit(&amp;d=
ev-&gt;vamgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; util_hash_table_destroy(de=
v-&gt;bo_flink_names);<br>
@@ -140,6 &#43;140,13 @@ static void amdgpu_device_free_internal(amdgpu_dev=
ice_handle dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(dev-&gt;fd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((dev-&gt;flink_fd &gt;=
=3D 0) &amp;&amp; (dev-&gt;fd !=3D dev-&gt;flink_fd))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; close(dev-&gt;flink_fd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;asic_ids) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (id =3D dev-&gt;asic_ids; id-&gt;did; id&#43;&#43;) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (id-&gt;m=
arketing_name !=3D&nbsp; NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(id-&gt;marketing_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; free(dev-&gt;asic_ids);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(dev);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -267,6 &#43;274,11 @@ int amdgpu_device_initialize(int fd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vamgr_init(&amp;dev=
-&gt;vamgr_32, start, max,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev-&gt;dev_info.virtual_address_alignment);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_parse_asic_ids(&amp;=
dev-&gt;asic_ids);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fprintf(stderr, &quot;%s: Can not parse asic ids, 0x%x.&quot=
;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, r)=
;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *major_version =3D dev-&gt=
;major_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *minor_version =3D dev-&gt=
;minor_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *device_handle =3D dev;<br=
>
@@ -297,13 &#43;309,15 @@ int amdgpu_device_deinitialize(amdgpu_device_hand=
le dev)<br>
&nbsp;<br>
&nbsp;const char *amdgpu_get_marketing_name(amdgpu_device_handle dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_asic_id_table_t *=
t =3D amdgpu_asic_id_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_asic_id *id;<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev-&gt;asic_ids)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (t-&gt;did) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((t-&gt;did =3D=3D dev-&gt;info.asic_id) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (t-&gt;rid =3D=3D dev-&gt;info.pci_rev_i=
d))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return t-&gt;mar=
keting_name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; t&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D dev-&gt;asic_ids; id-=
&gt;did; id&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((id-&gt;did =3D=3D dev-&gt;info.asic_id) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (id-&gt;rid =3D=3D dev-&gt;info.pci_rev=
_id))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return id-&g=
t;marketing_name;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h<br>
index cf119a5..9d11bea 100644<br>
--- a/amdgpu/amdgpu_internal.h<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_internal.h<br>
@@ -69,6 &#43;69,12 @@ struct amdgpu_va {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mgr *v=
amgr;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct amdgpu_asic_id {<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t did;<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t rid;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *marketing_name;<br>
&#43;};<br>
&#43;<br>
&nbsp;struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t refcount;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
@@ -76,6 &#43;82,8 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned major_version;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned minor_version;<br=
>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Lookup table of asic device i=
d, revision id and marketing name */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_asic_id *asic_ids;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** List of buffer handles=
. Protected by bo_table_mutex. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct util_hash_table *bo=
_handles;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** List of buffer GEM fli=
nk names. Protected by bo_table_mutex. */<br>
@@ -149,6 &#43;157,8 @@ amdgpu_vamgr_find_va(struct amdgpu_bo_va_mgr *mgr, =
uint64_t size,<br>
&nbsp;drm_private void<br>
&nbsp;amdgpu_vamgr_free_va(struct amdgpu_bo_va_mgr *mgr, uint64_t va, uint6=
4_t size);<br>
&nbsp;<br>
&#43;drm_private int amdgpu_parse_asic_ids(struct amdgpu_asic_id **asic_ids=
);<br>
&#43;<br>
&nbsp;drm_private int amdgpu_query_gpu_info_init(amdgpu_device_handle dev);=
<br>
&nbsp;<br>
&nbsp;drm_private uint64_t amdgpu_cs_calculate_timeout(uint64_t timeout);<b=
r>
-- <br>
2.7.4<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BY2PR1201MB0968501917152E7FF9C1B19D89ED0BY2PR1201MB0968_--

--===============0656594655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0656594655==--
