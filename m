From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Allow switching to CUSTOM profile on smu7
 v2
Date: Thu, 28 Mar 2019 09:24:49 +0000
Message-ID: <BN6PR12MB161820CAB9F87E2C6B5EE6D885590@BN6PR12MB1618.namprd12.prod.outlook.com>
References: <20190327135851.6023-1-kent.russell@amd.com>
 <20190327135851.6023-2-kent.russell@amd.com>,
 <MN2PR12MB334449AB3DCD2313A5F8BDA2E4590@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1394944328=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB334449AB3DCD2313A5F8BDA2E4590-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1394944328==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB161820CAB9F87E2C6B5EE6D885590BN6PR12MB1618namp_"

--_000_BN6PR12MB161820CAB9F87E2C6B5EE6D885590BN6PR12MB1618namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Evan,

I set tmp=3Dsmu7_profiling[PP_SMC_PROFILE_CUSTOM] before checking the bupda=
te parameters (see below). That way I don't have ugly 100-character-long ch=
ecks in the if size=3D=3D0 check. Then if its invalid I just return -EINVAL=
, or if it'svalid then we use it to writeto the SMU. If parameters are pass=
ed in, tmp is overwritten with the passed-in values and we use it as before=
.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: Quan, Evan
Sent: Wednesday, March 27, 2019 9:26:41 PM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent
Subject: RE: [PATCH 2/2] drm/amdgpu: Allow switching to CUSTOM profile on s=
mu7 v2

I think you should use smu7_profiling[PP_SMC_POWER_PROFILE_CUSTOM].bupdate_=
sclk/bupdate_mclk to judge whether there is saved custom profile.
That's where previous custom profile settings store in.
'tmp' is a temporary structures and you should not rely on that.

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Russell, Kent
> Sent: Wednesday, March 27, 2019 9:59 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 2/2] drm/amdgpu: Allow switching to CUSTOM profile on
> smu7 v2
>
> Allow changing to the CUSTOM profile without requiring the parameters
> being passed in each time. Store the values in the smu7_profiling table s=
ince
> it's defined here anyways
>
> v2: Add check that CUSTOM was previously set
>
> Change-Id: I6c5e3a1487e12410a6a7670a5cf1a6599253344d
> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  | 32 ++++++++++++--
> -----
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 83d3d935f3ac..048757e8f494 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -77,7 +77,7 @@
>  #define PCIE_BUS_CLK                10000
>  #define TCLK                        (PCIE_BUS_CLK / 10)
>
> -static const struct profile_mode_setting smu7_profiling[7] =3D
> +static struct profile_mode_setting smu7_profiling[7] =3D
>                                        {{0, 0, 0, 0, 0, 0, 0, 0},
>                                         {1, 0, 100, 30, 1, 0, 100, 10},
>                                         {1, 10, 0, 30, 0, 0, 0, 0},
> @@ -4984,17 +4984,27 @@ static int smu7_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, uint
>        mode =3D input[size];
>        switch (mode) {
>        case PP_SMC_POWER_PROFILE_CUSTOM:
> -             if (size < 8)
> +             if (size < 8 && size !=3D 0)
>                        return -EINVAL;
> -
> -             tmp.bupdate_sclk =3D input[0];
> -             tmp.sclk_up_hyst =3D input[1];
> -             tmp.sclk_down_hyst =3D input[2];
> -             tmp.sclk_activity =3D input[3];
> -             tmp.bupdate_mclk =3D input[4];
> -             tmp.mclk_up_hyst =3D input[5];
> -             tmp.mclk_down_hyst =3D input[6];
> -             tmp.mclk_activity =3D input[7];
> +             /* If only CUSTOM is passed in, use the saved values. Check
> +              * that we actually have a CUSTOM profile by ensuring that
> +              * the "use sclk" or the "use mclk" bits are set
> +              */
> +             tmp =3D smu7_profiling[PP_SMC_POWER_PROFILE_CUSTOM];
> +             if (size =3D=3D 0) {
> +                     if (tmp.bupdate_sclk =3D=3D 0 && tmp.bupdate_mclk =
=3D=3D
> 0)
> +                             return -EINVAL;
> +             } else {
> +                     tmp.bupdate_sclk =3D input[0];
> +                     tmp.sclk_up_hyst =3D input[1];
> +                     tmp.sclk_down_hyst =3D input[2];
> +                     tmp.sclk_activity =3D input[3];
> +                     tmp.bupdate_mclk =3D input[4];
> +                     tmp.mclk_up_hyst =3D input[5];
> +                     tmp.mclk_down_hyst =3D input[6];
> +                     tmp.mclk_activity =3D input[7];
> +                     smu7_profiling[PP_SMC_POWER_PROFILE_CUSTOM]
> =3D tmp;
> +             }
>                if (!smum_update_dpm_settings(hwmgr, &tmp)) {
>                        memcpy(&data->current_profile_setting, &tmp,
> sizeof(struct profile_mode_setting));
>                        hwmgr->power_profile_mode =3D mode;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB161820CAB9F87E2C6B5EE6D885590BN6PR12MB1618namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
Hi Evan,<br>
<br>
I set tmp=3Dsmu7_profiling[PP_SMC_PROFILE_CUSTOM] before checking the bupda=
te parameters (see below). That way I don't have ugly 100-character-long ch=
ecks in the if size=3D=3D0 check. Then if its invalid I just return -EINVAL=
, or if it'svalid then we use it to writeto
 the SMU. If parameters are passed in, tmp is overwritten with the passed-i=
n values and we use it as before.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan<br>
<b>Sent:</b> Wednesday, March 27, 2019 9:26:41 PM<br>
<b>To:</b> Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on smu7 v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I think you should use smu7_profiling[PP_SMC_POWER=
_PROFILE_CUSTOM].bupdate_sclk/bupdate_mclk to judge whether there is saved =
custom profile.<br>
That's where previous custom profile settings store in.<br>
'tmp' is a temporary structures and you should not rely on that.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Russell, Kent<br>
&gt; Sent: Wednesday, March 27, 2019 9:59 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 2/2] drm/amdgpu: Allow switching to CUSTOM profile on<=
br>
&gt; smu7 v2<br>
&gt; <br>
&gt; Allow changing to the CUSTOM profile without requiring the parameters<=
br>
&gt; being passed in each time. Store the values in the smu7_profiling tabl=
e since<br>
&gt; it's defined here anyways<br>
&gt; <br>
&gt; v2: Add check that CUSTOM was previously set<br>
&gt; <br>
&gt; Change-Id: I6c5e3a1487e12410a6a7670a5cf1a6599253344d<br>
&gt; Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp; | 32 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt; -----<br>
&gt;&nbsp; 1 file changed, 21 insertions(&#43;), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 83d3d935f3ac..048757e8f494 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -77,7 &#43;77,7 @@<br>
&gt;&nbsp; #define PCIE_BUS_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000<br>
&gt;&nbsp; #define TCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (PCIE_BUS_CLK / 10)<br>
&gt; <br>
&gt; -static const struct profile_mode_setting smu7_profiling[7] =3D<br>
&gt; &#43;static struct profile_mode_setting smu7_profiling[7] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; {{0, 0, 0, 0, 0, 0, 0, 0},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {1, 0, 100, 30, 1, 0, 100, 10},<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {1, 10, 0, 30, 0, 0, 0, 0},<br>
&gt; @@ -4984,17 &#43;4984,27 @@ static int smu7_set_power_profile_mode(str=
uct<br>
&gt; pp_hwmgr *hwmgr, long *input, uint<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode =3D input[size];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mode) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CU=
STOM:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; 8)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &lt; 8 &amp;&amp; size !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.bupdate_sclk =3D input[0];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.sclk_up_hyst =3D input[1];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.sclk_down_hyst =3D input[2];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.sclk_activity =3D input[3];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.bupdate_mclk =3D input[4];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.mclk_up_hyst =3D input[5];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.mclk_down_hyst =3D input[6];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp.mclk_activity =3D input[7];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If only CUSTOM is passed in, use the saved values. Check<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * that we actually have a CUSTOM profile by ensuring that<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * the &quot;use sclk&quot; or the &quot;use mclk&quot; bits a=
re set<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; tmp =3D smu7_profiling[PP_SMC_POWER_PROFILE_CUSTOM];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.bupdate_scl=
k =3D=3D 0 &amp;&amp; tmp.bupdate_mclk =3D=3D<br>
&gt; 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.bupdate_sclk =
=3D input[0];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.sclk_up_hyst =
=3D input[1];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.sclk_down_hyst =
=3D input[2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.sclk_activity =
=3D input[3];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.bupdate_mclk =
=3D input[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.mclk_up_hyst =
=3D input[5];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.mclk_down_hyst =
=3D input[6];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp.mclk_activity =
=3D input[7];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_profiling[PP_S=
MC_POWER_PROFILE_CUSTOM]<br>
&gt; =3D tmp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!smum_update_dpm_settings(hwmgr, &amp;tmp)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(=
&amp;data-&gt;current_profile_setting, &amp;tmp,<br>
&gt; sizeof(struct profile_mode_setting));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&=
gt;power_profile_mode =3D mode;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB161820CAB9F87E2C6B5EE6D885590BN6PR12MB1618namp_--

--===============1394944328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1394944328==--
