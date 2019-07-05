From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add mode1 (psp) reset for navi asic
Date: Fri, 5 Jul 2019 05:07:34 +0000
Message-ID: <MN2PR12MB3296F5EC7A912558985C152CA2F50@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190705045740.28107-1-kevin1.wang@amd.com>,
 <DM5PR12MB141852448B0C14F9A544533EFCF50@DM5PR12MB1418.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1034115915=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB141852448B0C14F9A544533EFCF50-2J9CzHegvk81aAVlcVN8UQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Kenenth.Feng-5C7GfCeVMHo@public.gmane.org" <Kenenth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============1034115915==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296F5EC7A912558985C152CA2F50MN2PR12MB3296namp_"

--_000_MN2PR12MB3296F5EC7A912558985C152CA2F50MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

okay, thanks.


Best Regards,

Kevin

________________________________
From: Zhang, Hawking
Sent: Friday, July 5, 2019 1:02:08 PM
To: Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack; Kenenth.Feng-5C7GfCeVMHo@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: add mode1 (psp) reset for navi asic

        if (smu_baco_is_support(smu)) {
                 ret =3D smu_baco_reset(smu);
+       } else {
+               ret =3D nv_asic_mode1_reset(adev);
         }
We don=1B$B!G=1B(Bt need {} for single statements. With that fixed, the pat=
ch is

Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: 2019=1B$BG/=1B(B7=1B$B7n=1B(B5=1B$BF|=1B(B 12:58
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Kenenth.Feng-5C7GfCeVMHo@public.gmane.org; Zhang, Hawking <H=
awking.Zhang-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: add mode1 (psp) reset for navi asic

add mode1 (by psp) reset for navi asic.

Change-Id: Id2e7cb11eb7026296d1488c7c39f895b100f206c
Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index f6f152e6ade4..05fd4736bc0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -256,6 +256,39 @@ static void nv_gpu_pci_config_reset(struct amdgpu_devi=
ce *adev)  }  #endif

+static int nv_asic_mode1_reset(struct amdgpu_device *adev) {
+       u32 i;
+       int ret =3D 0;
+
+       amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+
+       dev_info(adev->dev, "GPU mode1 reset\n");
+
+       /* disable BM */
+       pci_clear_master(adev->pdev);
+
+       pci_save_state(adev->pdev);
+
+       ret =3D psp_gpu_reset(adev);
+       if (ret)
+               dev_err(adev->dev, "GPU mode1 reset failed\n");
+
+       pci_restore_state(adev->pdev);
+
+       /* wait for asic to come out of reset */
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               u32 memsize =3D adev->nbio_funcs->get_memsize(adev);
+
+               if (memsize !=3D 0xffffffff)
+                       break;
+               udelay(1);
+       }
+
+       amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+
+       return ret;
+}
 static int nv_asic_reset(struct amdgpu_device *adev)  {

@@ -272,6 +305,8 @@ static int nv_asic_reset(struct amdgpu_device *adev)

         if (smu_baco_is_support(smu)) {
                 ret =3D smu_baco_reset(smu);
+       } else {
+               ret =3D nv_asic_mode1_reset(adev);
         }

         return ret;
--
2.22.0


--_000_MN2PR12MB3296F5EC7A912558985C152CA2F50MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">okay, thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking<br>
<b>Sent:</b> Friday, July 5, 2019 1:02:08 PM<br>
<b>To:</b> Wang, Kevin(Yang); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xiao, Jack; Kenenth.Feng-5C7GfCeVMHo@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: add mode1 (psp) reset for navi asic=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu=
_baco_is_support(smu)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_baco_reset(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D nv_asic_mode1_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
We don=1B$B!G=1B(Bt need {} for single statements. With that fixed, the pat=
ch is<br>
<br>
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt; <br>
Sent: 2019=1B$BG/=1B(B7=1B$B7n=1B(B5=1B$BF|=1B(B 12:58<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Kenenth.Feng-5C7GfCeVMHo@public.gmane.org; Zhang, Hawk=
ing &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
Subject: [PATCH] drm/amdgpu: add mode1 (psp) reset for navi asic<br>
<br>
add mode1 (by psp) reset for navi asic.<br>
<br>
Change-Id: Id2e7cb11eb7026296d1488c7c39f895b100f206c<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c | 35 &#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 35 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c index f6f152e6ade4..05fd4736bc0c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -256,6 &#43;256,39 @@ static void nv_gpu_pci_config_reset(struct amdgpu_=
device *adev)&nbsp; }&nbsp; #endif<br>
&nbsp;<br>
&#43;static int nv_asic_mode1_reset(struct amdgpu_device *adev) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engi=
ne_hung(adev, true);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU =
mode1 reset\n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable BM */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_clear_master(adev-&gt;pdev);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_save_state(adev-&gt;pdev);<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_gpu_reset(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GPU mode1 reset failed\n&quot;);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_restore_state(adev-&gt;pdev);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come out of r=
eset */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;use=
c_timeout; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; u32 memsize =3D adev-&gt;nbio_funcs-&gt;get_memsize(adev);<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (memsize !=3D 0xffffffff)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; udelay(1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engi=
ne_hung(adev, false);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&nbsp;static int nv_asic_reset(struct amdgpu_device *adev)&nbsp; {<br>
&nbsp;<br>
@@ -272,6 &#43;305,8 @@ static int nv_asic_reset(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(sm=
u)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_baco_reset(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D nv_asic_mode1_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
--<br>
2.22.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296F5EC7A912558985C152CA2F50MN2PR12MB3296namp_--

--===============1034115915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1034115915==--
