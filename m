From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerply: fix power reading on Fiji
Date: Fri, 30 Mar 2018 07:52:37 +0000
Message-ID: <CY4PR12MB1687D41D30442A05D1663E1FFBA10@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1522351312-27566-1-git-send-email-JinHuiEric.Huang@amd.com>
 <BN6PR12MB18093357508F0377D97DCBFCF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <cb84765d-f9bd-f3d0-973f-13ff15f5b13d@amd.com>
 <BN6PR12MB18094AA1EA63372A78E03B17F7A20@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <d34a1d2c-7f3d-4722-8f80-1ae0cba18df0@amd.com>
 <BN6PR12MB1809CD35DDC84D955B4C847DF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1810893006=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809CD35DDC84D955B4C847DF7A20-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1810893006==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687D41D30442A05D1663E1FFBA10CY4PR12MB1687namp_"

--_000_CY4PR12MB1687D41D30442A05D1663E1FFBA10CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>> Power value is wrong reported by customer.

Hi Eric,

What is the wrong value customer reported?

In my end, there is no big difference between 20ms and 200ms or 2s. I teste=
d on Fiji/Tonga when gpu idle or running fullscreen glxgears.

why need 50 ms?

How long does the SMU core take to complete one cycle of dpm tasks? I teste=
d, it is less than 1 ms.

So when we delay 20 ms, The output is the average value of more than 20 sam=
pling.

Best Regards
Rex


From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of D=
eucher, Alexander
Sent: Friday, March 30, 2018 4:00 AM
To: Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji


Fiji and tonga I presume.  The current code seems to work fine on tonga at =
least.



Alex

________________________________
From: Huang, JinHuiEric
Sent: Thursday, March 29, 2018 3:58:42 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists.=
freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji


Right. This is only for Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on poar=
is.



Thanks,

Eric

On 2018-03-29 03:54 PM, Deucher, Alexander wrote:

Thanks. Patch is:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deucher=
@amd.com>

Care to make a patch to use PPSMC_MSG_GetCurrPkgPwr on polaris boards so we=
 don't have to worry about the delay on them?



Alex

________________________________
From: Huang, JinHuiEric
Sent: Thursday, March 29, 2018 3:40:22 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists.=
freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji


This reading method is shared with AGT tool only on Fiji, because SMU FW do=
esn't support PPSMC_MSG_GetCurrPkgPwr message on Fiji. But since polaris10,=
 PPSMC_MSG_GetCurrPkgPwr has been supported. We also use PPSMC_MSG_GetCurrP=
kgPwr on vega which SMU FW control sampling period. Driver will not care ab=
out it.



Eric

On 2018-03-29 03:31 PM, Deucher, Alexander wrote:

Do you know what the sampling period is on vega?  We should try and be cons=
istent.  How about making this selectable via hwmon:

power[1-*]_average_interval       Power use averaging interval.  A poll

                          notification is sent to this file if the

                          hardware changes the averaging interval.

                          Unit: milliseconds

                          RW



power[1-*]_average_interval_max   Maximum power use averaging interval

                          Unit: milliseconds

                          RO



power[1-*]_average_interval_min   Minimum power use averaging interval

                          Unit: milliseconds

                          RO



Then the user can select the interval they want.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>=
<mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, March 29, 2018 3:21:52 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Huang, JinHuiEric
Subject: [PATCH] drm/amd/powerply: fix power reading on Fiji

Power value is wrong reported by customer. It is a regression by

commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254
Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Date:   Mon Mar 27 15:32:59 2017 +0800

    drm/amd/powerplay: reduce sample period time

    for power readings.

    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.=
deucher-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexande=
r.deucher-5C7GfCeVMHo@public.gmane.org>

The theoretical sampling period is from 50ms to 4sec, original 2sec
is long but correct, and 20ms is too short. change it to more
reasonable 200ms.

Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org><mailto:JinHuiEric.Huan=
g@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index a03b7fe..7631d80 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3377,7 +3377,8 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr,
                         "Failed to start pm status log!",
                         return -1);

-       msleep_interruptible(20);
+       /* Sampling period from 50ms to 4sec */
+       msleep_interruptible(200);

         PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
                         PPSMC_MSG_PmStatusLogSample),
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_CY4PR12MB1687D41D30442A05D1663E1FFBA10CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Times New Roman","serif";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">&gt;=
&gt; Power value is wrong reported by customer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Hi E=
ric,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">What=
 is the wrong value customer reported?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">In m=
y end, there is no big difference between 20ms and 200ms or 2s. I tested on=
 Fiji/Tonga when gpu idle or running fullscreen glxgears.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">why =
need 50 ms? <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">How =
long does the SMU core take to complete one cycle of dpm tasks? I tested, i=
t is less than 1 ms.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">So w=
hen we delay 20 ms, The output is the average value of more than 20 samplin=
g.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Best=
 Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rex<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
]
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Friday, March 30, 2018 4:00 AM<br>
<b>To:</b> Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power reading on Fiji<o:p=
></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"divtagdefaultwrapper">
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black">Fiji and tonga I presume.&nbsp; The current code =
seems to work fine on tonga at least.<o:p></o:p></span></p>
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</sp=
an></b><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:black"> Huang, JinHuiEric<br>
<b>Sent:</b> Thursday, March 29, 2018 3:58:42 PM<br>
<b>To:</b> Deucher, Alexander; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power reading on Fiji</sp=
an><span lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<p style=3D"background:white"><span lang=3D"EN-US">Right. This is only for =
Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on poaris.<o:p></o:p></span></p=
>
<p style=3D"background:white"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p style=3D"background:white"><span lang=3D"EN-US">Thanks,<o:p></o:p></span=
></p>
<p style=3D"background:white"><span lang=3D"EN-US">Eric<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US"><o:p=
>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US">On 2=
018-03-29 03:54 PM, Deucher, Alexander wrote:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div id=3D"x_divtagdefaultwrapper">
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Thanks. Patch is:<o:p>=
</o:p></span></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Acked-by: Alex Deucher
<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&=
gt;</a><o:p></o:p></span></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Care to make a patch t=
o use
<span style=3D"background:white">PPSMC_MSG_GetCurrPkgPwr </span>on polaris =
boards so we don't have to worry about the delay on them?<o:p></o:p></span>=
</p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></spa=
n></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Alex<o:p></o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span lang=3D"EN-US" s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;;color:black">From:</span></b><span lang=3D"EN-US" style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"> =
Huang, JinHuiEric<br>
<b>Sent:</b> Thursday, March 29, 2018 3:40:22 PM<br>
<b>To:</b> Deucher, Alexander; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power reading on Fiji</sp=
an><span lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US">&nbs=
p;<o:p></o:p></span></p>
</div>
</div>
<div>
<p style=3D"background:white"><span lang=3D"EN-US">This reading method is s=
hared with AGT tool only on Fiji, because SMU FW doesn't support PPSMC_MSG_=
GetCurrPkgPwr message on Fiji. But since polaris10, PPSMC_MSG_GetCurrPkgPwr=
 has been supported. We also use PPSMC_MSG_GetCurrPkgPwr
 on vega which SMU FW control sampling period. Driver will not care about i=
t.<o:p></o:p></span></p>
<p style=3D"background:white"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p style=3D"background:white"><span lang=3D"EN-US">Eric<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US"><o:p=
>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US">On 2=
018-03-29 03:31 PM, Deucher, Alexander wrote:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div id=3D"x_x_divtagdefaultwrapper">
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Do you know what the s=
ampling period is on vega?&nbsp; We should try and be consistent.&nbsp; How=
 about making this selectable via hwmon:<o:p></o:p></span></p>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
power[1-*]_average_interval&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power use a=
veraging interval.&nbsp; A poll<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 notification is sent to this file if the<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 hardware changes the averaging interval.<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Unit: milliseconds<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RW<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
<o:p>&nbsp;</o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
power[1-*]_average_interval_max&nbsp;&nbsp; Maximum power use averaging int=
erval<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Unit: milliseconds<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RO<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
<o:p>&nbsp;</o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
power[1-*]_average_interval_min&nbsp;&nbsp; Minimum power use averaging int=
erval<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Unit: milliseconds<o:p></o:p></span></pre>
<pre style=3D"background:white"><span lang=3D"EN-US" style=3D"color:black">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RO<o:p></o:p></span></pre>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></spa=
n></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Then the user can sele=
ct the interval they want.<o:p></o:p></span></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></spa=
n></p>
<p style=3D"background:white"><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Alex<o:p></o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center;backgr=
ound:white">
<span lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"background:white"><b><span lang=3D"EN-US" s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;;color:black">From:</span></b><span lang=3D"EN-US" style=3D"font-size:1=
1.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"> =
amd-gfx
<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Eric Huang
<a href=3D"mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org">&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt=
;</a><br>
<b>Sent:</b> Thursday, March 29, 2018 3:21:52 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Huang, JinHuiEric<br>
<b>Subject:</b> [PATCH] drm/amd/powerply: fix power reading on Fiji</span><=
span lang=3D"EN-US">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US">&nbs=
p;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US" styl=
e=3D"font-size:11.0pt">Power value is wrong reported by customer. It is a r=
egression by<br>
<br>
commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254<br>
Author: Rex Zhu <a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<=
/a><br>
Date:&nbsp;&nbsp; Mon Mar 27 15:32:59 2017 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amd/powerplay: reduce sample period time<br>
<br>
&nbsp;&nbsp;&nbsp; for power readings.<br>
<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu <a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher <a href=3D"mailto:alexander.de=
ucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher <a href=3D"mailto:alexander.=
deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
The theoretical sampling period is from 50ms to 4sec, original 2sec<br>
is long but correct, and 20ms is too short. change it to more<br>
reasonable 200ms.<br>
<br>
Signed-off-by: Eric Huang <a href=3D"mailto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org">&lt;J=
inHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index a03b7fe..7631d80 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -3377,7 &#43;3377,8 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hw=
mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to start pm status log!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -1);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep_interruptible(20);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sampling period from 50ms to 4=
sec */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep_interruptible(200);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_=
send_msg_to_smc(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC=
_MSG_PmStatusLogSample),<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US"><o:p=
>&nbsp;</o:p></span></p>
</div>
</blockquote>
<p class=3D"MsoNormal" style=3D"background:white"><span lang=3D"EN-US"><o:p=
>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687D41D30442A05D1663E1FFBA10CY4PR12MB1687namp_--

--===============1810893006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1810893006==--
