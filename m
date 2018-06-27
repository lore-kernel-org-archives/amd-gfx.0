From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code
Date: Wed, 27 Jun 2018 18:29:54 +0000
Message-ID: <CY4PR12MB13040D289B98AF5798E9C4EEFE480@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <20180627163941.18737-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1573858499=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180627163941.18737-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1573858499==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB13040D289B98AF5798E9C4EEFE480CY4PR12MB1304namp_"

--_000_CY4PR12MB13040D289B98AF5798E9C4EEFE480CY4PR12MB1304namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I wonder how '#if 0' made its way upstream, but besides this


Reviewed-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, June 27, 2018 12:39:40 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

This has always been disabled, no need to keep it.

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index 1563417a7..5fe49b607 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -2459,15 +2459,6 @@ static const xf86OutputFuncsRec drmmode_output_funcs=
 =3D {
         .create_resources =3D drmmode_output_create_resources,
         .set_property =3D drmmode_output_set_property,
         .get_property =3D drmmode_output_get_property,
-#if 0
-
-       .save =3D drmmode_crt_save,
-       .restore =3D drmmode_crt_restore,
-       .mode_fixup =3D drmmode_crt_mode_fixup,
-       .prepare =3D drmmode_output_prepare,
-       .mode_set =3D drmmode_crt_mode_set,
-       .commit =3D drmmode_output_commit,
-#endif
         .detect =3D drmmode_output_detect,
         .mode_valid =3D drmmode_output_mode_valid,

@@ -3470,9 +3461,6 @@ Bool drmmode_setup_colormap(ScreenPtr pScreen, ScrnIn=
foPtr pScrn)
                     !xf86HandleColormaps(pScreen, 256, 10,
                                          NULL, NULL,
                                          CMAP_PALETTED_TRUECOLOR
-#if 0                          /* This option messes up text mode! (eich@s=
use.de) */
-                                        | CMAP_LOAD_EVEN_IF_OFFSCREEN
-#endif
                                          | CMAP_RELOAD_ON_MODE_SWITCH))
                         return FALSE;
         }
--
2.18.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB13040D289B98AF5798E9C4EEFE480CY4PR12MB1304namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">I wonder how '#if 0' made its way=
 upstream, but besides this</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Slava Abramov &lt;sl=
ava.abramov-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Wednesday, June 27, 2018 12:39:40 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
This has always been disabled, no need to keep it.<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c | 12 ------------<br>
&nbsp;1 file changed, 12 deletions(-)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index 1563417a7..5fe49b607 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -2459,15 &#43;2459,6 @@ static const xf86OutputFuncsRec drmmode_output_f=
uncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .create_resources =3D drmm=
ode_output_create_resources,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_property =3D drmmode_=
output_set_property,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_property =3D drmmode_=
output_get_property,<br>
-#if 0<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .save =3D drmmode_crt_save,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .restore =3D drmmode_crt_restore,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode_fixup =3D drmmode_crt_mode_fixu=
p,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prepare =3D drmmode_output_prepare,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode_set =3D drmmode_crt_mode_set,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .commit =3D drmmode_output_commit,<br=
>
-#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .detect =3D drmmode_output=
_detect,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode_valid =3D drmmode_ou=
tput_mode_valid,<br>
&nbsp;<br>
@@ -3470,9 &#43;3461,6 @@ Bool drmmode_setup_colormap(ScreenPtr pScreen, Sc=
rnInfoPtr pScrn)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !xf86HandleColormaps(pScreen,=
 256, 10,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NULL, NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; CMAP_PALETTED_TRUECOLOR<br>
-#if 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* This option messes up text mode! (eich-l3A5Bk7waGM@public.gmane.org) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | CMAP_LOAD_EVEN_IF_OFFSCREEN<br>
-#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | CMAP_RELOAD_ON_MODE_SWITCH))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n FALSE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
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

--_000_CY4PR12MB13040D289B98AF5798E9C4EEFE480CY4PR12MB1304namp_--

--===============1573858499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1573858499==--
