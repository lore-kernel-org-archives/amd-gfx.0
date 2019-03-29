From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on
 Vega10/20 v2
Date: Fri, 29 Mar 2019 14:29:05 +0000
Message-ID: <BN6PR12MB18091C286A136C72F6208D5FF75A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190327135851.6023-1-kent.russell@amd.com>,
 <MN2PR12MB3344EAC6FE032D423A0358DFE4590@MN2PR12MB3344.namprd12.prod.outlook.com>
 <BN6PR12MB16180F6EDF5F7F62EB66707385590@BN6PR12MB1618.namprd12.prod.outlook.com>
 <MN2PR12MB334492CD00FBCA9764C950F1E4590@MN2PR12MB3344.namprd12.prod.outlook.com>,
 <DM5PR12MB1625F1CB987EC4A655678D4B855A0@DM5PR12MB1625.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240794732=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1625F1CB987EC4A655678D4B855A0-2J9CzHegvk/5JWmPm5paawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0240794732==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18091C286A136C72F6208D5FF75A0BN6PR12MB1809namp_"

--_000_BN6PR12MB18091C286A136C72F6208D5FF75A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Only vega and newer have the concept of profiles in the SMU.  Vegas has a s=
et of profiles that the SMU tracks directly.  SMU7 parts don't really have =
profiles per se; there just one "state" and the driver loads all the params=
 into that state when you request a profile (custom or hardcoded).

Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Russell,=
 Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, March 29, 2019 7:07 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on V=
ega10/20 v2


Sorry for all of the questions, Evan. I see that we store the CUSTOM profil=
e for Vega10/Fiji, but is that a limitation of the HW not being able to sto=
re it via the SMU? It seems like a lot of extra work to store a local copy,=
 when we can just get the copy from the GPU itself, especially if we don=92=
t need to do that on future ASICs. I would assume that the CUSTOM profile t=
hat is kept on the GPU is valid, but would it be simpler to just initialize=
 the CUSTOM profile to the same values as the BOOTUP values when we initial=
ize the ASIC, then submit that to the GPU, thus ensuring that the CUSTOM pr=
ofile always has some valid values? Or conversely, zeroing out the CUSTOM p=
rofile on initialization, so that the check is still valid.



I have no problem doing the work, I just want to make sure that it makes th=
e most sense and that we=92re not having to redo it later if the SMU standa=
rdizes things and actually allows all future ASICs to store the CUSTOM prof=
ile on the GPU. Thanks!



Kent

From: Quan, Evan
Sent: Thursday, March 28, 2019 10:47 AM
To: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on V=
ega10/20 v2



OK, I see. Yep, the new settings will be stored in SMU.

But as I know, the SMU comes with some default settings for CUSTOM profile.

I suspect =93activity_monitor.Soc_BoosterFreqType !=3D 0=94 will be also tr=
ue even without your first CUSTOM profile settings(with input parameters).

So, I would prefer to have a local copy of previous custom settigns(as what=
 we do on vega10 and smu7).



Evan

From: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org<mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, March 28, 2019 5:29 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on V=
ega10/20 v2



Am I mistaken in thinking that activity monitor gets the existing CUSTOM pr=
ofile from the SMU? When I tested it, the CUSTOM profile was saved and coul=
d be retrieved through this method. I specifically set the profile to somet=
hing ridiculous (1 2 3 4 5 6 7 8 9 10) and these values were retained when =
switching to VR and back to CUSTOM, so I was under the impression that it w=
as saved to the SMU when we submit it to the SMU.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122

________________________________

From: Quan, Evan
Sent: Wednesday, March 27, 2019 9:36:02 PM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org>
Cc: Russell, Kent
Subject: RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on V=
ega10/20 v2



For vega20, activity_monitor is also a temporary structure and you should n=
ot rely on that for judging existence of custom profile.

Regards
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On Behalf Of
> Russell, Kent
> Sent: Wednesday, March 27, 2019 9:59 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org<mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org>>
> Subject: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on
> Vega10/20 v2
>
> Don't return an error if the CUSTOM profile is selected, just apply it wi=
th the
> values saved to the GPU
>
> v2: Remove reference to fixed bug, check that CUSTOM profile was set
>
> Change-Id: I114cc9783226ee9ebb146863897e951527a85e20
> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org<mailto:kent.russell@amd=
.com>>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14
> +++++++++++++-
> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 14
> +++++++++++++-
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 85a536924571..7e9e7e254a0d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4910,9 +4910,20 @@ static int vega10_set_power_profile_mode(struct
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
> +              * (check BUSY_SET_POINT since that is always >0 for a vali=
d
> +              * profile) then just apply the profile.
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
> @@ -4923,6 +4934,7 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                        use_rlc_busy << 16 |
> min_active_level<<24);
>        }
>
> +out:
>        hwmgr->power_profile_mode =3D power_profile_mode;
>
>        return 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index 70dc641bf94d..6dc16a9e766b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3843,7 +3843,7 @@ static int vega20_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>        }
>
>        if (power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
> -             if (size < 10)
> +             if (size < 10 && size !=3D 0)
>                        return -EINVAL;
>
>                result =3D vega20_get_activity_monitor_coeff(hwmgr,
> @@ -3853,6 +3853,17 @@ static int vega20_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                "[SetPowerProfile] Failed to get activity
> monitor!",
>                                return result);
>
> +             /* If size =3D 0 and the CUSTOM profile has been set alread=
y
> +              * (check BoosterFreqType since that is always >0 for a val=
id
> +              * profile) then just apply the profile.
> +              */
> +             if (size =3D=3D 0) {
> +                     if (activity_monitor.Soc_BoosterFreqType !=3D 0)
> +                             goto out;
> +                     else
> +                             return -EINVAL;
> +             }
> +
>                switch (input[0]) {
>                case 0: /* Gfxclk */
>                        activity_monitor.Gfx_FPS =3D input[1]; @@ -3908,6
> +3919,7 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr
> *hwmgr, long *input, ui
>                                return result);
>        }
>
> +out:
>        /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>        workload_type =3D
>
>        conv_power_profile_to_pplib_workload(power_profile_mode);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18091C286A136C72F6208D5FF75A0BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Only vega and newer have the concept of profiles in the SMU.&nbsp; Vegas ha=
s a set of profiles that the SMU tracks directly.&nbsp; SMU7 parts don't re=
ally have profiles per se; there just one &quot;state&quot; and the driver =
loads all the params into that state when you request
 a profile (custom or hardcoded).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Russell, Kent &lt;Kent.Russel=
l@amd.com&gt;<br>
<b>Sent:</b> Friday, March 29, 2019 7:07 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on Vega10/20 v2</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Sorry for all of the questions, Evan. I see that w=
e store the CUSTOM profile for Vega10/Fiji, but is that a limitation of the=
 HW not being able to store it via the SMU? It seems like a lot of extra wo=
rk to store a local copy, when we
 can just get the copy from the GPU itself, especially if we don=92t need t=
o do that on future ASICs. I would assume that the CUSTOM profile that is k=
ept on the GPU is valid, but would it be simpler to just initialize the CUS=
TOM profile to the same values as
 the BOOTUP values when we initialize the ASIC, then submit that to the GPU=
, thus ensuring that the CUSTOM profile always has some valid values? Or co=
nversely, zeroing out the CUSTOM profile on initialization, so that the che=
ck is still valid.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">I have no problem doing the work, I just want to m=
ake sure that it makes the most sense and that we=92re not having to redo i=
t later if the SMU standardizes things and actually allows all future ASICs=
 to store the CUSTOM profile on the
 GPU. Thanks!</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Kent</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Quan, Evan <br>
<b>Sent:</b> Thursday, March 28, 2019 10:47 AM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on Vega10/20 v2</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">OK, I see. Yep, the new settings will be stored in=
 SMU.</p>
<p class=3D"x_MsoNormal">But as I know, the SMU comes with some default set=
tings for CUSTOM profile.
</p>
<p class=3D"x_MsoNormal">I suspect =93activity_monitor.Soc_BoosterFreqType =
!=3D 0=94 will be also true even without your first CUSTOM profile settings=
(with input parameters).</p>
<p class=3D"x_MsoNormal">So, I would prefer to have a local copy of previou=
s custom settigns(as what we do on vega10 and smu7).</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Evan</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Russell, Kent &lt;<a href=3D"mailto:K=
ent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Russell-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Thursday, March 28, 2019 5:29 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on Vega10/20 v2</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Am I mistaken in thinking that activity monitor ge=
ts the existing CUSTOM profile from the SMU? When I tested it, the CUSTOM p=
rofile was saved and could be retrieved through this method. I specifically=
 set the profile to something ridiculous
 (1 2 3 4 5 6 7 8 9 10) and these values were retained when switching to VR=
 and back to CUSTOM, so I was under the impression that it was saved to the=
 SMU when we submit it to the SMU.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122</p>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Quan, Evan<br>
<b>Sent:</b> Wednesday, March 27, 2019 9:36:02 PM<br>
<b>To:</b> Russell, Kent; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profi=
le on Vega10/20 v2</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">For vega20, activity_monitor is also a temporary s=
tructure and you should not rely on that for judging existence of custom pr=
ofile.<br>
<br>
Regards<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of<br>
&gt; Russell, Kent<br>
&gt; Sent: Wednesday, March 27, 2019 9:59 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Rus=
sell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Subject: [PATCH 1/2] drm/amdgpu: Allow switching to CUSTOM profile on<=
br>
&gt; Vega10/20 v2<br>
&gt; <br>
&gt; Don't return an error if the CUSTOM profile is selected, just apply it=
 with the<br>
&gt; values saved to the GPU<br>
&gt; <br>
&gt; v2: Remove reference to fixed bug, check that CUSTOM profile was set<b=
r>
&gt; <br>
&gt; Change-Id: I114cc9783226ee9ebb146863897e951527a85e20<br>
&gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell-5C7GfCeVMHo@public.gmane.org=
">kent.russell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 14<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt; drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 14<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; 2 files changed, 26 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 85a536924571..7e9e7e254a0d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4910,9 &#43;4910,20 @@ static int vega10_set_power_profile_mode(st=
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
;&nbsp;&nbsp; * (check BUSY_SET_POINT since that is always &gt;0 for a vali=
d<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * profile) then just apply the profile.<br>
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
&gt; @@ -4923,6 &#43;4934,7 @@ static int vega10_set_power_profile_mode(str=
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
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index 70dc641bf94d..6dc16a9e766b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -3843,7 &#43;3843,7 @@ static int vega20_set_power_profile_mode(str=
uct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (power_profile_mode =3D=
=3D PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; 10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &lt; 10 &amp;&amp; size !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D vega20_get_activity_monitor_coeff(hwmgr,<br>
&gt; @@ -3853,6 &#43;3853,17 @@ static int vega20_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[SetPowerProfile] Failed to =
get activity<br>
&gt; monitor!&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0 and the CUSTOM profile has been set already<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * (check BoosterFreqType since that is always &gt;0 for a val=
id<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * profile) then just apply the profile.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (activity_monito=
r.Soc_BoosterFreqType !=3D 0)<br>
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
;&nbsp;&nbsp;&nbsp; switch (input[0]) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 0: /* Gfxclk */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; activit=
y_monitor.Gfx_FPS =3D input[1]; @@ -3908,6<br>
&gt; &#43;3919,7 @@ static int vega20_set_power_profile_mode(struct pp_hwmg=
r<br>
&gt; *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; &#43;out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* conv PP_SMC_POWER_PROFILE=
* to WORKLOAD_PPLIB_*_BIT */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workload_type =3D<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conv_power_profile_to_pplib_=
workload(power_profile_mode);<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18091C286A136C72F6208D5FF75A0BN6PR12MB1809namp_--

--===============0240794732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0240794732==--
