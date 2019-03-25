From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Allow changing to BOOTUP profile on smu7
Date: Mon, 25 Mar 2019 16:00:43 +0000
Message-ID: <BN6PR12MB1618EEE6BA7316853C8EFB14855E0@BN6PR12MB1618.namprd12.prod.outlook.com>
References: <20190325124120.7793-1-kent.russell@amd.com>
 <20190325124120.7793-3-kent.russell@amd.com>,
 <MN2PR12MB3344C54453D308D2D2888AAFE45E0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1922802790=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344C54453D308D2D2888AAFE45E0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1922802790==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1618EEE6BA7316853C8EFB14855E0BN6PR12MB1618namp_"

--_000_BN6PR12MB1618EEE6BA7316853C8EFB14855E0BN6PR12MB1618namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks for that confirmation Evan. I will drop this patch.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: Quan, Evan
Sent: Monday, March 25, 2019 10:26:54 AM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent
Subject: RE: [PATCH 3/3] drm/amdgpu: Allow changing to BOOTUP profile on sm=
u7

As I know, BOOTUP profile is only available for Vega10 and later ASICs.
The BOOTUP profile for SMU7 has only some dummy settings and is not expecte=
d to switch to such mode.
The default power profile for SMU7 is FULLSCREEN3D(different with Vega10 an=
d later ASICs).
        hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_FULLSCREEN3D];
        hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
        hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCRE=
EN3D;

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Russell, Kent
> Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B25=1B$BF|=1B(B 20:42
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 3/3] drm/amdgpu: Allow changing to BOOTUP profile on
> smu7
>
> With SMU7 using case statements, against vega10/20 only checking for the
> CUSTOM profile, SMU7 can't set the power profile back to the
> BOOTUP_DEFAULT, while newer HWMGRs can. Add the case statement in to
> align functionality with other ASICs
>
> Change-Id: Ibc7df3b94b1a9dabcb88934e534c91209fc75967
> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 74d55b8fb74e..7c3eae2a34b4 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -5005,6 +5005,7 @@ static int smu7_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, uint
>                        hwmgr->power_profile_mode =3D mode;
>                }
>                break;
> +     case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT:
>        case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
>        case PP_SMC_POWER_PROFILE_POWERSAVING:
>        case PP_SMC_POWER_PROFILE_VIDEO:
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1618EEE6BA7316853C8EFB14855E0BN6PR12MB1618namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
Thanks for that confirmation Evan. I will drop this patch.<br>
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
<b>Sent:</b> Monday, March 25, 2019 10:26:54 AM<br>
<b>To:</b> Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amdgpu: Allow changing to BOOTUP profil=
e on smu7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As I know, BOOTUP profile is only available for Ve=
ga10 and later ASICs.<br>
The BOOTUP profile for SMU7 has only some dummy settings and is not expecte=
d to switch to such mode.<br>
The default power profile for SMU7 is FULLSCREEN3D(different with Vega10 an=
d later ASICs).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &l=
t;&lt; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D=
 PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_profile_=
mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Russell, Kent<br>
&gt; Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B25=1B$BF|=1B(B 20:42<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH 3/3] drm/amdgpu: Allow changing to BOOTUP profile on<b=
r>
&gt; smu7<br>
&gt; <br>
&gt; With SMU7 using case statements, against vega10/20 only checking for t=
he<br>
&gt; CUSTOM profile, SMU7 can't set the power profile back to the<br>
&gt; BOOTUP_DEFAULT, while newer HWMGRs can. Add the case statement in to<b=
r>
&gt; align functionality with other ASICs<br>
&gt; <br>
&gt; Change-Id: Ibc7df3b94b1a9dabcb88934e534c91209fc75967<br>
&gt; Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 1 &#43;<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 74d55b8fb74e..7c3eae2a34b4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -5005,6 &#43;5005,7 @@ static int smu7_set_power_profile_mode(struc=
t<br>
&gt; pp_hwmgr *hwmgr, long *input, uint<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&=
gt;power_profile_mode =3D mode;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT=
:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_PO=
WERSAVING:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VI=
DEO:<br>
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

--_000_BN6PR12MB1618EEE6BA7316853C8EFB14855E0BN6PR12MB1618namp_--

--===============1922802790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1922802790==--
