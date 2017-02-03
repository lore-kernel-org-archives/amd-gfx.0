From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 00/12] mise patch related uvd/vce cg and pg.
Date: Fri, 3 Feb 2017 15:52:35 +0000
Message-ID: <BN6PR12MB1652780FA922E4E11AFB4A97F74F0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1485428438-13989-1-git-send-email-Rex.Zhu@amd.com>,
 <29b2ec13-be6a-acb0-6dff-9620671cc026@vodafone.de>
 <CY4PR12MB1687B033A06043A6620A9DE8FB4F0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0554081364=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687B033A06043A6620A9DE8FB4F0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============0554081364==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652780FA922E4E11AFB4A97F74F0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652780FA922E4E11AFB4A97F74F0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of Z=
hu, Rex
Sent: Friday, February 03, 2017 7:10 AM
To: Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher
Subject: Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.


Thanks Alex and Christian.



Patch7 is just a workaround for issue: when dpm disabled, can't initialize =
uvd on Ci.

Now I have found the root cause. so no need to add timeout time.



Please review the attached patch.

Best Regards
Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Christian K=F6nig <deathsimple@vodafo=
ne.de<mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>>
Sent: Friday, January 27, 2017 4:34 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>
Subject: Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.

I only skimmed over it, but what I saw looked mostly good to me.

Patch #7: Please add a code comment explaining why we do this.

Apart from that the rest is Acked-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org<mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>>.

Regards,
Christian.

Am 26.01.2017 um 12:00 schrieb Rex Zhu:
> Rex Zhu (12):
>    drm/amdgpu: when dpm disabled, also can enable uvd cg/pg.
>    drm/amdgpu: add current_pg_status register define for smu7.1
>    drm/amdgpu: power down/up uvd4 when smu disabled.
>    drm/amdgpu: refine uvd pg code in kv_dpm.c
>    drm/amdgpu: refine uvd4.2 init/stop code.
>    drm/amdgpu: refine uvd5.0/6.0 code.
>    drm/amdgpu: add uvd timeout time.
>    drm/amdgpu: when dpm disabled, also need to stop/start vce.
>    drm/amdgpu: refine code for VCE2.0 and related dpm code.
>    drm/amdgpu: enable vce pg feature on Kv.
>    drm/amdgpu: move subfunctions to the front of vce_v2_0.c.
>    drm/amdgpu: refine vce3.0 code and related powerplay pg code.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   9 +
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |   9 -
>   drivers/gpu/drm/amd/amdgpu/cik.c                   |   4 +-
>   drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |  68 +---
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              | 130 ++++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |  24 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  21 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              | 451 +++++++++++---=
-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  17 +-
>   .../gpu/drm/amd/include/asic_reg/smu/smu_7_0_1_d.h |   1 +
>   .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  |  71 ++--
>   .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |  23 +-
>   14 files changed, 438 insertions(+), 414 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



--_000_BN6PR12MB1652780FA922E4E11AFB4A97F74F0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Reviewed-by: Alex Deucher=
 &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>Zhu, Rex<br>
<b>Sent:</b> Friday, February 03, 2017 7:10 AM<br>
<b>To:</b> Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Alex Deucher<br>
<b>Subject:</b> Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.<o:p=
></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Thanks Alex and Christian.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Patch7 is just&nbsp;a workaround for issue: when dpm disabled, c=
an't initialize uvd on&nbsp;Ci.&nbsp;<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Now I have found the root cause. so no need to add timeout time.=
&nbsp;<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Please review the attached patch.&nbsp;<o:p></o:p></span></p>
<div id=3D"divtagdefaultwrapper">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"divtagdefaultwrapper">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Best Regards<o:p></o:p></span></p>
</div>
<div id=3D"divtagdefaultwrapper">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Rex<o:p></o:p></span></p>
</div>
<div id=3D"divtagdefaultwrapper">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Christian K=F6nig &lt;<a href=3D"mailto:deathsimple@vodafone.=
de">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, January 27, 2017 4:34 PM<br>
<b>To:</b> Zhu, Rex; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.</sp=
an><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">I only skimmed over it, but=
 what I saw looked mostly good to me.<br>
<br>
Patch #7: Please add a code comment explaining why we do this.<br>
<br>
Apart from that the rest is Acked-by: Christian K=F6nig <br>
&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a=
>&gt;.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 26.01.2017 um 12:00 schrieb Rex Zhu:<br>
&gt; Rex Zhu (12):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: when dpm disabled, also can enable uvd c=
g/pg.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add current_pg_status register define fo=
r smu7.1<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: power down/up uvd4 when smu disabled.<br=
>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd pg code in kv_dpm.c<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd4.2 init/stop code.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd5.0/6.0 code.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add uvd timeout time.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: when dpm disabled, also need to stop/sta=
rt vce.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine code for VCE2.0 and related dpm c=
ode.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: enable vce pg feature on Kv.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: move subfunctions to the front of vce_v2=
_0.c.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine vce3.0 code and related powerplay=
 pg code.<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 9 -<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 4 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/kv_dpm.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 68 &#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 130 &#43;&#43;&=
#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 24 &#43;-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 21 &#43;-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v2_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 451 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 &#43;-=
<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/include/asic_reg/smu/smu_7_0_1_d.h |&nbsp;=
&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c&nbsp; |&=
nbsp; 71 &#43;&#43;--<br>
&gt;&nbsp;&nbsp; .../amd/powerplay/hwmgr/smu7_clockpowergating.c&nbsp;&nbsp=
;&nbsp; |&nbsp; 23 &#43;-<br>
&gt;&nbsp;&nbsp; 14 files changed, 438 insertions(&#43;), 414 deletions(-)<=
br>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk95829">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1486123=
3545480.24770334642380476">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_14861233545420.3257206380367279">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
&quot;sans-serif&quot;;color:#0078D7"><a href=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decorat=
ion:none">amd-gfx
 Info Page - lists.freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_14861=
233545440.3748800181783736">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_14861233545450.265732379630208">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">To see the collection of prior postings to the list,=
 visit the amd-gfx Archives. Using amd-gfx: To post a message
 to all the list members, send email ...<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652780FA922E4E11AFB4A97F74F0BN6PR12MB1652namp_--

--===============0554081364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0554081364==--
