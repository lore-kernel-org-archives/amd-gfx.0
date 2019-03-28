From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: check for invalid profile mode before
 switching
Date: Thu, 28 Mar 2019 02:45:25 +0000
Message-ID: <BN6PR12MB1809BBED68E62E5A1C29415AF7590@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190328015121.12888-1-evan.quan@amd.com>,
 <MN2PR12MB3344778D716CA5D11CCC5D52E4590@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851768710=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344778D716CA5D11CCC5D52E4590-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

--===============1851768710==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BBED68E62E5A1C29415AF7590BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BBED68E62E5A1C29415AF7590BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sure no problem.

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Quan, Evan
Sent: Wednesday, March 27, 2019 9:55 PM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Cc: Russell, Kent
Subject: RE: [PATCH] drm/amd/powerplay: check for invalid profile mode befo=
re switching

It's kind of an improvement of the previous commit
    drm/amd/powerplay: update current profile mode only when it's really ap=
plied

    No need to update current profile mode if the new profile mode
    does not take effect in fact.

Maybe @Deucher, Alexander can help to combine them as one.

Regards,
Evan
> -----Original Message-----
> From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> Sent: Thursday, March 28, 2019 9:51 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Quan, Evan
> <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: check for invalid profile mode before
> switching
>
> Need to check for invalid profile mode settings before determining to swi=
tch
> to that.
>
> Change-Id: Ie47cd75a73a8369c349410ea74d322df1d3d38d1
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 85a536924571..973a8896fa9d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4906,9 +4906,6 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>        uint8_t min_active_level;
>        uint32_t power_profile_mode =3D input[size];
>
> -     smum_send_msg_to_smc_with_parameter(hwmgr,
> PPSMC_MSG_SetWorkloadMask,
> -                                             1 << power_profile_mode);
> -
>        if (power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
>                if (size =3D=3D 0 || size > 4)
>                        return -EINVAL;
> @@ -4923,6 +4920,8 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                        use_rlc_busy << 16 |
> min_active_level<<24);
>        }
>
> +     smum_send_msg_to_smc_with_parameter(hwmgr,
> PPSMC_MSG_SetWorkloadMask,
> +                                             1 << power_profile_mode);
>        hwmgr->power_profile_mode =3D power_profile_mode;
>
>        return 0;
> --
> 2.21.0


--_000_BN6PR12MB1809BBED68E62E5A1C29415AF7590BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Sure no problem.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Wednesday, March 27, 2019 9:55 PM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br=
>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: check for invalid profile mo=
de before switching</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It's kind of an improvement of the previous commit=
<br>
&nbsp;&nbsp;&nbsp; drm/amd/powerplay: update current profile mode only when=
 it's really applied<br>
<br>
&nbsp;&nbsp;&nbsp; No need to update current profile mode if the new profil=
e mode<br>
&nbsp;&nbsp;&nbsp; does not take effect in fact.<br>
<br>
Maybe @Deucher, Alexander can help to combine them as one.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Sent: Thursday, March 28, 2019 9:51 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan<br>
&gt; &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: check for invalid profile mode bef=
ore<br>
&gt; switching<br>
&gt; <br>
&gt; Need to check for invalid profile mode settings before determining to =
switch<br>
&gt; to that.<br>
&gt; <br>
&gt; Change-Id: Ie47cd75a73a8369c349410ea74d322df1d3d38d1<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 5 &#43;&#43=
;---<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 85a536924571..973a8896fa9d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4906,9 &#43;4906,6 @@ static int vega10_set_power_profile_mode(str=
uct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t min_active_level;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_profile_mode =
=3D input[size];<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<b=
r>
&gt; PPSMC_MSG_SetWorkloadMask,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; power_profile_mode=
);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (power_profile_mode =3D=
=3D PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (size =3D=3D 0 || size &gt; 4)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; @@ -4923,6 &#43;4920,8 @@ static int vega10_set_power_profile_mode(str=
uct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; use_rlc_busy &lt;&lt; 16 |<br>
&gt; min_active_level&lt;&lt;24);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmg=
r,<br>
&gt; PPSMC_MSG_SetWorkloadMask,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; power_profile_=
mode);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode=
 =3D power_profile_mode;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.21.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809BBED68E62E5A1C29415AF7590BN6PR12MB1809namp_--

--===============1851768710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1851768710==--
