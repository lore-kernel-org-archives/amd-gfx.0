From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix no irq process when evict vram
Date: Wed, 13 Dec 2017 16:36:32 +0000
Message-ID: <BN6PR12MB16525F17767212FA9471691FF7350@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1513136263-9908-1-git-send-email-yttao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1567006618=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513136263-9908-1-git-send-email-yttao-5C7GfCeVMHo@public.gmane.org>
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

--===============1567006618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16525F17767212FA9471691FF7350BN6PR12MB1652namp_"

--_000_BN6PR12MB16525F17767212FA9471691FF7350BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This seems like a good thing to do in general even with Monk's fix.


Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yintian =
Tao <yttao-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, December 12, 2017 10:37:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tao, Yintian
Subject: [PATCH] drm/amdgpu: Fix no irq process when evict vram

When unload amdgpu driver we use sdma to evict vram but there is no
irq process after sdma completed work which raises that waiting for the
fence costs 2s which will trigger VFLR under SRIOV and at last make
unload driver failed.The reason is that the shutdown varible in adev
is set to true before evict vram, it cause ISR directly return without
processing.Therefore, we need set the varible after evict vram.

Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd
Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a269bbc..80934ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2458,7 +2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
         int r;

         DRM_INFO("amdgpu: finishing device.\n");
-       adev->shutdown =3D true;
         if (adev->mode_info.mode_config_initialized)
                 drm_crtc_force_disable_all(adev->ddev);

@@ -2466,6 +2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
         amdgpu_fence_driver_fini(adev);
         amdgpu_fbdev_fini(adev);
         r =3D amdgpu_fini(adev);
+       adev->shutdown =3D true;
         if (adev->firmware.gpu_info_fw) {
                 release_firmware(adev->firmware.gpu_info_fw);
                 adev->firmware.gpu_info_fw =3D NULL;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16525F17767212FA9471691FF7350BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">This seems like a good thing to d=
o in general even with Monk's fix.
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Tuesday, December 12, 2017 10:37:43 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Tao, Yintian<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix no irq process when evict vram</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">When unload amdgpu driver we use sdma to evict vra=
m but there is no<br>
irq process after sdma completed work which raises that waiting for the<br>
fence costs 2s which will trigger VFLR under SRIOV and at last make<br>
unload driver failed.The reason is that the shutdown varible in adev<br>
is set to true before evict vram, it cause ISR directly return without<br>
processing.Therefore, we need set the varible after evict vram.<br>
<br>
Change-Id: I7bf75481aa0744b99c41672b49670adc70b478bd<br>
Signed-off-by: Yintian Tao &lt;yttao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a269bbc..80934ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2458,7 &#43;2458,6 @@ void amdgpu_device_fini(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;amdgpu: fin=
ishing device.\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shutdown =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mode_info.mod=
e_config_initialized)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_crtc_force_disable_all(adev-&gt;ddev);<br>
&nbsp;<br>
@@ -2466,6 &#43;2465,7 @@ void amdgpu_device_fini(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_driver_fini(a=
dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_fini(adev);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_fini(adev);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shutdown =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.gpu_=
info_fw) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; release_firmware(adev-&gt;firmware.gpu_info_fw);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.gpu_info_fw =3D NULL;<br>
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

--_000_BN6PR12MB16525F17767212FA9471691FF7350BN6PR12MB1652namp_--

--===============1567006618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1567006618==--
