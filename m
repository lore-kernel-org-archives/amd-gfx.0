From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Enable/Disable NBPSTATE on On/OFF of
 UVD
Date: Fri, 28 Sep 2018 13:35:23 +0000
Message-ID: <BN6PR12MB18096491078EBD3D346069B6F7EC0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1537950879-27760-1-git-send-email-satyajit.sahu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1007215224=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537950879-27760-1-git-send-email-satyajit.sahu-5C7GfCeVMHo@public.gmane.org>
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
To: "Sahu, Satyajit" <Satyajit.Sahu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Agrawal, Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>

--===============1007215224==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18096491078EBD3D346069B6F7EC0BN6PR12MB1809namp_"

--_000_BN6PR12MB18096491078EBD3D346069B6F7EC0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Satyajit=
 Sahu <satyajit.sahu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 26, 2018 4:34:39 AM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Sahu, Satyajit; Agrawal, Akshu
Subject: [PATCH] drm/amd/powerplay: Enable/Disable NBPSTATE on On/OFF of UV=
D

From: Akshu Agrawal <akshu.agrawal-5C7GfCeVMHo@public.gmane.org>

We observe black lines (underflow) on display when playing a
4K video with UVD. On Disabling Low memory P state this issue is
not seen.
Multiple runs of power measurement shows no imapct.

Change-Id: I6171ced550ee244e6b9a961fb50247d12f4168a0
Signed-off-by: Akshu Agrawal <akshu.agrawal-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Satyajit Sahu <satyajit.sahu-5C7GfCeVMHo@public.gmane.org>
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
index b863704..86b6a43 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -1227,14 +1227,17 @@ static int smu8_dpm_force_dpm_level(struct pp_hwmgr=
 *hwmgr,

 static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
-       if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
+       if (PP_CAP(PHM_PlatformCaps_UVDPowerGating)) {
+               smu8_nbdpm_pstate_enable_disable(hwmgr, true, true);
                 return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPowerOFF);
+       }
         return 0;
 }

 static int smu8_dpm_powerup_uvd(struct pp_hwmgr *hwmgr)
 {
         if (PP_CAP(PHM_PlatformCaps_UVDPowerGating)) {
+               smu8_nbdpm_pstate_enable_disable(hwmgr, false, true);
                 return smum_send_msg_to_smc_with_parameter(
                         hwmgr,
                         PPSMC_MSG_UVDPowerON,
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18096491078EBD3D346069B6F7EC0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Satyajit Sahu &lt;satyajit.sa=
hu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 26, 2018 4:34:39 AM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Sahu, Satyajit; Agrawal, Akshu<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Enable/Disable NBPSTATE on On/OF=
F of UVD</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Akshu Agrawal &lt;akshu.agrawal-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
<br>
We observe black lines (underflow) on display when playing a<br>
4K video with UVD. On Disabling Low memory P state this issue is<br>
not seen.<br>
Multiple runs of power measurement shows no imapct.<br>
<br>
Change-Id: I6171ced550ee244e6b9a961fb50247d12f4168a0<br>
Signed-off-by: Akshu Agrawal &lt;akshu.agrawal-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Satyajit Sahu &lt;satyajit.sahu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c | 5 &#43;&#43;&#43;&=
#43;-<br>
&nbsp;1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
index b863704..86b6a43 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
@@ -1227,14 &#43;1227,17 @@ static int smu8_dpm_force_dpm_level(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_UVDPowerG=
ating))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_UVDPo=
werGating)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu8_nbdpm_pstate_enable_disable(hwmgr, true, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_smc(hwmgr, PPSMC_MSG_UVDPower=
OFF);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu8_dpm_powerup_uvd(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCap=
s_UVDPowerGating)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu8_nbdpm_pstate_enable_disable(hwmgr, false, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_smc_with_parameter(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC=
_MSG_UVDPowerON,<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18096491078EBD3D346069B6F7EC0BN6PR12MB1809namp_--

--===============1007215224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1007215224==--
