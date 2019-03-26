From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile
 switch
Date: Tue, 26 Mar 2019 09:47:31 +0000
Message-ID: <DM5PR12MB1625361860767875ADB4C4D5855F0@DM5PR12MB1625.namprd12.prod.outlook.com>
References: <20190325124120.7793-1-kent.russell@amd.com>,
 <MN2PR12MB3344372CF30753A2F0556109E45E0@MN2PR12MB3344.namprd12.prod.outlook.com>
 <BN6PR12MB1618F581D7E429F48154C804855E0@BN6PR12MB1618.namprd12.prod.outlook.com>
 <MN2PR12MB334481F582B040EB2CE30AB2E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912980175=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB334481F582B040EB2CE30AB2E45F0-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0912980175==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1625361860767875ADB4C4D5855F0DM5PR12MB1625namp_"

--_000_DM5PR12MB1625361860767875ADB4C4D5855F0DM5PR12MB1625namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Indeed, it allowed me to apply the profile even with no previous profile se=
t (so it basically just applied all zeros). I=1B$B!G=1B(Bll rebase my 2 pat=
ches on your patch once that is pushed to drm-next.

Kent

From: Quan, Evan
Sent: Tuesday, March 26, 2019 5:10 AM
To: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile s=
witch

That seems a bug. I will fix that.
It=1B$B!G=1B(Bs OK to store previous CUSTOM profile settings in driver and =
switch back to that with no need to pass in settings again. That makes sens=
e.
But you may need to update the patch(to check whether there is previous cus=
tom profile settings).

Regards,
Evan
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Russell, Kent
Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B26=1B$BF|=1B(B 0:00
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile s=
witch

I set CUSTOM to a weird value like "1 2 3 4 5 6" , then switched to VR prof=
ile, then switched back to CUSTOM (just with "echo 6 > profile), and it kep=
t my custom values. Before this patch, it throws EINVAL but still switches =
it to CUSTOM with the saved values, on both vega10 and vega20.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: Quan, Evan
Sent: Monday, March 25, 2019 10:14:03 AM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org>
Cc: Russell, Kent
Subject: RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile s=
witch

How can you tell whether it was already applied before or 1st time to switc=
h to compute mode?
For the latter case, other settings/parameters do need.

Regards,
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On Behalf Of
> Russell, Kent
> Sent: 2019=1B$BG/=1B(B3=1B$B7n=1B(B25=1B$BF|=1B(B 20:42
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org<mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org>>
> Subject: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile
> switch
>
> Don't return an error after switching to the CUSTOM profile, if there are=
n't
> any CUSTOM values passed in. The CUSTOM profile is already applied, so if
> no other arguments are passed, just return instead of throwing -EINVAL
> when successful
>
> Change-Id: I114cc9783226ee9ebb146863897e951527a85e20
> Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org<mailto:kent.russell@amd=
.com>>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 6 +++++-
> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 5 ++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index ed6c638700f5..a98b927282ac 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4911,7 +4911,11 @@ static int vega10_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>                                                1<<hwmgr-
> >power_profile_mode);
>
>        if (hwmgr->power_profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_CUSTOM) {
> -             if (size =3D=3D 0 || size > 4)
> +             /* If size =3D 0, then just return, it was applied above */
> +             if (size =3D=3D 0)
> +                     return 0;
> +
> +             if (size !=3D 4)
>                        return -EINVAL;
>
>                data->custom_profile_mode[0] =3D busy_set_point =3D input[=
0];
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index 664544e7fcdc..225b2102c82c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3828,8 +3828,11 @@ static int vega20_set_power_profile_mode(struct
> pp_hwmgr *hwmgr, long *input, ui
>        }
>
>        if (hwmgr->power_profile_mode =3D=3D
> PP_SMC_POWER_PROFILE_CUSTOM) {
> -             if (size < 10)
> +             if (size < 10 && size !=3D 0)
>                        return -EINVAL;
> +             /* If size =3D 0, then just return, it was applied above */
> +             if (size =3D=3D 0)
> +                     return 0;
>
>                result =3D vega20_get_activity_monitor_coeff(hwmgr,
>                                (uint8_t *)(&activity_monitor),
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1625361860767875ADB4C4D5855F0DM5PR12MB1625namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif;
	mso-fareast-language:JA;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Indeed, it allowed me to=
 apply the profile even with no previous profile set (so it basically just =
applied all zeros). I=1B$B!G=1B(Bll rebase my 2 patches on
 your patch once that is pushed to drm-next.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US">Kent<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-fareast-language:ZH-CN">From:</span></b><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-f=
areast-language:ZH-CN"> Quan, Evan
<br>
<b>Sent:</b> Tuesday, March 26, 2019 5:10 AM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during pr=
ofile switch<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">That seems a bug. I will=
 fix that.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">It=1B$B!G=1B(Bs OK to st=
ore previous CUSTOM profile settings in driver and switch back to that with=
 no need to pass in settings again. That makes sense.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">But you may need to upda=
te the patch(to check whether there is previous custom profile settings).<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Regards,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;mso-fareast-language:ZH-CN">Evan<o:p></o:p></span></=
p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;<a href=3D"mailto:=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g</a>&gt;
<b>On Behalf Of </b>Russell, Kent<br>
<b>Sent:</b> 2019</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BG=
/=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot=
;,sans-serif">3</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$B7n=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif">26</span><span lang=3D"JA" style=3D"font-size:11.0pt">=1B$BF|=
=1B(B</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif">
 0:00<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during pr=
ofile switch<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I set CUSTOM to a weird value like &quot;1 2 3 4 5 6=
&quot; , then switched to VR profile, then switched back to CUSTOM (just wi=
th &quot;echo 6 &gt; profile), and it kept my custom values. Before this pa=
tch, it throws EINVAL but still switches it to CUSTOM
 with the saved values, on both vega10 and vega20.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Quan, =
Evan<br>
<b>Sent:</b> Monday, March 25, 2019 10:14:03 AM<br>
<b>To:</b> Russell, Kent; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during pr=
ofile switch</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">How can you tell wh=
ether it was already applied before or 1st time to switch to compute mode?<=
br>
For the latter case, other settings/parameters do need.<br>
<br>
Regards,<br>
Evan<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of<br>
&gt; Russell, Kent<br>
&gt; Sent: 2019<span lang=3D"JA">=1B$BG/=1B(B</span>3<span lang=3D"JA">=1B$=
B7n=1B(B</span>25<span lang=3D"JA">=1B$BF|=1B(B</span> 20:42<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Rus=
sell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Subject: [PATCH 1/3] drm/amdgpu: Stop returning EINVAL during profile<=
br>
&gt; switch<br>
&gt; <br>
&gt; Don't return an error after switching to the CUSTOM profile, if there =
aren't<br>
&gt; any CUSTOM values passed in. The CUSTOM profile is already applied, so=
 if<br>
&gt; no other arguments are passed, just return instead of throwing -EINVAL=
<br>
&gt; when successful<br>
&gt; <br>
&gt; Change-Id: I114cc9783226ee9ebb146863897e951527a85e20<br>
&gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell-5C7GfCeVMHo@public.gmane.org=
">kent.russell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 6 &#43;&#43=
;&#43;&#43;&#43;-<br>
&gt; drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 5 &#43;&#43;&#43;=
&#43;-<br>
&gt;&nbsp; 2 files changed, 9 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index ed6c638700f5..a98b927282ac 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4911,7 &#43;4911,11 @@ static int vega10_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&lt;&lt;hwmg=
r-<br>
&gt; &gt;power_profile_mode);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_=
mode =3D=3D<br>
&gt; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size =3D=3D 0 || size &gt; 4)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0, then just return, it was applied above */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size !=3D 4)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;custom_profile_mode[0] =3D busy_set_point =3D =
input[0];<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index 664544e7fcdc..225b2102c82c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -3828,8 &#43;3828,11 @@ static int vega20_set_power_profile_mode(st=
ruct<br>
&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_=
mode =3D=3D<br>
&gt; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; 10)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size &lt; 10 &amp;&amp; size !=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* If size =3D 0, then just return, it was applied above */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (size =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D vega20_get_activity_monitor_coeff(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;activity_monitor)=
,<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></=
p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1625361860767875ADB4C4D5855F0DM5PR12MB1625namp_--

--===============0912980175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0912980175==--
