From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/powerplay: enable dpm under pass-through
Date: Mon, 20 Aug 2018 14:35:47 +0000
Message-ID: <BN6PR12MB1809E891E4E83258B04BC959F7320@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1534736393-23259-1-git-send-email-yttao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1387597788=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534736393-23259-1-git-send-email-yttao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>

--===============1387597788==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E891E4E83258B04BC959F7320BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E891E4E83258B04BC959F7320BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yintian =
Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, August 19, 2018 11:39:53 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tao, Yintian
Subject: [PATCH] drm/powerplay: enable dpm under pass-through

Repeat enable dpm under pass-through because there is no actually
hardware-fini and real power-off when guest vm shutdown or reboot.
Otherwise, under pass-through it will be failed to populate populate
and upload SCLK MCLK DPM levels due to zero of pcie_speed_table.count.

Change-Id: I7cbc55c650867d00e19241ceea5d98f78b5ac3f5
Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
index 53207e7..6ef3c87 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
@@ -75,10 +75,12 @@ int phm_set_power_state(struct pp_hwmgr *hwmgr,

 int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D NULL;
         int ret =3D -EINVAL;;
         PHM_FUNC_CHECK(hwmgr);
+       adev =3D hwmgr->adev;

-       if (smum_is_dpm_running(hwmgr)) {
+       if (smum_is_dpm_running(hwmgr) && !amdgpu_passthrough(adev)) {
                 pr_info("dpm has been enabled\n");
                 return 0;
         }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809E891E4E83258B04BC959F7320BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Sunday, August 19, 2018 11:39:53 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Tao, Yintian<br>
<b>Subject:</b> [PATCH] drm/powerplay: enable dpm under pass-through</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Repeat enable dpm under pass-through because there=
 is no actually<br>
hardware-fini and real power-off when guest vm shutdown or reboot.<br>
Otherwise, under pass-through it will be failed to populate populate<br>
and upload SCLK MCLK DPM levels due to zero of pcie_speed_table.count.<br>
<br>
Change-Id: I7cbc55c650867d00e19241ceea5d98f78b5ac3f5<br>
Signed-off-by: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c | 4 &#43;&#43;&=
#43;-<br>
&nbsp;1 file changed, 3 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
index 53207e7..6ef3c87 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c<br>
@@ -75,10 &#43;75,12 @@ int phm_set_power_state(struct pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D NU=
LL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev =3D hwmgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smum_is_dpm_running(hwmgr)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smum_is_dpm_running(hwmgr) &a=
mp;&amp; !amdgpu_passthrough(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;dpm has been enabled\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB1809E891E4E83258B04BC959F7320BN6PR12MB1809namp_--

--===============1387597788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1387597788==--
