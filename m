From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: use hardware fan control if no
 powerplay fan table
Date: Fri, 28 Jun 2019 13:53:00 +0000
Message-ID: <DM6PR12MB3209FB0AAB01FA130E94FDE2FEFC0@DM6PR12MB3209.namprd12.prod.outlook.com>
References: <20190628031529.12017-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082301117=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190628031529.12017-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============2082301117==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3209FB0AAB01FA130E94FDE2FEFC0DM6PR12MB3209namp_"

--_000_DM6PR12MB3209FB0AAB01FA130E94FDE2FEFC0DM6PR12MB3209namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tested-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

Acked-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, June 27, 2019 11:15:29 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH] drm/amd/powerplay: use hardware fan control if no powerpla=
y fan table

Use SMC default fan table if no external powerplay fan table.

Change-Id: Icd7467a7fc5287a92945ba0fcc19699192b1683a
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 4 +++-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h                   | 1 +
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c     | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
index ae64ff7153d6..1cd5a8b5cdc1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
@@ -916,8 +916,10 @@ static int init_thermal_controller(
                         PHM_PlatformCaps_ThermalController
                   );

-       if (0 =3D=3D powerplay_table->usFanTableOffset)
+       if (0 =3D=3D powerplay_table->usFanTableOffset) {
+               hwmgr->thermal_controller.use_hw_fan_control =3D 1;
                 return 0;
+       }

         fan_table =3D (const PPTable_Generic_SubTable_Header *)
                 (((unsigned long)powerplay_table) +
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 2f186fcbdfc5..ec53bf24396e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -697,6 +697,7 @@ struct pp_thermal_controller_info {
         uint8_t ucType;
         uint8_t ucI2cLine;
         uint8_t ucI2cAddress;
+       uint8_t use_hw_fan_control;
         struct pp_fan_info fanInfo;
         struct pp_advance_fan_control_parameters advanceFanControlParamete=
rs;
 };
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index fbac2d3326b5..a1a9f6196009 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -2092,6 +2092,10 @@ static int polaris10_thermal_setup_fan_table(struct =
pp_hwmgr *hwmgr)
                 return 0;
         }

+       /* use hardware fan control */
+       if (hwmgr->thermal_controller.use_hw_fan_control)
+               return 0;
+
         tmp64 =3D hwmgr->thermal_controller.advanceFanControlParameters.
                         usPWMMin * duty100;
         do_div(tmp64, 10000);
--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB3209FB0AAB01FA130E94FDE2FEFC0DM6PR12MB3209namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Tested-by: Slava Abramov &lt;slav=
a.abramov-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 16px;">Acked-by: Slava Abramov =
&lt;slava.abramov-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, June 27, 2019 11:15:29 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: use hardware fan control if no p=
owerplay fan table</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use SMC default fan table if no external powerplay=
 fan table.<br>
<br>
Change-Id: Icd7467a7fc5287a92945ba0fcc19699192b1683a<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 4 &#43;=
&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c&nbsp;&nbsp;&n=
bsp;&nbsp; | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 8 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/=
drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c<br>
index ae64ff7153d6..1cd5a8b5cdc1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0=
.c<br>
@@ -916,8 &#43;916,10 @@ static int init_thermal_controller(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_P=
latformCaps_ThermalController<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; );<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (0 =3D=3D powerplay_table-&gt;usFa=
nTableOffset)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (0 =3D=3D powerplay_table-&gt;=
usFanTableOffset) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.use_hw_fan_control =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fan_table =3D (const PPTab=
le_Generic_SubTable_Header *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (((unsigned long)powerplay_table) &#43;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 2f186fcbdfc5..ec53bf24396e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -697,6 &#43;697,7 @@ struct pp_thermal_controller_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t ucType;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t ucI2cLine;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t ucI2cAddress;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t use_hw_fan_control;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_fan_info fanInfo=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_advance_fan_cont=
rol_parameters advanceFanControlParameters;<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index fbac2d3326b5..a1a9f6196009 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -2092,6 &#43;2092,10 @@ static int polaris10_thermal_setup_fan_table(str=
uct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use hardware fan control */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;thermal_controller.=
use_hw_fan_control)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp64 =3D hwmgr-&gt;therma=
l_controller.advanceFanControlParameters.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usPWM=
Min * duty100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(tmp64, 10000);<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB3209FB0AAB01FA130E94FDE2FEFC0DM6PR12MB3209namp_--

--===============2082301117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2082301117==--
