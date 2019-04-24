From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] Retry get_fb_ptr in get_fb
Date: Wed, 24 Apr 2019 15:26:10 +0000
Message-ID: <BN6PR12MB1809927A95E8ED0D7ADE67BBF73C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190424103230.20174-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0719222941=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190424103230.20174-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0719222941==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809927A95E8ED0D7ADE67BBF73C0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809927A95E8ED0D7ADE67BBF73C0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, April 24, 2019 6:32 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati] Retry get_fb_ptr in get_fb

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

If get_fb_ptr returns NULL, try again after pixmap_get_handle, it should
work then.

Fixes spurious Present page flipping failures using "normal" pixmaps
which aren't shared with direct rendering clients, e.g. with a
compositor using the RENDER extension.

Bugzilla: https://bugs.freedesktop.org/110417
(Ported from amdgpu commit bf61e6d7ac1a5754b1026d7f80acf25ef622c491)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/radeon.h | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index 74454c307..008a59f3a 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -877,21 +877,22 @@ static inline struct drmmode_fb*
 radeon_pixmap_get_fb(PixmapPtr pix)
 {
     struct drmmode_fb **fb_ptr =3D radeon_pixmap_get_fb_ptr(pix);
-
-    if (!fb_ptr)
-       return NULL;
-
-    if (!*fb_ptr) {
-       uint32_t handle;
-
-       if (radeon_get_pixmap_handle(pix, &handle)) {
-           ScrnInfoPtr scrn =3D xf86ScreenToScrn(pix->drawable.pScreen);
-           RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
-
-           *fb_ptr =3D radeon_fb_create(scrn, pRADEONEnt->fd, pix->drawabl=
e.width,
-                                      pix->drawable.height, pix->devKind,
-                                      handle);
-       }
+    uint32_t handle;
+
+    if (fb_ptr && *fb_ptr)
+       return *fb_ptr;
+
+    if (radeon_get_pixmap_handle(pix, &handle)) {
+       ScrnInfoPtr scrn =3D xf86ScreenToScrn(pix->drawable.pScreen);
+       RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
+
+       if (!fb_ptr)
+           fb_ptr =3D radeon_pixmap_get_fb_ptr(pix);
+
+       *fb_ptr =3D radeon_fb_create(scrn, pRADEONEnt->fd,
+                                  pix->drawable.width,
+                                  pix->drawable.height, pix->devKind,
+                                  handle);
     }

     return *fb_ptr;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809927A95E8ED0D7ADE67BBF73C0BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Wednesday, April 24, 2019 6:32 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati] Retry get_fb_ptr in get_fb</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
If get_fb_ptr returns NULL, try again after pixmap_get_handle, it should<br=
>
work then.<br>
<br>
Fixes spurious Present page flipping failures using &quot;normal&quot; pixm=
aps<br>
which aren't shared with direct rendering clients, e.g. with a<br>
compositor using the RENDER extension.<br>
<br>
Bugzilla: <a href=3D"https://bugs.freedesktop.org/110417">https://bugs.free=
desktop.org/110417</a><br>
(Ported from amdgpu commit bf61e6d7ac1a5754b1026d7f80acf25ef622c491)<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/radeon.h | 31 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;---------------<br>
&nbsp;1 file changed, 16 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/src/radeon.h b/src/radeon.h<br>
index 74454c307..008a59f3a 100644<br>
--- a/src/radeon.h<br>
&#43;&#43;&#43; b/src/radeon.h<br>
@@ -877,21 &#43;877,22 @@ static inline struct drmmode_fb*<br>
&nbsp;radeon_pixmap_get_fb(PixmapPtr pix)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct drmmode_fb **fb_ptr =3D radeon_pixmap_get_f=
b_ptr(pix);<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (!fb_ptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (!*fb_ptr) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t handle;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (radeon_get_pixmap_handle(pix, &am=
p;handle)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr s=
crn =3D xf86ScreenToScrn(pix-&gt;drawable.pScreen);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RADEONEntPtr =
pRADEONEnt =3D RADEONEntPriv(scrn);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fb_ptr =3D r=
adeon_fb_create(scrn, pRADEONEnt-&gt;fd, pix-&gt;drawable.width,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ix-&gt;drawable.height, pix-&gt;devKind,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h=
andle);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t handle;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; if (fb_ptr &amp;&amp; *fb_ptr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return *fb_ptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;&nbsp;&nbsp;&nbsp; if (radeon_get_pixmap_handle(pix, &amp;handle)) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenTo=
Scrn(pix-&gt;drawable.pScreen);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEO=
NEntPriv(scrn);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fb_ptr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fb_ptr =
=3D radeon_pixmap_get_fb_ptr(pix);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fb_ptr =3D radeon_fb_create(scrn=
, pRADEONEnt-&gt;fd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pix-&gt;drawable.widt=
h,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pix-&gt;drawable.heig=
ht, pix-&gt;devKind,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; return *fb_ptr;<br>
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

--_000_BN6PR12MB1809927A95E8ED0D7ADE67BBF73C0BN6PR12MB1809namp_--

--===============0719222941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0719222941==--
