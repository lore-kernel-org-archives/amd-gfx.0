From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on
 Vega10 v2
Date: Tue, 2 Apr 2019 14:34:54 +0000
Message-ID: <BN6PR12MB16187A4CCAFA2B1298D9DB7185560@BN6PR12MB1618.namprd12.prod.outlook.com>
References: <20190401112716.5101-1-kent.russell@amd.com>,
 <MN2PR12MB33440A254AF4FC93173CDD6EE4560@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2064383172=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB33440A254AF4FC93173CDD6EE4560-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============2064383172==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16187A4CCAFA2B1298D9DB7185560BN6PR12MB1618namp_"

--_000_BN6PR12MB16187A4CCAFA2B1298D9DB7185560BN6PR12MB1618namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

I can confirm it. I switched back and forth a few times and the custom valu=
es persisted until reboot. Thanks Evan!

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: Quan, Evan
Sent: Monday, April 1, 2019 10:19:33 PM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent
Subject: RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on V=
ega10 v2

Can you confirm that the save custom profile settings are not lost after re=
sume?
With that confirmed, the patch is Reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org=
>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Russell, Kent
> Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B1=1B$BF|=1B(B 19:27
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on
> Vega10 v2
>
> Don't return an error if the CUSTOM profile is selected, just apply it wi=
th the
> values saved to the GPU. But ensure that we zero out the copy stored in
> adev to ensure that a valid profile has been submitted at some point firs=
t
>
> v2: Fix comment that wasn't updated from previous patch
>
> Change-Id: Iafa5994e89ce00d3a124285b3435b581ec0e5d3b
> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
> ---
>  .../drm/amd/powerplay/hwmgr/vega10_hwmgr.c    | 23
> ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 85a536924571..476a072027a6 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -1427,6 +1427,15 @@ static int
> vega10_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)
>
>        vega10_setup_default_pcie_table(hwmgr);
>
> +     /* Zero out the saved copy of the CUSTOM profile
> +      * This will be checked when trying to set the profile
> +      * and will require that new values be passed in
> +      */
> +     data->custom_profile_mode[0] =3D 0;
> +     data->custom_profile_mode[1] =3D 0;
> +     data->custom_profile_mode[2] =3D 0;
> +     data->custom_profile_mode[3] =3D 0;
> +
>        /* save a copy of the default DPM table */
>        memcpy(&(data->golden_dpm_table), &(data->dpm_table),
>                        sizeof(struct vega10_dpm_table));
> @@ -4910,9 +4919,20 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                                1 << power_profile_mode);
>
>        if (power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> -             if (size =3D=3D 0 || size > 4)
> +             if (size !=3D 0 && size !=3D 4)
>                        return -EINVAL;
>
> +             /* If size =3D 0 and the CUSTOM profile has been set alread=
y
> +              * then just apply the profile. The copy stored in the hwmg=
r
> +              * is zeroed out on init
> +              */
> +             if (size =3D=3D 0) {
> +                     if (data->custom_profile_mode[0] !=3D 0)
> +                             goto out;
> +                     else
> +                             return -EINVAL;
> +             }
> +
>                data->custom_profile_mode[0] =3D busy_set_point =3D input[=
0];
>                data->custom_profile_mode[1] =3D FPS =3D input[1];
>                data->custom_profile_mode[2] =3D use_rlc_busy =3D input[2]=
;
> @@ -4923,6 +4943,7 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                        use_rlc_busy << 16 |
> min_active_level<<24);
>        }
>
> +out:
>        hwmgr->power_profile_mode =3D power_profile_mode;
>
>        return 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16187A4CCAFA2B1298D9DB7185560BN6PR12MB1618namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
I can confirm it. I switched back and forth a few times and the custom valu=
es persisted until reboot. Thanks Evan!<br>
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
<b>Sent:</b> Monday, April 1, 2019 10:19:33 PM<br>
<b>To:</b> Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on Vega10 v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Can you confirm that the save custom profile setti=
ngs are not lost after resume?<br>
With that confirmed, the patch is Reviewed-by: Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Russell, Kent<br>
&gt; Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B1=1B$BF|=1B(B 19:27<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on<=
br>
&gt; Vega10 v2<br>
&gt; <br>
&gt; Don't return an error if the CUSTOM profile is selected, just apply it=
 with the<br>
&gt; values saved to the GPU. But ensure that we zero out the copy stored i=
n<br>
&gt; adev to ensure that a valid profile has been submitted at some point f=
irst<br>
&gt; <br>
&gt; v2: Fix comment that wasn't updated from previous patch<br>
&gt; <br>
&gt; Change-Id: Iafa5994e89ce00d3a124285b3435b581ec0e5d3b<br>
&gt; Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega10_hwmgr.c&nbsp;&nbsp;&nbsp; | 2=
3<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; 1 file changed, 22 insertions(&#43;), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 85a536924571..476a072027a6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -1427,6 &#43;1427,15 @@ static int<br>
&gt; vega10_setup_default_dpm_tables(struct pp_hwmgr *hwmgr)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_setup_default_pcie_ta=
ble(hwmgr);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Zero out the saved copy of the CUSTOM=
 profile<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This will be checked when trying=
 to set the profile<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and will require that new values=
 be passed in<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[0] =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[1] =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[2] =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[3] =3D 0;<b=
r>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save a copy of the defaul=
t DPM table */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;(data-&gt;golden=
_dpm_table), &amp;(data-&gt;dpm_table),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
struct vega10_dpm_table));<br>
&gt; @@ -4910,9 &#43;4919,20 @@ static int vega10_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; po=
wer_profile_mode);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (power_profile_mode =3D=
=3D PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size =3D=3D 0 || size &gt; 4)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size !=3D 0 &amp;&amp; size !=3D 4)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0 and the CUSTOM profile has been set already<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * then just apply the profile. The copy stored in the hwmgr<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * is zeroed out on init<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;custom=
_profile_mode[0] !=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[0] =3D busy_set_point =3D =
input[0];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[1] =3D FPS =3D input[1];<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[2] =3D use_rlc_busy =3D in=
put[2];<br>
&gt; @@ -4923,6 &#43;4943,7 @@ static int vega10_set_power_profile_mode(str=
uct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; use_rlc_busy &lt;&lt; 16 |<br>
&gt; min_active_level&lt;&lt;24);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; &#43;out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode=
 =3D power_profile_mode;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
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

--_000_BN6PR12MB16187A4CCAFA2B1298D9DB7185560BN6PR12MB1618namp_--

--===============2064383172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2064383172==--
