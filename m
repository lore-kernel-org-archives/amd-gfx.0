From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix num_doorbell calculation issue
Date: Fri, 30 Nov 2018 15:41:12 +0000
Message-ID: <BN6PR12MB1809921C7AF0B328B32E8410F7D30@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1543592352-6915-1-git-send-email-ozeng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0737638137=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543592352-6915-1-git-send-email-ozeng-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Yin,
 Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>

--===============0737638137==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809921C7AF0B328B32E8410F7D30BN6PR12MB1809namp_"

--_000_BN6PR12MB1809921C7AF0B328B32E8410F7D30BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Oak Zeng=
 <ozeng-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 30, 2018 10:39:21 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yang, Philip; Zeng, Oak; Yin, Tianci (Rico)
Subject: [PATCH] drm/amdgpu: Fix num_doorbell calculation issue

When paging queue is enabled, it use the second page of doorbell.
The AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
kernel doorbells are in the first page. So with paging queue enabled,
the total kernel doorbell range should be original num_doorbell plus
one page (0x400 in dword), not *2.

Change-Id: I62023bb91da33ca5532b22b263771b587b796d59
Signed-off-by: Oak Zeng <ozeng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8eaa40e..c75badf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -539,10 +539,13 @@ static int amdgpu_device_doorbell_init(struct amdgpu_=
device *adev)
                 return -EINVAL;

         /* For Vega, reserve and map two pages on doorbell BAR since SDMA
-        * paging queue doorbell use the second page
+        * paging queue doorbell use the second page. The
+        * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+        * doorbells are in the first page. So with paging queue enabled,
+        * the max num_doorbells should + 1 page (0x400 in dword)
          */
         if (adev->asic_type >=3D CHIP_VEGA10)
-               adev->doorbell.num_doorbells *=3D 2;
+               adev->doorbell.num_doorbells +=3D 0x400;

         adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
                                      adev->doorbell.num_doorbells *
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809921C7AF0B328B32E8410F7D30BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
<b>Sent:</b> Friday, November 30, 2018 10:39:21 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yang, Philip; Zeng, Oak; Yin, Tianci (Rico)<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix num_doorbell calculation issue</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When paging queue is enabled, it use the second pa=
ge of doorbell.<br>
The AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the<br>
kernel doorbells are in the first page. So with paging queue enabled,<br>
the total kernel doorbell range should be original num_doorbell plus<br>
one page (0x400 in dword), not *2.<br>
<br>
Change-Id: I62023bb91da33ca5532b22b263771b587b796d59<br>
Signed-off-by: Oak Zeng &lt;ozeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;&#43;&#=
43;--<br>
&nbsp;1 file changed, 5 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 8eaa40e..c75badf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -539,10 &#43;539,13 @@ static int amdgpu_device_doorbell_init(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For Vega, reserve and m=
ap two pages on doorbell BAR since SDMA<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * paging queue doorbell use the=
 second page<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * paging queue doorbell use=
 the second page. The<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AMDGPU_DOORBELL64_MAX_ASS=
IGNMENT definition assumes all the<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * doorbells are in the firs=
t page. So with paging queue enabled,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the max num_doorbells sho=
uld &#43; 1 page (0x400 in dword)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt=
;=3D CHIP_VEGA10)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;doorbell.num_doorbells *=3D 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;doorbell.num_doorbells &#43;=3D 0x400;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell.ptr =3D =
ioremap(adev-&gt;doorbell.base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;doorbell.num_doorbells *<br>
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

--_000_BN6PR12MB1809921C7AF0B328B32E8410F7D30BN6PR12MB1809namp_--

--===============0737638137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0737638137==--
