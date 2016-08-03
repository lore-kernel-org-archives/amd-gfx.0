From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume defaults
Date: Wed, 3 Aug 2016 16:31:11 +0000
Message-ID: <DM5PR12MB1132B576B670B06A46671827F7060@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160803155142.27161-1-tom.stdenis@amd.com>
 <20160803155142.27161-3-tom.stdenis@amd.com>,
 <CY4PR12MB13012C4621A36F9729CABCABF7060@CY4PR12MB1301.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1071414711=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB13012C4621A36F9729CABCABF7060-rpdhrqHFk05CiBuckNFh9wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1071414711==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132B576B670B06A46671827F7060DM5PR12MB1132namp_"

--_000_DM5PR12MB1132B576B670B06A46671827F7060DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The logic is a bit confusing at first.  "gated" means that SW CG is enabled=
 not that the clocks are turned off.  When I sampled the registers in the o=
riginal configuration the clocks were reading 100% when the core was active=
.  It would read 0% when idle but only because power was gated.


With the logic the way it is when the core is active I see many of the cloc=
ks throttle as they should.


Tom


________________________________
From: Deucher, Alexander
Sent: Wednesday, August 3, 2016 12:28
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: RE: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume defaul=
ts

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Wednesday, August 03, 2016 11:52 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: StDenis, Tom
> Subject: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume
> defaults
>
> CG was being enabled in reverse sense from dpm/powerplay.
> Also fix the default CLK_EN signal to enable all of the blocks.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 26fb606e2d3e..93604bb78257 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -130,7 +130,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(struct
> amdgpu_device *adev,
>        /* Set Override to disable Clock Gating */
>        vce_v3_0_override_vce_clock_gating(adev, true);
>
> -     if (!gated) {
> +     if (gated) {
>                /* Force CLOCK ON for VCE_CLOCK_GATING_B,
>                 * {*_FORCE_ON, *_FORCE_OFF} =3D {1, 0}

This doesn't make sense to me unless I'm mis-understanding the specific CG =
feature.  Forcing the clocks on, implies ungating, not gating.  In this cas=
e if forcing the clocks on part of the fw controlled clockgating configurat=
ion?  If so, please add a comment to that effect in the function.

Alex

>                 * VREG can be FORCE ON or set to Dynamic, but can't be OF=
F
> @@ -153,7 +153,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(struct
> amdgpu_device *adev,
>                /* set VCE_UENC_CLOCK_GATING_2 */
>                tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
>                data |=3D 0x2;
> -             data &=3D ~0x2;
> +             data &=3D ~0x00010000;
>                if (tmp !=3D data)
>                        WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
>
> @@ -538,7 +538,7 @@ static void vce_v3_0_mc_resume(struct
> amdgpu_device *adev, int idx)
>        WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
>        WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000,
> ~0xFF9FF000);
>        WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
> -     WREG32(mmVCE_CLOCK_GATING_B, 0xf7);
> +     WREG32(mmVCE_CLOCK_GATING_B, 0x1FF);
>
>        WREG32(mmVCE_LMI_CTRL, 0x00398000);
>        WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1132B576B670B06A46671827F7060DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>The logic is a bit confusing at first. &nbsp;&quot;gated&quot; means tha=
t SW CG is enabled not that the clocks are turned off. &nbsp;When I sampled=
 the registers in the original configuration the clocks were reading 100% w=
hen the core was active. &nbsp;It would read 0% when idle
 but only because power was gated.</p>
<p><br>
</p>
<p>With the logic the way it is when the core is active I see many of the c=
locks throttle as they should.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Wednesday, August 3, 2016 12:28<br>
<b>To:</b> 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume=
 defaults</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Wednesday, August 03, 2016 11:52 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH 2/6] drm/amd/amdgpu: Fix VCE CG order and resume<br>
&gt; defaults<br>
&gt; <br>
&gt; CG was being enabled in reverse sense from dpm/powerplay.<br>
&gt; Also fix the default CLK_EN signal to enable all of the blocks.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 6 &#43;&#43;&#43;---<br>
&gt;&nbsp; 1 file changed, 3 insertions(&#43;), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; index 26fb606e2d3e..93604bb78257 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; @@ -130,7 &#43;130,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(s=
truct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set Override to disable C=
lock Gating */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_=
gating(adev, true);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (gated) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Force CLOCK ON for VCE_CLOCK_GATING_B,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * {*_FORCE_ON, *_FORCE_OFF} =3D {1, 0}<br>
<br>
This doesn't make sense to me unless I'm mis-understanding the specific CG =
feature.&nbsp; Forcing the clocks on, implies ungating, not gating.&nbsp; I=
n this case if forcing the clocks on part of the fw controlled clockgating =
configuration?&nbsp; If so, please add a comment
 to that effect in the function.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * VREG can be FORCE ON or set to Dynamic, but can=
't be OFF<br>
&gt; @@ -153,7 &#43;153,7 @@ static void vce_v3_0_set_vce_sw_clock_gating(s=
truct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* set VCE_UENC_CLOCK_GATING_2 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~0x2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data &amp;=3D ~0x00010000;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (tmp !=3D data)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(=
mmVCE_UENC_CLOCK_GATING_2, data);<br>
&gt; <br>
&gt; @@ -538,7 &#43;538,7 @@ static void vce_v3_0_mc_resume(struct<br>
&gt; amdgpu_device *adev, int idx)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_CLOCK_GATING_=
A, 0, ~(1 &lt;&lt; 16));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_UENC_CLOCK_GA=
TING, 0x1FF000,<br>
&gt; ~0xFF9FF000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_UENC_REG_CLOC=
K_GATING, 0x3F, ~0x3F);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0xf7);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0x1FF);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_LMI_CTRL, 0x003=
98000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CACHE_CTR=
L, 0x0, ~0x1);<br>
&gt; --<br>
&gt; 2.9.2<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1132B576B670B06A46671827F7060DM5PR12MB1132namp_--

--===============1071414711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1071414711==--
