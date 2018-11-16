From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drm/amd:Enable/Disable NBPSTATE on On/OFF of UVD
Date: Fri, 16 Nov 2018 14:53:42 +0000
Message-ID: <BN6PR12MB1809CD70EAB22FB0C61C3C8BF7DD0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542351012-13110-1-git-send-email-suresh.guttula@amd.com>,
 <1542351012-13110-3-git-send-email-suresh.guttula@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1330140003=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542351012-13110-3-git-send-email-suresh.guttula-5C7GfCeVMHo@public.gmane.org>
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
To: "Guttula, Suresh" <Suresh.Guttula-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "Agrawal,
 Akshu" <Akshu.Agrawal-5C7GfCeVMHo@public.gmane.org>

--===============1330140003==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809CD70EAB22FB0C61C3C8BF7DD0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809CD70EAB22FB0C61C3C8BF7DD0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Guttula,=
 Suresh <Suresh.Guttula-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 16, 2018 1:50:37 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Sharma, Deepak; Guttula, Suresh; Agrawal, Akshu
Subject: [PATCH v2 3/3] drm/amd:Enable/Disable NBPSTATE on On/OFF of UVD

We observe black lines (underflow) on display when playing a
4K video with UVD. On Disabling Low memory P state this issue is
not seen.
In this patch ,disabling low memory P state only when video
size >=3D 4k.
Multiple runs of power measurement shows no imapct

Signed-off-by: suresh guttula <suresh.guttula-5C7GfCeVMHo@public.gmane.org>
---
v2: Enable/disable low memory pstate logic added to
    amdgpu_dpm_enable_uvd() instead of parser function

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 7235cd0..66c0dbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -33,6 +33,8 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/nospec.h>
+#include "hwmgr.h"
+#define WIDTH_4K 3840

 static int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);

@@ -1956,6 +1958,21 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *ade=
v, bool enable)
                 amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_=
UVD, !enable);
                 mutex_unlock(&adev->pm.mutex);
         }
+       /* enable/disable Low Memory PState for UVD (4k videos) */
+       if (adev->asic_type =3D=3D CHIP_STONEY &&
+               adev->uvd.decode_image_width >=3D WIDTH_4K) {
+               struct pp_hwmgr *hwmgr;
+               struct pp_instance *pp_handle =3D
+                       (struct pp_instance *)adev->powerplay.pp_handle;
+               if (pp_handle) {
+                       hwmgr =3D pp_handle->hwmgr;
+                       if (hwmgr && hwmgr->hwmgr_func &&
+                               hwmgr->hwmgr_func->update_nbdpm_pstate)
+                               hwmgr->hwmgr_func->update_nbdpm_pstate(hwmg=
r,
+                                                                       !en=
able,
+                                                                       tru=
e);
+               }
+       }
 }

 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c
index 69896f4..4e5d13e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -692,6 +692,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_devic=
e *adev, uint32_t *msg,
         buf_sizes[0x1] =3D dpb_size;
         buf_sizes[0x2] =3D image_size;
         buf_sizes[0x4] =3D min_ctx_size;
+       /* store image width to adjust nb memory pstate */
+       adev->uvd.decode_image_width =3D width;
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.h
index a3ab1a4..5eb6328 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -65,6 +65,8 @@ struct amdgpu_uvd {
         struct drm_sched_entity entity;
         struct delayed_work     idle_work;
         unsigned                harvest_config;
+       /* store image width to adjust nb memory state */
+       unsigned                decode_image_width;
 };

 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809CD70EAB22FB0C61C3C8BF7DD0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Guttula, Suresh &lt;Suresh.Gu=
ttula-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, November 16, 2018 1:50:37 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Sharma, Deepak; Guttula, Suresh; Agrawal, Akshu<br>
<b>Subject:</b> [PATCH v2 3/3] drm/amd:Enable/Disable NBPSTATE on On/OFF of=
 UVD</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We observe black lines (underflow) on display when=
 playing a<br>
4K video with UVD. On Disabling Low memory P state this issue is<br>
not seen.<br>
In this patch ,disabling low memory P state only when video<br>
size &gt;=3D 4k.<br>
Multiple runs of power measurement shows no imapct<br>
<br>
Signed-off-by: suresh guttula &lt;suresh.guttula-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
v2: Enable/disable low memory pstate logic added to<br>
&nbsp;&nbsp;&nbsp; amdgpu_dpm_enable_uvd() instead of parser function<br>
&nbsp;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp; | 17 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |&nbsp; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |&nbsp; 2 &#43;&#43;<br>
&nbsp;3 files changed, 21 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 7235cd0..66c0dbd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -33,6 &#43;33,8 @@<br>
&nbsp;#include &lt;linux/hwmon.h&gt;<br>
&nbsp;#include &lt;linux/hwmon-sysfs.h&gt;<br>
&nbsp;#include &lt;linux/nospec.h&gt;<br>
&#43;#include &quot;hwmgr.h&quot;<br>
&#43;#define WIDTH_4K 3840<br>
&nbsp;<br>
&nbsp;static int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);<br>
&nbsp;<br>
@@ -1956,6 &#43;1958,21 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device =
*adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_=
TYPE_UVD, !enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable/disable Low Memory PSta=
te for UVD (4k videos) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_STONEY &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;uvd.decode_image_width &gt;=3D WIDTH_4K) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct pp_instance *pp_handle =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct pp_i=
nstance *)adev-&gt;powerplay.pp_handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (pp_handle) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp=
_handle-&gt;hwmgr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &a=
mp;&amp; hwmgr-&gt;hwmgr_func &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;update_nbdpm_p=
state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;update_nbdpm_p=
state(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !enable,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)<b=
r>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c<br>
index 69896f4..4e5d13e4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
@@ -692,6 &#43;692,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_d=
evice *adev, uint32_t *msg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_sizes[0x1] =3D dpb_siz=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_sizes[0x2] =3D image_s=
ize;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf_sizes[0x4] =3D min_ctx=
_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* store image width to adjust nb=
 memory pstate */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.decode_image_width =
=3D width;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.h<br>
index a3ab1a4..5eb6328 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
@@ -65,6 &#43;65,8 @@ struct amdgpu_uvd {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity en=
tity;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work&nbsp;&=
nbsp;&nbsp;&nbsp; idle_work;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ha=
rvest_config;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* store image width to adjust nb=
 memory state */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode_im=
age_width;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int amdgpu_uvd_sw_init(struct amdgpu_device *adev);<br>
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

--_000_BN6PR12MB1809CD70EAB22FB0C61C3C8BF7DD0BN6PR12MB1809namp_--

--===============1330140003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1330140003==--
