From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in
 smu7_fan_ctrl_set_fan_speed_rpm
Date: Thu, 20 Sep 2018 15:35:13 +0000
Message-ID: <BN6PR12MB18099E37F094DEC91B897155F7130@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1537427667-23717-1-git-send-email-Rex.Zhu@amd.com>
 <BN6PR12MB18097706023511533D3B4E6FF7130@BN6PR12MB1809.namprd12.prod.outlook.com>,
 <BYAPR12MB277505BCC3D7AB18104E3A4CFB130@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1585016102=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB277505BCC3D7AB18104E3A4CFB130-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

--===============1585016102==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18099E37F094DEC91B897155F7130BN6PR12MB1809namp_"

--_000_BN6PR12MB18099E37F094DEC91B897155F7130BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Zhu, Rex
Sent: Thursday, September 20, 2018 10:43 AM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Quan, Evan
Subject: RE: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fan_ctrl_=
set_fan_speed_rpm


Hi Alex and Evan,



For the fan control via sysfs,  I think we need to clarify the use case.



We support manual/auto fan control mode.



User can set the mode through pwm_enable. 1 mean manual. 2 mean auto

User can set fan speed via pwm1 and fan1_input.



For pwm1, user set the percentage value (0% - 100%)

And can get the pwm1=92s range via sysfs: pwm1_min, pwm1_max. the range is =
[0, 255]. In driver, we transfer to [0% - 100%]



For fan1_input, user set the fan=92s resolution per minute

No way for user to get the range. On Tonga, the range is (0, 6000]. Not sup=
port zero-rpm on tonga.



Do we need to add new sysfs to expose the RPM range or just print the range=
 in dmesg if user=92s setting is out of range?



Yes, expose the rpm limits via fan1_min and max.  See:

https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface

for more info on standard sysfs interfaces for hwmon.


Another question is:



Currently, the default fan control mode is auto.

When user change the fan speed via pwm1 or fan1_input, we switch to manual =
mode automatically.



So if user want to change back to auto fan control mode, they need to echo =
2 to pwm_enable.



I think we should reject any changes unless the user selects manual (1) fir=
st.


Best Regards

Rex





From: Deucher, Alexander
Sent: Thursday, September 20, 2018 9:52 PM
To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fan_ctrl_=
set_fan_speed_rpm



Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, September 20, 2018 3:14:25 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Zhu, Rex
Subject: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fan_ctrl_set_=
fan_speed_rpm



The minRPM speed maybe equal to zero. so need to check
input RPM not equal to 0, otherwise cause divide-by-zero driver crash.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.c
index 44527755..d61a9b4 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
@@ -260,6 +260,7 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hw=
mgr, uint32_t speed)
         if (hwmgr->thermal_controller.fanInfo.bNoFan ||
                         (hwmgr->thermal_controller.fanInfo.
                         ucTachometerPulsesPerRevolution =3D=3D 0) ||
+                       speed =3D=3D 0 ||
                         (speed < hwmgr->thermal_controller.fanInfo.ulMinRP=
M) ||
                         (speed > hwmgr->thermal_controller.fanInfo.ulMaxRP=
M))
                 return 0;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18099E37F094DEC91B897155F7130BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhu, Rex<br>
<b>Sent:</b> Thursday, September 20, 2018 10:43 AM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Quan, Evan<br=
>
<b>Subject:</b> RE: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fa=
n_ctrl_set_fan_speed_rpm</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"x_Generator" content=3D"Microsoft Word 15 (filtered medium)">
<div link=3D"blue" vlink=3D"purple" lang=3D"EN-US">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Hi Alex and Evan,</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">For the fan control via sysfs,&nbsp; I think we ne=
ed to clarify the use case.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">We support manual/auto fan control mode.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">User can set the mode through pwm_enable. 1 mean m=
anual. 2 mean auto</p>
<p class=3D"x_MsoNormal">User can set fan speed via pwm1 and fan1_input.</p=
>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">For pwm1, user set the percentage value (0% - 100%=
)</p>
<p class=3D"x_MsoNormal">And can get the pwm1=92s range via sysfs: pwm1_min=
, pwm1_max. the range is [0, 255]. In driver, we transfer to [0% - 100%]</p=
>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">For fan1_input, user set the fan=92s resolution pe=
r minute</p>
<p class=3D"x_MsoNormal">No way for user to get the range. On Tonga, the ra=
nge is (0, 6000]. Not support zero-rpm on tonga.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Do we need to add new sysfs to expose the RPM rang=
e or just print the range in dmesg if user=92s setting is out of range?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"color: rgb(75, 165, 36);">Yes, expo=
se the rpm limits via fan1_min and max.&nbsp; See:</span></p>
<p class=3D"x_MsoNormal"><a href=3D"https://www.kernel.org/doc/Documentatio=
n/hwmon/sysfs-interface" class=3D"OWAAutoLink" id=3D"LPlnk700456" previewre=
moved=3D"true"><span style=3D"color: rgb(75, 165, 36);">https://www.kernel.=
org/doc/Documentation/hwmon/sysfs-interface</span></a></p>
<p class=3D"x_MsoNormal"><span style=3D"color: rgb(75, 165, 36);">for more =
info on standard
</span><span style=3D"color: rgb(75, 165, 36);">sysfs interfaces for hwmon.=
</span><br>
</p>
<p class=3D"x_MsoNormal"><br>
</p>
<p class=3D"x_MsoNormal">Another question is:</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Currently, the default fan control mode is auto.</=
p>
<p class=3D"x_MsoNormal">When user change the fan speed via pwm1 or fan1_in=
put, we switch to manual mode automatically.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">So if user want to change back to auto fan control=
 mode, they need to echo 2 to pwm_enable.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"color: rgb(75, 165, 36);">I think w=
e should reject any changes unless the user selects manual (1) first.</span=
><br>
</p>
<p class=3D"x_MsoNormal"><br>
</p>
<p class=3D"x_MsoNormal">Best Regards</p>
<p class=3D"x_MsoNormal">Rex</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Deucher, Alexander <br>
<b>Sent:</b> Thursday, September 20, 2018 9:52 PM<br>
<b>To:</b> Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<=
br>
<b>Subject:</b> Re: [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fa=
n_ctrl_set_fan_speed_rpm</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt; color:black">Series is:</span></p>
<p><span style=3D"font-size:12.0pt; color:black">Reviewed-by: Alex Deucher =
&lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk816393" class=
=3D"OWAAutoLink" previewremoved=3D"true">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<=
/span></p>
</div>
<div class=3D"x_MsoNormal" style=3D"text-align:center" align=3D"center">
<hr width=3D"98%" size=3D"3" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org" id=3D"LPlnk94004" class=3D"OWAAutoLink" previewremoved=
=3D"true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk312=
175" class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<=
br>
<b>Sent:</b> Thursday, September 20, 2018 3:14:25 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk9146=
09" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/3] drm/amd/pp: Avoid divide-by-zero in smu7_fan_ct=
rl_set_fan_speed_rpm</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal">The minRPM speed maybe equal to zero. so need to c=
heck<br>
input RPM not equal to 0, otherwise cause divide-by-zero driver crash.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk85=
7205" class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;=
<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
index 44527755..d61a9b4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c<br>
@@ -260,6 &#43;260,7 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;thermal_cont=
roller.fanInfo.bNoFan ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (hwmg=
r-&gt;thermal_controller.fanInfo.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucTac=
hometerPulsesPerRevolution =3D=3D 0) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed =3D=3D=
 0 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (spee=
d &lt; hwmgr-&gt;thermal_controller.fanInfo.ulMinRPM) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (spee=
d &gt; hwmgr-&gt;thermal_controller.fanInfo.ulMaxRPM))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk288979" class=
=3D"OWAAutoLink" previewremoved=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><=
br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk994164" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18099E37F094DEC91B897155F7130BN6PR12MB1809namp_--

--===============1585016102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1585016102==--
