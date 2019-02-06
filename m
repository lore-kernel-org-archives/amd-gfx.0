From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()
Date: Wed, 6 Feb 2019 17:01:32 +0000
Message-ID: <SN1PR12MB23657F8FB9109F776FD56F46F06F0@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190206154921.14463-1-Yong.Zhao@amd.com>,
 <20190206154921.14463-2-Yong.Zhao@amd.com>,
 <DM5PR12MB1707AB38B8039A41F07FC1E7926F0@DM5PR12MB1707.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0592160758=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1707AB38B8039A41F07FC1E7926F0-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0592160758==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB23657F8FB9109F776FD56F46F06F0SN1PR12MB2365namp_"

--_000_SN1PR12MB23657F8FB9109F776FD56F46F06F0SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Not too sure about this, but it looks strange in the code when all other si=
milar code uses 64-bit.

"Maybe it makes more sense to think of 64-bit doorbells as using 2 doorbell=
 indexes". You mean the alternative is to multiply all the current 64 doorb=
ell index constants with 2, right? That might be easier and cleaner, and we=
 need to make sure that the *2 and << 1 conversions from 64-bit index to dw=
ord index are all removed.

Regards,
Yong
________________________________
From: Kuehling, Felix
Sent: Wednesday, February 6, 2019 11:26 AM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()

Are you sure about this? Typically 64-bit doorbells don't wrap around. But =
this one does. If the IH doorbell wraps around, there is no reason why it n=
eeds to be 64-bit, so I suspect it may still be a 32-bit doorbell.

AFAIK, not all doorbells on Vega10 are 64-bit. It depends on the IP block. =
Therefore, maybe some of your other renaming changes should be reconsidered=
 if they assume that all doorbells are 64-bit. Maybe it makes more sense to=
 think of 64-bit doorbells as using 2 doorbell indexes.

Regards,
  Felix

________________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhao, Yo=
ng <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, February 6, 2019 10:49 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhao, Yong
Subject: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()

Clearly, it should be a 64-bit doorbell operation.

Change-Id: I644a2ebcb18c2ede24ee15692a6189efad10a35c
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c
index 796004896661..36f0e3cada30 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -377,7 +377,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device *ad=
ev,
        if (ih->use_doorbell) {
                /* XXX check if swapping is necessary on BE */
                *ih->rptr_cpu =3D ih->rptr;
-               WDOORBELL32(ih->doorbell_idx_in_dw, ih->rptr);
+               WDOORBELL64(ih->doorbell_idx_in_dw, ih->rptr);
        } else if (ih =3D=3D &adev->irq.ih) {
                WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
        } else if (ih =3D=3D &adev->irq.ih1) {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN1PR12MB23657F8FB9109F776FD56F46F06F0SN1PR12MB2365namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Not too sure about this, but it looks strange in the code when all other si=
milar code uses 64-bit.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">&quot;Maybe
 it makes more sense to think of 64-bit doorbells as using 2 doorbell index=
es&quot;. You mean the alternative is to multiply all the current 64 doorbe=
ll index constants with 2, right? That might be easier and cleaner, and we =
need to make sure that the *2 and &lt;&lt;
 1 conversions from 64-bit index to dword index are all removed.&nbsp;</spa=
n></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Regards,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Yong</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Wednesday, February 6, 2019 11:26 AM<br>
<b>To:</b> Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rpt=
r()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Are you sure about this? Typically 64-bit doorbell=
s don't wrap around. But this one does. If the IH doorbell wraps around, th=
ere is no reason why it needs to be 64-bit, so I suspect it may still be a =
32-bit doorbell.<br>
<br>
AFAIK, not all doorbells on Vega10 are 64-bit. It depends on the IP block. =
Therefore, maybe some of your other renaming changes should be reconsidered=
 if they assume that all doorbells are 64-bit. Maybe it makes more sense to=
 think of 64-bit doorbells as using
 2 doorbell indexes.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
________________________________________<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zh=
ao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
Sent: Wednesday, February 6, 2019 10:49 AM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Zhao, Yong<br>
Subject: [PATCH 2/3] drm/amdgpu: Fix a typo in vega10_ih_set_rptr()<br>
<br>
Clearly, it should be a 64-bit doorbell operation.<br>
<br>
Change-Id: I644a2ebcb18c2ede24ee15692a6189efad10a35c<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c<br>
index 796004896661..36f0e3cada30 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
@@ -377,7 &#43;377,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device=
 *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;use_doorbell) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* XXX check if swapping is necessary on BE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; *ih-&gt;rptr_cpu =3D ih-&gt;rptr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WDOORBELL32(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WDOORBELL64(ih-&gt;doorbell_idx_in_dw, ih-&gt;rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;adev-&=
gt;irq.ih) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih-&gt;rptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;adev-&=
gt;irq.ih1) {<br>
--<br>
2.17.1<br>
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

--_000_SN1PR12MB23657F8FB9109F776FD56F46F06F0SN1PR12MB2365namp_--

--===============0592160758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0592160758==--
