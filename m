From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 3/3] Remove dri2_drawable_crtc parameter
 consider_disabled
Date: Fri, 14 Jun 2019 13:37:16 +0000
Message-ID: <BN6PR12MB1809A51AC1ED562BDED9AEAEF7EE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190614092745.4488-1-michel@daenzer.net>,
 <20190614092745.4488-3-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1876992852=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190614092745.4488-3-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1876992852==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A51AC1ED562BDED9AEAEF7EE0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A51AC1ED562BDED9AEAEF7EE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, June 14, 2019 5:27 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 3/3] Remove dri2_drawable_crtc parameter con=
sider_disabled

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

All callers were passing TRUE.

(Ported from amdgpu commit ea19a5207054bb159fc7fb6d88e0ceb10c3da010)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/radeon_dri2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c
index c59d799ff..66a223d87 100644
--- a/src/radeon_dri2.c
+++ b/src/radeon_dri2.c
@@ -509,11 +509,11 @@ static Bool radeon_dri2_get_crtc_msc(xf86CrtcPtr crtc=
, CARD64 *ust, CARD64 *msc)
 }

 static
-xf86CrtcPtr radeon_dri2_drawable_crtc(DrawablePtr pDraw, Bool consider_dis=
abled)
+xf86CrtcPtr radeon_dri2_drawable_crtc(DrawablePtr pDraw)
 {
     ScreenPtr pScreen =3D pDraw->pScreen;
     ScrnInfoPtr pScrn =3D xf86ScreenToScrn(pScreen);
-    xf86CrtcPtr crtc =3D radeon_pick_best_crtc(pScrn, consider_disabled,
+    xf86CrtcPtr crtc =3D radeon_pick_best_crtc(pScrn, TRUE,
                                               pDraw->x, pDraw->x + pDraw->=
width,
                                               pDraw->y, pDraw->y + pDraw->=
height);

@@ -928,7 +928,7 @@ CARD32 radeon_dri2_extrapolate_msc_delay(xf86CrtcPtr cr=
tc, CARD64 *target_msc,
  */
 static int radeon_dri2_get_msc(DrawablePtr draw, CARD64 *ust, CARD64 *msc)
 {
-    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TRUE);
+    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw);

     /* Drawable not displayed, make up a value */
     if (!crtc) {
@@ -1043,7 +1043,7 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr cl=
ient, DrawablePtr draw,
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
     DRI2FrameEventPtr wait_info =3D NULL;
     uintptr_t drm_queue_seq =3D 0;
-    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TRUE);
+    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw);
     uint32_t msc_delta;
     uint32_t seq;
     CARD64 current_msc;
@@ -1192,7 +1192,7 @@ static int radeon_dri2_schedule_swap(ClientPtr client=
, DrawablePtr draw,
 {
     ScreenPtr screen =3D draw->pScreen;
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TRUE);
+    xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw);
     uint32_t msc_delta;
     drmVBlankSeqType type;
     uint32_t seq;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A51AC1ED562BDED9AEAEF7EE0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Friday, June 14, 2019 5:27 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 3/3] Remove dri2_drawable_crtc parame=
ter consider_disabled</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
All callers were passing TRUE.<br>
<br>
(Ported from amdgpu commit ea19a5207054bb159fc7fb6d88e0ceb10c3da010)<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/radeon_dri2.c | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 5 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c<br>
index c59d799ff..66a223d87 100644<br>
--- a/src/radeon_dri2.c<br>
&#43;&#43;&#43; b/src/radeon_dri2.c<br>
@@ -509,11 &#43;509,11 @@ static Bool radeon_dri2_get_crtc_msc(xf86CrtcPtr =
crtc, CARD64 *ust, CARD64 *msc)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static<br>
-xf86CrtcPtr radeon_dri2_drawable_crtc(DrawablePtr pDraw, Bool consider_dis=
abled)<br>
&#43;xf86CrtcPtr radeon_dri2_drawable_crtc(DrawablePtr pDraw)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr pScreen =3D pDraw-&gt;pScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr pScrn =3D xf86ScreenToScrn(pScreen);<b=
r>
-&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_pick_best_crtc(pScrn, consi=
der_disabled,<br>
&#43;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_pick_best_crtc(pScrn, T=
RUE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pDraw-&gt;x, pDraw-&gt;=
x &#43; pDraw-&gt;width,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pDraw-&gt;y, pDraw-&gt;=
y &#43; pDraw-&gt;height);<br>
&nbsp;<br>
@@ -928,7 &#43;928,7 @@ CARD32 radeon_dri2_extrapolate_msc_delay(xf86CrtcPt=
r crtc, CARD64 *target_msc,<br>
&nbsp; */<br>
&nbsp;static int radeon_dri2_get_msc(DrawablePtr draw, CARD64 *ust, CARD64 =
*msc)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TR=
UE);<br>
&#43;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw=
);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Drawable not displayed, make up a value */<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!crtc) {<br>
@@ -1043,7 &#43;1043,7 @@ static int radeon_dri2_schedule_wait_msc(ClientPt=
r client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
&nbsp;&nbsp;&nbsp;&nbsp; DRI2FrameEventPtr wait_info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq =3D 0;<br>
-&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TR=
UE);<br>
&#43;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&nbsp;&nbsp;&nbsp;&nbsp; CARD64 current_msc;<br>
@@ -1192,7 &#43;1192,7 @@ static int radeon_dri2_schedule_swap(ClientPtr cl=
ient, DrawablePtr draw,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D draw-&gt;pScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TR=
UE);<br>
&#43;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmVBlankSeqType type;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809A51AC1ED562BDED9AEAEF7EE0BN6PR12MB1809namp_--

--===============1876992852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1876992852==--
