From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] Add radeon_dirty_src_drawable helper
Date: Fri, 1 Dec 2017 15:22:06 +0000
Message-ID: <BN6PR12MB1652128FB370F7DD490653A1F7390@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20171201145620.9572-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0027568535=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171201145620.9572-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0027568535==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652128FB370F7DD490653A1F7390BN6PR12MB1652namp_"

--_000_BN6PR12MB1652128FB370F7DD490653A1F7390BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, December 1, 2017 9:56 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati] Add radeon_dirty_src_drawable helper

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Allows tidying up radeon_dirty_src_equals and redisplay_dirty slightly.

(Cherry picked from amdgpu commit 1d65ac395971571094df21ca0408d5972c6b56ec)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

---
 src/radeon.h     | 18 +++++++++---------
 src/radeon_kms.c |  7 ++-----
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index 3e04101c2..cc5dc09f1 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -191,24 +191,24 @@ radeon_master_screen(ScreenPtr screen)

 static inline ScreenPtr
 radeon_dirty_master(PixmapDirtyUpdatePtr dirty)
+{
+    return radeon_master_screen(dirty->slave_dst->drawable.pScreen);
+}
+
+static inline DrawablePtr
+radeon_dirty_src_drawable(PixmapDirtyUpdatePtr dirty)
 {
 #ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC
-    ScreenPtr screen =3D dirty->src->pScreen;
+    return dirty->src;
 #else
-    ScreenPtr screen =3D dirty->src->drawable.pScreen;
+    return &dirty->src->drawable;
 #endif
-
-    return radeon_master_screen(screen);
 }

 static inline Bool
 radeon_dirty_src_equals(PixmapDirtyUpdatePtr dirty, PixmapPtr pixmap)
 {
-#ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC
-    return dirty->src =3D=3D &pixmap->drawable;
-#else
-    return dirty->src =3D=3D pixmap;
-#endif
+    return radeon_dirty_src_drawable(dirty) =3D=3D &pixmap->drawable;
 }


diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index 5fcd8f0b7..a9300d400 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -570,11 +570,8 @@ dirty_region(PixmapDirtyUpdatePtr dirty)
 static void
 redisplay_dirty(PixmapDirtyUpdatePtr dirty, RegionPtr region)
 {
-#ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC
-       ScrnInfoPtr src_scrn =3D xf86ScreenToScrn(dirty->src->pScreen);
-#else
-       ScrnInfoPtr src_scrn =3D xf86ScreenToScrn(dirty->src->drawable.pScr=
een);
-#endif
+       ScrnInfoPtr src_scrn =3D
+               xf86ScreenToScrn(radeon_dirty_src_drawable(dirty)->pScreen)=
;

         if (RegionNil(region))
                 goto out;
--
2.15.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652128FB370F7DD490653A1F7390BN6PR12MB1652namp_
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
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@=
daenzer.net&gt;<br>
<b>Sent:</b> Friday, December 1, 2017 9:56 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati] Add radeon_dirty_src_drawable helper=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
Allows tidying up radeon_dirty_src_equals and redisplay_dirty slightly.<br>
<br>
(Cherry picked from amdgpu commit 1d65ac395971571094df21ca0408d5972c6b56ec)=
<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Acked-by: Alex Deucher &lt;alexander.deucher@amd.c=
om&gt;<br>
</div>
<div class=3D"PlainText"><br>
---<br>
&nbsp;src/radeon.h&nbsp;&nbsp;&nbsp;&nbsp; | 18 &#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;---------<br>
&nbsp;src/radeon_kms.c |&nbsp; 7 &#43;&#43;-----<br>
&nbsp;2 files changed, 11 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/src/radeon.h b/src/radeon.h<br>
index 3e04101c2..cc5dc09f1 100644<br>
--- a/src/radeon.h<br>
&#43;&#43;&#43; b/src/radeon.h<br>
@@ -191,24 &#43;191,24 @@ radeon_master_screen(ScreenPtr screen)<br>
&nbsp;<br>
&nbsp;static inline ScreenPtr<br>
&nbsp;radeon_dirty_master(PixmapDirtyUpdatePtr dirty)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; return radeon_master_screen(dirty-&gt;slave_dst-&gt=
;drawable.pScreen);<br>
&#43;}<br>
&#43;<br>
&#43;static inline DrawablePtr<br>
&#43;radeon_dirty_src_drawable(PixmapDirtyUpdatePtr dirty)<br>
&nbsp;{<br>
&nbsp;#ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC<br>
-&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D dirty-&gt;src-&gt;pScreen;<br>
&#43;&nbsp;&nbsp;&nbsp; return dirty-&gt;src;<br>
&nbsp;#else<br>
-&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D dirty-&gt;src-&gt;drawable.pScreen=
;<br>
&#43;&nbsp;&nbsp;&nbsp; return &amp;dirty-&gt;src-&gt;drawable;<br>
&nbsp;#endif<br>
-<br>
-&nbsp;&nbsp;&nbsp; return radeon_master_screen(screen);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline Bool<br>
&nbsp;radeon_dirty_src_equals(PixmapDirtyUpdatePtr dirty, PixmapPtr pixmap)=
<br>
&nbsp;{<br>
-#ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC<br>
-&nbsp;&nbsp;&nbsp; return dirty-&gt;src =3D=3D &amp;pixmap-&gt;drawable;<b=
r>
-#else<br>
-&nbsp;&nbsp;&nbsp; return dirty-&gt;src =3D=3D pixmap;<br>
-#endif<br>
&#43;&nbsp;&nbsp;&nbsp; return radeon_dirty_src_drawable(dirty) =3D=3D &amp=
;pixmap-&gt;drawable;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/src/radeon_kms.c b/src/radeon_kms.c<br>
index 5fcd8f0b7..a9300d400 100644<br>
--- a/src/radeon_kms.c<br>
&#43;&#43;&#43; b/src/radeon_kms.c<br>
@@ -570,11 &#43;570,8 @@ dirty_region(PixmapDirtyUpdatePtr dirty)<br>
&nbsp;static void<br>
&nbsp;redisplay_dirty(PixmapDirtyUpdatePtr dirty, RegionPtr region)<br>
&nbsp;{<br>
-#ifdef HAS_DIRTYTRACKING_DRAWABLE_SRC<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr src_scrn =3D xf86ScreenTo=
Scrn(dirty-&gt;src-&gt;pScreen);<br>
-#else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr src_scrn =3D xf86ScreenTo=
Scrn(dirty-&gt;src-&gt;drawable.pScreen);<br>
-#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr src_scrn =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; xf86ScreenToScrn(radeon_dirty_src_drawable(dirty)-&gt;pScree=
n);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RegionNil(region))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
-- <br>
2.15.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk977905" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652128FB370F7DD490653A1F7390BN6PR12MB1652namp_--

--===============0027568535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0027568535==--
