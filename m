From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm v2] drm: add fallback function to get device name
Date: Mon, 24 Jun 2019 16:04:20 +0000
Message-ID: <MN2PR12MB3296B9C93C1789A2D489F086A2E00@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190624114819.3422-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1859264903=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190624114819.3422-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>

--===============1859264903==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296B9C93C1789A2D489F086A2E00MN2PR12MB3296namp_"

--_000_MN2PR12MB3296B9C93C1789A2D489F086A2E00MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

changes  history:

v1: 1. Simplify the old code logic,

      2. Provides a backup function when the name is not found in the amdgp=
u.ids file

v2: 1. when open ids file fail, not ids version or ids version not matched,=
 it will generate a device name by device id and revision id. eg:69a0:01

      2. fix miss a close file operation.


BR,

Kevin

________________________________
From: Wang, Kevin(Yang) <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, June 24, 2019 7:48 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Daenzer, Michel; Wang, Kevin(Yang)
Subject: [PATCH libdrm v2] drm: add fallback function to get device name

1.optimize code logic.
2.if not found device name in amdgpu.ids,
will return a fallback device name "deviceid:revisionid", eg:69a0:01

Change-Id: I0d0c95a402533a74978681309680cb73d6a36e60
Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu_asic_id.c  | 134 ++++++++-------------------------------
 amdgpu/amdgpu_device.c   |   5 +-
 amdgpu/amdgpu_internal.h |   1 +
 3 files changed, 33 insertions(+), 107 deletions(-)

diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c
index a5007ffc80a7..6ecb9e573403 100644
--- a/amdgpu/amdgpu_asic_id.c
+++ b/amdgpu/amdgpu_asic_id.c
@@ -34,128 +34,50 @@
 #include "amdgpu_drm.h"
 #include "amdgpu_internal.h"

-static int parse_one_line(struct amdgpu_device *dev, const char *line)
+char* amdgpu_get_device_name(uint32_t devid, uint32_t revid)
 {
-       char *buf, *saveptr;
-       char *s_did;
-       uint32_t did;
-       char *s_rid;
-       uint32_t rid;
-       char *s_name;
-       char *endptr;
-       int r =3D -EINVAL;

-       /* ignore empty line and commented line */
-       if (strlen(line) =3D=3D 0 || line[0] =3D=3D '#')
-               return -EAGAIN;
-
-       buf =3D strdup(line);
-       if (!buf)
-               return -ENOMEM;
-
-       /* device id */
-       s_did =3D strtok_r(buf, ",", &saveptr);
-       if (!s_did)
-               goto out;
-
-       did =3D strtol(s_did, &endptr, 16);
-       if (*endptr)
-               goto out;
-
-       if (did !=3D dev->info.asic_id) {
-               r =3D -EAGAIN;
-               goto out;
-       }
-
-       /* revision id */
-       s_rid =3D strtok_r(NULL, ",", &saveptr);
-       if (!s_rid)
-               goto out;
-
-       rid =3D strtol(s_rid, &endptr, 16);
-       if (*endptr)
-               goto out;
-
-       if (rid !=3D dev->info.pci_rev_id) {
-               r =3D -EAGAIN;
-               goto out;
-       }
-
-       /* marketing name */
-       s_name =3D strtok_r(NULL, ",", &saveptr);
-       if (!s_name)
-               goto out;
-
-       /* trim leading whitespaces or tabs */
-       while (isblank(*s_name))
-               s_name++;
-       if (strlen(s_name) =3D=3D 0)
-               goto out;
-
-       dev->marketing_name =3D strdup(s_name);
-       if (dev->marketing_name)
-               r =3D 0;
-       else
-               r =3D -ENOMEM;
-
-out:
-       free(buf);
-
-       return r;
-}
-
-void amdgpu_parse_asic_ids(struct amdgpu_device *dev)
-{
-       FILE *fp;
-       char *line =3D NULL;
-       size_t len =3D 0;
-       ssize_t n;
-       int line_num =3D 1;
-       int r =3D 0;
+       char *name =3D NULL;
+       FILE *fp =3D NULL;
+       char buf[100];
+       int a, b, c, len =3D 0;
+       uint32_t vid, rid;

         fp =3D fopen(AMDGPU_ASIC_ID_TABLE, "r");
         if (!fp) {
                 fprintf(stderr, "%s: %s\n", AMDGPU_ASIC_ID_TABLE,
                         strerror(errno));
-               return;
+               goto fallback;
         }

-       /* 1st valid line is file version */
-       while ((n =3D getline(&line, &len, fp)) !=3D -1) {
-               /* trim trailing newline */
-               if (line[n - 1] =3D=3D '\n')
-                       line[n - 1] =3D '\0';
-
-               /* ignore empty line and commented line */
-               if (strlen(line) =3D=3D 0 || line[0] =3D=3D '#') {
-                       line_num++;
-                       continue;
-               }
-
-               drmMsg("%s version: %s\n", AMDGPU_ASIC_ID_TABLE, line);
+       while (fgets(buf, sizeof(buf), fp)) {
+               if (buf[0] =3D=3D '#') continue;
                 break;
         }

-       while ((n =3D getline(&line, &len, fp)) !=3D -1) {
-               /* trim trailing newline */
-               if (line[n - 1] =3D=3D '\n')
-                       line[n - 1] =3D '\0';
+       if (fscanf(fp, "%d.%d.%d", &a, &b, &c) !=3D 3)
+               goto fallback;

-               r =3D parse_one_line(dev, line);
-               if (r !=3D -EAGAIN)
-                       break;
+       /* check ids verison: should be 1.0.0 */
+       if (a !=3D 1 || b !=3D 0 || c !=3D 0)
+               goto fallback;

-               line_num++;
+       while(!feof(fp) && fscanf(fp, "%4x, %2x, %[^,'\n']", &vid, &rid, bu=
f) =3D=3D 3) {
+               if (vid =3D=3D devid && rid =3D=3D revid) {
+                       name =3D strdup(buf);
+                       break;
+               }
         }

-       if (r =3D=3D -EINVAL) {
-               fprintf(stderr, "Invalid format: %s: line %d: %s\n",
-                       AMDGPU_ASIC_ID_TABLE, line_num, line);
-       } else if (r && r !=3D -EAGAIN) {
-               fprintf(stderr, "%s: Cannot parse ASIC IDs: %s\n",
-                       __func__, strerror(-r));
+fallback:
+       if (name =3D=3D NULL) {
+               memset(buf, 0, sizeof(buf));
+               len =3D snprintf(buf, sizeof(buf), "%04x:%02x", devid, revi=
d);
+               buf[len] =3D '\0';
+               name =3D strdup(buf);
         }
+       if (fp)
+               fclose(fp);

-       free(line);
-       fclose(fp);
+       return name;
 }
diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c
index 8e74393a5518..4291c6628346 100644
--- a/amdgpu/amdgpu_device.c
+++ b/amdgpu/amdgpu_device.c
@@ -260,7 +260,10 @@ drm_public int amdgpu_device_initialize(int fd,
         amdgpu_vamgr_init(&dev->vamgr_high, start, max,
                           dev->dev_info.virtual_address_alignment);

-       amdgpu_parse_asic_ids(dev);
+       /* amdgpu_get_device_name(vid, rid) */
+       dev->marketing_name =3D amdgpu_get_device_name(dev->info.asic_id,
+                                                    dev->info.pci_rev_id);
+

         *major_version =3D dev->major_version;
         *minor_version =3D dev->minor_version;
diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h
index b614b4acb81f..510abecd0042 100644
--- a/amdgpu/amdgpu_internal.h
+++ b/amdgpu/amdgpu_internal.h
@@ -142,6 +142,7 @@ drm_private void amdgpu_vamgr_init(struct amdgpu_bo_va_=
mgr *mgr, uint64_t start,
 drm_private void amdgpu_vamgr_deinit(struct amdgpu_bo_va_mgr *mgr);

 drm_private void amdgpu_parse_asic_ids(struct amdgpu_device *dev);
+drm_private char* amdgpu_get_device_name(uint32_t devid, uint32_t revid);

 drm_private int amdgpu_query_gpu_info_init(amdgpu_device_handle dev);

--
2.22.0


--_000_MN2PR12MB3296B9C93C1789A2D489F086A2E00MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">changes&nbsp; history:</p>
<p style=3D"margin-top:0;margin-bottom:0">v1: 1.&nbsp;<span style=3D"font-s=
ize: 12pt;">Simplify the old code logic,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 12pt;">=
&nbsp; &nbsp; &nbsp; 2.&nbsp;Provides a backup function when the name is no=
t found in the amdgpu.ids file</span></p>
<p style=3D"margin-top:0;margin-bottom:0">v2: 1. when open ids file fail, n=
ot ids version or&nbsp;ids version not matched, it will generate a device n=
ame by device id and revision id. eg:69a0:01</p>
<p style=3D"margin-top:0;margin-bottom:0">&nbsp; &nbsp; &nbsp; 2. fix miss =
a close file&nbsp;<span style=3D"font-size: 12pt;">operation.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">BR,</p>
<p style=3D"margin-top:0;margin-bottom:0">Kevin</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, June 24, 2019 7:48 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Daenzer, Michel; Wang, Kevin(Yang)<br>
<b>Subject:</b> [PATCH libdrm v2] drm: add fallback function to get device =
name</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">1.optimize code logic.<br>
2.if not found device name in amdgpu.ids,<br>
will return a fallback device name &quot;deviceid:revisionid&quot;, eg:69a0=
:01<br>
<br>
Change-Id: I0d0c95a402533a74978681309680cb73d6a36e60<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;amdgpu/amdgpu_asic_id.c&nbsp; | 134 &#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;-------------------------------<br>
&nbsp;amdgpu/amdgpu_device.c&nbsp;&nbsp; |&nbsp;&nbsp; 5 &#43;-<br>
&nbsp;amdgpu/amdgpu_internal.h |&nbsp;&nbsp; 1 &#43;<br>
&nbsp;3 files changed, 33 insertions(&#43;), 107 deletions(-)<br>
<br>
diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c<br>
index a5007ffc80a7..6ecb9e573403 100644<br>
--- a/amdgpu/amdgpu_asic_id.c<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_asic_id.c<br>
@@ -34,128 &#43;34,50 @@<br>
&nbsp;#include &quot;amdgpu_drm.h&quot;<br>
&nbsp;#include &quot;amdgpu_internal.h&quot;<br>
&nbsp;<br>
-static int parse_one_line(struct amdgpu_device *dev, const char *line)<br>
&#43;char* amdgpu_get_device_name(uint32_t devid, uint32_t revid)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf, *saveptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_did;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_rid;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t rid;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *s_name;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *endptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ignore empty line and commented li=
ne */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(line) =3D=3D 0 || line[0] =
=3D=3D '#')<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EAGAIN;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf =3D strdup(line);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* device id */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_did =3D strtok_r(buf, &quot;,&quot;=
, &amp;saveptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_did)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; did =3D strtol(s_did, &amp;endptr, 16=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*endptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (did !=3D dev-&gt;info.asic_id) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -EAGAIN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* revision id */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_rid =3D strtok_r(NULL, &quot;,&quot=
;, &amp;saveptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_rid)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rid =3D strtol(s_rid, &amp;endptr, 16=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*endptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rid !=3D dev-&gt;info.pci_rev_id)=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -EAGAIN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* marketing name */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_name =3D strtok_r(NULL, &quot;,&quo=
t;, &amp;saveptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!s_name)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* trim leading whitespaces or tabs *=
/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (isblank(*s_name))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; s_name&#43;&#43;;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strlen(s_name) =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;marketing_name =3D strdup(s_n=
ame);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;marketing_name)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ENOMEM;<br>
-<br>
-out:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(buf);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-}<br>
-<br>
-void amdgpu_parse_asic_ids(struct amdgpu_device *dev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FILE *fp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *line =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t n;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int line_num =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *name =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FILE *fp =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char buf[100];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int a, b, c, len =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vid, rid;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fp =3D fopen(AMDGPU_ASIC_I=
D_TABLE, &quot;r&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fp) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: %s\n&quot;, AMDGPU_ASIC_ID_=
TABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strer=
ror(errno));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto fallback;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 1st valid line is file version */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((n =3D getline(&amp;line, &amp=
;len, fp)) !=3D -1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* trim trailing newline */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (line[n - 1] =3D=3D '\n')<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line[n - 1] =3D =
'\0';<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* ignore empty line and commented line */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (strlen(line) =3D=3D 0 || line[0] =3D=3D '#') {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line_num&#43;&#4=
3;;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drmMsg(&quot;%s version: %s\n&quot;, AMDGPU_ASIC_ID_TABLE, line)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fgets(buf, sizeof(buf), fp=
)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (buf[0] =3D=3D '#') continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((n =3D getline(&amp;line, &amp=
;len, fp)) !=3D -1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* trim trailing newline */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (line[n - 1] =3D=3D '\n')<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line[n - 1] =3D =
'\0';<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fscanf(fp, &quot;%d.%d.%d&quo=
t;, &amp;a, &amp;b, &amp;c) !=3D 3)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto fallback;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D parse_one_line(dev, line);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r !=3D -EAGAIN)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check ids verison: should be 1=
.0.0 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a !=3D 1 || b !=3D 0 || c !=
=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto fallback;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; line_num&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(!feof(fp) &amp;&amp; fscanf=
(fp, &quot;%4x, %2x, %[^,'\n']&quot;, &amp;vid, &amp;rid, buf) =3D=3D 3) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (vid =3D=3D devid &amp;&amp; rid =3D=3D revid) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name =3D str=
dup(buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -EINVAL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fprintf(stderr, &quot;Invalid format: %s: line %d: %s\n&quot;,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_ASIC_ID_T=
ABLE, line_num, line);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (r &amp;&amp; r !=3D -EAGAI=
N) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fprintf(stderr, &quot;%s: Cannot parse ASIC IDs: %s\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, strerr=
or(-r));<br>
&#43;fallback:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (name =3D=3D NULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memset(buf, 0, sizeof(buf));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; len =3D snprintf(buf, sizeof(buf), &quot;%04x:%02x&quot;, de=
vid, revid);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; buf[len] =3D '\0';<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; name =3D strdup(buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fp)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fclose(fp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(line);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fclose(fp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return name;<br>
&nbsp;}<br>
diff --git a/amdgpu/amdgpu_device.c b/amdgpu/amdgpu_device.c<br>
index 8e74393a5518..4291c6628346 100644<br>
--- a/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_device.c<br>
@@ -260,7 &#43;260,10 @@ drm_public int amdgpu_device_initialize(int fd,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vamgr_init(&amp;dev=
-&gt;vamgr_high, start, max,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev-&gt;dev_info.virtual_address_alignment);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_parse_asic_ids(dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* amdgpu_get_device_name(vid, ri=
d) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;marketing_name =3D amdgpu=
_get_device_name(dev-&gt;info.asic_id,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; dev-&gt;info.pci_rev_id);<br>
&#43;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *major_version =3D dev-&gt=
;major_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *minor_version =3D dev-&gt=
;minor_version;<br>
diff --git a/amdgpu/amdgpu_internal.h b/amdgpu/amdgpu_internal.h<br>
index b614b4acb81f..510abecd0042 100644<br>
--- a/amdgpu/amdgpu_internal.h<br>
&#43;&#43;&#43; b/amdgpu/amdgpu_internal.h<br>
@@ -142,6 &#43;142,7 @@ drm_private void amdgpu_vamgr_init(struct amdgpu_bo=
_va_mgr *mgr, uint64_t start,<br>
&nbsp;drm_private void amdgpu_vamgr_deinit(struct amdgpu_bo_va_mgr *mgr);<b=
r>
&nbsp;<br>
&nbsp;drm_private void amdgpu_parse_asic_ids(struct amdgpu_device *dev);<br=
>
&#43;drm_private char* amdgpu_get_device_name(uint32_t devid, uint32_t revi=
d);<br>
&nbsp;<br>
&nbsp;drm_private int amdgpu_query_gpu_info_init(amdgpu_device_handle dev);=
<br>
&nbsp;<br>
-- <br>
2.22.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3296B9C93C1789A2D489F086A2E00MN2PR12MB3296namp_--

--===============1859264903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1859264903==--
