From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] modesetting: add tile property support
Date: Thu, 14 Mar 2019 13:16:10 +0000
Message-ID: <BN6PR12MB1809958DD227122255F52357F74B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190314101948.4496-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1091902848=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190314101948.4496-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1091902848==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809958DD227122255F52357F74B0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809958DD227122255F52357F74B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Thursday, March 14, 2019 6:19 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati] modesetting: add tile property support

From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This adds tiling support to the driver, it retrieves the tile info from
the kernel and translates it into the server format and exposes the
property.

(Ported from xserver commits 8fb8bbb3062f1a06621ab7030a9e89d5e8367b35
 and 6abdb54a11dac4e8854ff94ecdcb90a14321ab31)
(Ported from amdgpu commit 6ee857726166f495abcd68e4ff60e3a09593d079)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c | 54 +++++++++++++++++++++++++++++++++++++++++--
 src/drmmode_display.h |  3 +++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index 002513f1a..0e9e24749 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -1576,6 +1576,51 @@ drmmode_output_mode_valid(xf86OutputPtr output, Disp=
layModePtr pModes)
         return MODE_OK;
 }

+static void
+drmmode_output_attach_tile(xf86OutputPtr output)
+{
+#if XORG_VERSION_CURRENT >=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, 0)
+       drmmode_output_private_ptr drmmode_output =3D output->driver_privat=
e;
+       drmModeConnectorPtr koutput =3D drmmode_output->mode_output;
+       RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(output->scrn);
+       struct xf86CrtcTileInfo tile_info, *set =3D NULL;
+       int i;
+
+       if (!koutput) {
+               xf86OutputSetTile(output, NULL);
+               return;
+       }
+
+       /* look for a TILE property */
+       for (i =3D 0; i < koutput->count_props; i++) {
+               drmModePropertyPtr props;
+               props =3D drmModeGetProperty(pRADEONEnt->fd, koutput->props=
[i]);
+               if (!props)
+                       continue;
+
+               if (!(props->flags & DRM_MODE_PROP_BLOB)) {
+                       drmModeFreeProperty(props);
+                       continue;
+               }
+
+               if (!strcmp(props->name, "TILE")) {
+                       drmModeFreePropertyBlob(drmmode_output->tile_blob);
+                       drmmode_output->tile_blob =3D
+                               drmModeGetPropertyBlob(pRADEONEnt->fd,
+                                                      koutput->prop_values=
[i]);
+               }
+               drmModeFreeProperty(props);
+       }
+       if (drmmode_output->tile_blob) {
+               if (xf86OutputParseKMSTile(drmmode_output->tile_blob->data,
+                                          drmmode_output->tile_blob->lengt=
h,
+                                          &tile_info) =3D=3D TRUE)
+                       set =3D &tile_info;
+       }
+       xf86OutputSetTile(output, set);
+#endif
+}
+
 static int
 koutput_get_prop_idx(int fd, drmModeConnectorPtr koutput,
         int type, const char *name)
@@ -1648,6 +1693,8 @@ drmmode_output_get_modes(xf86OutputPtr output)
         }
         xf86OutputSetEDID(output, mon);

+       drmmode_output_attach_tile(output);
+
         /* modes should already be available */
         for (i =3D 0; i < koutput->count_modes; i++) {
                 Mode =3D xnfalloc(sizeof(DisplayModeRec));
@@ -1665,8 +1712,11 @@ drmmode_output_destroy(xf86OutputPtr output)
         drmmode_output_private_ptr drmmode_output =3D output->driver_priva=
te;
         int i;

-       if (drmmode_output->edid_blob)
-               drmModeFreePropertyBlob(drmmode_output->edid_blob);
+       drmModeFreePropertyBlob(drmmode_output->edid_blob);
+#if XORG_VERSION_CURRENT >=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, 0)
+       drmModeFreePropertyBlob(drmmode_output->tile_blob);
+#endif
+
         for (i =3D 0; i < drmmode_output->num_props; i++) {
                 drmModeFreeProperty(drmmode_output->props[i].mode_prop);
                 free(drmmode_output->props[i].atoms);
diff --git a/src/drmmode_display.h b/src/drmmode_display.h
index 2c2c3d57f..96eaef0aa 100644
--- a/src/drmmode_display.h
+++ b/src/drmmode_display.h
@@ -142,6 +142,9 @@ typedef struct {
     drmModeConnectorPtr mode_output;
     drmModeEncoderPtr *mode_encoders;
     drmModePropertyBlobPtr edid_blob;
+#if XORG_VERSION_CURRENT >=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, 0)
+    drmModePropertyBlobPtr tile_blob;
+#endif
     int dpms_enum_id;
     int num_props;
     drmmode_prop_ptr props;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809958DD227122255F52357F74B0BN6PR12MB1809namp_
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
<b>Sent:</b> Thursday, March 14, 2019 6:19 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati] modesetting: add tile property suppo=
rt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Dave Airlie &lt;airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br>
<br>
This adds tiling support to the driver, it retrieves the tile info from<br>
the kernel and translates it into the server format and exposes the<br>
property.<br>
<br>
(Ported from xserver commits 8fb8bbb3062f1a06621ab7030a9e89d5e8367b35<br>
&nbsp;and 6abdb54a11dac4e8854ff94ecdcb90a14321ab31)<br>
(Ported from amdgpu commit 6ee857726166f495abcd68e4ff60e3a09593d079)<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c | 54 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;--<br>
&nbsp;src/drmmode_display.h |&nbsp; 3 &#43;&#43;&#43;<br>
&nbsp;2 files changed, 55 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index 002513f1a..0e9e24749 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -1576,6 &#43;1576,51 @@ drmmode_output_mode_valid(xf86OutputPtr output, =
DisplayModePtr pModes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return MODE_OK;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void<br>
&#43;drmmode_output_attach_tile(xf86OutputPtr output)<br>
&#43;{<br>
&#43;#if XORG_VERSION_CURRENT &gt;=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, =
0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output_private_ptr drmmod=
e_output =3D output-&gt;driver_private;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeConnectorPtr koutput =3D d=
rmmode_output-&gt;mode_output;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEO=
NEntPriv(output-&gt;scrn);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct xf86CrtcTileInfo tile_info=
, *set =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!koutput) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; xf86OutputSetTile(output, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* look for a TILE property */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; koutput-&gt;=
count_props; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drmModePropertyPtr props;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; props =3D drmModeGetProperty(pRADEONEnt-&gt;fd, koutput-&gt;=
props[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!props)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!(props-&gt;flags &amp; DRM_MODE_PROP_BLOB)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeFreeP=
roperty(props);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!strcmp(props-&gt;name, &quot;TILE&quot;)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeFreeP=
ropertyBlob(drmmode_output-&gt;tile_blob);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_outp=
ut-&gt;tile_blob =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeGetPropertyBlob(pRADEONEnt-&gt;f=
d,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; koutput-&gt;prop_values[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drmModeFreeProperty(props);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drmmode_output-&gt;tile_blob)=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (xf86OutputParseKMSTile(drmmode_output-&gt;tile_blob-&gt;=
data,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output-&gt;tile_blob-&gt;length,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tile_info) =3D=3D TRUE)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set =3D &amp=
;tile_info;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86OutputSetTile(output, set);<b=
r>
&#43;#endif<br>
&#43;}<br>
&#43;<br>
&nbsp;static int<br>
&nbsp;koutput_get_prop_idx(int fd, drmModeConnectorPtr koutput,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int type, const char *name=
)<br>
@@ -1648,6 &#43;1693,8 @@ drmmode_output_get_modes(xf86OutputPtr output)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86OutputSetEDID(output, =
mon);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output_attach_tile(output=
);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* modes should already be=
 available */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; koutp=
ut-&gt;count_modes; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mode =3D xnfalloc(sizeof(DisplayModeRec));<br>
@@ -1665,8 &#43;1712,11 @@ drmmode_output_destroy(xf86OutputPtr output)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_output_private_ptr=
 drmmode_output =3D output-&gt;driver_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drmmode_output-&gt;edid_blob)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drmModeFreePropertyBlob(drmmode_output-&gt;edid_blob);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeFreePropertyBlob(drmmode_o=
utput-&gt;edid_blob);<br>
&#43;#if XORG_VERSION_CURRENT &gt;=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, =
0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeFreePropertyBlob(drmmode_o=
utput-&gt;tile_blob);<br>
&#43;#endif<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; drmmo=
de_output-&gt;num_props; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drmModeFreeProperty(drmmode_output-&gt;props[i].mode_=
prop);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; free(drmmode_output-&gt;props[i].atoms);<br>
diff --git a/src/drmmode_display.h b/src/drmmode_display.h<br>
index 2c2c3d57f..96eaef0aa 100644<br>
--- a/src/drmmode_display.h<br>
&#43;&#43;&#43; b/src/drmmode_display.h<br>
@@ -142,6 &#43;142,9 @@ typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmModeConnectorPtr mode_output;<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmModeEncoderPtr *mode_encoders;<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmModePropertyBlobPtr edid_blob;<br>
&#43;#if XORG_VERSION_CURRENT &gt;=3D XORG_VERSION_NUMERIC(1, 17, 99, 901, =
0)<br>
&#43;&nbsp;&nbsp;&nbsp; drmModePropertyBlobPtr tile_blob;<br>
&#43;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp; int dpms_enum_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp; int num_props;<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmmode_prop_ptr props;<br>
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

--_000_BN6PR12MB1809958DD227122255F52357F74B0BN6PR12MB1809namp_--

--===============1091902848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1091902848==--
