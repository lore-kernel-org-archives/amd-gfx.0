From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 1/2] Only call drmmode_uevent_init if RandR
 is enabled
Date: Wed, 9 Jan 2019 14:27:00 +0000
Message-ID: <BN6PR12MB18090CA1D25579CFF7BFCE3EF78B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190109104323.4524-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1183325101=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190109104323.4524-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1183325101==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090CA1D25579CFF7BFCE3EF78B0BN6PR12MB1809namp_"

--_000_BN6PR12MB18090CA1D25579CFF7BFCE3EF78B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, January 9, 2019 5:43:22 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 1/2] Only call drmmode_uevent_init if RandR =
is enabled

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

There's no point in listening for hotplug events if RandR is disabled,
as there's no other mechanism for them to be propagated. We were already
mostly ignoring them in that case.

Inspired by
https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/commit/1a489142=
c8e6a4828348cc9afbd0f430d3b1e2d8
(via https://bugs.freedesktop.org/109230#c11).

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c | 2 +-
 src/radeon_kms.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index d433e0611..e04a17d5e 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -3273,7 +3273,7 @@ restart_destroy:
         /* Check to see if a lessee has disappeared */
         drmmode_validate_leases(scrn);

-       if (changed && dixPrivateKeyRegistered(rrPrivKey)) {
+       if (changed) {
 #if XORG_VERSION_CURRENT >=3D XORG_VERSION_NUMERIC(1,14,99,2,0)
                 RRSetChanged(xf86ScrnToScreen(scrn));
 #else
diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index bb6885fb9..67f42e0fe 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -349,13 +349,13 @@ static Bool RADEONCreateScreenResources_KMS(ScreenPtr=
 pScreen)
             RROutputChanged(rrScrPriv->primaryOutput, FALSE);
             rrScrPriv->layoutChanged =3D TRUE;
         }
+
+       drmmode_uevent_init(pScrn, &info->drmmode);
     }

     if (!drmmode_set_desired_modes(pScrn, &info->drmmode, pScreen->isGPU))
         return FALSE;

-    drmmode_uevent_init(pScrn, &info->drmmode);
-
     if (info->r600_shadow_fb) {
         pixmap =3D pScreen->GetScreenPixmap(pScreen);

--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18090CA1D25579CFF7BFCE3EF78B0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Wednesday, January 9, 2019 5:43:22 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 1/2] Only call drmmode_uevent_init if=
 RandR is enabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
There's no point in listening for hotplug events if RandR is disabled,<br>
as there's no other mechanism for them to be propagated. We were already<br=
>
mostly ignoring them in that case.<br>
<br>
Inspired by<br>
<a href=3D"https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/comm=
it/1a489142c8e6a4828348cc9afbd0f430d3b1e2d8">https://gitlab.freedesktop.org=
/xorg/driver/xf86-video-intel/commit/1a489142c8e6a4828348cc9afbd0f430d3b1e2=
d8</a><br>
(via <a href=3D"https://bugs.freedesktop.org/109230#c11">https://bugs.freed=
esktop.org/109230#c11</a>).<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c | 2 &#43;-<br>
&nbsp;src/radeon_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<br>
&nbsp;2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index d433e0611..e04a17d5e 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -3273,7 &#43;3273,7 @@ restart_destroy:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check to see if a lesse=
e has disappeared */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_validate_leases(sc=
rn);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (changed &amp;&amp; dixPrivateKeyR=
egistered(rrPrivKey)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (changed) {<br>
&nbsp;#if XORG_VERSION_CURRENT &gt;=3D XORG_VERSION_NUMERIC(1,14,99,2,0)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RRSetChanged(xf86ScrnToScreen(scrn));<br>
&nbsp;#else<br>
diff --git a/src/radeon_kms.c b/src/radeon_kms.c<br>
index bb6885fb9..67f42e0fe 100644<br>
--- a/src/radeon_kms.c<br>
&#43;&#43;&#43; b/src/radeon_kms.c<br>
@@ -349,13 &#43;349,13 @@ static Bool RADEONCreateScreenResources_KMS(Scree=
nPtr pScreen)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RR=
OutputChanged(rrScrPriv-&gt;primaryOutput, FALSE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rr=
ScrPriv-&gt;layoutChanged =3D TRUE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_uevent_init(pScrn, &amp;i=
nfo-&gt;drmmode);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!drmmode_set_desired_modes(pScrn, &amp;info-&g=
t;drmmode, pScreen-&gt;isGPU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return FALSE;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; drmmode_uevent_init(pScrn, &amp;info-&gt;drmmode);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;r600_shadow_fb) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pixmap =3D pScreen-&gt;Get=
ScreenPixmap(pScreen);<br>
&nbsp;<br>
-- <br>
2.20.1<br>
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

--_000_BN6PR12MB18090CA1D25579CFF7BFCE3EF78B0BN6PR12MB1809namp_--

--===============1183325101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1183325101==--
