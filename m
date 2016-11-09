From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: always un-gate UVD REGS path.
Date: Wed, 9 Nov 2016 10:23:59 +0000
Message-ID: <CY4PR12MB17688DD4BBA4F17F489B4487F7B90@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1478686135-21055-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0799351994=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478686135-21055-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0799351994==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17688DD4BBA4F17F489B4487F7B90CY4PR12MB1768namp_"

--_000_CY4PR12MB17688DD4BBA4F17F489B4487F7B90CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

You could do that as


WREG32_FIELD(UVD_CGC_GATE, REGS, 0);


Unless you need 'data' somewhere else in the function.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 9, 2016 05:08
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 1/2] drm/amdgpu: always un-gate UVD REGS path.

Change-Id: I910a79b551a9b79b635161bb42ac123a23783225
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v4_2.c
index d2c96f1..d686946 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -596,7 +596,10 @@ static void uvd_v4_2_set_dcm(struct amdgpu_device *ade=
v,
                              bool sw_mode)
 {
         u32 tmp, tmp2;
+       u32 data =3D RREG32(mmUVD_CGC_GATE);

+       data &=3D ~UVD_CGC_GATE__REGS_MASK;
+       WREG32(mmUVD_CGC_GATE, data);
         tmp =3D RREG32(mmUVD_CGC_CTRL);
         tmp &=3D ~(UVD_CGC_CTRL__CLK_OFF_DELAY_MASK | UVD_CGC_CTRL__CLK_GA=
TE_DLY_TIMER_MASK);
         tmp |=3D UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK |
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB17688DD4BBA4F17F489B4487F7B90CY4PR12MB1768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>You could do that as&nbsp;</p>
<p><br>
</p>
<p>WREG32_FIELD(UVD_CGC_GATE, REGS, 0);</p>
<p><br>
</p>
<p>Unless you need 'data' somewhere else in the function.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Wednesday, November 9, 2016 05:08<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: always un-gate UVD REGS path.</font=
>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Change-Id: I910a79b551a9b79b635161bb42ac123a237832=
25<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 3 &#43;&#43;&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v4_2.c<br>
index d2c96f1..d686946 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
@@ -596,7 &#43;596,10 @@ static void uvd_v4_2_set_dcm(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool sw_mode)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp, tmp2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data =3D RREG32(mmUVD_CGC_GAT=
E);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~UVD_CGC_GATE__REGS=
_MASK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_GATE, data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmUVD_CGC_C=
TRL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~(UVD_CGC_CTR=
L__CLK_OFF_DELAY_MASK | UVD_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D UVD_CGC_CTRL__DYN=
_CLOCK_MODE_MASK |<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk831725" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB17688DD4BBA4F17F489B4487F7B90CY4PR12MB1768namp_--

--===============0799351994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0799351994==--
