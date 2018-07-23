From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/powerplay: correct the argument for
 PPSMC_MSG_SetUclkFastSwitch
Date: Mon, 23 Jul 2018 06:58:37 +0000
Message-ID: <CY4PR12MB16875E49597259D03FCD9D83FB560@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180720023505.25239-1-evan.quan@amd.com>
 <20180720023505.25239-2-evan.quan@amd.com>,
 <SN6PR12MB265616FADB384E7692A4D8CAE4560@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1458262610=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB265616FADB384E7692A4D8CAE4560-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1458262610==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16875E49597259D03FCD9D83FB560CY4PR12MB1687namp_"

--_000_CY4PR12MB16875E49597259D03FCD9D83FB560CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org<mailto:rezhu-5C7GfCeVMHo@public.gmane.org>>


Best Regards
Rex



________________________________
From: Quan, Evan
Sent: Monday, July 23, 2018 2:38 PM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH 2/3] drm/amd/powerplay: correct the argument for PPSMC_=
MSG_SetUclkFastSwitch

Ping ..

> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: Friday, July 20, 2018 10:35 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/3] drm/amd/powerplay: correct the argument for
> PPSMC_MSG_SetUclkFastSwitch
>
> The argument was set wrongly. Fast/slow switch was asked when there is
> actually a slow/fast switch needed.
>
> Change-Id: Ibcfdf741dea1700cc3796f84291606231e732f4b
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
> drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index bf7b8cfebe2b..002ed77a5268 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3705,7 +3705,7 @@ static void
> vega10_notify_smc_display_change(struct pp_hwmgr *hwmgr,  {
>        smum_send_msg_to_smc_with_parameter(hwmgr,
>                        PPSMC_MSG_SetUclkFastSwitch,
> -                     has_disp ? 0 : 1);
> +                     has_disp ? 1 : 0);
>  }
>
>  int vega10_display_clock_voltage_request(struct pp_hwmgr *hwmgr, diff --
> git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 4ed218dd8ba7..35f96dacb50a 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1334,7 +1334,7 @@ static int vega12_notify_smc_display_change(struct
> pp_hwmgr *hwmgr,
>        if (data->smu_features[GNLD_DPM_UCLK].enabled)
>                return smum_send_msg_to_smc_with_parameter(hwmgr,
>                        PPSMC_MSG_SetUclkFastSwitch,
> -                     has_disp ? 0 : 1);
> +                     has_disp ? 1 : 0);
>
>        return 0;
>  }
> --
> 2.18.0


--_000_CY4PR12MB16875E49597259D03FCD9D83FB560CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size:12pt;" i=
d=3D"divtagdefaultwrapper"></p>
<div style=3D"margin-top:0;margin-bottom:0;">Series is:</div>
<div style=3D"margin-top:0;margin-bottom:0;"><font size=3D"2" color=3D"blac=
k" face=3D"sans-serif"><span style=3D"font-size:11pt;">Reviewed-by: Rex Zhu=
&lt;</span></font><a href=3D"mailto:rezhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D=
"noopener noreferrer" data-auth=3D"NotApplicable" id=3D"LPlnk933400" previe=
wremoved=3D"true"><font size=3D"2" face=3D"sans-serif"><span style=3D"font-=
size:11pt;" id=3D"LPlnk933400">rezhu-5C7GfCeVMHo@public.gmane.org</span></font></a><font size=3D=
"2" color=3D"black" face=3D"sans-serif"><span style=3D"font-size:11pt;">&gt=
;
</span></font><font size=3D"2" color=3D"black" face=3D"sans-serif"><span st=
yle=3D"font-size:11pt;"><br>
</span></font></div>
<div style=3D"margin-top:0;margin-bottom:0;"><br>
</div>
<div style=3D"margin-top:0;margin-bottom:0;"><br>
</div>
<div style=3D"margin-top:0;margin-bottom:0;">Best Regards</div>
<div style=3D"margin-top:0;margin-bottom:0;">Rex</div>
</span><br>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Monday, July 23, 2018 2:38 PM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amd/powerplay: correct the argument for=
 PPSMC_MSG_SetUclkFastSwitch</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping ..<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Friday, July 20, 2018 10:35 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
&gt; Subject: [PATCH 2/3] drm/amd/powerplay: correct the argument for<br>
&gt; PPSMC_MSG_SetUclkFastSwitch<br>
&gt; <br>
&gt; The argument was set wrongly. Fast/slow switch was asked when there is=
<br>
&gt; actually a slow/fast switch needed.<br>
&gt; <br>
&gt; Change-Id: Ibcfdf741dea1700cc3796f84291606231e732f4b<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 &#43;-<br=
>
&gt; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 2 &#43;-<br>
&gt;&nbsp; 2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index bf7b8cfebe2b..002ed77a5268 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -3705,7 &#43;3705,7 @@ static void<br>
&gt; vega10_notify_smc_display_change(struct pp_hwmgr *hwmgr,&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_pa=
rameter(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_M=
SG_SetUclkFastSwitch,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_disp ? 0 : 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_disp ? 1 : 0);<=
br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; int vega10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,=
 diff --<br>
&gt; git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; index 4ed218dd8ba7..35f96dacb50a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<b=
r>
&gt; @@ -1334,7 &#43;1334,7 @@ static int vega12_notify_smc_display_change(=
struct<br>
&gt; pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GN=
LD_DPM_UCLK].enabled)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_M=
SG_SetUclkFastSwitch,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_disp ? 0 : 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_disp ? 1 : 0);<=
br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.18.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16875E49597259D03FCD9D83FB560CY4PR12MB1687namp_--

--===============1458262610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1458262610==--
