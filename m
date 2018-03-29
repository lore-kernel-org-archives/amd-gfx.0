From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerply: fix power reading on Fiji
Date: Thu, 29 Mar 2018 20:00:14 +0000
Message-ID: <BN6PR12MB1809CD35DDC84D955B4C847DF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1522351312-27566-1-git-send-email-JinHuiEric.Huang@amd.com>
 <BN6PR12MB18093357508F0377D97DCBFCF7A20@BN6PR12MB1809.namprd12.prod.outlook.com>
 <cb84765d-f9bd-f3d0-973f-13ff15f5b13d@amd.com>
 <BN6PR12MB18094AA1EA63372A78E03B17F7A20@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <d34a1d2c-7f3d-4722-8f80-1ae0cba18df0@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1523033559=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d34a1d2c-7f3d-4722-8f80-1ae0cba18df0-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1523033559==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CD35DDC84D955B4C847DF7A20BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CD35DDC84D955B4C847DF7A20BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fiji and tonga I presume.  The current code seems to work fine on tonga at =
least.


Alex

________________________________
From: Huang, JinHuiEric
Sent: Thursday, March 29, 2018 3:58:42 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
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

power[1-*]_average_interval     Power use averaging interval.  A poll
                                notification is sent to this file if the
                                hardware changes the averaging interval.
                                Unit: milliseconds
                                RW

power[1-*]_average_interval_max Maximum power use averaging interval
                                Unit: milliseconds
                                RO

power[1-*]_average_interval_min Minimum power use averaging interval
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



--_000_BN6PR12MB1809CD35DDC84D955B4C847DF7A20BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Fiji and tonga I presume.&nbsp; T=
he current code seems to work fine on tonga at least.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric<br>
<b>Sent:</b> Thursday, March 29, 2018 3:58:42 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power reading on Fiji</fo=
nt>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<p>Right. This is only for Fiji. We should use PPSMC_MSG_GetCurrPkgPwr on p=
oaris.</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Eric<br>
</p>
<br>
<div class=3D"x_moz-cite-prefix">On 2018-03-29 03:54 PM, Deucher, Alexander=
 wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Thanks. Patch is:</p>
<p style=3D"margin-top:0; margin-bottom:0">Acked-by: Alex Deucher <a class=
=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
<p style=3D"margin-top:0; margin-bottom:0">Care to make a patch to use <spa=
n style=3D"background-color:white">
PPSMC_MSG_GetCurrPkgPwr </span>on polaris boards so we don't have to worry =
about the delay on them?</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Alex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, JinHuiEric<b=
r>
<b>Sent:</b> Thursday, March 29, 2018 3:40:22 PM<br>
<b>To:</b> Deucher, Alexander; <a class=3D"x_moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerply: fix power reading on Fiji</fo=
nt>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<p>This reading method is shared with AGT tool only on Fiji, because SMU FW=
 doesn't support PPSMC_MSG_GetCurrPkgPwr message on Fiji. But since polaris=
10, PPSMC_MSG_GetCurrPkgPwr has been supported. We also use PPSMC_MSG_GetCu=
rrPkgPwr on vega which SMU FW control
 sampling period. Driver will not care about it.</p>
<p><br>
</p>
<p>Eric<br>
</p>
<br>
<div class=3D"x_x_moz-cite-prefix">On 2018-03-29 03:31 PM, Deucher, Alexand=
er wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div id=3D"x_x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; c=
olor:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Do you know what the sampling pe=
riod is on vega?&nbsp; We should try and be consistent.&nbsp; How about mak=
ing this selectable via hwmon:</p>
<pre>power[1-*]_average_interval	Power use averaging interval.  A poll
				notification is sent to this file if the
				hardware changes the averaging interval.
				Unit: milliseconds
				RW

power[1-*]_average_interval_max	Maximum power use averaging interval
				Unit: milliseconds
				RO

power[1-*]_average_interval_min	Minimum power use averaging interval
				Unit: milliseconds
				RO</pre>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Then the user can select the int=
erval they want.<br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Alex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Eric Huang <=
a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:JinHuiEric.Huang@amd.c=
om">
&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Thursday, March 29, 2018 3:21:52 PM<br>
<b>To:</b> <a class=3D"x_x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx=
@lists.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Huang, JinHuiEric<br>
<b>Subject:</b> [PATCH] drm/amd/powerply: fix power reading on Fiji</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Power value is wrong reported by customer. It =
is a regression by<br>
<br>
commit a7c7bc4c0c47eaac77b8fa92f0672032df7f4254<br>
Author: Rex Zhu <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Date:&nbsp;&nbsp; Mon Mar 27 15:32:59 2017 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amd/powerplay: reduce sample period time<br>
<br>
&nbsp;&nbsp;&nbsp; for power readings.<br>
<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu <a class=3D"x_x_moz-txt-link-rfc2=
396E" href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Alex Deucher <a class=3D"x_x_moz-txt-link-r=
fc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher <a class=3D"x_x_moz-txt-link=
-rfc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
The theoretical sampling period is from 50ms to 4sec, original 2sec<br>
is long but correct, and 20ms is too short. change it to more<br>
reasonable 200ms.<br>
<br>
Signed-off-by: Eric Huang <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org">
&lt;JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
<a class=3D"x_x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</blockquote>
<br>
</div>
</blockquote>
<br>
</div>
</body>
</html>

--_000_BN6PR12MB1809CD35DDC84D955B4C847DF7A20BN6PR12MB1809namp_--

--===============1523033559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1523033559==--
