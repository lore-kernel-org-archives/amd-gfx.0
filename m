From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Convert voltage unit in mV*4 to mV on
 CZ/ST
Date: Wed, 25 Jul 2018 14:45:38 +0000
Message-ID: <BN6PR12MB180985FD16A196F854CCCB59F7540@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1532494993-23009-1-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023253510=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532494993-23009-1-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0023253510==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180985FD16A196F854CCCB59F7540BN6PR12MB1809namp_"

--_000_BN6PR12MB180985FD16A196F854CCCB59F7540BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<rex.zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, July 25, 2018 1:03:12 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/2] drm/amd/pp: Convert voltage unit in mV*4 to mV on CZ/S=
T

the voltage showed in debugfs and hwmon should be in mV

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
index cafa822..b863704 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c
@@ -244,6 +244,7 @@ static int smu8_initialize_dpm_defaults(struct pp_hwmgr=
 *hwmgr)
         return 0;
 }

+/* convert form 8bit vid to real voltage in mV*4 */
 static uint32_t smu8_convert_8Bit_index_to_voltage(
                         struct pp_hwmgr *hwmgr, uint16_t voltage)
 {
@@ -1707,13 +1708,13 @@ static int smu8_read_sensor(struct pp_hwmgr *hwmgr,=
 int idx,
         case AMDGPU_PP_SENSOR_VDDNB:
                 tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG_=
_SMC, ixSMUSVI_NB_CURRENTVID) &
                         CURRENT_NB_VID_MASK) >> CURRENT_NB_VID__SHIFT;
-               vddnb =3D smu8_convert_8Bit_index_to_voltage(hwmgr, tmp);
+               vddnb =3D smu8_convert_8Bit_index_to_voltage(hwmgr, tmp) / =
4;
                 *((uint32_t *)value) =3D vddnb;
                 return 0;
         case AMDGPU_PP_SENSOR_VDDGFX:
                 tmp =3D (cgs_read_ind_register(hwmgr->device, CGS_IND_REG_=
_SMC, ixSMUSVI_GFX_CURRENTVID) &
                         CURRENT_GFX_VID_MASK) >> CURRENT_GFX_VID__SHIFT;
-               vddgfx =3D smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)t=
mp);
+               vddgfx =3D smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)t=
mp) / 4;
                 *((uint32_t *)value) =3D vddgfx;
                 return 0;
         case AMDGPU_PP_SENSOR_UVD_VCLK:
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180985FD16A196F854CCCB59F7540BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, July 25, 2018 1:03:12 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/pp: Convert voltage unit in mV*4 to mV =
on CZ/ST</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">the voltage showed in debugfs and hwmon should be =
in mV<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c | 5 &#43;&#43;&#43;-=
-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
index cafa822..b863704 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c<br>
@@ -244,6 &#43;244,7 @@ static int smu8_initialize_dpm_defaults(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/* convert form 8bit vid to real voltage in mV*4 */<br>
&nbsp;static uint32_t smu8_convert_8Bit_index_to_voltage(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t pp_hwmgr *hwmgr, uint16_t voltage)<br>
&nbsp;{<br>
@@ -1707,13 &#43;1708,13 @@ static int smu8_read_sensor(struct pp_hwmgr *hw=
mgr, int idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDN=
B:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_=
IND_REG__SMC, ixSMUSVI_NB_CURRENTVID) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRE=
NT_NB_VID_MASK) &gt;&gt; CURRENT_NB_VID__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vddnb =3D smu8_convert_8Bit_index_to_voltage(hwmgr, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vddnb =3D smu8_convert_8Bit_index_to_voltage(hwmgr, tmp) / 4=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *((uint32_t *)value) =3D vddnb;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDG=
FX:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D (cgs_read_ind_register(hwmgr-&gt;device, CGS_=
IND_REG__SMC, ixSMUSVI_GFX_CURRENTVID) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CURRE=
NT_GFX_VID_MASK) &gt;&gt; CURRENT_GFX_VID__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vddgfx =3D smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)tmp);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vddgfx =3D smu8_convert_8Bit_index_to_voltage(hwmgr, (u16)tm=
p) / 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *((uint32_t *)value) =3D vddgfx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_UVD_=
VCLK:<br>
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

--_000_BN6PR12MB180985FD16A196F854CCCB59F7540BN6PR12MB1809namp_--

--===============0023253510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0023253510==--
