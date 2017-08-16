From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 03/10] Create drmmode_wait_vblank helper
Date: Wed, 16 Aug 2017 16:38:12 +0000
Message-ID: <MWHPR12MB1549AC09E8B5584768E9AE4AFE820@MWHPR12MB1549.namprd12.prod.outlook.com>
References: <20170816075725.9566-1-michel@daenzer.net>,
 <20170816075725.9566-4-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1004432750=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170816075725.9566-4-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1004432750==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1549AC09E8B5584768E9AE4AFE820MWHPR12MB1549namp_"

--_000_MWHPR12MB1549AC09E8B5584768E9AE4AFE820MWHPR12MB1549namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Two really small comments inline


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, August 16, 2017 3:57 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 03/10] Create drmmode_wait_vblank helper

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Allows cleaning up the code considerably.

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c |  61 ++++++++++++++++++++----------
 src/drmmode_display.h |   4 ++
 src/radeon.h          |   2 -
 src/radeon_dri2.c     | 103 ++++++++++++++--------------------------------=
----
 src/radeon_kms.c      |  22 +++--------
 src/radeon_present.c  |  23 ++---------
 6 files changed, 82 insertions(+), 133 deletions(-)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index 46a579ff3..96c108a85 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -242,6 +242,39 @@ drmmode_ConvertToKMode(ScrnInfoPtr scrn,

 }

+/*
+ * Utility helper for drmWaiVBlank

[slava a] drmWaitVBlank

+ */
+Bool
+drmmode_wait_vblank(xf86CrtcPtr crtc, drmVBlankSeqType type, unsigned seq,
+                   unsigned long signal, uint64_t *ust, uint32_t *msc)
+{
+       int crtc_id =3D drmmode_get_crtc_id(crtc);
+       ScrnInfoPtr scrn =3D crtc->scrn;
+       RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
+       drmVBlank vbl;
+
+       if (crtc_id =3D=3D 1)
+               type |=3D DRM_VBLANK_SECONDARY;
+       else if (crtc_id > 1)
+               type |=3D (crtc_id << DRM_VBLANK_HIGH_CRTC_SHIFT) &
+                       DRM_VBLANK_HIGH_CRTC_MASK;
+
+       vbl.request.type =3D type;
+       vbl.request.sequence =3D seq;
+       vbl.request.signal =3D signal;
+
+       if (drmWaitVBlank(pRADEONEnt->fd, &vbl) !=3D 0)
+               return FALSE;
+
+       if (ust)
+               *ust =3D (uint64_t)vbl.reply.tval_sec * 1000000 +
+                       vbl.reply.tval_usec;
+       if (msc)
+               *msc =3D vbl.reply.sequence;

[slava a] Blank line here for better readability

+       return TRUE;
+}
+
 /*
  * Retrieves present time in microseconds that is compatible
  * with units used by vblank timestamps. Depending on the kernel
@@ -272,23 +305,15 @@ int drmmode_get_current_ust(int drm_fd, CARD64 *ust)
 int drmmode_crtc_get_ust_msc(xf86CrtcPtr crtc, CARD64 *ust, CARD64 *msc)
 {
     ScrnInfoPtr scrn =3D crtc->scrn;
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
-    drmVBlank vbl;
-    int ret;
-
-    vbl.request.type =3D DRM_VBLANK_RELATIVE;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
-    vbl.request.sequence =3D 0;
+    uint32_t seq;

-    ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-    if (ret) {
+    if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE, 0, 0, ust, &seq)) =
{
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                    "get vblank counter failed: %s\n", strerror(errno));
-       return ret;
+       return -1;
     }

-    *ust =3D ((CARD64)vbl.reply.tval_sec * 1000000) + vbl.reply.tval_usec;
-    *msc =3D vbl.reply.sequence;
+    *msc =3D seq;

     return Success;
 }
@@ -305,7 +330,7 @@ drmmode_do_crtc_dpms(xf86CrtcPtr crtc, int mode)
         drmmode_crtc->pending_dpms_mode =3D mode;

         if (drmmode_crtc->dpms_mode =3D=3D DPMSModeOn && mode !=3D DPMSMod=
eOn) {
-               drmVBlank vbl;
+               uint32_t seq;

                 /* Wait for any pending flip to finish */
                 if (drmmode_crtc->flip_pending)
@@ -315,20 +340,14 @@ drmmode_do_crtc_dpms(xf86CrtcPtr crtc, int mode)
                  * On->Off transition: record the last vblank time,
                  * sequence number and frame period.
                  */
-               vbl.request.type =3D DRM_VBLANK_RELATIVE;
-               vbl.request.type |=3D radeon_populate_vbl_request_type(crtc=
);
-               vbl.request.sequence =3D 0;
-               ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-               if (ret)
+               if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE, 0, 0, &=
ust,
+                                        &seq))
                         xf86DrvMsg(scrn->scrnIndex, X_ERROR,
                                    "%s cannot get last vblank counter\n",
                                    __func__);
                 else {
-                       CARD64 seq =3D (CARD64)vbl.reply.sequence;
                         CARD64 nominal_frame_rate, pix_in_frame;

-                       ust =3D ((CARD64)vbl.reply.tval_sec * 1000000) +
-                               vbl.reply.tval_usec;
                         drmmode_crtc->dpms_last_ust =3D ust;
                         drmmode_crtc->dpms_last_seq =3D seq;
                         nominal_frame_rate =3D crtc->mode.Clock;
diff --git a/src/drmmode_display.h b/src/drmmode_display.h
index f21047890..4262051d7 100644
--- a/src/drmmode_display.h
+++ b/src/drmmode_display.h
@@ -226,5 +226,9 @@ Bool radeon_do_pageflip(ScrnInfoPtr scrn, ClientPtr cli=
ent,
 int drmmode_crtc_get_ust_msc(xf86CrtcPtr crtc, CARD64 *ust, CARD64 *msc);
 int drmmode_get_current_ust(int drm_fd, CARD64 *ust);

+Bool drmmode_wait_vblank(xf86CrtcPtr crtc, drmVBlankSeqType type, unsigned=
 seq,
+                        unsigned long signal, uint64_t *ust, uint32_t *msc=
);
+
+
 #endif

diff --git a/src/radeon.h b/src/radeon.h
index d815d3f00..b93e28163 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -693,8 +693,6 @@ extern void radeon_ddx_cs_start(ScrnInfoPtr pScrn,
 void radeon_kms_update_vram_limit(ScrnInfoPtr pScrn, uint32_t new_fb_size)=
;
 extern RADEONEntPtr RADEONEntPriv(ScrnInfoPtr pScrn);

-drmVBlankSeqType radeon_populate_vbl_request_type(xf86CrtcPtr crtc);
-
 static inline struct radeon_surface *radeon_get_pixmap_surface(PixmapPtr p=
Pix)
 {
 #ifdef USE_GLAMOR
diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c
index 80b17f1f9..a0deb6bae 100644
--- a/src/radeon_dri2.c
+++ b/src/radeon_dri2.c
@@ -889,26 +889,6 @@ cleanup:
     radeon_dri2_frame_event_abort(crtc, event_data);
 }

-drmVBlankSeqType radeon_populate_vbl_request_type(xf86CrtcPtr crtc)
-{
-    drmVBlankSeqType type =3D 0;
-    int crtc_id =3D drmmode_get_crtc_id(crtc);
-
-    if (crtc_id =3D=3D 1)
-        type |=3D DRM_VBLANK_SECONDARY;
-    else if (crtc_id > 1)
-#ifdef DRM_VBLANK_HIGH_CRTC_SHIFT
-       type |=3D (crtc_id << DRM_VBLANK_HIGH_CRTC_SHIFT) &
-               DRM_VBLANK_HIGH_CRTC_MASK;
-#else
-       ErrorF("radeon driver bug: %s called for CRTC %d > 1, but "
-              "DRM_VBLANK_HIGH_CRTC_MASK not defined at build time\n",
-              __func__, crtc_id);
-#endif
-
-    return type;
-}
-
 /*
  * This function should be called on a disabled CRTC only (i.e., CRTC
  * in DPMS-off state). It will calculate the delay necessary to reach
@@ -1087,13 +1067,11 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr =
client, DrawablePtr draw,
 {
     ScreenPtr screen =3D draw->pScreen;
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
     DRI2FrameEventPtr wait_info =3D NULL;
     uintptr_t drm_queue_seq =3D 0;
     xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TRUE);
     uint32_t msc_delta;
-    drmVBlank vbl;
-    int ret;
+    uint32_t seq;
     CARD64 current_msc;

     /* Truncate to match kernel interfaces; means occasional overflow
@@ -1132,17 +1110,13 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr =
client, DrawablePtr draw,
     }

     /* Get current count */
-    vbl.request.type =3D DRM_VBLANK_RELATIVE;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
-    vbl.request.sequence =3D 0;
-    ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-    if (ret) {
+    if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE, 0, 0, NULL, &seq))=
 {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                 "get vblank counter failed: %s\n", strerror(errno));
         goto out_complete;
     }

-    current_msc =3D vbl.reply.sequence + msc_delta;
+    current_msc =3D seq + msc_delta;
     current_msc &=3D 0xffffffff;

     drm_queue_seq =3D radeon_drm_queue_alloc(crtc, client, RADEON_DRM_QUEU=
E_ID_DEFAULT,
@@ -1169,12 +1143,9 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr c=
lient, DrawablePtr draw,
          */
         if (current_msc >=3D target_msc)
             target_msc =3D current_msc;
-        vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
-       vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
-        vbl.request.sequence =3D target_msc - msc_delta;
-        vbl.request.signal =3D drm_queue_seq;
-        ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-        if (ret) {
+        if (!drmmode_wait_vblank(crtc, DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EV=
ENT,
+                                target_msc - msc_delta, drm_queue_seq, NUL=
L,
+                                NULL)) {
             xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                     "get vblank counter failed: %s\n", strerror(errno));
             goto out_complete;
@@ -1188,11 +1159,7 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr c=
lient, DrawablePtr draw,
      * If we get here, target_msc has already passed or we don't have one,
      * so we queue an event that will satisfy the divisor/remainder equati=
on.
      */
-    vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
-
-    vbl.request.sequence =3D current_msc - (current_msc % divisor) +
-        remainder - msc_delta;
+    target_msc =3D current_msc - (current_msc % divisor) + remainder - msc=
_delta;

     /*
      * If calculated remainder is larger than requested remainder,
@@ -1201,11 +1168,10 @@ static int radeon_dri2_schedule_wait_msc(ClientPtr =
client, DrawablePtr draw,
      * that will happen.
      */
     if ((current_msc % divisor) >=3D remainder)
-        vbl.request.sequence +=3D divisor;
+        target_msc +=3D divisor;

-    vbl.request.signal =3D drm_queue_seq;
-    ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-    if (ret) {
+    if (!drmmode_wait_vblank(crtc, DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT,
+                            target_msc, drm_queue_seq, NULL, NULL)) {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                 "get vblank counter failed: %s\n", strerror(errno));
         goto out_complete;
@@ -1249,14 +1215,14 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
 {
     ScreenPtr screen =3D draw->pScreen;
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
     xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(draw, TRUE);
     uint32_t msc_delta;
-    drmVBlank vbl;
-    int ret, flip =3D 0;
+    drmVBlankSeqType type;
+    uint32_t seq;
+    int flip =3D 0;
     DRI2FrameEventPtr swap_info =3D NULL;
     uintptr_t drm_queue_seq;
-    CARD64 current_msc;
+    CARD64 current_msc, event_msc;
     BoxRec box;
     RegionRec region;

@@ -1319,18 +1285,14 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
     }

     /* Get current count */
-    vbl.request.type =3D DRM_VBLANK_RELATIVE;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
-    vbl.request.sequence =3D 0;
-    ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-    if (ret) {
+    if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE, 0, 0, NULL, &seq))=
 {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                 "first get vblank counter failed: %s\n",
                 strerror(errno));
         goto blit_fallback;
     }

-    current_msc =3D vbl.reply.sequence + msc_delta;
+    current_msc =3D seq + msc_delta;
     current_msc &=3D 0xffffffff;

     /* Flips need to be submitted one frame before */
@@ -1352,14 +1314,13 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
      * the swap.
      */
     if (divisor =3D=3D 0 || current_msc < *target_msc) {
-        vbl.request.type =3D  DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
+        type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
         /* If non-pageflipping, but blitting/exchanging, we need to use
          * DRM_VBLANK_NEXTONMISS to avoid unreliable timestamping later
          * on.
          */
         if (flip =3D=3D 0)
-            vbl.request.type |=3D DRM_VBLANK_NEXTONMISS;
-       vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
+            type |=3D DRM_VBLANK_NEXTONMISS;

         /* If target_msc already reached or passed, set it to
          * current_msc to ensure we return a reasonable value back
@@ -1368,17 +1329,15 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
         if (current_msc >=3D *target_msc)
             *target_msc =3D current_msc;

-        vbl.request.sequence =3D *target_msc - msc_delta;
-        vbl.request.signal =3D drm_queue_seq;
-        ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-        if (ret) {
+        if (!drmmode_wait_vblank(crtc, type, *target_msc - msc_delta,
+                                drm_queue_seq, NULL, &seq)) {
             xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                     "divisor 0 get vblank counter failed: %s\n",
                     strerror(errno));
             goto blit_fallback;
         }

-        *target_msc =3D vbl.reply.sequence + flip + msc_delta;
+        *target_msc =3D seq + flip + msc_delta;
         swap_info->frame =3D *target_msc;

         return TRUE;
@@ -1389,13 +1348,11 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
      * and we need to queue an event that will satisfy the divisor/remaind=
er
      * equation.
      */
-    vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
+    type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;
     if (flip =3D=3D 0)
-        vbl.request.type |=3D DRM_VBLANK_NEXTONMISS;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);
+        type |=3D DRM_VBLANK_NEXTONMISS;

-    vbl.request.sequence =3D current_msc - (current_msc % divisor) +
-        remainder - msc_delta;
+    event_msc =3D current_msc - (current_msc % divisor) + remainder - msc_=
delta;

     /*
      * If the calculated deadline vbl.request.sequence is smaller than
@@ -1408,15 +1365,13 @@ static int radeon_dri2_schedule_swap(ClientPtr clie=
nt, DrawablePtr draw,
      * into account, as well as a potential DRM_VBLANK_NEXTONMISS delay
      * if we are blitting/exchanging instead of flipping.
      */
-    if (vbl.request.sequence <=3D current_msc)
-        vbl.request.sequence +=3D divisor;
+    if (event_msc <=3D current_msc)
+        event_msc +=3D divisor;

     /* Account for 1 frame extra pageflip delay if flip > 0 */
-    vbl.request.sequence -=3D flip;
+    event_msc -=3D flip;

-    vbl.request.signal =3D drm_queue_seq;
-    ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-    if (ret) {
+    if (!drmmode_wait_vblank(crtc, type, event_msc, drm_queue_seq, NULL, &=
seq)) {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
                 "final get vblank counter failed: %s\n",
                 strerror(errno));
@@ -1424,7 +1379,7 @@ static int radeon_dri2_schedule_swap(ClientPtr client=
, DrawablePtr draw,
     }

     /* Adjust returned value for 1 fame pageflip offset of flip > 0 */
-    *target_msc =3D vbl.reply.sequence + flip + msc_delta;
+    *target_msc =3D seq + flip + msc_delta;
     *target_msc &=3D 0xffffffff;
     swap_info->frame =3D *target_msc;

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index 5ae94f5c8..423d36cbb 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -722,11 +722,9 @@ radeon_prime_scanout_update(PixmapDirtyUpdatePtr dirty=
)
 {
     ScreenPtr screen =3D dirty->slave_dst->drawable.pScreen;
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
     xf86CrtcPtr xf86_crtc =3D radeon_prime_dirty_to_crtc(dirty);
     drmmode_crtc_private_ptr drmmode_crtc;
     uintptr_t drm_queue_seq;
-    drmVBlank vbl;

     if (!xf86_crtc || !xf86_crtc->enabled)
         return;
@@ -748,13 +746,10 @@ radeon_prime_scanout_update(PixmapDirtyUpdatePtr dirt=
y)
         return;
     }

-    vbl.request.type =3D DRM_VBLANK_RELATIVE | DRM_VBLANK_EVENT;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(xf86_crtc);
-    vbl.request.sequence =3D 1;
-    vbl.request.signal =3D drm_queue_seq;
-    if (drmWaitVBlank(pRADEONEnt->fd, &vbl)) {
+    if (!drmmode_wait_vblank(xf86_crtc, DRM_VBLANK_RELATIVE | DRM_VBLANK_E=
VENT,
+                            1, drm_queue_seq, NULL, NULL)) {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
-                  "drmWaitVBlank failed for PRIME update: %s\n",
+                  "drmmode_wait_vblank failed for PRIME update: %s\n",
                    strerror(errno));
         radeon_drm_abort_entry(drm_queue_seq);
         return;
@@ -1019,10 +1014,8 @@ static void
 radeon_scanout_update(xf86CrtcPtr xf86_crtc)
 {
     drmmode_crtc_private_ptr drmmode_crtc =3D xf86_crtc->driver_private;
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(xf86_crtc->scrn);
     uintptr_t drm_queue_seq;
     ScrnInfoPtr scrn;
-    drmVBlank vbl;
     DamagePtr pDamage;
     RegionPtr pRegion;
     BoxRec extents;
@@ -1059,13 +1052,10 @@ radeon_scanout_update(xf86CrtcPtr xf86_crtc)
         return;
     }

-    vbl.request.type =3D DRM_VBLANK_RELATIVE | DRM_VBLANK_EVENT;
-    vbl.request.type |=3D radeon_populate_vbl_request_type(xf86_crtc);
-    vbl.request.sequence =3D 1;
-    vbl.request.signal =3D drm_queue_seq;
-    if (drmWaitVBlank(pRADEONEnt->fd, &vbl)) {
+    if (!drmmode_wait_vblank(xf86_crtc, DRM_VBLANK_RELATIVE | DRM_VBLANK_E=
VENT,
+                            1, drm_queue_seq, NULL, NULL)) {
         xf86DrvMsg(scrn->scrnIndex, X_WARNING,
-                  "drmWaitVBlank failed for scanout update: %s\n",
+                  "drmmode_wait_vblank failed for scanout update: %s\n",
                    strerror(errno));
         radeon_drm_abort_entry(drm_queue_seq);
         return;
diff --git a/src/radeon_present.c b/src/radeon_present.c
index c01ba95f9..135a0a97c 100644
--- a/src/radeon_present.c
+++ b/src/radeon_present.c
@@ -55,16 +55,6 @@ struct radeon_present_vblank_event {
     Bool unflip;
 };

-static uint32_t crtc_select(int crtc_id)
-{
-    if (crtc_id > 1)
-       return crtc_id << DRM_VBLANK_HIGH_CRTC_SHIFT;
-    else if (crtc_id > 0)
-       return DRM_VBLANK_SECONDARY;
-    else
-       return 0;
-}
-
 static RRCrtcPtr
 radeon_present_get_crtc(WindowPtr window)
 {
@@ -155,13 +145,8 @@ radeon_present_queue_vblank(RRCrtcPtr crtc, uint64_t e=
vent_id, uint64_t msc)
 {
     xf86CrtcPtr xf86_crtc =3D crtc->devPrivate;
     ScreenPtr screen =3D crtc->pScreen;
-    ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);
-    int crtc_id =3D drmmode_get_crtc_id(xf86_crtc);
     struct radeon_present_vblank_event *event;
     uintptr_t drm_queue_seq;
-    drmVBlank vbl;
-    int ret;

     event =3D calloc(sizeof(struct radeon_present_vblank_event), 1);
     if (!event)
@@ -177,12 +162,10 @@ radeon_present_queue_vblank(RRCrtcPtr crtc, uint64_t =
event_id, uint64_t msc)
         return BadAlloc;
     }

-    vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT | crtc_sel=
ect(crtc_id);
-    vbl.request.sequence =3D msc;
-    vbl.request.signal =3D drm_queue_seq;
     for (;;) {
-       ret =3D drmWaitVBlank(pRADEONEnt->fd, &vbl);
-       if (!ret)
+       if (drmmode_wait_vblank(xf86_crtc,
+                               DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT, msc=
,
+                               drm_queue_seq, NULL, NULL))
             break;
         if (errno !=3D EBUSY || !radeon_present_flush_drm_events(screen)) =
{
             radeon_drm_abort_entry(drm_queue_seq);
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_MWHPR12MB1549AC09E8B5584768E9AE4AFE820MWHPR12MB1549namp_
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
<p>Two really small comments inline</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@=
daenzer.net&gt;<br>
<b>Sent:</b> Wednesday, August 16, 2017 3:57 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 03/10] Create drmmode_wait_vblank hel=
per</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
Allows cleaning up the code considerably.<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c |&nbsp; 61 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<=
br>
&nbsp;src/drmmode_display.h |&nbsp;&nbsp; 4 &#43;&#43;<br>
&nbsp;src/radeon.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; 2 -<br>
&nbsp;src/radeon_dri2.c&nbsp;&nbsp;&nbsp;&nbsp; | 103 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------------------=
----------<br>
&nbsp;src/radeon_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 22 &#43;&#43;&=
#43;--------<br>
&nbsp;src/radeon_present.c&nbsp; |&nbsp; 23 &#43;&#43;---------<br>
&nbsp;6 files changed, 82 insertions(&#43;), 133 deletions(-)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index 46a579ff3..96c108a85 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -242,6 &#43;242,39 @@ drmmode_ConvertToKMode(ScrnInfoPtr scrn,<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/*<br>
&#43; * Utility helper for drmWaiVBlank</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[slava a] drmWaitVBlank</div>
<div class=3D"PlainText"><br>
&#43; */<br>
&#43;Bool<br>
&#43;drmmode_wait_vblank(xf86CrtcPtr crtc, drmVBlankSeqType type, unsigned =
seq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long signal, uint64_t *ust,=
 uint32_t *msc)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int crtc_id =3D drmmode_get_crtc_=
id(crtc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D crtc-&gt;scr=
n;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEO=
NEntPriv(scrn);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (crtc_id =3D=3D 1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; type |=3D DRM_VBLANK_SECONDARY;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (crtc_id &gt; 1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; type |=3D (crtc_id &lt;&lt; DRM_VBLANK_HIGH_CRTC_SHIFT) &amp=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_VBLANK_H=
IGH_CRTC_MASK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type =3D type;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D seq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.signal =3D signal;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drmWaitVBlank(pRADEONEnt-&gt;=
fd, &amp;vbl) !=3D 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return FALSE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ust)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *ust =3D (uint64_t)vbl.reply.tval_sec * 1000000 &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.reply.tv=
al_usec;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msc)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *msc =3D vbl.reply.sequence;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[slava a] Blank line here for better readability</=
div>
<div class=3D"PlainText"><br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return TRUE;<br>
&#43;}<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * Retrieves present time in microseconds that is compatible<br>
&nbsp; * with units used by vblank timestamps. Depending on the kernel<br>
@@ -272,23 &#43;305,15 @@ int drmmode_get_current_ust(int drm_fd, CARD64 *u=
st)<br>
&nbsp;int drmmode_crtc_get_ust_msc(xf86CrtcPtr crtc, CARD64 *ust, CARD64 *m=
sc)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D crtc-&gt;scrn;<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
-&nbsp;&nbsp;&nbsp; int ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
crtc);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE,=
 0, 0, ust, &amp;seq)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;get vblank counter failed: %s=
\n&quot;, strerror(errno));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; *ust =3D ((CARD64)vbl.reply.tval_sec * 1000000) &#43; v=
bl.reply.tval_usec;<br>
-&nbsp;&nbsp;&nbsp; *msc =3D vbl.reply.sequence;<br>
&#43;&nbsp;&nbsp;&nbsp; *msc =3D seq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; return Success;<br>
&nbsp;}<br>
@@ -305,7 &#43;330,7 @@ drmmode_do_crtc_dpms(xf86CrtcPtr crtc, int mode)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_crtc-&gt;pending_d=
pms_mode =3D mode;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drmmode_crtc-&gt;dpms_=
mode =3D=3D DPMSModeOn &amp;&amp; mode !=3D DPMSModeOn) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; drmVBlank vbl;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t seq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Wait for any pending flip to finish */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (drmmode_crtc-&gt;flip_pending)<br>
@@ -315,20 &#43;340,14 @@ drmmode_do_crtc_dpms(xf86CrtcPtr crtc, int mode)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * On-&gt;Off transition: record the last vblank=
 time,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * sequence number and frame period.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(crtc);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vbl.request.sequence =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE, 0, 0, &a=
mp;ust,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &amp;seq))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86D=
rvMsg(scrn-&gt;scrnIndex, X_ERROR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%s canno=
t get last vblank counter\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CARD64 seq =3D (=
CARD64)vbl.reply.sequence;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CARD6=
4 nominal_frame_rate, pix_in_frame;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ust =3D ((CARD64=
)vbl.reply.tval_sec * 1000000) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.reply.tval_usec;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmo=
de_crtc-&gt;dpms_last_ust =3D ust;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmo=
de_crtc-&gt;dpms_last_seq =3D seq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nomin=
al_frame_rate =3D crtc-&gt;mode.Clock;<br>
diff --git a/src/drmmode_display.h b/src/drmmode_display.h<br>
index f21047890..4262051d7 100644<br>
--- a/src/drmmode_display.h<br>
&#43;&#43;&#43; b/src/drmmode_display.h<br>
@@ -226,5 &#43;226,9 @@ Bool radeon_do_pageflip(ScrnInfoPtr scrn, ClientPtr=
 client,<br>
&nbsp;int drmmode_crtc_get_ust_msc(xf86CrtcPtr crtc, CARD64 *ust, CARD64 *m=
sc);<br>
&nbsp;int drmmode_get_current_ust(int drm_fd, CARD64 *ust);<br>
&nbsp;<br>
&#43;Bool drmmode_wait_vblank(xf86CrtcPtr crtc, drmVBlankSeqType type, unsi=
gned seq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsign=
ed long signal, uint64_t *ust, uint32_t *msc);<br>
&#43;<br>
&#43;<br>
&nbsp;#endif<br>
&nbsp;<br>
diff --git a/src/radeon.h b/src/radeon.h<br>
index d815d3f00..b93e28163 100644<br>
--- a/src/radeon.h<br>
&#43;&#43;&#43; b/src/radeon.h<br>
@@ -693,8 &#43;693,6 @@ extern void radeon_ddx_cs_start(ScrnInfoPtr pScrn,<=
br>
&nbsp;void radeon_kms_update_vram_limit(ScrnInfoPtr pScrn, uint32_t new_fb_=
size);<br>
&nbsp;extern RADEONEntPtr RADEONEntPriv(ScrnInfoPtr pScrn);<br>
&nbsp;<br>
-drmVBlankSeqType radeon_populate_vbl_request_type(xf86CrtcPtr crtc);<br>
-<br>
&nbsp;static inline struct radeon_surface *radeon_get_pixmap_surface(Pixmap=
Ptr pPix)<br>
&nbsp;{<br>
&nbsp;#ifdef USE_GLAMOR<br>
diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c<br>
index 80b17f1f9..a0deb6bae 100644<br>
--- a/src/radeon_dri2.c<br>
&#43;&#43;&#43; b/src/radeon_dri2.c<br>
@@ -889,26 &#43;889,6 @@ cleanup:<br>
&nbsp;&nbsp;&nbsp;&nbsp; radeon_dri2_frame_event_abort(crtc, event_data);<b=
r>
&nbsp;}<br>
&nbsp;<br>
-drmVBlankSeqType radeon_populate_vbl_request_type(xf86CrtcPtr crtc)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; drmVBlankSeqType type =3D 0;<br>
-&nbsp;&nbsp;&nbsp; int crtc_id =3D drmmode_get_crtc_id(crtc);<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (crtc_id =3D=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type |=3D DRM_VBLANK_SECONDARY;=
<br>
-&nbsp;&nbsp;&nbsp; else if (crtc_id &gt; 1)<br>
-#ifdef DRM_VBLANK_HIGH_CRTC_SHIFT<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type |=3D (crtc_id &lt;&lt; DRM_VBLAN=
K_HIGH_CRTC_SHIFT) &amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_VBLANK_HIGH_CRTC_MASK;<br>
-#else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ErrorF(&quot;radeon driver bug: %s ca=
lled for CRTC %d &gt; 1, but &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;DRM_VBLANK_HIGH_CRTC_MASK not defined at build time\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; __func__, crtc_id);<br>
-#endif<br>
-<br>
-&nbsp;&nbsp;&nbsp; return type; <br>
-}<br>
-<br>
&nbsp;/*<br>
&nbsp; * This function should be called on a disabled CRTC only (i.e., CRTC=
<br>
&nbsp; * in DPMS-off state). It will calculate the delay necessary to reach=
<br>
@@ -1087,13 &#43;1067,11 @@ static int radeon_dri2_schedule_wait_msc(Client=
Ptr client, DrawablePtr draw,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D draw-&gt;pScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);<br>
&nbsp;&nbsp;&nbsp;&nbsp; DRI2FrameEventPtr wait_info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(dra=
w, TRUE);<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t msc_delta;<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
-&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&nbsp;&nbsp;&nbsp;&nbsp; CARD64 current_msc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Truncate to match kernel interfaces; means occa=
sional overflow<br>
@@ -1132,17 &#43;1110,13 @@ static int radeon_dri2_schedule_wait_msc(Client=
Ptr client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Get current count */<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
crtc);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D 0;<br>
-&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE,=
 0, 0, NULL, &amp;seq)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;get vblank counter failed: %s\n&quot;, strerror=
(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_complete;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; current_msc =3D vbl.reply.sequence &#43; msc_delta;<br>
&#43;&nbsp;&nbsp;&nbsp; current_msc =3D seq &#43; msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp; current_msc &amp;=3D 0xffffffff;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm_queue_seq =3D radeon_drm_queue_alloc(crtc, cli=
ent, RADEON_DRM_QUEUE_ID_DEFAULT,<br>
@@ -1169,12 &#43;1143,9 @@ static int radeon_dri2_schedule_wait_msc(ClientP=
tr client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (current_msc &gt;=3D ta=
rget_msc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta=
rget_msc =3D current_msc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK=
_ABSOLUTE | DRM_VBLANK_EVENT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate=
_vbl_request_type(crtc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D target=
_msc - msc_delta;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queu=
e_seq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEn=
t-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(cr=
tc, DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target_msc - msc_delta, drm_queue=
_seq, NULL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf=
86DrvMsg(scrn-&gt;scrnIndex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;get vblank counter fail=
ed: %s\n&quot;, strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to out_complete;<br>
@@ -1188,11 &#43;1159,7 @@ static int radeon_dri2_schedule_wait_msc(ClientP=
tr client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If we get here, target_msc has already pas=
sed or we don't have one,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so we queue an event that will satisfy the=
 divisor/remainder equation.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_E=
VENT;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
crtc);<br>
-<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D current_msc - (current_msc % d=
ivisor) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remainder - msc_delta;<br>
&#43;&nbsp;&nbsp;&nbsp; target_msc =3D current_msc - (current_msc % divisor=
) &#43; remainder - msc_delta;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If calculated remainder is larger than req=
uested remainder,<br>
@@ -1201,11 &#43;1168,10 @@ static int radeon_dri2_schedule_wait_msc(Client=
Ptr client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that will happen.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp; if ((current_msc % divisor) &gt;=3D remainder)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.sequence &#43;=3D d=
ivisor;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target_msc &#43;=3D divisor=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, DRM_VBLANK_ABSOLUTE =
| DRM_VBLANK_EVENT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; target_msc, drm_queue_seq, NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;get vblank counter failed: %s\n&quot;, strerror=
(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_complete;<br>
@@ -1249,14 &#43;1215,14 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D draw-&gt;pScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);<br>
&nbsp;&nbsp;&nbsp;&nbsp; xf86CrtcPtr crtc =3D radeon_dri2_drawable_crtc(dra=
w, TRUE);<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t msc_delta;<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
-&nbsp;&nbsp;&nbsp; int ret, flip =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp; drmVBlankSeqType type;<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&#43;&nbsp;&nbsp;&nbsp; int flip =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp; DRI2FrameEventPtr swap_info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; CARD64 current_msc;<br>
&#43;&nbsp;&nbsp;&nbsp; CARD64 current_msc, event_msc;<br>
&nbsp;&nbsp;&nbsp;&nbsp; BoxRec box;<br>
&nbsp;&nbsp;&nbsp;&nbsp; RegionRec region;<br>
&nbsp;<br>
@@ -1319,18 &#43;1285,14 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Get current count */<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
crtc);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D 0;<br>
-&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, DRM_VBLANK_RELATIVE,=
 0, 0, NULL, &amp;seq)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;first get vblank counter failed: %s\n&quot;,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto blit_fallback;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; current_msc =3D vbl.reply.sequence &#43; msc_delta;<br>
&#43;&nbsp;&nbsp;&nbsp; current_msc =3D seq &#43; msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp; current_msc &amp;=3D 0xffffffff;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Flips need to be submitted one frame before */<=
br>
@@ -1352,14 &#43;1314,13 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the swap.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (divisor =3D=3D 0 || current_msc &lt; *target_m=
sc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type =3D&nbsp; DRM_=
VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type =3D DRM_VBLANK_ABSOLUT=
E | DRM_VBLANK_EVENT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If non-pageflipping, bu=
t blitting/exchanging, we need to use<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DRM_VBLANK_NEXTONM=
ISS to avoid unreliable timestamping later<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flip =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.req=
uest.type |=3D DRM_VBLANK_NEXTONMISS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate=
_vbl_request_type(crtc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; typ=
e |=3D DRM_VBLANK_NEXTONMISS;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If target_msc already r=
eached or passed, set it to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * current_msc to ens=
ure we return a reasonable value back<br>
@@ -1368,17 &#43;1329,15 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (current_msc &gt;=3D *t=
arget_msc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *t=
arget_msc =3D current_msc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D *targe=
t_msc - msc_delta;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queu=
e_seq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEn=
t-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(cr=
tc, type, *target_msc - msc_delta,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_queue_seq, NULL, &amp;seq)) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf=
86DrvMsg(scrn-&gt;scrnIndex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;divisor 0 get vblank co=
unter failed: %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to blit_fallback;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *target_msc =3D vbl.reply.seque=
nce &#43; flip &#43; msc_delta;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *target_msc =3D seq &#43; f=
lip &#43; msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swap_info-&gt;frame =3D *t=
arget_msc;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return TRUE;<br>
@@ -1389,13 &#43;1348,11 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and we need to queue an event that will sa=
tisfy the divisor/remainder<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * equation.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_E=
VENT;<br>
&#43;&nbsp;&nbsp;&nbsp; type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp; if (flip =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.type |=3D DRM_VBLAN=
K_NEXTONMISS;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
crtc);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type |=3D DRM_VBLANK_NEXTON=
MISS;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D current_msc - (current_msc % d=
ivisor) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remainder - msc_delta;<br>
&#43;&nbsp;&nbsp;&nbsp; event_msc =3D current_msc - (current_msc % divisor)=
 &#43; remainder - msc_delta;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If the calculated deadline vbl.request.seq=
uence is smaller than<br>
@@ -1408,15 &#43;1365,13 @@ static int radeon_dri2_schedule_swap(ClientPtr =
client, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * into account, as well as a potential DRM_V=
BLANK_NEXTONMISS delay<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if we are blitting/exchanging instead of f=
lipping.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; if (vbl.request.sequence &lt;=3D current_msc)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbl.request.sequence &#43;=3D d=
ivisor;<br>
&#43;&nbsp;&nbsp;&nbsp; if (event_msc &lt;=3D current_msc)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_msc &#43;=3D divisor;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Account for 1 frame extra pageflip delay if fli=
p &gt; 0 */<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence -=3D flip;<br>
&#43;&nbsp;&nbsp;&nbsp; event_msc -=3D flip;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(crtc, type, event_msc, drm=
_queue_seq, NULL, &amp;seq)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;final get vblank counter failed: %s\n&quot;,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
@@ -1424,7 &#43;1379,7 @@ static int radeon_dri2_schedule_swap(ClientPtr cl=
ient, DrawablePtr draw,<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Adjust returned value for 1 fame pageflip offse=
t of flip &gt; 0 */<br>
-&nbsp;&nbsp;&nbsp; *target_msc =3D vbl.reply.sequence &#43; flip &#43; msc=
_delta;<br>
&#43;&nbsp;&nbsp;&nbsp; *target_msc =3D seq &#43; flip &#43; msc_delta;<br>
&nbsp;&nbsp;&nbsp;&nbsp; *target_msc &amp;=3D 0xffffffff;<br>
&nbsp;&nbsp;&nbsp;&nbsp; swap_info-&gt;frame =3D *target_msc;<br>
&nbsp;<br>
diff --git a/src/radeon_kms.c b/src/radeon_kms.c<br>
index 5ae94f5c8..423d36cbb 100644<br>
--- a/src/radeon_kms.c<br>
&#43;&#43;&#43; b/src/radeon_kms.c<br>
@@ -722,11 &#43;722,9 @@ radeon_prime_scanout_update(PixmapDirtyUpdatePtr d=
irty)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D dirty-&gt;slave_dst-&gt;drawa=
ble.pScreen;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);<br>
&nbsp;&nbsp;&nbsp;&nbsp; xf86CrtcPtr xf86_crtc =3D radeon_prime_dirty_to_cr=
tc(dirty);<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmmode_crtc_private_ptr drmmode_crtc;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!xf86_crtc || !xf86_crtc-&gt;enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
@@ -748,13 &#43;746,10 @@ radeon_prime_scanout_update(PixmapDirtyUpdatePtr =
dirty)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE | DRM_VBLANK_E=
VENT;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
xf86_crtc);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D 1;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; if (drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl)) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(xf86_crtc, DRM_VBLANK_RELA=
TIVE | DRM_VBLANK_EVENT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 1, drm_queue_seq, NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;drmWaitVBlank failed for PRIME update: %=
s\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;drmmode_wait_vblank failed for PRIME=
 update: %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_drm_abort_entry(drm=
_queue_seq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
@@ -1019,10 &#43;1014,8 @@ static void<br>
&nbsp;radeon_scanout_update(xf86CrtcPtr xf86_crtc)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; drmmode_crtc_private_ptr drmmode_crtc =3D xf86_crt=
c-&gt;driver_private;<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(xf86_crtc-&gt=
;scrn);<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn;<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
&nbsp;&nbsp;&nbsp;&nbsp; DamagePtr pDamage;<br>
&nbsp;&nbsp;&nbsp;&nbsp; RegionPtr pRegion;<br>
&nbsp;&nbsp;&nbsp;&nbsp; BoxRec extents;<br>
@@ -1059,13 &#43;1052,10 @@ radeon_scanout_update(xf86CrtcPtr xf86_crtc)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_RELATIVE | DRM_VBLANK_E=
VENT;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type |=3D radeon_populate_vbl_request_type(=
xf86_crtc);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D 1;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; if (drmWaitVBlank(pRADEONEnt-&gt;fd, &amp;vbl)) {<br>
&#43;&nbsp;&nbsp;&nbsp; if (!drmmode_wait_vblank(xf86_crtc, DRM_VBLANK_RELA=
TIVE | DRM_VBLANK_EVENT,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 1, drm_queue_seq, NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_WARNING,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;drmWaitVBlank failed for scanout update:=
 %s\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;drmmode_wait_vblank failed for scano=
ut update: %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strerror(errno));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_drm_abort_entry(drm=
_queue_seq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
diff --git a/src/radeon_present.c b/src/radeon_present.c<br>
index c01ba95f9..135a0a97c 100644<br>
--- a/src/radeon_present.c<br>
&#43;&#43;&#43; b/src/radeon_present.c<br>
@@ -55,16 &#43;55,6 @@ struct radeon_present_vblank_event {<br>
&nbsp;&nbsp;&nbsp;&nbsp; Bool unflip;<br>
&nbsp;};<br>
&nbsp;<br>
-static uint32_t crtc_select(int crtc_id)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; if (crtc_id &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return crtc_id &lt;&lt; DRM_VBLANK_HI=
GH_CRTC_SHIFT;<br>
-&nbsp;&nbsp;&nbsp; else if (crtc_id &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DRM_VBLANK_SECONDARY;<br>
-&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static RRCrtcPtr<br>
&nbsp;radeon_present_get_crtc(WindowPtr window)<br>
&nbsp;{<br>
@@ -155,13 &#43;145,8 @@ radeon_present_queue_vblank(RRCrtcPtr crtc, uint64=
_t event_id, uint64_t msc)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; xf86CrtcPtr xf86_crtc =3D crtc-&gt;devPrivate;<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D crtc-&gt;pScreen;<br>
-&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; RADEONEntPtr pRADEONEnt =3D RADEONEntPriv(scrn);<br>
-&nbsp;&nbsp;&nbsp; int crtc_id =3D drmmode_get_crtc_id(xf86_crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct radeon_present_vblank_event *event;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t drm_queue_seq;<br>
-&nbsp;&nbsp;&nbsp; drmVBlank vbl;<br>
-&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; event =3D calloc(sizeof(struct radeon_present_vbla=
nk_event), 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!event)<br>
@@ -177,12 &#43;162,10 @@ radeon_present_queue_vblank(RRCrtcPtr crtc, uint6=
4_t event_id, uint64_t msc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return BadAlloc;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.type =3D DRM_VBLANK_ABSOLUTE | DRM_VBLANK_E=
VENT | crtc_select(crtc_id);<br>
-&nbsp;&nbsp;&nbsp; vbl.request.sequence =3D msc;<br>
-&nbsp;&nbsp;&nbsp; vbl.request.signal =3D drm_queue_seq;<br>
&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drmWaitVBlank(pRADEONEnt-&gt;=
fd, &amp;vbl);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drmmode_wait_vblank(xf86_crtc=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_VBLANK_ABSOLUTE | DRM_VBLANK_EVENT,=
 msc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_queue_seq, NULL, NULL))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (errno !=3D EBUSY || !r=
adeon_present_flush_drm_events(screen)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra=
deon_drm_abort_entry(drm_queue_seq);<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk679799" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15029013964060.38499156816480995" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15029013964040.6571836435305722" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15029013964050.5827731624270094" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15029013964050.06646265142104446"></div=
>
<div id=3D"LPTitle_15029013964050.8577571959803711" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15029013964060.5288276377801104" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15029013964060.5154021037906125" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15029013964060.7455276551082373" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1549AC09E8B5584768E9AE4AFE820MWHPR12MB1549namp_--

--===============1004432750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1004432750==--
