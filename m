From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Implement
 dm_pp_get_clock_levels_by_type_with_latency
Date: Mon, 28 May 2018 01:46:15 +0000
Message-ID: <DM5PR1201MB2489A23BE7366B2C86681C16E46E0@DM5PR1201MB2489.namprd12.prod.outlook.com>
References: <20180523175157.22210-1-harry.wentland@amd.com>,
 <CADnq5_P1gntWz1+x0tePmnsF0oA5AdsHPbYNvn9mzyA+ad4bKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0437540021=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P1gntWz1+x0tePmnsF0oA5AdsHPbYNvn9mzyA+ad4bKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Lipski,
 Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0437540021==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB2489A23BE7366B2C86681C16E46E0DM5PR1201MB2489_"

--_000_DM5PR1201MB2489A23BE7366B2C86681C16E46E0DM5PR1201MB2489_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> +               /* translate 10kHz to kHz */
> +               clk_level_info->data[i].clocks_in_khz =3D pp_clks->data[i=
].clocks_in_khz;
> +               clk_level_info->data[i].latency_in_us =3D pp_clks->data[i=
].clocks_in_khz;

This seems a typo(latency_in_us =3D clocks_in_khz ?).

And the comment does not meet the code. If it translates 10kHz to kHz, why =
there is no "*10"?
> +       }


Regards,

Evan

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, May 24, 2018 12:35:52 PM
To: Wentland, Harry
Cc: Cheng, Tony; Lipski, Mikita; Zhu, Rex; Wu, Hersen; amd-gfx list
Subject: Re: [PATCH] drm/amd/display: Implement dm_pp_get_clock_levels_by_t=
ype_with_latency

On Wed, May 23, 2018 at 1:51 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> wr=
ote:
> This is required so we use the correct minimum clocks for Vega. Without
> this pplib will never be able to enter the lowest clock states.
>
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../display/amdgpu_dm/amdgpu_dm_services.c    | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> index 0229c7edb8ad..30ddd329104d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> @@ -234,6 +234,34 @@ static void pp_to_dc_clock_levels(
>         }
>  }
>
> +static void pp_to_dc_clock_levels_with_latency(
> +               const struct pp_clock_levels_with_latency *pp_clks,
> +               struct dm_pp_clock_levels_with_latency *clk_level_info,
> +               enum dm_pp_clock_type dc_clk_type)
> +{
> +       uint32_t i;
> +
> +       if (pp_clks->num_levels > DM_PP_MAX_CLOCK_LEVELS) {
> +               DRM_INFO("DM_PPLIB: Warning: %s clock: number of levels %=
d exceeds maximum of %d!\n",
> +                               DC_DECODE_PP_CLOCK_TYPE(dc_clk_type),
> +                               pp_clks->num_levels,
> +                               DM_PP_MAX_CLOCK_LEVELS);
> +
> +               clk_level_info->num_levels =3D DM_PP_MAX_CLOCK_LEVELS;
> +       } else
> +               clk_level_info->num_levels =3D pp_clks->num_levels;
> +
> +       DRM_INFO("DM_PPLIB: values for %s clock\n",
> +                       DC_DECODE_PP_CLOCK_TYPE(dc_clk_type));
> +
> +       for (i =3D 0; i < clk_level_info->num_levels; i++) {
> +               DRM_INFO("DM_PPLIB:\t %d\n", pp_clks->data[i].clocks_in_k=
hz);

leftover debugging output?  Maybe make that DRM_DEBUG?  With that addressed=
:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Alex

> +               /* translate 10kHz to kHz */
> +               clk_level_info->data[i].clocks_in_khz =3D pp_clks->data[i=
].clocks_in_khz;
> +               clk_level_info->data[i].latency_in_us =3D pp_clks->data[i=
].clocks_in_khz;
> +       }
> +}
> +
>  bool dm_pp_get_clock_levels_by_type(
>                 const struct dc_context *ctx,
>                 enum dm_pp_clock_type clk_type,
> @@ -311,8 +339,22 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
>         enum dm_pp_clock_type clk_type,
>         struct dm_pp_clock_levels_with_latency *clk_level_info)
>  {
> -       /* TODO: to be implemented */
> -       return false;
> +       struct amdgpu_device *adev =3D ctx->driver_context;
> +       void *pp_handle =3D adev->powerplay.pp_handle;
> +       struct pp_clock_levels_with_latency pp_clks =3D { 0 };
> +       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +
> +       if (!pp_funcs->get_clock_by_type_with_latency)
> +               return false;
> +
> +       if (pp_funcs->get_clock_by_type_with_latency(pp_handle,
> +                                                    dc_to_pp_clock_type(=
clk_type),
> +                                                    &pp_clks))
> +               return false;
> +
> +       pp_to_dc_clock_levels_with_latency(&pp_clks, clk_level_info, clk_=
type);
> +
> +       return true;
>  }
>
>  bool dm_pp_get_clock_levels_by_type_with_voltage(
> --
> 2.17.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR1201MB2489A23BE7366B2C86681C16E46E0DM5PR1201MB2489_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /* translate 10kHz to kHz */</span><br style=3D"color:=
 rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &q=
uot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size:=
 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;da=
ta[i].clocks_in_khz =3D pp_clks-&gt;data[i].clocks_in_khz;</span><br style=
=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI=
&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; =
font-size: 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;da=
ta[i].latency_in_us =3D pp_clks-&gt;data[i].clocks_in_khz;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
></span>This seems a typo(latency_in_us =3D clocks_in_khz
 ?).</p>
<p style=3D"margin-top:0;margin-bottom:0">And the comment does not meet the=
 code. If it&nbsp;<span style=3D"color: rgb(33, 33, 33); font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif, serif, EmojiFont; font-size: 14.6667px;">translates
 10kHz to kHz, why there is no &quot;*10&quot;?</span><br style=3D"">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }</span><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Regards,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><font color=3D"#212121" face=3D"w=
f_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, Em=
ojiFont"><span style=3D"font-size: 14.6667px;">Evan</span></font></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 24, 2018 12:35:52 PM<br>
<b>To:</b> Wentland, Harry<br>
<b>Cc:</b> Cheng, Tony; Lipski, Mikita; Zhu, Rex; Wu, Hersen; amd-gfx list<=
br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Implement dm_pp_get_clock_leve=
ls_by_type_with_latency</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, May 23, 2018 at 1:51 PM, Harry Wentland &l=
t;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; This is required so we use the correct minimum clocks for Vega. Withou=
t<br>
&gt; this pplib will never be able to enter the lowest clock states.<br>
&gt;<br>
&gt; Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../display/amdgpu_dm/amdgpu_dm_services.c&nbsp;&nbsp;&nbsp; | 4=
6 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;-<br>
&gt;&nbsp; 1 file changed, 44 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&gt; index 0229c7edb8ad..30ddd329104d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_serv=
ices.c<br>
&gt; @@ -234,6 &#43;234,34 @@ static void pp_to_dc_clock_levels(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static void pp_to_dc_clock_levels_with_latency(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const struct pp_clock_levels_with_latency *pp_clks,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dm_pp_clock_levels_with_latency *clk_level_info,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; enum dm_pp_clock_type dc_clk_type)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_clks-&gt;num_levels &=
gt; DM_PP_MAX_CLOCK_LEVELS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DM_PPLIB: Warning: %s clock: number of l=
evels %d exceeds maximum of %d!\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DECODE_PP_CLOCK_TYPE(dc_clk_typ=
e),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_clks-&gt;num_levels,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DM_PP_MAX_CLOCK_LEVELS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;num_levels =3D DM_PP_MAX_CLOCK_LEVEL=
S;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;num_levels =3D pp_clks-&gt;num_level=
s;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DM_PPLIB: val=
ues for %s clock\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DECO=
DE_PP_CLOCK_TYPE(dc_clk_type));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clk_lev=
el_info-&gt;num_levels; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DM_PPLIB:\t %d\n&quot;, pp_clks-&gt;data=
[i].clocks_in_khz);<br>
<br>
leftover debugging output?&nbsp; Maybe make that DRM_DEBUG?&nbsp; With that=
 addressed:<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Alex<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* translate 10kHz to kHz */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;data[i].clocks_in_khz =3D pp_clks-&g=
t;data[i].clocks_in_khz;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clk_level_info-&gt;data[i].latency_in_us =3D pp_clks-&g=
t;data[i].clocks_in_khz;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; bool dm_pp_get_clock_levels_by_type(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_context *ctx,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum dm_pp_clock_type clk_type,<br>
&gt; @@ -311,8 &#43;339,22 @@ bool dm_pp_get_clock_levels_by_type_with_late=
ncy(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dm_pp_clock_type =
clk_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_clock_lev=
els_with_latency *clk_level_info)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: to be implemented */<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ctx-&gt;driver_context;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =3D adev-&gt=
;powerplay.pp_handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_levels_with_=
latency pp_clks =3D { 0 };<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs *p=
p_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs-&gt;get_clock_=
by_type_with_latency)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;get_clock_b=
y_type_with_latency(pp_handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; dc_to_pp_clock_type(clk_type),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;pp_clks))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_to_dc_clock_levels_with_l=
atency(&amp;pp_clks, clk_level_info, clk_type);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; bool dm_pp_get_clock_levels_by_type_with_voltage(<br>
&gt; --<br>
&gt; 2.17.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR1201MB2489A23BE7366B2C86681C16E46E0DM5PR1201MB2489_--

--===============0437540021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0437540021==--
