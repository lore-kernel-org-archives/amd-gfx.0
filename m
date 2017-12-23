From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/2] Move cursor related ScreenInit
 calls into AMDGPUCursorInit_KMS
Date: Sat, 23 Dec 2017 16:28:15 +0000
Message-ID: <BN6PR12MB1652370CCC7D73956FB7ED4AF7030@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20171222173944.23221-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0694763287=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171222173944.23221-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0694763287==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652370CCC7D73956FB7ED4AF7030BN6PR12MB1652namp_"

--_000_BN6PR12MB1652370CCC7D73956FB7ED4AF7030BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, December 22, 2017 12:39:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-amdgpu 1/2] Move cursor related ScreenInit calls=
 into AMDGPUCursorInit_KMS

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

And bail if xf86_cursors_init fails.

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/amdgpu_kms.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c
index c15711224..58531bf33 100644
--- a/src/amdgpu_kms.c
+++ b/src/amdgpu_kms.c
@@ -1523,12 +1523,29 @@ static Bool AMDGPUCursorInit_KMS(ScreenPtr pScreen)
         ScrnInfoPtr pScrn =3D xf86ScreenToScrn(pScreen);
         AMDGPUInfoPtr info =3D AMDGPUPTR(pScrn);

-       return xf86_cursors_init(pScreen, info->cursor_w, info->cursor_h,
-                                (HARDWARE_CURSOR_TRUECOLOR_AT_8BPP |
-                                 HARDWARE_CURSOR_AND_SOURCE_WITH_MASK |
-                                 HARDWARE_CURSOR_SOURCE_MASK_INTERLEAVE_1 =
|
-                                 HARDWARE_CURSOR_UPDATE_UNHIDDEN |
-                                 HARDWARE_CURSOR_ARGB));
+       xf86DrvMsgVerb(pScrn->scrnIndex, X_INFO, AMDGPU_LOGLEVEL_DEBUG,
+                      "Initializing Cursor\n");
+
+       /* Set Silken Mouse */
+       xf86SetSilkenMouse(pScreen);
+
+       /* Cursor setup */
+       miDCInitialize(pScreen, xf86GetPointerScreenFuncs());
+
+       if (xf86ReturnOptValBool(info->Options, OPTION_SW_CURSOR, FALSE))
+               return TRUE;
+
+       if (!xf86_cursors_init(pScreen, info->cursor_w, info->cursor_h,
+                              HARDWARE_CURSOR_TRUECOLOR_AT_8BPP |
+                              HARDWARE_CURSOR_AND_SOURCE_WITH_MASK |
+                              HARDWARE_CURSOR_SOURCE_MASK_INTERLEAVE_1 |
+                              HARDWARE_CURSOR_UPDATE_UNHIDDEN |
+                              HARDWARE_CURSOR_ARGB)) {
+               xf86DrvMsg(pScrn->scrnIndex, X_ERROR, "xf86_cursors_init fa=
iled\n");
+               return FALSE;
+       }
+
+       return TRUE;
 }

 void AMDGPUBlank(ScrnInfoPtr pScrn)
@@ -1858,19 +1875,8 @@ Bool AMDGPUScreenInit_KMS(ScreenPtr pScreen, int arg=
c, char **argv)
                        "Initializing DPMS\n");
         xf86DPMSInit(pScreen, xf86DPMSSet, 0);

-       xf86DrvMsgVerb(pScrn->scrnIndex, X_INFO, AMDGPU_LOGLEVEL_DEBUG,
-                      "Initializing Cursor\n");
-
-       /* Set Silken Mouse */
-       xf86SetSilkenMouse(pScreen);
-
-       /* Cursor setup */
-       miDCInitialize(pScreen, xf86GetPointerScreenFuncs());
-
-       if (!xf86ReturnOptValBool(info->Options, OPTION_SW_CURSOR, FALSE)) =
{
-               if (AMDGPUCursorInit_KMS(pScreen)) {
-               }
-       }
+       if (!AMDGPUCursorInit_KMS(pScreen))
+               return FALSE;

         /* DGA setup */
 #ifdef XFreeXDGA
--
2.15.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652370CCC7D73956FB7ED4AF7030BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Friday, December 22, 2017 12:39:43 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-amdgpu 1/2] Move cursor related ScreenIni=
t calls into AMDGPUCursorInit_KMS</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
And bail if xf86_cursors_init fails.<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/amdgpu_kms.c | 44 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;-------------------<br>
&nbsp;1 file changed, 25 insertions(&#43;), 19 deletions(-)<br>
<br>
diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c<br>
index c15711224..58531bf33 100644<br>
--- a/src/amdgpu_kms.c<br>
&#43;&#43;&#43; b/src/amdgpu_kms.c<br>
@@ -1523,12 &#43;1523,29 @@ static Bool AMDGPUCursorInit_KMS(ScreenPtr pScr=
een)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr pScrn =3D xf86=
ScreenToScrn(pScreen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPUInfoPtr info =3D AMD=
GPUPTR(pScrn);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return xf86_cursors_init(pScreen, inf=
o-&gt;cursor_w, info-&gt;cursor_h,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (HARDWARE_CURSOR_TRUECOLOR_AT_8BPP |<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_AND_SOURCE_WITH=
_MASK |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_SOURCE_MASK_INT=
ERLEAVE_1 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_UPDATE_UNHIDDEN=
 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_ARGB));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsgVerb(pScrn-&gt;scrnInde=
x, X_INFO, AMDGPU_LOGLEVEL_DEBUG,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Initializing=
 Cursor\n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set Silken Mouse */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86SetSilkenMouse(pScreen);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cursor setup */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; miDCInitialize(pScreen, xf86GetPo=
interScreenFuncs());<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xf86ReturnOptValBool(info-&gt=
;Options, OPTION_SW_CURSOR, FALSE))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return TRUE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xf86_cursors_init(pScreen, i=
nfo-&gt;cursor_w, info-&gt;cursor_h,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_TRUECOLOR_AT_8BPP |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_AND_SOURCE_WITH_MASK |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_SOURCE_MASK_INTERLEAVE_1 |<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_UPDATE_UNHIDDEN |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HARDWARE_CURSOR_ARGB)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; xf86DrvMsg(pScrn-&gt;scrnIndex, X_ERROR, &quot;xf86_cursors_=
init failed\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return FALSE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return TRUE;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void AMDGPUBlank(ScrnInfoPtr pScrn)<br>
@@ -1858,19 &#43;1875,8 @@ Bool AMDGPUScreenInit_KMS(ScreenPtr pScreen, int=
 argc, char **argv)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Initi=
alizing DPMS\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DPMSInit(pScreen, xf86=
DPMSSet, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsgVerb(pScrn-&gt;scrnIndex, X=
_INFO, AMDGPU_LOGLEVEL_DEBUG,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Initializing Cur=
sor\n&quot;);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set Silken Mouse */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86SetSilkenMouse(pScreen);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cursor setup */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; miDCInitialize(pScreen, xf86GetPointe=
rScreenFuncs());<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xf86ReturnOptValBool(info-&gt;Op=
tions, OPTION_SW_CURSOR, FALSE)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (AMDGPUCursorInit_KMS(pScreen)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!AMDGPUCursorInit_KMS(pScreen=
))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return FALSE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DGA setup */<br>
&nbsp;#ifdef XFreeXDGA<br>
-- <br>
2.15.1<br>
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

--_000_BN6PR12MB1652370CCC7D73956FB7ED4AF7030BN6PR12MB1652namp_--

--===============0694763287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0694763287==--
