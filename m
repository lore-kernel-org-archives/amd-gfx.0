From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 15/35] drm/amd/display: make vline_config parameter const.
Date: Sun, 3 Feb 2019 18:49:21 +0100
Message-ID: <CA+nq7DtCqojJynhoxwyPnUGXf4gPzkrypi7dUT_ahQ9DDygqKQ@mail.gmail.com>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-16-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0673702304=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190201152847.11151-16-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0673702304==
Content-Type: multipart/alternative; boundary="000000000000ade68b058100ffc1"

--000000000000ade68b058100ffc1
Content-Type: text/plain; charset="UTF-8"

Hi,

It seems the commit title is a little confusing. The change is to now pass
by (const) reference rather than by value.

Regards
Nils

Den fre 1 feb. 2019 16:29 skrev Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org
>:

> From: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>
>
> Change-Id: Icfe018c7579ad2b3ef65195f578b8e44422d53f3
> Signed-off-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Aric Cyr <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c                 | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c        | 8 ++++----
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h        | 2 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index e0ac009f00ab..d8579b207300 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1560,11 +1560,11 @@ static void commit_planes_do_stream_update(struct
> dc *dc,
>
>                         if (stream_update->vline0_config &&
> pipe_ctx->stream_res.tg->funcs->program_vline_interrupt)
>
> pipe_ctx->stream_res.tg->funcs->program_vline_interrupt(
> -                                       pipe_ctx->stream_res.tg, VLINE0,
> stream->vline0_config);
> +                                       pipe_ctx->stream_res.tg, VLINE0,
> &stream->vline0_config);
>
>                         if (stream_update->vline1_config &&
> pipe_ctx->stream_res.tg->funcs->program_vline_interrupt)
>
> pipe_ctx->stream_res.tg->funcs->program_vline_interrupt(
> -                                       pipe_ctx->stream_res.tg, VLINE1,
> stream->vline1_config);
> +                                       pipe_ctx->stream_res.tg, VLINE1,
> &stream->vline1_config);
>
>                         if ((stream_update->hdr_static_metadata &&
> !stream->use_dynamic_meta) ||
>                                         stream_update->vrr_infopacket ||
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> index 1d4f9b48ed7d..cefa322df8a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> @@ -95,19 +95,19 @@ static void optc1_disable_stereo(struct
> timing_generator *optc)
>  void optc1_program_vline_interrupt(
>                 struct timing_generator *optc,
>                 enum vline_select vline,
> -               struct vline_config vline_config)
> +               const struct vline_config *vline_config)
>  {
>         struct optc *optc1 = DCN10TG_FROM_TG(optc);
>
>         switch (vline) {
>         case VLINE0:
>                 REG_SET_2(OTG_VERTICAL_INTERRUPT0_POSITION, 0,
> -                               OTG_VERTICAL_INTERRUPT0_LINE_START,
> vline_config.start_line,
> -                               OTG_VERTICAL_INTERRUPT0_LINE_END,
> vline_config.end_line);
> +                               OTG_VERTICAL_INTERRUPT0_LINE_START,
> vline_config->start_line,
> +                               OTG_VERTICAL_INTERRUPT0_LINE_END,
> vline_config->end_line);
>                 break;
>         case VLINE1:
>                 REG_SET(OTG_VERTICAL_INTERRUPT1_POSITION, 0,
> -
>  OTG_VERTICAL_INTERRUPT1_LINE_START, vline_config.start_line);
> +
>  OTG_VERTICAL_INTERRUPT1_LINE_START, vline_config->start_line);
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
> b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
> index 8eb71c0160a7..b34c8a240598 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
> @@ -485,7 +485,7 @@ void optc1_program_timing(
>
>  void optc1_program_vline_interrupt(struct timing_generator *optc,
>                 enum vline_select vline,
> -               struct vline_config vline_config);
> +               const struct vline_config *vline_config);
>
>  void optc1_program_global_sync(
>                 struct timing_generator *optc);
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> index df64cf73ceb9..d22a406c19c0 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
> @@ -151,7 +151,7 @@ struct timing_generator_funcs {
>                                                         bool use_vbios);
>         void (*program_vline_interrupt)(struct timing_generator *optc,
>                         enum vline_select vline,
> -                       struct vline_config vline_config);
> +                       const struct vline_config *vline_config);
>         bool (*enable_crtc)(struct timing_generator *tg);
>         bool (*disable_crtc)(struct timing_generator *tg);
>         bool (*is_counter_moving)(struct timing_generator *tg);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000ade68b058100ffc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">It seems=
 the commit title is a little confusing. The change is to now pass by (cons=
t) reference rather than by value.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Regards</div><div dir=3D"auto">Nils</div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr">Den fre 1 feb. 2019 16:29 skrev Bhawanpreet =
Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">Bhawanpreet.Lakha@am=
d.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Yongqiang Sun =
&lt;<a href=3D"mailto:yongqiang.sun-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noref=
errer">yongqiang.sun-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Change-Id: Icfe018c7579ad2b3ef65195f578b8e44422d53f3<br>
Signed-off-by: Yongqiang Sun &lt;<a href=3D"mailto:yongqiang.sun-5C7GfCeVMHo@public.gmane.org" t=
arget=3D"_blank" rel=3D"noreferrer">yongqiang.sun-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Aric Cyr &lt;<a href=3D"mailto:Aric.Cyr-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank" rel=3D"noreferrer">Aric.Cyr-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org=
" target=3D"_blank" rel=3D"noreferrer">Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org</a>&gt;<br=
>
---<br>
=C2=A0drivers/gpu/drm/amd/display/dc/core/dc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 8 ++++----<br>
=C2=A0drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 2 +-<br>
=C2=A0drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-<br>
=C2=A04 files changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd=
/display/dc/core/dc.c<br>
index e0ac009f00ab..d8579b207300 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
@@ -1560,11 +1560,11 @@ static void commit_planes_do_stream_update(struct d=
c *dc,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (stream_update-&gt;vline0_config &amp;&amp; pipe_ctx-&gt;stre=
am_res.tg-&gt;funcs-&gt;program_vline_interrupt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pipe_ctx-&gt;stream_res.tg-&gt;funcs=
-&gt;program_vline_interrupt(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-=
&gt;<a href=3D"http://stream_res.tg" rel=3D"noreferrer noreferrer" target=
=3D"_blank">stream_res.tg</a>, VLINE0, stream-&gt;vline0_config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-=
&gt;<a href=3D"http://stream_res.tg" rel=3D"noreferrer noreferrer" target=
=3D"_blank">stream_res.tg</a>, VLINE0, &amp;stream-&gt;vline0_config);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (stream_update-&gt;vline1_config &amp;&amp; pipe_ctx-&gt;stre=
am_res.tg-&gt;funcs-&gt;program_vline_interrupt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pipe_ctx-&gt;stream_res.tg-&gt;funcs=
-&gt;program_vline_interrupt(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-=
&gt;<a href=3D"http://stream_res.tg" rel=3D"noreferrer noreferrer" target=
=3D"_blank">stream_res.tg</a>, VLINE1, stream-&gt;vline1_config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pipe_ctx-=
&gt;<a href=3D"http://stream_res.tg" rel=3D"noreferrer noreferrer" target=
=3D"_blank">stream_res.tg</a>, VLINE1, &amp;stream-&gt;vline1_config);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if ((stream_update-&gt;hdr_static_metadata &amp;&amp; !stream-&g=
t;use_dynamic_meta) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stream_u=
pdate-&gt;vrr_infopacket ||<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
index 1d4f9b48ed7d..cefa322df8a6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c<br>
@@ -95,19 +95,19 @@ static void optc1_disable_stereo(struct timing_generato=
r *optc)<br>
=C2=A0void optc1_program_vline_interrupt(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timing_gener=
ator *optc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum vline_select v=
line,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vline_config=
 vline_config)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vline_=
config *vline_config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct optc *optc1 =3D DCN10TG_FROM_TG(optc);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (vline) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VLINE0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 REG_SET_2(OTG_VERTI=
CAL_INTERRUPT0_POSITION, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTICAL_INTERRUPT0_LINE_START, v=
line_config.start_line,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTICAL_INTERRUPT0_LINE_END, vli=
ne_config.end_line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTICAL_INTERRUPT0_LINE_START, v=
line_config-&gt;start_line,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTICAL_INTERRUPT0_LINE_END, vli=
ne_config-&gt;end_line);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VLINE1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 REG_SET(OTG_VERTICA=
L_INTERRUPT1_POSITION, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTI=
CAL_INTERRUPT1_LINE_START, vline_config.start_line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OTG_VERTI=
CAL_INTERRUPT1_LINE_START, vline_config-&gt;start_line);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gp=
u/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
index 8eb71c0160a7..b34c8a240598 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h<br>
@@ -485,7 +485,7 @@ void optc1_program_timing(<br>
<br>
=C2=A0void optc1_program_vline_interrupt(struct timing_generator *optc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum vline_select v=
line,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vline_config=
 vline_config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vline_=
config *vline_config);<br>
<br>
=C2=A0void optc1_program_global_sync(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timing_gener=
ator *optc);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/dri=
vers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<br>
index df64cf73ceb9..d22a406c19c0 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h<br>
@@ -151,7 +151,7 @@ struct timing_generator_funcs {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool use_vbios);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void (*program_vline_interrupt)(struct timing_g=
enerator *optc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 enum vline_select vline,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vline_config vline_config);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct vline_config *vline_config);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool (*enable_crtc)(struct timing_generator *tg=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool (*disable_crtc)(struct timing_generator *t=
g);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool (*is_counter_moving)(struct timing_generat=
or *tg);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000ade68b058100ffc1--

--===============0673702304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0673702304==--
