From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Correct the amdgpu_ucode_fini_bo place for
 Tonga
Date: Thu, 8 Mar 2018 02:59:24 +0000
Message-ID: <BN6PR12MB16527B26D9438D68D212E777F7DF0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1520477702-6291-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068508840=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520477702-6291-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0068508840==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16527B26D9438D68D212E777F7DF0BN6PR12MB1652namp_"

--_000_BN6PR12MB16527B26D9438D68D212E777F7DF0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Emily De=
ng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 7, 2018 9:55:02 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deng, Emily
Subject: [PATCH] drm/amdgpu: Correct the amdgpu_ucode_fini_bo place for Ton=
ga

The amdgpu_ucode_fini_bo should be called after gfx_v8_0_hw_fini,
or it will have KCQ disable failed issue.

For Tonga, as it firstly finishes SMC block, and the SMC hw fini
will call amdgpu_ucode_fini, which will lead the amdgpu_ucode_fini_bo
called before gfx_v8_0_hw_fini, this is incorrect.

Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index aa1e517..ac76983 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1457,6 +1457,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_device=
 *adev)
         }

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
+               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_SMC &&
+                       adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
+                       amdgpu_ucode_fini_bo(adev);
                 if (!adev->ip_blocks[i].status.hw)
                         continue;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_powerplay.c
index 5c2e2d5..825c9b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
@@ -162,9 +162,6 @@ static int amdgpu_pp_hw_fini(void *handle)
                 ret =3D adev->powerplay.ip_funcs->hw_fini(
                                         adev->powerplay.pp_handle);

-       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
-               amdgpu_ucode_fini_bo(adev);
-
         return ret;
 }

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16527B26D9438D68D212E777F7DF0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Emily Deng &lt;Emily.Deng@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, March 7, 2018 9:55:02 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deng, Emily<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Correct the amdgpu_ucode_fini_bo place =
for Tonga</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The amdgpu_ucode_fini_bo should be called after gf=
x_v8_0_hw_fini,<br>
or it will have KCQ disable failed issue.<br>
<br>
For Tonga, as it firstly finishes SMC block, and the SMC hw fini<br>
will call amdgpu_ucode_fini, which will lead the amdgpu_ucode_fini_bo<br>
called before gfx_v8_0_hw_fini, this is incorrect.<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 3 &#43=
;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c | 3 ---<br>
&nbsp;2 files changed, 3 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index aa1e517..ac76983 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1457,6 &#43;1457,9 @@ static int amdgpu_device_ip_fini(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLO=
CK_TYPE_SMC &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fir=
mware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode=
_fini_bo(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.hw)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_powerplay.c<br>
index 5c2e2d5..825c9b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c<br>
@@ -162,9 &#43;162,6 @@ static int amdgpu_pp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D adev-&gt;powerplay.ip_funcs-&gt;hw_fini(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=
=3D AMDGPU_FW_LOAD_SMU)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
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

--_000_BN6PR12MB16527B26D9438D68D212E777F7DF0BN6PR12MB1652namp_--

--===============0068508840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0068508840==--
