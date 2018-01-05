From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display support in
 debugfs
Date: Fri, 5 Jan 2018 15:44:00 +0000
Message-ID: <BN6PR12MB16521B0C1D9FE6C399F09F52F71C0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515152305-17549-1-git-send-email-Rex.Zhu@amd.com>,
 <1515152305-17549-2-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1393486357=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515152305-17549-2-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============1393486357==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16521B0C1D9FE6C399F09F52F71C0BN6PR12MB1652namp_"

--_000_BN6PR12MB16521B0C1D9FE6C399F09F52F71C0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, January 5, 2018 6:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display support in d=
ebugfs

The additional output are: PSTATE_SCLK and PSTATE_MCLK value
in MHz as:

300 MHz (PSTATE_SCLK)
300 MHz (PSTATE_MCLK)

Change-Id: I08645d518635f81bc566d242712b6906ee5413fb
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c         | 2 ++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c  | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index e5ee7cf..4bd48b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1512,6 +1512,8 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file =
*m, struct amdgpu_device *a
                 seq_printf(m, "\t%u MHz (MCLK)\n", value/100);
         if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void=
 *)&value, &size))
                 seq_printf(m, "\t%u MHz (SCLK)\n", value/100);
+       if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_STABLE_PSTATE_CL=
K, (void *)&value, &size))
+               seq_printf(m, "\t%u MHz (PSTATE_SCLK)\n\t%u MHz (PSTATE_MCL=
K)\n", value & 0xffff, (value>>16) & 0xffff);
         if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX, (void *=
)&value, &size))
                 seq_printf(m, "\t%u mV (VDDGFX)\n", value);
         if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)=
&value, &size))
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 0f89d2a8..1be526f 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -122,6 +122,7 @@ enum amd_pp_sensors {
         AMDGPU_PP_SENSOR_VCE_POWER,
         AMDGPU_PP_SENSOR_UVD_POWER,
         AMDGPU_PP_SENSOR_GPU_POWER,
+       AMDGPU_PP_SENSOR_STABLE_PSTATE_CLK,
 };

 enum amd_pp_task {
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 8859b67..a0c5642 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -998,6 +998,14 @@ static int pp_dpm_read_sensor(void *handle, int idx,

         hwmgr =3D pp_handle->hwmgr;

+       if ((idx =3D=3D AMDGPU_PP_SENSOR_STABLE_PSTATE_CLK) && (value !=3D =
NULL)) {
+               mutex_lock(&pp_handle->pp_lock);
+               *((uint32_t *)value) =3D (hwmgr->pstate_sclk / 100 & 0xffff=
) |
+                               ((hwmgr->pstate_mclk / 100 & 0xffff) << 16)=
;

This seems kinda hacky.  Either add two queries or make the query take two =
values.

Alex

+               mutex_unlock(&pp_handle->pp_lock);
+               return 0;
+       }
+
         if (hwmgr->hwmgr_func->read_sensor =3D=3D NULL) {
                 pr_info("%s was not implemented.\n", __func__);
                 return 0;
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16521B0C1D9FE6C399F09F52F71C0BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Friday, January 5, 2018 6:38 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display suppo=
rt in debugfs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The additional output are: PSTATE_SCLK and PSTATE_=
MCLK value<br>
in MHz as:<br>
<br>
300 MHz (PSTATE_SCLK)<br>
300 MHz (PSTATE_MCLK)<br>
<br>
Change-Id: I08645d518635f81bc566d242712b6906ee5413fb<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/include/kgd_pp_interface.h | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp; | 8 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 11 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index e5ee7cf..4bd48b1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -1512,6 &#43;1512,8 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_f=
ile *m, struct amdgpu_device *a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u MHz (MCLK)\n&quot;, value/10=
0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_senso=
r(adev, AMDGPU_PP_SENSOR_GFX_SCLK, (void *)&amp;value, &amp;size))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u MHz (SCLK)\n&quot;, value/10=
0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_sensor(adev,=
 AMDGPU_PP_SENSOR_STABLE_PSTATE_CLK, (void *)&amp;value, &amp;size))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; seq_printf(m, &quot;\t%u MHz (PSTATE_SCLK)\n\t%u MHz (PSTATE=
_MCLK)\n&quot;, value &amp; 0xffff, (value&gt;&gt;16) &amp; 0xffff);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_senso=
r(adev, AMDGPU_PP_SENSOR_VDDGFX, (void *)&amp;value, &amp;size))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;\t%u mV (VDDGFX)\n&quot;, value);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_dpm_read_senso=
r(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&amp;value, &amp;size))<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index 0f89d2a8..1be526f 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -122,6 &#43;122,7 @@ enum amd_pp_sensors {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_VCE_POWER=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_UVD_POWER=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_GPU_POWER=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_PP_SENSOR_STABLE_PSTATE_CL=
K,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum amd_pp_task {<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 8859b67..a0c5642 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -998,6 &#43;998,14 @@ static int pp_dpm_read_sensor(void *handle, int id=
x,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_handle-&gt;hw=
mgr;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((idx =3D=3D AMDGPU_PP_SENSOR_=
STABLE_PSTATE_CLK) &amp;&amp; (value !=3D NULL)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-&gt;pp_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *((uint32_t *)value) =3D (hwmgr-&gt;pstate_sclk / 100 &amp; =
0xffff) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((hwmgr-&gt;pstate_mclk / 100 &amp; 0xf=
fff) &lt;&lt; 16);</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">This seems kinda hacky.&nbsp; Either add two queri=
es or make the query take two values.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Alex<br>
</div>
<div class=3D"PlainText"><br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mutex_unlock(&amp;pp_handle-&gt;pp_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&=
gt;read_sensor =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quot;, __func=
__);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk796199" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16521B0C1D9FE6C399F09F52F71C0BN6PR12MB1652namp_--

--===============1393486357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1393486357==--
