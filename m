From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/4] drm/amd/powerplay: remove unused parameter of
 phm_start_thermal_controller
Date: Tue, 2 Jan 2018 01:51:12 +0000
Message-ID: <MWHPR1201MB2494130290BCAC752A1FE690E4190@MWHPR1201MB2494.namprd12.prod.outlook.com>
References: <1514533479-14038-1-git-send-email-evan.quan@amd.com>,
 <1514533479-14038-2-git-send-email-evan.quan@amd.com>
 <BN6PR12MB1652FB809C0FE26E36E11B16F71A0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457234537=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652FB809C0FE26E36E11B16F71A0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1457234537==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB2494130290BCAC752A1FE690E4190MWHPR1201MB2494_"

--_000_MWHPR1201MB2494130290BCAC752A1FE690E4190MWHPR1201MB2494_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Sorry, i cannot get your point. The patch removes the 2nd parameter 'temper=
ature_range' which is always passed in as 'NULL'.
Do you mean someone sent another patch which uses this parameter as non 'NU=
LL'?

Regards,
Evan
From: Deucher, Alexander
Sent: Sunday, December 31, 2017 2:31 AM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/4] drm/amd/powerplay: remove unused parameter of phm_=
start_thermal_controller


Should this be used to set the default critical temperatures?  IIRC, they w=
ere set to 0 until last week when someone sent a patch to fix them.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, December 29, 2017 2:44 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Quan, Evan
Subject: [PATCH 2/4] drm/amd/powerplay: remove unused parameter of phm_star=
t_thermal_controller

Change-Id: Id6039cb50b73bdf8a6df37e5383f4bea4ae737ed
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 14 +++-----------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c           |  4 ++--
 drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h   |  2 +-
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 623cff9..cba0aee 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -220,20 +220,12 @@ int phm_register_thermal_interrupt(struct pp_hwmgr *h=
wmgr, const void *info)
 * Initializes the thermal controller subsystem.
 *
 * @param    pHwMgr  the address of the powerplay hardware manager.
-* @param    pTemperatureRange the address of the structure holding the tem=
perature range.
 * @exception PP_Result_Failed if any of the paramters is NULL, otherwise t=
he return value from the dispatcher.
 */
-int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_Tempera=
tureRange *temperature_range)
+int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
 {
-       struct PP_TemperatureRange range;
-
-       if (temperature_range =3D=3D NULL) {
-               range.max =3D TEMP_RANGE_MAX;
-               range.min =3D TEMP_RANGE_MIN;
-       } else {
-               range.max =3D temperature_range->max;
-               range.min =3D temperature_range->min;
-       }
+       struct PP_TemperatureRange range =3D {{TEMP_RANGE_MIN, TEMP_RANGE_M=
AX}};
+
         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
                         PHM_PlatformCaps_ThermalController)
                         && hwmgr->hwmgr_func->start_thermal_controller !=
=3D NULL)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index 08b7963..38f7d0d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -265,7 +265,7 @@ int hwmgr_hw_init(struct pp_instance *handle)
         ret =3D phm_enable_dynamic_state_management(hwmgr);
         if (ret)
                 goto err2;
-       ret =3D phm_start_thermal_controller(hwmgr, NULL);
+       ret =3D phm_start_thermal_controller(hwmgr);
         ret |=3D psm_set_performance_states(hwmgr);
         if (ret)
                 goto err2;
@@ -345,7 +345,7 @@ int hwmgr_hw_resume(struct pp_instance *handle)
         ret =3D phm_enable_dynamic_state_management(hwmgr);
         if (ret)
                 return ret;
-       ret =3D phm_start_thermal_controller(hwmgr, NULL);
+       ret =3D phm_start_thermal_controller(hwmgr);
         if (ret)
                 return ret;

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/=
gpu/drm/amd/powerplay/inc/hardwaremanager.h
index b8bd86b..7489003 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
@@ -407,7 +407,7 @@ extern int phm_force_dpm_levels(struct pp_hwmgr *hwmgr,=
 enum amd_dpm_forced_leve
 extern int phm_display_configuration_changed(struct pp_hwmgr *hwmgr);
 extern int phm_notify_smc_display_config_after_ps_adjustment(struct pp_hwm=
gr *hwmgr);
 extern int phm_register_thermal_interrupt(struct pp_hwmgr *hwmgr, const vo=
id *info);
-extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_=
TemperatureRange *temperature_range);
+extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr);
 extern int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr);
 extern bool phm_check_smc_update_required_for_display_configuration(struct=
 pp_hwmgr *hwmgr);

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MWHPR1201MB2494130290BCAC752A1FE690E4190MWHPR1201MB2494_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
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
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;
	font-weight:normal;
	font-style:normal;}
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
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D">Hi Alex,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D">Sorry, i cannot get your point. The patch removes the =
2<sup>nd</sup> parameter &#8216;temperature_range&#8217; which is always pa=
ssed in as &#8216;NULL&#8217;.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D">Do you mean someone sent another patch which uses this=
 parameter as non &#8216;NULL&#8217;?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#1F497D">Evan<o:p></o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander
<br>
<b>Sent:</b> Sunday, December 31, 2017 2:31 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH 2/4] drm/amd/powerplay: remove unused parameter =
of phm_start_thermal_controller<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">S=
hould this be used to set the default critical temperatures?&nbsp; IIRC, th=
ey were set to 0 until last week when someone sent a patch to fix them.<o:p=
></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">A=
lex<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan@=
amd.com</a>&gt;<br>
<b>Sent:</b> Friday, December 29, 2017 2:44 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 2/4] drm/amd/powerplay: remove unused parameter of p=
hm_start_thermal_controller</span><span style=3D"font-family:&quot;Calibri&=
quot;,sans-serif;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Change-Id: Id6039cb50b73bdf8a6df37e5383=
f4bea4ae737ed<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 14 &#43;&#43;=
&#43;-----------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;3 files changed, 6 insertions(&#43;), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
index 623cff9..cba0aee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
@@ -220,20 &#43;220,12 @@ int phm_register_thermal_interrupt(struct pp_hwmg=
r *hwmgr, const void *info)<br>
&nbsp;* Initializes the thermal controller subsystem.<br>
&nbsp;*<br>
&nbsp;* @param&nbsp;&nbsp;&nbsp; pHwMgr&nbsp; the address of the powerplay =
hardware manager.<br>
-* @param&nbsp;&nbsp;&nbsp; pTemperatureRange the address of the structure =
holding the temperature range.<br>
&nbsp;* @exception PP_Result_Failed if any of the paramters is NULL, otherw=
ise the return value from the dispatcher.<br>
&nbsp;*/<br>
-int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_Tempera=
tureRange *temperature_range)<br>
&#43;int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (temperature_range =3D=3D NULL) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.max =3D TEMP_RANGE_MAX;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.min =3D TEMP_RANGE_MIN;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.max =3D temperature_range-&gt;max;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; range.min =3D temperature_range-&gt;min;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange range =
=3D {{TEMP_RANGE_MIN, TEMP_RANGE_MAX}};<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-=
&gt;platform_descriptor.platformCaps,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_ThermalController)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; hwmgr-&gt;hwmgr_func-&gt;start_thermal_controller !=3D NULL)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index 08b7963..38f7d0d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -265,7 &#43;265,7 @@ int hwmgr_hw_init(struct pp_instance *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_enable_dynamic=
_state_management(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_controller(=
hwmgr, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_control=
ler(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret |=3D psm_set_performan=
ce_states(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto err2;<br>
@@ -345,7 &#43;345,7 @@ int hwmgr_hw_resume(struct pp_instance *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_enable_dynamic=
_state_management(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_controller(=
hwmgr, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_start_thermal_control=
ler(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h b/drivers/=
gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
index b8bd86b..7489003 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<br>
@@ -407,7 &#43;407,7 @@ extern int phm_force_dpm_levels(struct pp_hwmgr *hw=
mgr, enum amd_dpm_forced_leve<br>
&nbsp;extern int phm_display_configuration_changed(struct pp_hwmgr *hwmgr);=
<br>
&nbsp;extern int phm_notify_smc_display_config_after_ps_adjustment(struct p=
p_hwmgr *hwmgr);<br>
&nbsp;extern int phm_register_thermal_interrupt(struct pp_hwmgr *hwmgr, con=
st void *info);<br>
-extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr, struct PP_=
TemperatureRange *temperature_range);<br>
&#43;extern int phm_start_thermal_controller(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern int phm_stop_thermal_controller(struct pp_hwmgr *hwmgr);<br>
&nbsp;extern bool phm_check_smc_update_required_for_display_configuration(s=
truct pp_hwmgr *hwmgr);<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk358679">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p><=
/o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR1201MB2494130290BCAC752A1FE690E4190MWHPR1201MB2494_--

--===============1457234537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1457234537==--
