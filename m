From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Cleaning up vega10_enable_dpm_tasks function
Date: Fri, 23 Feb 2018 05:43:48 +0000
Message-ID: <CY4PR12MB1687B0AF1E6859601BA5FBCFFBCC0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1519359682-28335-1-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_PHqqQcjf+2qEiLUDVDU8s8GHW09q4YtP-Q3kpwM4mbgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1069516295=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PHqqQcjf+2qEiLUDVDU8s8GHW09q4YtP-Q3kpwM4mbgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1069516295==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687B0AF1E6859601BA5FBCFFBCC0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687B0AF1E6859601BA5FBCFFBCC0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>I don't think backend_init actually touches the hw anywhere else.
>Seems like it might be better to move this to setup_asic_task for
>consistency.


Thanks Alex, you are right. the change for telemetry will cause telemetry s=
etting not restore after s3/s4 resume back.


Best Regards

Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, February 23, 2018 1:01 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amd/pp: Cleaning up vega10_enable_dpm_tasks functi=
on

On Thu, Feb 22, 2018 at 11:21 PM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> move out functions that unrelated to enable dpm task.
>
> Change-Id: I93416e0eea82325040557a64af2b82a38d8c32ce
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14 +++++---------
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |  1 -
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index b13f55d..c6cc6b2 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -811,7 +811,8 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr =
*hwmgr)
>                         data->vddci_control =3D VEGA10_VOLTAGE_CONTROL_BY=
_GPIO;
>         }
>
> -       data->config_telemetry =3D config_telemetry;
> +       smum_send_msg_to_smc_with_parameter(hwmgr,
> +               PPSMC_MSG_ConfigureTelemetry, config_telemetry);

I don't think backend_init actually touches the hw anywhere else.
Seems like it might be better to move this to setup_asic_task for
consistency.

Alex

>
>         vega10_set_features_platform_caps(hwmgr);
>
> @@ -928,6 +929,9 @@ static int vega10_setup_asic_task(struct pp_hwmgr *hw=
mgr)
>                         "Failed to set up led dpm config!",
>                         return -EINVAL);
>
> +       smum_send_msg_to_smc_with_parameter(hwmgr,
> +                       PPSMC_MSG_NumOfDisplays, 0);
> +
>         return 0;
>  }
>
> @@ -2853,16 +2857,8 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr=
, uint32_t bitmap)
>
>  static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
>  {
> -       struct vega10_hwmgr *data =3D
> -                       (struct vega10_hwmgr *)(hwmgr->backend);
>         int tmp_result, result =3D 0;
>
> -       smum_send_msg_to_smc_with_parameter(hwmgr,
> -               PPSMC_MSG_ConfigureTelemetry, data->config_telemetry);
> -
> -       smum_send_msg_to_smc_with_parameter(hwmgr,
> -                       PPSMC_MSG_NumOfDisplays, 0);
> -
>         tmp_result =3D (!smum_is_dpm_running(hwmgr)) ? 0 : -1;
>         PP_ASSERT_WITH_CODE(!tmp_result,
>                         "DPM is already running right , skipping re-enabl=
ement!",
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
> index ab3e879..df7999d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h
> @@ -380,7 +380,6 @@ struct vega10_hwmgr {
>         struct smu_features            smu_features[GNLD_FEATURES_MAX];
>         struct vega10_smc_state_table  smc_state_table;
>
> -       uint32_t                       config_telemetry;
>         uint32_t                       acg_loop_state;
>         uint32_t                       mem_channels;
>         uint8_t                       custom_profile_mode[4];
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_CY4PR12MB1687B0AF1E6859601BA5FBCFFBCC0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt;I don't think backend_init actually touches the hw anyw=
here else.<br>
&gt;Seems like it might be better to move this to setup_asic_task for<br>
&gt;consistency.</span></font><br>
</p>
<br>
<p style=3D"margin-top:0;margin-bottom:0">Thanks Alex, you are right. the c=
hange for
<font size=3D"2"><span style=3D"font-size:11pt;">telemetry will cause <font=
 size=3D"2">
<span style=3D"font-size:11pt;">telemetry</span></font> setting not restore=
 after s3/s4 resume back.</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;"><br>
</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">Best Regards</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">Rex</span></font><br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Alex Deucher &lt;ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, February 23, 2018 1:01 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pp: Cleaning up vega10_enable_dpm_tasks=
 function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Feb 22, 2018 at 11:21 PM, Rex Zhu &lt;Rex.=
Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; move out functions that unrelated to enable dpm task.<br>
&gt;<br>
&gt; Change-Id: I93416e0eea82325040557a64af2b82a38d8c32ce<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14 &#43;&#4=
3;&#43;&#43;&#43;---------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |&nbsp; 1 -<b=
r>
&gt;&nbsp; 2 files changed, 5 insertions(&#43;), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index b13f55d..c6cc6b2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -811,7 &#43;811,8 @@ static int vega10_hwmgr_backend_init(struct pp=
_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata-&gt;vddci_control =3D VEGA10_VOLTAGE_CONTROL_BY_GPIO;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;config_telemetry =3D co=
nfig_telemetry;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_pa=
rameter(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ConfigureTelemetry, config_telemetry);<br>
<br>
I don't think backend_init actually touches the hw anywhere else.<br>
Seems like it might be better to move this to setup_asic_task for<br>
consistency.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_set_features_pl=
atform_caps(hwmgr);<br>
&gt;<br>
&gt; @@ -928,6 &#43;929,9 @@ static int vega10_setup_asic_task(struct pp_hw=
mgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;Failed to set up led dpm config!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn -EINVAL);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_pa=
rameter(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_M=
SG_NumOfDisplays, 0);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -2853,16 &#43;2857,8 @@ static int vega10_start_dpm(struct pp_hwmgr=
 *hwmgr, uint32_t bitmap)<br>
&gt;<br>
&gt;&nbsp; static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct veg=
a10_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_result, result=
 =3D 0;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parame=
ter(hwmgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_ConfigureTelemetry, data-&gt;config_telemetry);<b=
r>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parame=
ter(hwmgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_N=
umOfDisplays, 0);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D (!smum_=
is_dpm_running(hwmgr)) ? 0 : -1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!t=
mp_result,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
quot;DPM is already running right , skipping re-enablement!&quot;,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<br>
&gt; index ab3e879..df7999d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h<b=
r>
&gt; @@ -380,7 &#43;380,6 @@ struct vega10_hwmgr {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_features&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_feature=
s[GNLD_FEATURES_MAX];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_smc_stat=
e_table&nbsp; smc_state_table;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config_telemetry;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acg_loop_state;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channels;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; custom_profile_mode[4];<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a previewremoved=3D"true" id=3D"LPlnk581868" href=3D"https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15193633579850.8452219915677441">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_151936335=
79830.43468917679138286" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15193633579840.4384779857039953=
">
<div id=3D"LPRemovePreviewContainer_15193633579840.9124738318741223"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15193633579840.686=
5981313645956">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15193633579840=
.2760762511591671">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15193633579840.15709379421513125">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15193633579850.89076=
84278369051">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
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

--_000_CY4PR12MB1687B0AF1E6859601BA5FBCFFBCC0CY4PR12MB1687namp_--

--===============1069516295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1069516295==--
