From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: correct reference clock value on vega10
Date: Wed, 11 Oct 2017 08:48:00 +0000
Message-ID: <CY1PR12MB0474780D27899B282A97EE988C4A0@CY1PR12MB0474.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2004270857=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============2004270857==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0474780D27899B282A97EE988C4A0CY1PR12MB0474namp_"

--_000_CY1PR12MB0474780D27899B282A97EE988C4A0CY1PR12MB0474namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

Change-Id: I377029075af1e2e002f7cfd793ddd58d8610e474
Signed-off-by: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 7839677..a510c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -279,10 +279,8 @@ static void soc15_init_golden_registers(struct amdgpu_=
device *adev)
 }
 static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
-       if (adev->asic_type =3D=3D CHIP_VEGA10)
-               return adev->clock.spll.reference_freq/4;
-       else
-               return adev->clock.spll.reference_freq;
+       /* return the value in Khz instead of 10Khz*/
+       return adev->clock.spll.reference_freq * 10;
 }


--
2.7.4


--_000_CY1PR12MB0474780D27899B282A97EE988C4A0CY1PR12MB0474namp_
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
 0); font-family: Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;=
Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Seg=
oe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols;" dir=3D"ltr">
<p><span id=3D"ms-rterangepaste-start"></span><font size=3D"2"><span style=
=3D"font-size:10pt;"></span></font></p>
<font size=3D"2">
<div class=3D"PlainText">From: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Change-Id: I377029075af1e2e002f7cfd793ddd58d8610e474<br>
Signed-off-by: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 6 &#43;&#43;----<br>
&nbsp;1 file changed, 2 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 7839677..a510c8c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -279,10 &#43;279,8 @@ static void soc15_init_golden_registers(struct amd=
gpu_device *adev)<br>
&nbsp;}<br>
&nbsp;static u32 soc15_get_xclk(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VE=
GA10)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;clock.spll.reference_freq/4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return adev-&gt;clock.spll.reference_freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return the value in Khz instea=
d of 10Khz*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;clock.spll.refere=
nce_freq * 10;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-- <br>
2.7.4</div>
</font><span id=3D"ms-rterangepaste-end"></span><br>
<p></p>
</div>
</body>
</html>

--_000_CY1PR12MB0474780D27899B282A97EE988C4A0CY1PR12MB0474namp_--

--===============2004270857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2004270857==--
