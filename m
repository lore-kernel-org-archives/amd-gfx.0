From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 2/2] dri2: Call drm_queue_handle_deferred
 in dri2_deferred_event
Date: Fri, 1 Mar 2019 20:40:38 +0000
Message-ID: <BN6PR12MB1809DD3A7F44450038E9385CF7760@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190301173550.21762-1-michel@daenzer.net>,
 <20190301173550.21762-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1252286494=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190301173550.21762-2-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1252286494==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DD3A7F44450038E9385CF7760BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DD3A7F44450038E9385CF7760BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, March 1, 2019 12:35 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 2/2] dri2: Call drm_queue_handle_deferred in=
 dri2_deferred_event

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

drm_queue_handler just puts the event on the signalled list; without
calling drm_queue_handle_deferred, actual processing of the event may be
delayed indefinitely, e.g. until another event arrives from the kernel.

This could result in DRI2 clients hanging during DPMS off.

Fixes: ba83a866af5a "Add radeon_drm_handle_event wrapper for
                     drmHandleEvent"
(Ported from amdgpu commit 09be74a3d1dd9604336d9a27f98d132b262dcbaf)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/radeon_dri2.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c
index b5d6835c9..a9f14e8d8 100644
--- a/src/radeon_dri2.c
+++ b/src/radeon_dri2.c
@@ -979,12 +979,18 @@ CARD32 radeon_dri2_deferred_event(OsTimerPtr timer, C=
ARD32 now, pointer data)
     if (ret) {
         xf86DrvMsg(scrn->scrnIndex, X_ERROR,
                    "%s cannot get current time\n", __func__);
-       if (event_info->drm_queue_seq)
+
+       if (event_info->drm_queue_seq) {
             drmmode_crtc->drmmode->event_context.
                 vblank_handler(pRADEONEnt->fd, 0, 0, 0,
                                (void*)event_info->drm_queue_seq);
-       else
+           drmmode_crtc->wait_flip_nesting_level++;
+           radeon_drm_queue_handle_deferred(crtc);
+
+       } else {
             radeon_dri2_frame_event_handler(crtc, 0, 0, data);
+       }
+
         return 0;
     }
     /*
@@ -995,13 +1001,18 @@ CARD32 radeon_dri2_deferred_event(OsTimerPtr timer, =
CARD32 now, pointer data)
     delta_seq =3D delta_t * drmmode_crtc->dpms_last_fps;
     delta_seq /=3D 1000000;
     frame =3D (CARD64)drmmode_crtc->dpms_last_seq + delta_seq;
-    if (event_info->drm_queue_seq)
+
+    if (event_info->drm_queue_seq) {
         drmmode_crtc->drmmode->event_context.
             vblank_handler(pRADEONEnt->fd, frame, drm_now / 1000000,
                            drm_now % 1000000,
                            (void*)event_info->drm_queue_seq);
-    else
+       drmmode_crtc->wait_flip_nesting_level++;
+       radeon_drm_queue_handle_deferred(crtc);
+    } else {
         radeon_dri2_frame_event_handler(crtc, frame, drm_now, data);
+    }
+
     return 0;
 }

--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DD3A7F44450038E9385CF7760BN6PR12MB1809namp_
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
<b>Sent:</b> Friday, March 1, 2019 12:35 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 2/2] dri2: Call drm_queue_handle_defe=
rred in dri2_deferred_event</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
drm_queue_handler just puts the event on the signalled list; without<br>
calling drm_queue_handle_deferred, actual processing of the event may be<br=
>
delayed indefinitely, e.g. until another event arrives from the kernel.<br>
<br>
This could result in DRI2 clients hanging during DPMS off.<br>
<br>
Fixes: ba83a866af5a &quot;Add radeon_drm_handle_event wrapper for<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmHandleEvent&quot;<br>
(Ported from amdgpu commit 09be74a3d1dd9604336d9a27f98d132b262dcbaf)<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/radeon_dri2.c | 19 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;1 file changed, 15 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/src/radeon_dri2.c b/src/radeon_dri2.c<br>
index b5d6835c9..a9f14e8d8 100644<br>
--- a/src/radeon_dri2.c<br>
&#43;&#43;&#43; b/src/radeon_dri2.c<br>
@@ -979,12 &#43;979,18 @@ CARD32 radeon_dri2_deferred_event(OsTimerPtr time=
r, CARD32 now, pointer data)<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(scrn-&gt;scrnIn=
dex, X_ERROR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%s cannot get current time\n&=
quot;, __func__);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (event_info-&gt;drm_queue_seq)<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (event_info-&gt;drm_queue_seq)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
mmode_crtc-&gt;drmmode-&gt;event_context.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vblank_handler(pRADEONEnt-&gt;fd, 0, 0, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void*)event_info-&gt;drm_queue_seq);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_c=
rtc-&gt;wait_flip_nesting_level&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_dr=
m_queue_handle_deferred(crtc);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra=
deon_dri2_frame_event_handler(crtc, 0, 0, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -995,13 &#43;1001,18 @@ CARD32 radeon_dri2_deferred_event(OsTimerPtr tim=
er, CARD32 now, pointer data)<br>
&nbsp;&nbsp;&nbsp;&nbsp; delta_seq =3D delta_t * drmmode_crtc-&gt;dpms_last=
_fps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; delta_seq /=3D 1000000;<br>
&nbsp;&nbsp;&nbsp;&nbsp; frame =3D (CARD64)drmmode_crtc-&gt;dpms_last_seq &=
#43; delta_seq;<br>
-&nbsp;&nbsp;&nbsp; if (event_info-&gt;drm_queue_seq)<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; if (event_info-&gt;drm_queue_seq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_crtc-&gt;drmmode-&=
gt;event_context.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vb=
lank_handler(pRADEONEnt-&gt;fd, frame, drm_now / 1000000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; drm_now % 1000000,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (void*)event_info-&gt;drm_queue_seq);<br>
-&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode_crtc-&gt;wait_flip_nestin=
g_level&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_drm_queue_handle_deferred(=
crtc);<br>
&#43;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radeon_dri2_frame_event_ha=
ndler(crtc, frame, drm_now, data);<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
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

--_000_BN6PR12MB1809DD3A7F44450038E9385CF7760BN6PR12MB1809namp_--

--===============1252286494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1252286494==--
