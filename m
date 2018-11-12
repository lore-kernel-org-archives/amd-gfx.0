From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix bug with IH ring setup
Date: Mon, 12 Nov 2018 19:33:37 +0000
Message-ID: <BN6PR12MB18094950A3FC8AA193D0A821F7C10@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542050408-19731-1-git-send-email-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018025018=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542050408-19731-1-git-send-email-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1018025018==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18094950A3FC8AA193D0A821F7C10BN6PR12MB1809namp_"

--_000_BN6PR12MB18094950A3FC8AA193D0A821F7C10BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yang, Ph=
ilip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 12, 2018 2:20 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yang, Philip
Subject: [PATCH] drm/amdgpu: fix bug with IH ring setup

The bug limits the IH ring wptr address to 40bit. When the system memory
is bigger than 1TB, the bus address is more than 40bit, this causes the
interrupt cannot be handled and cleared correctly.

Change-Id: I3cd1b8ad046b38945372f2fd1a2d225624893e28
Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c
index a99f717..a0fda6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -129,7 +129,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *ade=
v)
         else
                 wptr_off =3D adev->wb.gpu_addr + (adev->irq.ih.wptr_offs *=
 4);
         WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO, lower_32_bits(wptr_o=
ff));
-       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_of=
f) & 0xFF);
+       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, upper_32_bits(wptr_of=
f) & 0xFFFF);

         /* set rptr, wptr to 0 */
         WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18094950A3FC8AA193D0A821F7C10BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yang, Philip &lt;Philip.Yan=
g@amd.com&gt;<br>
<b>Sent:</b> Monday, November 12, 2018 2:20 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yang, Philip<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix bug with IH ring setup</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The bug limits the IH ring wptr address to 40bit. =
When the system memory<br>
is bigger than 1TB, the bus address is more than 40bit, this causes the<br>
interrupt cannot be handled and cleared correctly.<br>
<br>
Change-Id: I3cd1b8ad046b38945372f2fd1a2d225624893e28<br>
Signed-off-by: Philip Yang &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c<br>
index a99f717..a0fda6f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
@@ -129,7 &#43;129,7 @@ static int vega10_ih_irq_init(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; wptr_off =3D adev-&gt;wb.gpu_addr &#43; (adev-&gt;irq=
.ih.wptr_offs * 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mm=
IH_RB_WPTR_ADDR_LO, lower_32_bits(wptr_off));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_=
ADDR_HI, upper_32_bits(wptr_off) &amp; 0xFF);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_W=
PTR_ADDR_HI, upper_32_bits(wptr_off) &amp; 0xFFFF);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set rptr, wptr to 0 */<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mm=
IH_RB_RPTR, 0);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk129845" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18094950A3FC8AA193D0A821F7C10BN6PR12MB1809namp_--

--===============1018025018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1018025018==--
