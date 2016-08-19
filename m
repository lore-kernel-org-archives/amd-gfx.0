From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 xserver 3/5] modesetting: move common page flip handle
 to pageflip.c
Date: Fri, 19 Aug 2016 11:30:51 +0000
Message-ID: <DM5PR12MB1132187DDE5132521F18628FF7160@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <1471611050-27207-1-git-send-email-Qiang.Yu@amd.com>,
 <1471611050-27207-4-git-send-email-Qiang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0840126382=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471611050-27207-4-git-send-email-Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>, "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>
Cc: "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0840126382==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132187DDE5132521F18628FF7160DM5PR12MB1132namp_"

--_000_DM5PR12MB1132187DDE5132521F18628FF7160DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In ms_pageflip_free() you cannot free the parent structure before freeing t=
hings it points to.  That's undefined behaviour.

Tom

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Qiang Yu=
 <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 19, 2016 08:50
To: xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org
Cc: Yu, Qiang; michel-otUistvHUpPR7s880joybQ@public.gmane.org; emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx@lists.=
freedesktop.org
Subject: [PATCH v2 xserver 3/5] modesetting: move common page flip handle t=
o pageflip.c

The common page flip handle framework can be shared with DRI2
page flip.

Signed-off-by: Qiang Yu <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
---
 hw/xfree86/drivers/modesetting/driver.h   |  28 --------
 hw/xfree86/drivers/modesetting/pageflip.c | 102 ++++++++++++++++++++++++++=
++--
 hw/xfree86/drivers/modesetting/present.c  |  63 +++---------------
 3 files changed, 104 insertions(+), 89 deletions(-)

diff --git a/hw/xfree86/drivers/modesetting/driver.h b/hw/xfree86/drivers/m=
odesetting/driver.h
index c0d80a8..38f0ec0 100644
--- a/hw/xfree86/drivers/modesetting/driver.h
+++ b/hw/xfree86/drivers/modesetting/driver.h
@@ -156,34 +156,6 @@ Bool ms_present_screen_init(ScreenPtr screen);

 #ifdef GLAMOR

-/*
- * Event data for an in progress flip.
- * This contains a pointer to the vblank event,
- * and information about the flip in progress.
- * a reference to this is stored in the per-crtc
- * flips.
- */
-struct ms_flipdata {
-    ScreenPtr screen;
-    void *event;
-    /* number of CRTC events referencing this */
-    int flip_count;
-    uint64_t fe_msc;
-    uint64_t fe_usec;
-    uint32_t old_fb_id;
-};
-
-/*
- * Per crtc pageflipping infomation,
- * These are submitted to the queuing code
- * one of them per crtc per flip.
- */
-struct ms_crtc_pageflip {
-    Bool on_reference_crtc;
-    /* reference to the ms_flipdata */
-    struct ms_flipdata *flipdata;
-};
-
 typedef void (*ms_pageflip_handler_proc)(uint64_t frame,
                                          uint64_t usec,
                                          void *data);
diff --git a/hw/xfree86/drivers/modesetting/pageflip.c b/hw/xfree86/drivers=
/modesetting/pageflip.c
index 4549792..5f35999 100644
--- a/hw/xfree86/drivers/modesetting/pageflip.c
+++ b/hw/xfree86/drivers/modesetting/pageflip.c
@@ -32,6 +32,97 @@
 #ifdef GLAMOR

 /*
+ * Event data for an in progress flip.
+ * This contains a pointer to the vblank event,
+ * and information about the flip in progress.
+ * a reference to this is stored in the per-crtc
+ * flips.
+ */
+struct ms_flipdata {
+    ScreenPtr screen;
+    void *event;
+    ms_pageflip_handler_proc event_handler;
+    ms_pageflip_abort_proc abort_handler;
+    /* number of CRTC events referencing this */
+    int flip_count;
+    uint64_t fe_msc;
+    uint64_t fe_usec;
+    uint32_t old_fb_id;
+};
+
+/*
+ * Per crtc pageflipping infomation,
+ * These are submitted to the queuing code
+ * one of them per crtc per flip.
+ */
+struct ms_crtc_pageflip {
+    Bool on_reference_crtc;
+    /* reference to the ms_flipdata */
+    struct ms_flipdata *flipdata;
+};
+
+/**
+ * Free an ms_crtc_pageflip.
+ *
+ * Drops the reference count on the flipdata.
+ */
+static void
+ms_pageflip_free(struct ms_crtc_pageflip *flip)
+{
+    struct ms_flipdata *flipdata =3D flip->flipdata;
+
+    free(flip);
+    if (--flipdata->flip_count > 0)
+        return;
+    free(flipdata);
+}
+
+/**
+ * Callback for the DRM event queue when a single flip has completed
+ *
+ * Once the flip has been completed on all pipes, notify the
+ * extension code telling it when that happened
+ */
+static void
+ms_pageflip_handler(uint64_t msc, uint64_t ust, void *data)
+{
+    struct ms_crtc_pageflip *flip =3D data;
+    struct ms_flipdata *flipdata =3D flip->flipdata;
+    ScreenPtr screen =3D flipdata->screen;
+    ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
+    modesettingPtr ms =3D modesettingPTR(scrn);
+
+    if (flip->on_reference_crtc) {
+        flipdata->fe_msc =3D msc;
+        flipdata->fe_usec =3D ust;
+    }
+
+    if (flipdata->flip_count =3D=3D 1) {
+        flipdata->event_handler(flipdata->fe_msc,
+                                flipdata->fe_usec,
+                                flipdata->event);
+
+        drmModeRmFB(ms->fd, flipdata->old_fb_id);
+    }
+    ms_pageflip_free(flip);
+}
+
+/*
+ * Callback for the DRM queue abort code.  A flip has been aborted.
+ */
+static void
+ms_pageflip_abort(void *data)
+{
+    struct ms_crtc_pageflip *flip =3D data;
+    struct ms_flipdata *flipdata =3D flip->flipdata;
+
+    if (flipdata->flip_count =3D=3D 1)
+        flipdata->abort_handler(flipdata->event);
+
+    ms_pageflip_free(flip);
+}
+
+/*
  * Flush the DRM event queue when full; makes space for new events.
  *
  * Returns a negative value on error, 0 if there was nothing to process,
@@ -68,9 +159,7 @@ ms_flush_drm_events(ScreenPtr screen)
 static Bool
 queue_flip_on_crtc(ScreenPtr screen, xf86CrtcPtr crtc,
                    struct ms_flipdata *flipdata,
-                   int ref_crtc_vblank_pipe, uint32_t flags,
-                   ms_pageflip_handler_proc pageflip_handler,
-                   ms_pageflip_abort_proc pageflip_abort)
+                   int ref_crtc_vblank_pipe, uint32_t flags)
 {
     ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
     modesettingPtr ms =3D modesettingPTR(scrn);
@@ -92,7 +181,7 @@ queue_flip_on_crtc(ScreenPtr screen, xf86CrtcPtr crtc,
     flip->on_reference_crtc =3D (drmmode_crtc->vblank_pipe =3D=3D ref_crtc=
_vblank_pipe);
     flip->flipdata =3D flipdata;

-    seq =3D ms_drm_queue_alloc(crtc, flip, pageflip_handler, pageflip_abor=
t);
+    seq =3D ms_drm_queue_alloc(crtc, flip, ms_pageflip_handler, ms_pagefli=
p_abort);
     if (!seq) {
         free(flip);
         return FALSE;
@@ -164,6 +253,8 @@ ms_do_pageflip(ScreenPtr screen,

     flipdata->event =3D event;
     flipdata->screen =3D screen;
+    flipdata->event_handler =3D pageflip_handler;
+    flipdata->abort_handler =3D pageflip_abort;

     /*
      * Take a local reference on flipdata.
@@ -206,8 +297,7 @@ ms_do_pageflip(ScreenPtr screen,

         if (!queue_flip_on_crtc(screen, crtc, flipdata,
                                 ref_crtc_vblank_pipe,
-                                flags, pageflip_handler,
-                                pageflip_abort)) {
+                                flags)) {
             goto error_undo;
         }
     }
diff --git a/hw/xfree86/drivers/modesetting/present.c b/hw/xfree86/drivers/=
modesetting/present.c
index 18c82cd..deee1f1 100644
--- a/hw/xfree86/drivers/modesetting/present.c
+++ b/hw/xfree86/drivers/modesetting/present.c
@@ -192,77 +192,30 @@ ms_present_flush(WindowPtr window)
 #ifdef GLAMOR

 /**
- * Free an ms_crtc_pageflip.
- *
- * Drops the reference count on the flipdata.
- */
-static void
-ms_present_flip_free(struct ms_crtc_pageflip *flip)
-{
-    struct ms_flipdata *flipdata =3D flip->flipdata;
-
-    free(flip);
-    if (--flipdata->flip_count > 0)
-        return;
-    free(flipdata);
-}
-
-/**
- * Callback for the DRM event queue when a single flip has completed
- *
- * Once the flip has been completed on all pipes, notify the
+ * Callback for the flip has been completed on all pipes, notify the
  * extension code telling it when that happened
  */
 static void
 ms_present_flip_handler(uint64_t msc, uint64_t ust, void *data)
 {
-    struct ms_crtc_pageflip *flip =3D data;
-    ScreenPtr screen =3D flip->flipdata->screen;
-    ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);
-    modesettingPtr ms =3D modesettingPTR(scrn);
-    struct ms_flipdata *flipdata =3D flip->flipdata;
+    struct ms_present_vblank_event *event =3D data;

-    DebugPresent(("\t\tms:fh %lld c %d msc %llu ust %llu\n",
-                  (long long) flipdata->event->event_id,
-                  flipdata->flip_count,
+    DebugPresent(("\t\tms:fc %lld msc %llu ust %llu\n",
+                  (long long) event->event_id,
                   (long long) msc, (long long) ust));

-    if (flip->on_reference_crtc) {
-        flipdata->fe_msc =3D msc;
-        flipdata->fe_usec =3D ust;
-    }
-
-    if (flipdata->flip_count =3D=3D 1) {
-        DebugPresent(("\t\tms:fc %lld c %d msc %llu ust %llu\n",
-                      (long long) flipdata->event->event_id,
-                      flipdata->flip_count,
-                      (long long) flipdata->fe_msc, (long long) flipdata->=
fe_usec));
-
-
-        ms_present_vblank_handler(flipdata->fe_msc,
-                                  flipdata->fe_usec,
-                                  flipdata->event);
-
-        drmModeRmFB(ms->fd, flipdata->old_fb_id);
-    }
-    ms_present_flip_free(flip);
+    ms_present_vblank_handler(msc, ust, event);
 }

 /*
- * Callback for the DRM queue abort code.  A flip has been aborted.
+ * Callback for the flip has been aborted.
  */
 static void
 ms_present_flip_abort(void *data)
 {
-    struct ms_crtc_pageflip *flip =3D data;
-    struct ms_flipdata *flipdata =3D flip->flipdata;
-
-    DebugPresent(("\t\tms:fa %lld c %d\n", (long long) flipdata->event->ev=
ent_id, flipdata->flip_count));
-
-    if (flipdata->flip_count =3D=3D 1)
-        free(flipdata->event);
+    struct ms_present_vblank_event *event =3D data;

-    ms_present_flip_free(flip);
+    free(event);
 }

 /*
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_DM5PR12MB1132187DDE5132521F18628FF7160DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p></p>
<div>In ms_pageflip_free() you cannot free the parent structure before free=
ing things it points to. &nbsp;That's undefined behaviour.&nbsp;</div>
<div><br>
</div>
<div>Tom</div>
<p></p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Qiang Yu &lt;Qiang.Yu@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, August 19, 2016 08:50<br>
<b>To:</b> xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org<br>
<b>Cc:</b> Yu, Qiang; michel-otUistvHUpPR7s880joybQ@public.gmane.org; emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx=
@lists.freedesktop.org<br>
<b>Subject:</b> [PATCH v2 xserver 3/5] modesetting: move common page flip h=
andle to pageflip.c</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">The common page flip handle framework can be share=
d with DRI2<br>
page flip.<br>
<br>
Signed-off-by: Qiang Yu &lt;Qiang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;hw/xfree86/drivers/modesetting/driver.h&nbsp;&nbsp; |&nbsp; 28 ------=
--<br>
&nbsp;hw/xfree86/drivers/modesetting/pageflip.c | 102 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;hw/xfree86/drivers/modesetting/present.c&nbsp; |&nbsp; 63 &#43;&#43;&=
#43;---------------<br>
&nbsp;3 files changed, 104 insertions(&#43;), 89 deletions(-)<br>
<br>
diff --git a/hw/xfree86/drivers/modesetting/driver.h b/hw/xfree86/drivers/m=
odesetting/driver.h<br>
index c0d80a8..38f0ec0 100644<br>
--- a/hw/xfree86/drivers/modesetting/driver.h<br>
&#43;&#43;&#43; b/hw/xfree86/drivers/modesetting/driver.h<br>
@@ -156,34 &#43;156,6 @@ Bool ms_present_screen_init(ScreenPtr screen);<br>
&nbsp;<br>
&nbsp;#ifdef GLAMOR<br>
&nbsp;<br>
-/*<br>
- * Event data for an in progress flip.<br>
- * This contains a pointer to the vblank event,<br>
- * and information about the flip in progress.<br>
- * a reference to this is stored in the per-crtc<br>
- * flips.<br>
- */<br>
-struct ms_flipdata {<br>
-&nbsp;&nbsp;&nbsp; ScreenPtr screen;<br>
-&nbsp;&nbsp;&nbsp; void *event;<br>
-&nbsp;&nbsp;&nbsp; /* number of CRTC events referencing this */<br>
-&nbsp;&nbsp;&nbsp; int flip_count;<br>
-&nbsp;&nbsp;&nbsp; uint64_t fe_msc;<br>
-&nbsp;&nbsp;&nbsp; uint64_t fe_usec;<br>
-&nbsp;&nbsp;&nbsp; uint32_t old_fb_id;<br>
-};<br>
-<br>
-/*<br>
- * Per crtc pageflipping infomation,<br>
- * These are submitted to the queuing code<br>
- * one of them per crtc per flip.<br>
- */<br>
-struct ms_crtc_pageflip {<br>
-&nbsp;&nbsp;&nbsp; Bool on_reference_crtc;<br>
-&nbsp;&nbsp;&nbsp; /* reference to the ms_flipdata */<br>
-&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata;<br>
-};<br>
-<br>
&nbsp;typedef void (*ms_pageflip_handler_proc)(uint64_t frame,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t usec,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *data);<br>
diff --git a/hw/xfree86/drivers/modesetting/pageflip.c b/hw/xfree86/drivers=
/modesetting/pageflip.c<br>
index 4549792..5f35999 100644<br>
--- a/hw/xfree86/drivers/modesetting/pageflip.c<br>
&#43;&#43;&#43; b/hw/xfree86/drivers/modesetting/pageflip.c<br>
@@ -32,6 &#43;32,97 @@<br>
&nbsp;#ifdef GLAMOR<br>
&nbsp;<br>
&nbsp;/*<br>
&#43; * Event data for an in progress flip.<br>
&#43; * This contains a pointer to the vblank event,<br>
&#43; * and information about the flip in progress.<br>
&#43; * a reference to this is stored in the per-crtc<br>
&#43; * flips.<br>
&#43; */<br>
&#43;struct ms_flipdata {<br>
&#43;&nbsp;&nbsp;&nbsp; ScreenPtr screen;<br>
&#43;&nbsp;&nbsp;&nbsp; void *event;<br>
&#43;&nbsp;&nbsp;&nbsp; ms_pageflip_handler_proc event_handler;<br>
&#43;&nbsp;&nbsp;&nbsp; ms_pageflip_abort_proc abort_handler;<br>
&#43;&nbsp;&nbsp;&nbsp; /* number of CRTC events referencing this */<br>
&#43;&nbsp;&nbsp;&nbsp; int flip_count;<br>
&#43;&nbsp;&nbsp;&nbsp; uint64_t fe_msc;<br>
&#43;&nbsp;&nbsp;&nbsp; uint64_t fe_usec;<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t old_fb_id;<br>
&#43;};<br>
&#43;<br>
&#43;/*<br>
&#43; * Per crtc pageflipping infomation,<br>
&#43; * These are submitted to the queuing code<br>
&#43; * one of them per crtc per flip.<br>
&#43; */<br>
&#43;struct ms_crtc_pageflip {<br>
&#43;&nbsp;&nbsp;&nbsp; Bool on_reference_crtc;<br>
&#43;&nbsp;&nbsp;&nbsp; /* reference to the ms_flipdata */<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata;<br>
&#43;};<br>
&#43;<br>
&#43;/**<br>
&#43; * Free an ms_crtc_pageflip.<br>
&#43; *<br>
&#43; * Drops the reference count on the flipdata.<br>
&#43; */<br>
&#43;static void<br>
&#43;ms_pageflip_free(struct ms_crtc_pageflip *flip)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; free(flip);<br>
&#43;&nbsp;&nbsp;&nbsp; if (--flipdata-&gt;flip_count &gt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp; free(flipdata);<br>
&#43;}<br>
&#43;<br>
&#43;/**<br>
&#43; * Callback for the DRM event queue when a single flip has completed<b=
r>
&#43; *<br>
&#43; * Once the flip has been completed on all pipes, notify the<br>
&#43; * extension code telling it when that happened<br>
&#43; */<br>
&#43;static void<br>
&#43;ms_pageflip_handler(uint64_t msc, uint64_t ust, void *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_crtc_pageflip *flip =3D data;<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;=
<br>
&#43;&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D flipdata-&gt;screen;<br>
&#43;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
&#43;&nbsp;&nbsp;&nbsp; modesettingPtr ms =3D modesettingPTR(scrn);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; if (flip-&gt;on_reference_crtc) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_msc =3D msc=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_usec =3D us=
t;<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; if (flipdata-&gt;flip_count =3D=3D 1) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;event_handler(=
flipdata-&gt;fe_msc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_usec,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;event);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeRmFB(ms-&gt;fd, flip=
data-&gt;old_fb_id);<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp; ms_pageflip_free(flip);<br>
&#43;}<br>
&#43;<br>
&#43;/*<br>
&#43; * Callback for the DRM queue abort code.&nbsp; A flip has been aborte=
d.<br>
&#43; */<br>
&#43;static void<br>
&#43;ms_pageflip_abort(void *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_crtc_pageflip *flip =3D data;<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; if (flipdata-&gt;flip_count =3D=3D 1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;abort_handler(=
flipdata-&gt;event);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; ms_pageflip_free(flip);<br>
&#43;}<br>
&#43;<br>
&#43;/*<br>
&nbsp; * Flush the DRM event queue when full; makes space for new events.<b=
r>
&nbsp; *<br>
&nbsp; * Returns a negative value on error, 0 if there was nothing to proce=
ss,<br>
@@ -68,9 &#43;159,7 @@ ms_flush_drm_events(ScreenPtr screen)<br>
&nbsp;static Bool<br>
&nbsp;queue_flip_on_crtc(ScreenPtr screen, xf86CrtcPtr crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ref_crtc_vblank_pipe, uint32_t flags=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms_pageflip_handler_proc pageflip_handle=
r,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms_pageflip_abort_proc pageflip_abort)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ref_crtc_vblank_pipe, uint32_t f=
lags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
&nbsp;&nbsp;&nbsp;&nbsp; modesettingPtr ms =3D modesettingPTR(scrn);<br>
@@ -92,7 &#43;181,7 @@ queue_flip_on_crtc(ScreenPtr screen, xf86CrtcPtr crt=
c,<br>
&nbsp;&nbsp;&nbsp;&nbsp; flip-&gt;on_reference_crtc =3D (drmmode_crtc-&gt;v=
blank_pipe =3D=3D ref_crtc_vblank_pipe);<br>
&nbsp;&nbsp;&nbsp;&nbsp; flip-&gt;flipdata =3D flipdata;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; seq =3D ms_drm_queue_alloc(crtc, flip, pageflip_handler=
, pageflip_abort);<br>
&#43;&nbsp;&nbsp;&nbsp; seq =3D ms_drm_queue_alloc(crtc, flip, ms_pageflip_=
handler, ms_pageflip_abort);<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!seq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(flip);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return FALSE;<br>
@@ -164,6 &#43;253,8 @@ ms_do_pageflip(ScreenPtr screen,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;event =3D event;<br>
&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;screen =3D screen;<br>
&#43;&nbsp;&nbsp;&nbsp; flipdata-&gt;event_handler =3D pageflip_handler;<br=
>
&#43;&nbsp;&nbsp;&nbsp; flipdata-&gt;abort_handler =3D pageflip_abort;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Take a local reference on flipdata.<br>
@@ -206,8 &#43;297,7 @@ ms_do_pageflip(ScreenPtr screen,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue_flip_on_crtc(sc=
reen, crtc, flipdata,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref_crtc_vblank_pipe,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, pageflip_handler,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pageflip_abort)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to error_undo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/hw/xfree86/drivers/modesetting/present.c b/hw/xfree86/drivers/=
modesetting/present.c<br>
index 18c82cd..deee1f1 100644<br>
--- a/hw/xfree86/drivers/modesetting/present.c<br>
&#43;&#43;&#43; b/hw/xfree86/drivers/modesetting/present.c<br>
@@ -192,77 &#43;192,30 @@ ms_present_flush(WindowPtr window)<br>
&nbsp;#ifdef GLAMOR<br>
&nbsp;<br>
&nbsp;/**<br>
- * Free an ms_crtc_pageflip.<br>
- *<br>
- * Drops the reference count on the flipdata.<br>
- */<br>
-static void<br>
-ms_present_flip_free(struct ms_crtc_pageflip *flip)<br>
-{<br>
-&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;<br>
-<br>
-&nbsp;&nbsp;&nbsp; free(flip);<br>
-&nbsp;&nbsp;&nbsp; if (--flipdata-&gt;flip_count &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp; free(flipdata);<br>
-}<br>
-<br>
-/**<br>
- * Callback for the DRM event queue when a single flip has completed<br>
- *<br>
- * Once the flip has been completed on all pipes, notify the<br>
&#43; * Callback for the flip has been completed on all pipes, notify the<b=
r>
&nbsp; * extension code telling it when that happened<br>
&nbsp; */<br>
&nbsp;static void<br>
&nbsp;ms_present_flip_handler(uint64_t msc, uint64_t ust, void *data)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; struct ms_crtc_pageflip *flip =3D data;<br>
-&nbsp;&nbsp;&nbsp; ScreenPtr screen =3D flip-&gt;flipdata-&gt;screen;<br>
-&nbsp;&nbsp;&nbsp; ScrnInfoPtr scrn =3D xf86ScreenToScrn(screen);<br>
-&nbsp;&nbsp;&nbsp; modesettingPtr ms =3D modesettingPTR(scrn);<br>
-&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_present_vblank_event *event =3D data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; DebugPresent((&quot;\t\tms:fh %lld c %d msc %llu ust %l=
lu\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long) flipdata-&gt;event-&gt;event_id,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;flip_count,<br>
&#43;&nbsp;&nbsp;&nbsp; DebugPresent((&quot;\t\tms:fc %lld msc %llu ust %ll=
u\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long) event-&gt;event_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long) msc, (long long) ust));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; if (flip-&gt;on_reference_crtc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_msc =3D msc;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_usec =3D ust;<b=
r>
-&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (flipdata-&gt;flip_count =3D=3D 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DebugPresent((&quot;\t\tms:fc %=
lld c %d msc %llu ust %llu\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long) flipdata-&=
gt;event-&gt;event_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;flip_coun=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (long long) flipdata-&=
gt;fe_msc, (long long) flipdata-&gt;fe_usec));<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ms_present_vblank_handler(flipd=
ata-&gt;fe_msc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;fe_usec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flipdata-&gt;event);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmModeRmFB(ms-&gt;fd, flipdata=
-&gt;old_fb_id);<br>
-&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp; ms_present_flip_free(flip);<br>
&#43;&nbsp;&nbsp;&nbsp; ms_present_vblank_handler(msc, ust, event);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
- * Callback for the DRM queue abort code.&nbsp; A flip has been aborted.<b=
r>
&#43; * Callback for the flip has been aborted.<br>
&nbsp; */<br>
&nbsp;static void<br>
&nbsp;ms_present_flip_abort(void *data)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; struct ms_crtc_pageflip *flip =3D data;<br>
-&nbsp;&nbsp;&nbsp; struct ms_flipdata *flipdata =3D flip-&gt;flipdata;<br>
-<br>
-&nbsp;&nbsp;&nbsp; DebugPresent((&quot;\t\tms:fa %lld c %d\n&quot;, (long =
long) flipdata-&gt;event-&gt;event_id, flipdata-&gt;flip_count));<br>
-<br>
-&nbsp;&nbsp;&nbsp; if (flipdata-&gt;flip_count =3D=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(flipdata-&gt;event);<br>
&#43;&nbsp;&nbsp;&nbsp; struct ms_present_vblank_event *event =3D data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; ms_present_flip_free(flip);<br>
&#43;&nbsp;&nbsp;&nbsp; free(event);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk437166">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14716061893940.8420357393682676" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14716061893930.7108288203263247" cellspacing=3D"0"=
 style=3D"width: 90%; position: relative; overflow: auto; padding-top: 20px=
; padding-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 2=
00, 200); border-bottom: 1px dotted rgb(200, 200, 200); background-color: r=
gb(255, 255, 255);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14716061893930.9899862651724711" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14716061893930.47806653578636316"></div=
>
<div id=3D"LPTitle_14716061893930.16493228848820385" style=3D"top: 0px; col=
or: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_14716061893930.6212120889357053" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14716061893930.2849713450368425" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14716061893940.8733822341303554" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
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

--_000_DM5PR12MB1132187DDE5132521F18628FF7160DM5PR12MB1132namp_--

--===============0840126382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0840126382==--
