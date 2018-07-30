From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on
 Rv/Vega12
Date: Mon, 30 Jul 2018 01:31:35 +0000
Message-ID: <SN6PR12MB2656D918D6DBD7C1932747BFE42F0@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <1532864547-1072-1-git-send-email-rex.zhu@amd.com>,
 <1532864547-1072-3-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0743652418=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532864547-1072-3-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============0743652418==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2656D918D6DBD7C1932747BFE42F0SN6PR12MB2656namp_"

--_000_SN6PR12MB2656D918D6DBD7C1932747BFE42F0SN6PR12MB2656namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Since the gfxoff is always in dynamic switch, i do not think the status rep=
orted to user is reliable. It means user was told the gfx is on but actuall=
y it may switches to gfxoff already.


Regards,

Evan


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<rex.zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, July 29, 2018 7:42:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 3/3] drm/amd/pp: Add gfx power status check support on Rv/V=
ega12

As gfx off is supported on Rv/Vega12, so this check is
helpful and necessary when visit gfx regesiter via mmio.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 10 +++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 31 ++++++++++++++++++=
+++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 26d130a..da1be82 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -296,6 +296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
         return false;
 }

+static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,
+                               enum amd_ip_block_type client)
+{
+       if (client =3D=3D AMD_IP_BLOCK_TYPE_GFX)
+               return smu10_is_gfx_on(hwmgr);
+       else /* for other ip, to do */
+               return true;
+}
+
 static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
 {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);
@@ -1187,6 +1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmg=
r, bool bgate)
         .smus_notify_pwe =3D smu10_smus_notify_pwe,
         .display_clock_voltage_request =3D smu10_display_clock_voltage_req=
uest,
         .powergate_gfx =3D smu10_gfx_off_control,
+       .is_hw_ip_on =3D smu10_is_hw_ip_on,
 };

 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 0789d64..ee44300 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -45,7 +45,7 @@
 #include "ppinterrupt.h"
 #include "pp_overdriver.h"
 #include "pp_thermal.h"
-
+#include "soc15_common.h"

 static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,
                 enum pp_clock_type type, uint32_t mask);
@@ -2320,6 +2320,34 @@ static int vega12_get_thermal_temperature_range(stru=
ct pp_hwmgr *hwmgr,
         return 0;
 }

+/* GFX HW Power Status can be queried from bits [1:0] of MP1_SMN_EXT_SCRAT=
CH0
+ * 2'b00   GFX is OFF
+ * 2'b01   Transitioning out of GFXOFF state
+ * 2'b10   GFX is ON
+ * 2'b11   Transitioning into GFXOFF state
+*/
+
+static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)
+{
+       uint32_t tmp;
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       tmp =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+       if (tmp =3D=3D 1 || tmp =3D=3D 2)
+               return true;
+       else
+               return false;
+}
+
+static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,
+                               enum amd_ip_block_type client)
+{
+       if (client =3D=3D AMD_IP_BLOCK_TYPE_GFX)
+               return vega12_is_gfx_on(hwmgr);
+       else /* for other ip, to do */
+               return true;
+}
+
 static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)
 {
         struct vega12_hwmgr *data =3D
@@ -2402,6 +2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr *hw=
mgr, bool enable)
         .register_irq_handlers =3D smu9_register_irq_handlers,
         .start_thermal_controller =3D vega12_start_thermal_controller,
         .powergate_gfx =3D vega12_gfx_off_control,
+       .is_hw_ip_on =3D vega12_is_hw_ip_on,
 };

 int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB2656D918D6DBD7C1932747BFE42F0SN6PR12MB2656namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Since the gfxoff is always in dyn=
amic switch, i do not think the status reported to user is reliable. It mea=
ns user was told the gfx is on but actually it may switches to gfxoff alrea=
dy.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Evan</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Sunday, July 29, 2018 7:42:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/pp: Add gfx power status check support =
on Rv/Vega12</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">As gfx off is supported on Rv/Vega12, so this chec=
k is<br>
helpful and necessary when visit gfx regesiter via mmio.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c&nbsp; | 10 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 31 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;-<br>
&nbsp;2 files changed, 40 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index 26d130a..da1be82 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -296,6 &#43;296,15 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static bool smu10_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type client)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client =3D=3D AMD_IP_BLOCK_TY=
PE_GFX)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return smu10_is_gfx_on(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else /* for other ip, to do */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
@@ -1187,6 &#43;1196,7 @@ static void smu10_powergate_vcn(struct pp_hwmgr *=
hwmgr, bool bgate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smus_notify_pwe =3D smu10=
_smus_notify_pwe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_req=
uest =3D smu10_display_clock_voltage_request,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_gfx =3D smu10_g=
fx_off_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_hw_ip_on =3D smu10_is_hw_ip_o=
n,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index 0789d64..ee44300 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -45,7 &#43;45,7 @@<br>
&nbsp;#include &quot;ppinterrupt.h&quot;<br>
&nbsp;#include &quot;pp_overdriver.h&quot;<br>
&nbsp;#include &quot;pp_thermal.h&quot;<br>
-<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;<br>
&nbsp;static int vega12_force_clock_level(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask);<br>
@@ -2320,6 &#43;2320,34 @@ static int vega12_get_thermal_temperature_range(=
struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/* GFX HW Power Status can be queried from bits [1:0] of MP1_SMN_EXT_S=
CRATCH0<br>
&#43; * 2'b00&nbsp;&nbsp; GFX is OFF<br>
&#43; * 2'b01&nbsp;&nbsp; Transitioning out of GFXOFF state<br>
&#43; * 2'b10&nbsp;&nbsp; GFX is ON<br>
&#43; * 2'b11&nbsp;&nbsp; Transitioning into GFXOFF state<br>
&#43;*/<br>
&#43;<br>
&#43;static bool vega12_is_gfx_on(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(MP1, 0, mmMP=
1_SMN_EXT_SCRATCH0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp =3D=3D 1 || tmp =3D=3D 2)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;}<br>
&#43;<br>
&#43;static bool vega12_is_hw_ip_on(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type client)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (client =3D=3D AMD_IP_BLOCK_TY=
PE_GFX)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return vega12_is_gfx_on(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else /* for other ip, to do */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int vega12_enable_gfx_off(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D<br>
@@ -2402,6 &#43;2430,7 @@ static int vega12_gfx_off_control(struct pp_hwmgr=
 *hwmgr, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handlers =3D=
 smu9_register_irq_handlers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_thermal_controller =
=3D vega12_start_thermal_controller,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_gfx =3D vega12_=
gfx_off_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_hw_ip_on =3D vega12_is_hw_ip_=
on,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
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

--_000_SN6PR12MB2656D918D6DBD7C1932747BFE42F0SN6PR12MB2656namp_--

--===============0743652418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0743652418==--
