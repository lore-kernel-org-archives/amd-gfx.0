From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Disable sdma wptr polling memory for sriov
Date: Tue, 6 Mar 2018 03:17:08 +0000
Message-ID: <BN6PR12MB1652228A05BA9E5A90DD213EF7D90@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1520302493-20759-1-git-send-email-Emily.Deng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0943414412=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520302493-20759-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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

--===============0943414412==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652228A05BA9E5A90DD213EF7D90BN6PR12MB1652namp_"

--_000_BN6PR12MB1652228A05BA9E5A90DD213EF7D90BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Emily De=
ng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, March 5, 2018 9:14 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deng, Emily
Subject: [PATCH] drm/amdgpu: Disable sdma wptr polling memory for sriov

The sdma wptr polling memory will introduce serious issue sdma hang for
sriov environment on sdma v3.
And the sdma wptr polling memory is only to fix the FLR cornner case, the
issue's probabity is very low.

Change-Id: I2c447533aac6b16d541f58644d141228dd75dfb3
Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c
index ec885ff..44d7d08 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -716,10 +716,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *=
adev)
                 WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI + sdma_offsets[i],
                        upper_32_bits(wptr_gpu_addr));
                 wptr_poll_cntl =3D RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + =
sdma_offsets[i]);
-               if (amdgpu_sriov_vf(adev))
-                       wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl, SD=
MA0_GFX_RB_WPTR_POLL_CNTL, F32_POLL_ENABLE, 1);
-               else
-                       wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl, SD=
MA0_GFX_RB_WPTR_POLL_CNTL, F32_POLL_ENABLE, 0);
+               wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl, SDMA0_GFX_=
RB_WPTR_POLL_CNTL, F32_POLL_ENABLE, 0);
                 WREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + sdma_offsets[i], wp=
tr_poll_cntl);

                 /* enable DMA RB */
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652228A05BA9E5A90DD213EF7D90BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Emily Deng &lt;Emily.Deng@a=
md.com&gt;<br>
<b>Sent:</b> Monday, March 5, 2018 9:14 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deng, Emily<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Disable sdma wptr polling memory for sr=
iov</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The sdma wptr polling memory will introduce seriou=
s issue sdma hang for<br>
sriov environment on sdma v3.<br>
And the sdma wptr polling memory is only to fix the FLR cornner case, the<b=
r>
issue's probabity is very low.<br>
<br>
Change-Id: I2c447533aac6b16d541f58644d141228dd75dfb3<br>
Signed-off-by: Emily Deng &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 5 &#43;----<br>
&nbsp;1 file changed, 1 insertion(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c<br>
index ec885ff..44d7d08 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
@@ -716,10 &#43;716,7 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI &#43; sdma_of=
fsets[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bi=
ts(wptr_gpu_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =3D RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CN=
TL &#43; sdma_offsets[i]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =
=3D REG_SET_FIELD(wptr_poll_cntl, SDMA0_GFX_RB_WPTR_POLL_CNTL, F32_POLL_ENA=
BLE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_poll_cntl =
=3D REG_SET_FIELD(wptr_poll_cntl, SDMA0_GFX_RB_WPTR_POLL_CNTL, F32_POLL_ENA=
BLE, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl, SDMA0_GFX_R=
B_WPTR_POLL_CNTL, F32_POLL_ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL &#43; sdma_offse=
ts[i], wptr_poll_cntl);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* enable DMA RB */<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk353796" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652228A05BA9E5A90DD213EF7D90BN6PR12MB1652namp_--

--===============0943414412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0943414412==--
