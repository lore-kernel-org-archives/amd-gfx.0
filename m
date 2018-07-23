From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Use strcpy for RandR output property
 names
Date: Mon, 23 Jul 2018 16:48:02 +0000
Message-ID: <CY4PR12MB1304495AF9C43146E6CF1C21FE560@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <20180723164511.21547-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858061620=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180723164511.21547-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?Windows-1252?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0858061620==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1304495AF9C43146E6CF1C21FE560CY4PR12MB1304namp_"

--_000_CY4PR12MB1304495AF9C43146E6CF1C21FE560CY4PR12MB1304namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Monday, July 23, 2018 12:45:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-amdgpu] Use strcpy for RandR output property nam=
es

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Instead of strncpy with the string length. Avoids new warnings with GCC
8:

../../src/drmmode_display.c: In function =91drmmode_output_create_resources=
=92:
../../src/drmmode_display.c:2240:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 8 bytes from a string of the same length [-=
Wstringop-truncation]
  strncpy(tearfree_prop->name, "TearFree", 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../src/drmmode_display.c:2244:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 3 bytes from a string of the same length [-=
Wstringop-truncation]
  strncpy(tearfree_prop->enums[0].name, "off", 3);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../src/drmmode_display.c:2245:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 2 bytes from a string of the same length [-=
Wstringop-truncation]
  strncpy(tearfree_prop->enums[1].name, "on", 2);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../src/drmmode_display.c:2247:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 4 bytes from a string of the same length [-=
Wstringop-truncation]
  strncpy(tearfree_prop->enums[2].name, "auto", 4);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index b3e754005..92f58c157 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -2211,14 +2211,14 @@ static void drmmode_output_create_resources(xf86Out=
putPtr output)
         /* Userspace-only property for TearFree */
         tearfree_prop =3D calloc(1, sizeof(*tearfree_prop));
         tearfree_prop->flags =3D DRM_MODE_PROP_ENUM;
-       strncpy(tearfree_prop->name, "TearFree", 8);
+       strcpy(tearfree_prop->name, "TearFree");
         tearfree_prop->count_enums =3D 3;
         tearfree_prop->enums =3D calloc(tearfree_prop->count_enums,
                                       sizeof(*tearfree_prop->enums));
-       strncpy(tearfree_prop->enums[0].name, "off", 3);
-       strncpy(tearfree_prop->enums[1].name, "on", 2);
+       strcpy(tearfree_prop->enums[0].name, "off");
+       strcpy(tearfree_prop->enums[1].name, "on");
         tearfree_prop->enums[1].value =3D 1;
-       strncpy(tearfree_prop->enums[2].name, "auto", 4);
+       strcpy(tearfree_prop->enums[2].name, "auto");
         tearfree_prop->enums[2].value =3D 2;
         drmmode_output->props[j].mode_prop =3D tearfree_prop;
         drmmode_output->props[j].value =3D info->tear_free;
--
2.18.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1304495AF9C43146E6CF1C21FE560CY4PR12MB1304namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Slava Abramov &lt;sl=
ava.abramov-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Monday, July 23, 2018 12:45:11 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-amdgpu] Use strcpy for RandR output prope=
rty names</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
Instead of strncpy with the string length. Avoids new warnings with GCC<br>
8:<br>
<br>
../../src/drmmode_display.c: In function =91drmmode_output_create_resources=
=92:<br>
../../src/drmmode_display.c:2240:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 8 bytes from a string of the same length [-=
Wstringop-truncation]<br>
&nbsp; strncpy(tearfree_prop-&gt;name, &quot;TearFree&quot;, 8);<br>
&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
../../src/drmmode_display.c:2244:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 3 bytes from a string of the same length [-=
Wstringop-truncation]<br>
&nbsp; strncpy(tearfree_prop-&gt;enums[0].name, &quot;off&quot;, 3);<br>
&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
../../src/drmmode_display.c:2245:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 2 bytes from a string of the same length [-=
Wstringop-truncation]<br>
&nbsp; strncpy(tearfree_prop-&gt;enums[1].name, &quot;on&quot;, 2);<br>
&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
../../src/drmmode_display.c:2247:2: warning: =91strncpy=92 output truncated=
 before terminating nul copying 4 bytes from a string of the same length [-=
Wstringop-truncation]<br>
&nbsp; strncpy(tearfree_prop-&gt;enums[2].name, &quot;auto&quot;, 4);<br>
&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c | 8 &#43;&#43;&#43;&#43;----<br>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index b3e754005..92f58c157 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -2211,14 &#43;2211,14 @@ static void drmmode_output_create_resources(xf8=
6OutputPtr output)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Userspace-only property=
 for TearFree */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop =3D calloc(1=
, sizeof(*tearfree_prop));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop-&gt;flags =
=3D DRM_MODE_PROP_ENUM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(tearfree_prop-&gt;name, &quot=
;TearFree&quot;, 8);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(tearfree_prop-&gt;name, &q=
uot;TearFree&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop-&gt;count_en=
ums =3D 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop-&gt;enums =
=3D calloc(tearfree_prop-&gt;count_enums,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sizeof(*tearfree_prop-&gt;enums));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(tearfree_prop-&gt;enums[0].na=
me, &quot;off&quot;, 3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(tearfree_prop-&gt;enums[1].na=
me, &quot;on&quot;, 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(tearfree_prop-&gt;enums[0]=
.name, &quot;off&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(tearfree_prop-&gt;enums[1]=
.name, &quot;on&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop-&gt;enums[1]=
.value =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(tearfree_prop-&gt;enums[2].na=
me, &quot;auto&quot;, 4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(tearfree_prop-&gt;enums[2]=
.name, &quot;auto&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tearfree_prop-&gt;enums[2]=
.value =3D 2;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output-&gt;props[j=
].mode_prop =3D tearfree_prop;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output-&gt;props[j=
].value =3D info-&gt;tear_free;<br>
-- <br>
2.18.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1304495AF9C43146E6CF1C21FE560CY4PR12MB1304namp_--

--===============0858061620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0858061620==--
