From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga
Date: Fri, 7 Dec 2018 15:33:38 +0000
Message-ID: <BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1544148709-7256-1-git-send-email-Tiecheng.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0243742376=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544148709-7256-1-git-send-email-Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou, Tiecheng" <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0243742376==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tiecheng=
 Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 6, 2018 9:11:49 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhou, Tiecheng
Subject: [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga

SWDEV-173384: vm-mix reboot (4 VMs) fail on Tonga under sriov

Phenomena: there is compute_1.3.1 ring test fail on one VM
           when it starts to do hw_init after it is rebooted

Root cause: RLC will go wrong in soft_reset under sriov

Workaround: init RLC csb, and skip RLC stop, reset, start
            this is because GIM has already done
            full initialization on RLC

refer to 'commit cfee05bc9057 ("drm/amdgpu:bypass RLC init for SRIOV")'
     and 'commit f840cc5f8447 ("drm/amdgpu/sriov:init csb for gfxv9")'

Signed-off-by: Tiecehng Zhou <Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 1454fc3..a9c853a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4068,6 +4068,11 @@ static void gfx_v8_0_rlc_start(struct amdgpu_device =
*adev)

 static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)
 {
+       if (amdgpu_sriov(adev)) {
+               gfx_v8_0_init_csb(adev);
+               return 0;
+       }
+
         adev->gfx.rlc.funcs->stop(adev);
         adev->gfx.rlc.funcs->reset(adev);
         gfx_v8_0_init_pg(adev);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tiecheng Zhou &lt;Tiecheng.Zh=
ou-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, December 6, 2018 9:11:49 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhou, Tiecheng<br>
<b>Subject:</b> [PATCH] drm/amdgpu: bypass RLC init under sriov for Tonga</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SWDEV-173384: vm-mix reboot (4 VMs) fail on Tonga =
under sriov<br>
<br>
Phenomena: there is compute_1.3.1 ring test fail on one VM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; when it starts=
 to do hw_init after it is rebooted<br>
<br>
Root cause: RLC will go wrong in soft_reset under sriov<br>
<br>
Workaround: init RLC csb, and skip RLC stop, reset, start<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this is =
because GIM has already done<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; full ini=
tialization on RLC<br>
<br>
refer to 'commit cfee05bc9057 (&quot;drm/amdgpu:bypass RLC init for SRIOV&q=
uot;)'<br>
&nbsp;&nbsp;&nbsp;&nbsp; and 'commit f840cc5f8447 (&quot;drm/amdgpu/sriov:i=
nit csb for gfxv9&quot;)'<br>
<br>
Signed-off-by: Tiecehng Zhou &lt;Tiecheng.Zhou-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 &#43;&#43;&#43;&#43;&#43;<b=
r>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 1454fc3..a9c853a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4068,6 &#43;4068,11 @@ static void gfx_v8_0_rlc_start(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov(adev)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_init_csb(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;stop(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_pg(adev);<br=
>
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

--_000_BN6PR12MB180903FE05AC850D8D4BFEC9F7AA0BN6PR12MB1809namp_--

--===============0243742376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0243742376==--
