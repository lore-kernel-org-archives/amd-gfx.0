From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH 15/35] drm/amd/display: pass vline_config parameter by
 reference.
Date: Mon, 4 Feb 2019 15:49:26 +0000
Message-ID: <MW2PR12MB25880F89B37A74AC675ACF1AF96D0@MW2PR12MB2588.namprd12.prod.outlook.com>
References: <CA+nq7DtCqojJynhoxwyPnUGXf4gPzkrypi7dUT_ahQ9DDygqKQ@mail.gmail.com>,
 <20190204154522.22215-15-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1576153153=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190204154522.22215-15-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Sun, Yongqiang" <Yongqiang.Sun-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1576153153==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB25880F89B37A74AC675ACF1AF96D0MW2PR12MB2588namp_"

--_000_MW2PR12MB25880F89B37A74AC675ACF1AF96D0MW2PR12MB2588namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Bhawanpr=
eet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Sent: February 4, 2019 10:45 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Sun, Yongqiang
Subject: [PATCH 15/35] drm/amd/display: pass vline_config parameter by refe=
rence.

From: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>

Change-Id: Icfe018c7579ad2b3ef65195f578b8e44422d53f3
Signed-off-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Aric Cyr <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                 | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c        | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h        | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c
index e0ac009f00ab..d8579b207300 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1560,11 +1560,11 @@ static void commit_planes_do_stream_update(struct d=
c *dc,

                         if (stream_update->vline0_config && pipe_ctx->stre=
am_res.tg->funcs->program_vline_interrupt)
                                 pipe_ctx->stream_res.tg->funcs->program_vl=
ine_interrupt(
-                                       pipe_ctx->stream_res.tg, VLINE0, st=
ream->vline0_config);
+                                       pipe_ctx->stream_res.tg, VLINE0, &s=
tream->vline0_config);

                         if (stream_update->vline1_config && pipe_ctx->stre=
am_res.tg->funcs->program_vline_interrupt)
                                 pipe_ctx->stream_res.tg->funcs->program_vl=
ine_interrupt(
-                                       pipe_ctx->stream_res.tg, VLINE1, st=
ream->vline1_config);
+                                       pipe_ctx->stream_res.tg, VLINE1, &s=
tream->vline1_config);

                         if ((stream_update->hdr_static_metadata && !stream=
->use_dynamic_meta) ||
                                         stream_update->vrr_infopacket ||
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.c
index 1d4f9b48ed7d..cefa322df8a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -95,19 +95,19 @@ static void optc1_disable_stereo(struct timing_generato=
r *optc)
 void optc1_program_vline_interrupt(
                 struct timing_generator *optc,
                 enum vline_select vline,
-               struct vline_config vline_config)
+               const struct vline_config *vline_config)
 {
         struct optc *optc1 =3D DCN10TG_FROM_TG(optc);

         switch (vline) {
         case VLINE0:
                 REG_SET_2(OTG_VERTICAL_INTERRUPT0_POSITION, 0,
-                               OTG_VERTICAL_INTERRUPT0_LINE_START, vline_c=
onfig.start_line,
-                               OTG_VERTICAL_INTERRUPT0_LINE_END, vline_con=
fig.end_line);
+                               OTG_VERTICAL_INTERRUPT0_LINE_START, vline_c=
onfig->start_line,
+                               OTG_VERTICAL_INTERRUPT0_LINE_END, vline_con=
fig->end_line);
                 break;
         case VLINE1:
                 REG_SET(OTG_VERTICAL_INTERRUPT1_POSITION, 0,
-                                       OTG_VERTICAL_INTERRUPT1_LINE_START,=
 vline_config.start_line);
+                                       OTG_VERTICAL_INTERRUPT1_LINE_START,=
 vline_config->start_line);
                 break;
         default:
                 break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.h
index 8eb71c0160a7..b34c8a240598 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -485,7 +485,7 @@ void optc1_program_timing(

 void optc1_program_vline_interrupt(struct timing_generator *optc,
                 enum vline_select vline,
-               struct vline_config vline_config);
+               const struct vline_config *vline_config);

 void optc1_program_global_sync(
                 struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/dri=
vers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index df64cf73ceb9..d22a406c19c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -151,7 +151,7 @@ struct timing_generator_funcs {
                                                         bool use_vbios);
         void (*program_vline_interrupt)(struct timing_generator *optc,
                         enum vline_select vline,
-                       struct vline_config vline_config);
+                       const struct vline_config *vline_config);
         bool (*enable_crtc)(struct timing_generator *tg);
         bool (*disable_crtc)(struct timing_generator *tg);
         bool (*is_counter_moving)(struct timing_generator *tg);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_MW2PR12MB25880F89B37A74AC675ACF1AF96D0MW2PR12MB2588namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(185, 185, 185);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Bhawanpreet Lakha &lt;Bhawa=
npreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> February 4, 2019 10:45 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Sun, Yongqiang<br>
<b>Subject:</b> [PATCH 15/35] drm/amd/display: pass vline_config parameter =
by reference.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Yongqiang Sun &lt;yongqiang.sun-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
<br>
Change-Id: Icfe018c7579ad2b3ef65195f578b8e44422d53f3<br>
Signed-off-by: Yongqiang Sun &lt;yongqiang.sun-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Aric Cyr &lt;Aric.Cyr-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 8 &#43;&#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 &#43;-<b=
r>
&nbsp;4 files changed, 8 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index e0ac009f00ab..d8579b207300 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -1560,11 &#43;1560,11 @@ static void commit_planes_do_stream_update(stru=
ct dc *dc,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s=
tream_update-&gt;vline0_config &amp;&amp; pipe_ctx-&gt;stream_res.tg-&gt;fu=
ncs-&gt;program_vline_interrupt)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.tg-&gt;f=
uncs-&gt;program_vline_interrupt(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pipe_ctx-&gt;stream_res.tg, VLINE0, stream-&gt;vline0_config);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pipe_ctx-&gt;stream_res.tg, VLINE0, &amp;stream-&gt;vline0_config)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s=
tream_update-&gt;vline1_config &amp;&amp; pipe_ctx-&gt;stream_res.tg-&gt;fu=
ncs-&gt;program_vline_interrupt)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream_res.tg-&gt;f=
uncs-&gt;program_vline_interrupt(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pipe_ctx-&gt;stream_res.tg, VLINE1, stream-&gt;vline1_config);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; pipe_ctx-&gt;stream_res.tg, VLINE1, &amp;stream-&gt;vline1_config)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((=
stream_update-&gt;hdr_static_metadata &amp;&amp; !stream-&gt;use_dynamic_me=
ta) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; stream_update-&gt;vrr_infopacket ||<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
index 1d4f9b48ed7d..cefa322df8a6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
@@ -95,19 &#43;95,19 @@ static void optc1_disable_stereo(struct timing_gene=
rator *optc)<br>
&nbsp;void optc1_program_vline_interrupt(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct timing_generator *optc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum vline_select vline,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct vline_config vline_config)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const struct vline_config *vline_config)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct optc *optc1 =3D DCN=
10TG_FROM_TG(optc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (vline) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VLINE0:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; REG_SET_2(OTG_VERTICAL_INTERRUPT0_POSITION, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICAL_INTERRUPT0_LINE_START, vline_c=
onfig.start_line,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICAL_INTERRUPT0_LINE_END, vline_con=
fig.end_line);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICAL_INTERRUPT0_LINE_START, vli=
ne_config-&gt;start_line,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OTG_VERTICAL_INTERRUPT0_LINE_END, vline=
_config-&gt;end_line);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VLINE1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; REG_SET(OTG_VERTICAL_INTERRUPT1_POSITION, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; OTG_VERTICAL_INTERRUPT1_LINE_START, vline_config.start_line);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; OTG_VERTICAL_INTERRUPT1_LINE_START, vline_config-&gt;start_line);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
index 8eb71c0160a7..b34c8a240598 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
@@ -485,7 &#43;485,7 @@ void optc1_program_timing(<br>
&nbsp;<br>
&nbsp;void optc1_program_vline_interrupt(struct timing_generator *optc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum vline_select vline,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct vline_config vline_config);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const struct vline_config *vline_config);<br>
&nbsp;<br>
&nbsp;void optc1_program_global_sync(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct timing_generator *optc);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/dri=
vers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<br>
index df64cf73ceb9..d22a406c19c0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<=
br>
@@ -151,7 &#43;151,7 @@ struct timing_generator_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_vbios);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*program_vline_inter=
rupt)(struct timing_generator *optc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
vline_select vline,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vline_con=
fig vline_config);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct=
 vline_config *vline_config);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*enable_crtc)(struct=
 timing_generator *tg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*disable_crtc)(struc=
t timing_generator *tg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*is_counter_moving)(=
struct timing_generator *tg);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk545101" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15492952949000.33470954385925944" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15492952948980.28840650540887725" style=3D"width: =
90%; background-color: rgb(37, 37, 37); position: relative; overflow: auto;=
 padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1px=
 dotted rgb(64, 64, 64); border-bottom: 1px dotted rgb(64, 64, 64);" role=
=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15492952948990.18264087239542548" style=3D"vertical-alig=
n: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15492952948990.025164069854981763"></di=
v>
<div id=3D"LPTitle_15492952948990.15713982790708425" style=3D"top: 0px; col=
or: rgb(46, 162, 255); font-weight: 400; font-size: 21px; font-family: &quo=
t;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light=
&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-ser=
if; line-height: 21px;">
<a id=3D"LPUrlAnchor_15492952948990.6137017105389825" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15492952948990.2929248586278588" style=3D"margin: 10p=
x 0px 16px; color: rgb(185, 185, 185); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15492952949000.8198784761872338" style=3D"display:=
 block; color: rgb(185, 185, 185); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MW2PR12MB25880F89B37A74AC675ACF1AF96D0MW2PR12MB2588namp_--

--===============1576153153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1576153153==--
