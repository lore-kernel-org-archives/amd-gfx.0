From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 2/2] Keep track of how many SW cursors
 are visible on each screen
Date: Sat, 23 Dec 2017 16:30:20 +0000
Message-ID: <BN6PR12MB165200B7FB5FD46D96100773F7030@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20171222173944.23221-1-michel@daenzer.net>,
 <20171222173944.23221-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508307898=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171222173944.23221-2-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============0508307898==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB165200B7FB5FD46D96100773F7030BN6PR12MB1652namp_"

--_000_BN6PR12MB165200B7FB5FD46D96100773F7030BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, December 22, 2017 12:39:44 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-amdgpu 2/2] Keep track of how many SW cursors ar=
e visible on each screen

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

And use this to determine when we cannot use page flipping for DRI
clients. We previously did this based on whether the HW cursor cannot
be used on at least one CRTC, which had at least two issues:

* Even while the HW cursor cannot be used, no SW cursor may actually be
  visible (e.g. because all cursors are disabled), in which case we can
  use page flipping for DRI clients anyway
* Even while the HW cursor can be used, there may be SW cursors visible
  from non-core pointer devices, in which case we cannot use page
  flipping for DRI clients anyway

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/amdgpu_dri2.c     |  2 +-
 src/amdgpu_drv.h      | 13 +++++++++++++
 src/amdgpu_kms.c      | 28 +++++++++++++++++++++++++++
 src/amdgpu_present.c  |  2 +-
 src/drmmode_display.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/drmmode_display.h |  4 ++++
 6 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/src/amdgpu_dri2.c b/src/amdgpu_dri2.c
index a8ccd22ba..4ffa34676 100644
--- a/src/amdgpu_dri2.c
+++ b/src/amdgpu_dri2.c
@@ -603,7 +603,7 @@ can_flip(xf86CrtcPtr crtc, DrawablePtr draw,

         if (draw->type !=3D DRAWABLE_WINDOW ||
             !info->allowPageFlip ||
-           info->hwcursor_disabled ||
+           info->sprites_visible > 0 ||
             info->drmmode.present_flipping ||
             !pScrn->vtSema ||
             !DRI2CanFlip(draw))
diff --git a/src/amdgpu_drv.h b/src/amdgpu_drv.h
index 055c3c3e9..72975d597 100644
--- a/src/amdgpu_drv.h
+++ b/src/amdgpu_drv.h
@@ -234,6 +234,13 @@ struct amdgpu_client_priv {
         uint_fast32_t needs_flush;
 };

+struct amdgpu_device_priv {
+       CursorPtr cursor;
+       Bool sprite_visible;
+};
+
+extern DevScreenPrivateKeyRec amdgpu_device_private_key;
+
 typedef struct {
         EntityInfoPtr pEnt;
         struct pci_device *PciInfo;
@@ -274,6 +281,12 @@ typedef struct {
         CreateScreenResourcesProcPtr CreateScreenResources;
         CreateWindowProcPtr CreateWindow;
         WindowExposuresProcPtr WindowExposures;
+       void (*SetCursor) (DeviceIntPtr pDev, ScreenPtr pScreen,
+                          CursorPtr pCursor, int x, int y);
+       void (*MoveCursor) (DeviceIntPtr pDev, ScreenPtr pScreen, int x, in=
t y);
+
+       /* Number of SW cursor currently visible on this screen */
+       int sprites_visible;

         Bool IsSecondary;

diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c
index 58531bf33..49044f514 100644
--- a/src/amdgpu_kms.c
+++ b/src/amdgpu_kms.c
@@ -37,6 +37,7 @@
 #include "amdgpu_glamor.h"
 #include "amdgpu_probe.h"
 #include "micmap.h"
+#include "mipointrst.h"

 #include "amdgpu_version.h"
 #include "shadow.h"
@@ -62,6 +63,7 @@
 #include <gbm.h>

 static DevScreenPrivateKeyRec amdgpu_client_private_key;
+DevScreenPrivateKeyRec amdgpu_device_private_key;

 static Bool amdgpu_setup_kernel_mem(ScreenPtr pScreen);

@@ -1532,6 +1534,23 @@ static Bool AMDGPUCursorInit_KMS(ScreenPtr pScreen)
         /* Cursor setup */
         miDCInitialize(pScreen, xf86GetPointerScreenFuncs());

+       if (info->allowPageFlip) {
+               miPointerScreenPtr PointPriv =3D
+                       dixLookupPrivate(&pScreen->devPrivates, miPointerSc=
reenKey);
+
+               if (!dixRegisterScreenPrivateKey(&amdgpu_device_private_key=
, pScreen,
+                                                PRIVATE_DEVICE,
+                                                sizeof(struct amdgpu_devic=
e_priv))) {
+                       xf86DrvMsg(pScrn->scrnIndex, X_ERROR, "dixRegisterS=
creenPrivateKey failed\n");
+                       return FALSE;
+               }
+
+               info->SetCursor =3D PointPriv->spriteFuncs->SetCursor;
+               info->MoveCursor =3D PointPriv->spriteFuncs->MoveCursor;
+               PointPriv->spriteFuncs->SetCursor =3D drmmode_sprite_set_cu=
rsor;
+               PointPriv->spriteFuncs->MoveCursor =3D drmmode_sprite_move_=
cursor;
+       }
+
         if (xf86ReturnOptValBool(info->Options, OPTION_SW_CURSOR, FALSE))
                 return TRUE;

@@ -1701,6 +1720,15 @@ static Bool AMDGPUCloseScreen_KMS(ScreenPtr pScreen)
         amdgpu_glamor_fini(pScreen);
         pScrn->vtSema =3D FALSE;
         xf86ClearPrimInitDone(info->pEnt->index);
+
+       if (info->allowPageFlip) {
+               miPointerScreenPtr PointPriv =3D
+                       dixLookupPrivate(&pScreen->devPrivates, miPointerSc=
reenKey);
+
+               PointPriv->spriteFuncs->SetCursor =3D info->SetCursor;
+               PointPriv->spriteFuncs->MoveCursor =3D info->MoveCursor;
+       }
+
         pScreen->BlockHandler =3D info->BlockHandler;
         pScreen->CloseScreen =3D info->CloseScreen;
         return pScreen->CloseScreen(pScreen);
diff --git a/src/amdgpu_present.c b/src/amdgpu_present.c
index cef93c068..4e74bfac9 100644
--- a/src/amdgpu_present.c
+++ b/src/amdgpu_present.c
@@ -273,7 +273,7 @@ amdgpu_present_check_flip(RRCrtcPtr crtc, WindowPtr win=
dow, PixmapPtr pixmap,
         if (!info->allowPageFlip)
                 return FALSE;

-       if (info->hwcursor_disabled)
+       if (info->sprites_visible > 0)
                 return FALSE;

         if (info->drmmode.dri2_flipping)
diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index 55551eea7..047179449 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -34,6 +34,7 @@
 #include <time.h>
 #include "cursorstr.h"
 #include "damagestr.h"
+#include "inputstr.h"
 #include "list.h"
 #include "micmap.h"
 #include "xf86cmap.h"
@@ -2431,6 +2432,57 @@ void drmmode_fini(ScrnInfoPtr pScrn, drmmode_ptr drm=
mode)
                 drmmode_crtc_scanout_free(config->crtc[c]->driver_private)=
;
 }

+static void drmmode_sprite_do_set_cursor(struct amdgpu_device_priv *device=
_priv,
+                                        ScrnInfoPtr scrn, int x, int y)
+{
+       AMDGPUInfoPtr info =3D AMDGPUPTR(scrn);
+       CursorPtr cursor =3D device_priv->cursor;
+       Bool sprite_visible =3D device_priv->sprite_visible;
+
+       if (cursor) {
+               x -=3D cursor->bits->xhot;
+               y -=3D cursor->bits->yhot;
+
+               device_priv->sprite_visible =3D
+                       x < scrn->virtualX && y < scrn->virtualY &&
+                       (x + cursor->bits->width > 0) &&
+                       (y + cursor->bits->height > 0);
+       } else {
+               device_priv->sprite_visible =3D FALSE;
+       }
+
+       info->sprites_visible +=3D device_priv->sprite_visible - sprite_vis=
ible;
+}
+
+void drmmode_sprite_set_cursor(DeviceIntPtr pDev, ScreenPtr pScreen,
+                              CursorPtr pCursor, int x, int y)
+{
+       ScrnInfoPtr scrn =3D xf86ScreenToScrn(pScreen);
+       AMDGPUInfoPtr info =3D AMDGPUPTR(scrn);
+       struct amdgpu_device_priv *device_priv =3D
+               dixLookupScreenPrivate(&pDev->devPrivates,
+                                      &amdgpu_device_private_key, pScreen)=
;
+
+       device_priv->cursor =3D pCursor;
+       drmmode_sprite_do_set_cursor(device_priv, scrn, x, y);
+
+       info->SetCursor(pDev, pScreen, pCursor, x, y);
+}
+
+void drmmode_sprite_move_cursor(DeviceIntPtr pDev, ScreenPtr pScreen, int =
x,
+                               int y)
+{
+       ScrnInfoPtr scrn =3D xf86ScreenToScrn(pScreen);
+       AMDGPUInfoPtr info =3D AMDGPUPTR(scrn);
+       struct amdgpu_device_priv *device_priv =3D
+               dixLookupScreenPrivate(&pDev->devPrivates,
+                                      &amdgpu_device_private_key, pScreen)=
;
+
+       drmmode_sprite_do_set_cursor(device_priv, scrn, x, y);
+
+       info->MoveCursor(pDev, pScreen, x, y);
+}
+
 void drmmode_set_cursor(ScrnInfoPtr scrn, drmmode_ptr drmmode, int id,
                         struct amdgpu_buffer *bo)
 {
diff --git a/src/drmmode_display.h b/src/drmmode_display.h
index 03134f0c9..4e6f70776 100644
--- a/src/drmmode_display.h
+++ b/src/drmmode_display.h
@@ -198,6 +198,10 @@ extern int drmmode_page_flip_target_relative(AMDGPUEnt=
Ptr pAMDGPUEnt,
 extern Bool drmmode_pre_init(ScrnInfoPtr pScrn, drmmode_ptr drmmode, int c=
pp);
 extern void drmmode_init(ScrnInfoPtr pScrn, drmmode_ptr drmmode);
 extern void drmmode_fini(ScrnInfoPtr pScrn, drmmode_ptr drmmode);
+extern void drmmode_sprite_set_cursor(DeviceIntPtr pDev, ScreenPtr pScreen=
,
+                                     CursorPtr pCursor, int x, int y);
+extern void drmmode_sprite_move_cursor(DeviceIntPtr pDev, ScreenPtr pScree=
n, int x,
+                                      int y);
 extern void drmmode_set_cursor(ScrnInfoPtr scrn, drmmode_ptr drmmode, int =
id,
                                struct amdgpu_buffer *bo);
 void drmmode_adjust_frame(ScrnInfoPtr pScrn, drmmode_ptr drmmode, int x, i=
nt y);
--
2.15.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB165200B7FB5FD46D96100773F7030BN6PR12MB1652namp_
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
<b>Sent:</b> Friday, December 22, 2017 12:39:44 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-amdgpu 2/2] Keep track of how many SW cur=
sors are visible on each screen</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
And use this to determine when we cannot use page flipping for DRI<br>
clients. We previously did this based on whether the HW cursor cannot<br>
be used on at least one CRTC, which had at least two issues:<br>
<br>
* Even while the HW cursor cannot be used, no SW cursor may actually be<br>
&nbsp; visible (e.g. because all cursors are disabled), in which case we ca=
n<br>
&nbsp; use page flipping for DRI clients anyway<br>
* Even while the HW cursor can be used, there may be SW cursors visible<br>
&nbsp; from non-core pointer devices, in which case we cannot use page<br>
&nbsp; flipping for DRI clients anyway<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/amdgpu_dri2.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;src/amdgpu_drv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 13 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;src/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 28 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;src/amdgpu_present.c&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;src/drmmode_display.c | 52 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;src/drmmode_display.h |&nbsp; 4 &#43;&#43;&#43;&#43;<br>
&nbsp;6 files changed, 99 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/src/amdgpu_dri2.c b/src/amdgpu_dri2.c<br>
index a8ccd22ba..4ffa34676 100644<br>
--- a/src/amdgpu_dri2.c<br>
&#43;&#43;&#43; b/src/amdgpu_dri2.c<br>
@@ -603,7 &#43;603,7 @@ can_flip(xf86CrtcPtr crtc, DrawablePtr draw,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (draw-&gt;type !=3D DRA=
WABLE_WINDOW ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !i=
nfo-&gt;allowPageFlip ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;hwcu=
rsor_disabled ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;=
sprites_visible &gt; 0 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
fo-&gt;drmmode.present_flipping ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !p=
Scrn-&gt;vtSema ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !D=
RI2CanFlip(draw))<br>
diff --git a/src/amdgpu_drv.h b/src/amdgpu_drv.h<br>
index 055c3c3e9..72975d597 100644<br>
--- a/src/amdgpu_drv.h<br>
&#43;&#43;&#43; b/src/amdgpu_drv.h<br>
@@ -234,6 &#43;234,13 @@ struct amdgpu_client_priv {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint_fast32_t needs_flush;=
<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct amdgpu_device_priv {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CursorPtr cursor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool sprite_visible;<br>
&#43;};<br>
&#43;<br>
&#43;extern DevScreenPrivateKeyRec amdgpu_device_private_key;<br>
&#43;<br>
&nbsp;typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EntityInfoPtr pEnt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_device *PciInfo=
;<br>
@@ -274,6 &#43;281,12 @@ typedef struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CreateScreenResourcesProcP=
tr CreateScreenResources;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CreateWindowProcPtr Create=
Window;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WindowExposuresProcPtr Win=
dowExposures;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*SetCursor) (DeviceIntPtr p=
Dev, ScreenPtr pScreen,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; CursorPtr pCursor, int x, int y);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*MoveCursor) (DeviceIntPtr =
pDev, ScreenPtr pScreen, int x, int y);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Number of SW cursor currently =
visible on this screen */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int sprites_visible;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool IsSecondary;<br>
&nbsp;<br>
diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c<br>
index 58531bf33..49044f514 100644<br>
--- a/src/amdgpu_kms.c<br>
&#43;&#43;&#43; b/src/amdgpu_kms.c<br>
@@ -37,6 &#43;37,7 @@<br>
&nbsp;#include &quot;amdgpu_glamor.h&quot;<br>
&nbsp;#include &quot;amdgpu_probe.h&quot;<br>
&nbsp;#include &quot;micmap.h&quot;<br>
&#43;#include &quot;mipointrst.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_version.h&quot;<br>
&nbsp;#include &quot;shadow.h&quot;<br>
@@ -62,6 &#43;63,7 @@<br>
&nbsp;#include &lt;gbm.h&gt;<br>
&nbsp;<br>
&nbsp;static DevScreenPrivateKeyRec amdgpu_client_private_key;<br>
&#43;DevScreenPrivateKeyRec amdgpu_device_private_key;<br>
&nbsp;<br>
&nbsp;static Bool amdgpu_setup_kernel_mem(ScreenPtr pScreen);<br>
&nbsp;<br>
@@ -1532,6 &#43;1534,23 @@ static Bool AMDGPUCursorInit_KMS(ScreenPtr pScre=
en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Cursor setup */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; miDCInitialize(pScreen, xf=
86GetPointerScreenFuncs());<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;allowPageFlip) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; miPointerScreenPtr PointPriv =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dixLookupPri=
vate(&amp;pScreen-&gt;devPrivates, miPointerScreenKey);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!dixRegisterScreenPrivateKey(&amp;amdgpu_device_private_=
key, pScreen,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PRIVATE_DEVI=
CE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struc=
t amdgpu_device_priv))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(p=
Scrn-&gt;scrnIndex, X_ERROR, &quot;dixRegisterScreenPrivateKey failed\n&quo=
t;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return FALSE=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; info-&gt;SetCursor =3D PointPriv-&gt;spriteFuncs-&gt;SetCurs=
or;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; info-&gt;MoveCursor =3D PointPriv-&gt;spriteFuncs-&gt;MoveCu=
rsor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PointPriv-&gt;spriteFuncs-&gt;SetCursor =3D drmmode_sprite_s=
et_cursor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PointPriv-&gt;spriteFuncs-&gt;MoveCursor =3D drmmode_sprite_=
move_cursor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xf86ReturnOptValBool(i=
nfo-&gt;Options, OPTION_SW_CURSOR, FALSE))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TRUE;<br>
&nbsp;<br>
@@ -1701,6 &#43;1720,15 @@ static Bool AMDGPUCloseScreen_KMS(ScreenPtr pScr=
een)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_glamor_fini(pScreen=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pScrn-&gt;vtSema =3D FALSE=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86ClearPrimInitDone(info=
-&gt;pEnt-&gt;index);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;allowPageFlip) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; miPointerScreenPtr PointPriv =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dixLookupPri=
vate(&amp;pScreen-&gt;devPrivates, miPointerScreenKey);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PointPriv-&gt;spriteFuncs-&gt;SetCursor =3D info-&gt;SetCurs=
or;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PointPriv-&gt;spriteFuncs-&gt;MoveCursor =3D info-&gt;MoveCu=
rsor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pScreen-&gt;BlockHandler =
=3D info-&gt;BlockHandler;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pScreen-&gt;CloseScreen =
=3D info-&gt;CloseScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pScreen-&gt;CloseSc=
reen(pScreen);<br>
diff --git a/src/amdgpu_present.c b/src/amdgpu_present.c<br>
index cef93c068..4e74bfac9 100644<br>
--- a/src/amdgpu_present.c<br>
&#43;&#43;&#43; b/src/amdgpu_present.c<br>
@@ -273,7 &#43;273,7 @@ amdgpu_present_check_flip(RRCrtcPtr crtc, WindowPtr=
 window, PixmapPtr pixmap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!info-&gt;allowPageFli=
p)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return FALSE;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;hwcursor_disabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;sprites_visible &gt;=
 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return FALSE;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info-&gt;drmmode.dri2_=
flipping)<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index 55551eea7..047179449 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -34,6 &#43;34,7 @@<br>
&nbsp;#include &lt;time.h&gt;<br>
&nbsp;#include &quot;cursorstr.h&quot;<br>
&nbsp;#include &quot;damagestr.h&quot;<br>
&#43;#include &quot;inputstr.h&quot;<br>
&nbsp;#include &quot;list.h&quot;<br>
&nbsp;#include &quot;micmap.h&quot;<br>
&nbsp;#include &quot;xf86cmap.h&quot;<br>
@@ -2431,6 &#43;2432,57 @@ void drmmode_fini(ScrnInfoPtr pScrn, drmmode_ptr=
 drmmode)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drmmode_crtc_scanout_free(config-&gt;crtc[c]-&gt;driv=
er_private);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void drmmode_sprite_do_set_cursor(struct amdgpu_device_priv *de=
vice_priv,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ScrnInfoPtr scrn, int x, int y)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPUInfoPtr info =3D AMDGPUPTR(=
scrn);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CursorPtr cursor =3D device_priv-=
&gt;cursor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool sprite_visible =3D device_pr=
iv-&gt;sprite_visible;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; x -=3D cursor-&gt;bits-&gt;xhot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; y -=3D cursor-&gt;bits-&gt;yhot;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; device_priv-&gt;sprite_visible =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x &lt; scrn-=
&gt;virtualX &amp;&amp; y &lt; scrn-&gt;virtualY &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (x &#43; cur=
sor-&gt;bits-&gt;width &gt; 0) &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (y &#43; cur=
sor-&gt;bits-&gt;height &gt; 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; device_priv-&gt;sprite_visible =3D FALSE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;sprites_visible &#43;=3D=
 device_priv-&gt;sprite_visible - sprite_visible;<br>
&#43;}<br>
&#43;<br>
&#43;void drmmode_sprite_set_cursor(DeviceIntPtr pDev, ScreenPtr pScreen,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CursorPtr pCursor, int x, int y)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenTo=
Scrn(pScreen);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPUInfoPtr info =3D AMDGPUPTR(=
scrn);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_priv *device=
_priv =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dixLookupScreenPrivate(&amp;pDev-&gt;devPrivates,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &amp;amdgpu_device_private_key, pScreen);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_priv-&gt;cursor =3D pCurso=
r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_sprite_do_set_cursor(devi=
ce_priv, scrn, x, y);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;SetCursor(pDev, pScreen,=
 pCursor, x, y);<br>
&#43;}<br>
&#43;<br>
&#43;void drmmode_sprite_move_cursor(DeviceIntPtr pDev, ScreenPtr pScreen, =
int x,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int y)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenTo=
Scrn(pScreen);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPUInfoPtr info =3D AMDGPUPTR(=
scrn);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device_priv *device=
_priv =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dixLookupScreenPrivate(&amp;pDev-&gt;devPrivates,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &amp;amdgpu_device_private_key, pScreen);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_sprite_do_set_cursor(devi=
ce_priv, scrn, x, y);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;MoveCursor(pDev, pScreen=
, x, y);<br>
&#43;}<br>
&#43;<br>
&nbsp;void drmmode_set_cursor(ScrnInfoPtr scrn, drmmode_ptr drmmode, int id=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_buffer *bo)<br>
&nbsp;{<br>
diff --git a/src/drmmode_display.h b/src/drmmode_display.h<br>
index 03134f0c9..4e6f70776 100644<br>
--- a/src/drmmode_display.h<br>
&#43;&#43;&#43; b/src/drmmode_display.h<br>
@@ -198,6 &#43;198,10 @@ extern int drmmode_page_flip_target_relative(AMDGP=
UEntPtr pAMDGPUEnt,<br>
&nbsp;extern Bool drmmode_pre_init(ScrnInfoPtr pScrn, drmmode_ptr drmmode, =
int cpp);<br>
&nbsp;extern void drmmode_init(ScrnInfoPtr pScrn, drmmode_ptr drmmode);<br>
&nbsp;extern void drmmode_fini(ScrnInfoPtr pScrn, drmmode_ptr drmmode);<br>
&#43;extern void drmmode_sprite_set_cursor(DeviceIntPtr pDev, ScreenPtr pSc=
reen,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cur=
sorPtr pCursor, int x, int y);<br>
&#43;extern void drmmode_sprite_move_cursor(DeviceIntPtr pDev, ScreenPtr pS=
creen, int x,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; int y);<br>
&nbsp;extern void drmmode_set_cursor(ScrnInfoPtr scrn, drmmode_ptr drmmode,=
 int id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_buffer *bo);<br>
&nbsp;void drmmode_adjust_frame(ScrnInfoPtr pScrn, drmmode_ptr drmmode, int=
 x, int y);<br>
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

--_000_BN6PR12MB165200B7FB5FD46D96100773F7030BN6PR12MB1652namp_--

--===============0508307898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0508307898==--
