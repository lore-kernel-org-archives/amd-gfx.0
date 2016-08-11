From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
Date: Thu, 11 Aug 2016 15:48:19 +0000
Message-ID: <DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160811143253.24718-1-tom.stdenis@amd.com>
 <20160811143253.24718-4-tom.stdenis@amd.com>,
 <MWHPR12MB1694FE8258E0ADB4F32DC885F71E0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1495523717=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694FE8258E0ADB4F32DC885F71E0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1495523717==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Just trying to make it easier to read.


WREG32_FIELD(foo, FIELD, 1);


Is easier to read than


WREG32_P(foo, FOO__FIELD_MASK, ~FOO__FIELD_MASK);


(also I already pushed them after getting a RB by Christian this morning so=
 we might need to hold a different discussion).


I agree it's not really a functional change but making things a bit more un=
iform and easier to read helps maintenance.  And I did find a bug in the pr=
ocess :-)


Tom


________________________________
From: Deucher, Alexander
Sent: Thursday, August 11, 2016 11:46
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: RE: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Thursday, August 11, 2016 10:33 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: StDenis, Tom
> Subject: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

A couple pieces of this patch could be split out as separate cleanups (see =
below).  However, I'm not sure how much value there is in switching WREG32_=
P for WREG_FIELD other than code churn.  They basically do the same thing.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 39 +++++++++++++-------------
> ---------
>  1 file changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 80a37a602181..21ba219e943b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -127,15 +127,10 @@ static int vce_v2_0_start(struct amdgpu_device
> *adev)
>        WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>        WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
>
> -     WREG32_P(mmVCE_VCPU_CNTL,
> VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> -
> -     WREG32_P(mmVCE_SOFT_RESET,
> -              VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> -              ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> -
> +     WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);
> +     WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>        mdelay(100);
> -
> -     WREG32_P(mmVCE_SOFT_RESET, 0,
> ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +     WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
>
>        for (i =3D 0; i < 10; ++i) {
>                uint32_t status;
> @@ -150,10 +145,9 @@ static int vce_v2_0_start(struct amdgpu_device
> *adev)
>                        break;
>
>                DRM_ERROR("VCE not responding, trying to reset the
> ECPU!!!\n");
> -             WREG32_P(mmVCE_SOFT_RESET,
> VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> -
>        ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>                mdelay(10);
> -             WREG32_P(mmVCE_SOFT_RESET, 0,
> ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
>                mdelay(10);
>                r =3D -1;
>        }
> @@ -345,13 +339,13 @@ static void vce_v2_0_set_dyn_cg(struct
> amdgpu_device *adev, bool gated)
>                        DRM_INFO("VCE is busy, Can't set clock gateing");
>                        return;
>                }
> -             WREG32_P(mmVCE_VCPU_CNTL, 0,
> ~VCE_VCPU_CNTL__CLK_EN_MASK);
> -             WREG32_P(mmVCE_SOFT_RESET,
> VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 0);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>                mdelay(100);
>                WREG32(mmVCE_STATUS, 0);
>        } else {
> -             WREG32_P(mmVCE_VCPU_CNTL,
> VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> -             WREG32_P(mmVCE_SOFT_RESET,
> VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>                mdelay(100);
>        }
>
> @@ -458,9 +452,7 @@ static void vce_v2_0_mc_resume(struct
> amdgpu_device *adev)
>        WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
>
>        WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> -
> -     WREG32_P(mmVCE_SYS_INT_EN,
> VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,
> -
> ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> +     WREG32_FIELD(VCE_SYS_INT_EN,
> VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);
>
>        vce_v2_0_init_cg(adev);
>  }
> @@ -474,11 +466,11 @@ static bool vce_v2_0_is_idle(void *handle)
>
>  static int vce_v2_0_wait_for_idle(void *handle)
>  {
> -     unsigned i;
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     unsigned i;
>
>        for (i =3D 0; i < adev->usec_timeout; i++) {
> -             if (!(RREG32(mmSRBM_STATUS2) &
> SRBM_STATUS2__VCE_BUSY_MASK))
> +             if (vce_v2_0_is_idle(handle))
>                        return 0;

This could be split out as a separate patch.

>        }
>        return -ETIMEDOUT;
> @@ -488,8 +480,7 @@ static int vce_v2_0_soft_reset(void *handle)
>  {
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -     WREG32_P(mmSRBM_SOFT_RESET,
> SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK,
> -                     ~SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK);
> +     WREG32_FIELD(SRBM_SOFT_RESET, SOFT_RESET_VCE, 1);
>        mdelay(5);
>
>        return vce_v2_0_start(adev);
> @@ -516,10 +507,8 @@ static int vce_v2_0_process_interrupt(struct
> amdgpu_device *adev,
>        DRM_DEBUG("IH: VCE\n");
>        switch (entry->src_data) {
>        case 0:
> -             amdgpu_fence_process(&adev->vce.ring[0]);
> -             break;
>        case 1:
> -             amdgpu_fence_process(&adev->vce.ring[1]);
> +             amdgpu_fence_process(&adev->vce.ring[entry->src_data]);
>                break;
>        default:
>                DRM_ERROR("Unhandled interrupt: %d %d\n",

This too.

> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0DM5PR12MB1132namp_
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
<p>Just trying to make it easier to read. &nbsp;</p>
<p><br>
</p>
<p>WREG32_FIELD(foo, FIELD, 1);</p>
<p><br>
</p>
<p>Is easier to read than</p>
<p><br>
</p>
<p>WREG32_P(foo, FOO__FIELD_MASK, ~FOO__FIELD_MASK);</p>
<p><br>
</p>
<p>(also I already pushed them after getting a RB by Christian this morning=
 so we might need to hold a different discussion).</p>
<p><br>
</p>
<p>I agree it's not really a functional change but making things a bit more=
 uniform and easier to read helps maintenance. &nbsp;And I did find a bug i=
n the process :-)</p>
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
<b>Sent:</b> Thursday, August 11, 2016 11:46<br>
<b>To:</b> 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Thursday, August 11, 2016 10:33 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
A couple pieces of this patch could be split out as separate cleanups (see =
below).&nbsp; However, I'm not sure how much value there is in switching WR=
EG32_P for WREG_FIELD other than code churn.&nbsp; They basically do the sa=
me thing.&nbsp;
<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 39 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&gt; ---------<br>
&gt;&nbsp; 1 file changed, 14 insertions(&#43;), 25 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; index 80a37a602181..21ba219e943b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; @@ -127,15 &#43;127,10 @@ static int vce_v2_0_start(struct amdgpu_devi=
ce<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_BASE_HI2, up=
per_32_bits(ring-&gt;gpu_addr));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_SIZE2, ring-=
&gt;ring_size / 4);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_VCPU_CNTL,<br>
&gt; VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_R=
ESET, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(100);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SOFT_RESET, 0,<br>
&gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_R=
ESET, 0);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 10; &#4=
3;&#43;i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t status;<br>
&gt; @@ -150,10 &#43;145,9 @@ static int vce_v2_0_start(struct amdgpu_devic=
e<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;VCE not responding, trying to reset the=
<br>
&gt; ECPU!!!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_SOFT_R=
ESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET, 0,<br>
&gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D -1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -345,13 &#43;339,13 @@ static void vce_v2_0_set_dyn_cg(struct<br>
&gt; amdgpu_device *adev, bool gated)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INF=
O(&quot;VCE is busy, Can't set clock gateing&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_VCPU_CNTL, 0,<br>
&gt; ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_STATUS, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_VCPU_CNTL,<br>
&gt; VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; @@ -458,9 &#43;452,7 @@ static void vce_v2_0_mc_resume(struct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_VCPU_CACHE_SIZE=
2, size);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CTRL2, 0x=
0, ~0x100);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SYS_INT_EN,<br>
&gt; VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,<br>
&gt; -<br>
&gt; ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_SYS_INT_EN,<br>
&gt; VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v2_0_init_cg(adev);<br>
&gt;&nbsp; }<br>
&gt; @@ -474,11 &#43;466,11 @@ static bool vce_v2_0_is_idle(void *handle)<b=
r>
&gt; <br>
&gt;&nbsp; static int vce_v2_0_wait_for_idle(void *handle)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!(RREG32(mmSRBM_STATUS2) &amp;<br>
&gt; SRBM_STATUS2__VCE_BUSY_MASK))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (vce_v2_0_is_idle(handle))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
<br>
This could be split out as a separate patch.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; @@ -488,8 &#43;480,7 @@ static int vce_v2_0_soft_reset(void *handle)<b=
r>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmSRBM_SOFT_RESET,<br>
&gt; SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~SRBM_SOFT_RESET__SOFT_=
RESET_VCE_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(SRBM_SOFT_RESET, SOFT_RESET=
_VCE, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(5);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vce_v2_0_start(adev);=
<br>
&gt; @@ -516,10 &#43;507,8 @@ static int vce_v2_0_process_interrupt(struct<=
br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;IH: VCE\n&qu=
ot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (entry-&gt;src_data) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_fence_process(&amp;adev-&gt;vce.ring[0]);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_fence_process(&amp;adev-&gt;vce.ring[1]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_fence_process(&amp;adev-&gt;vce.ring[entry-&gt;src_data]);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Unhandled interrupt: %d %d\n&quot;,<br>
<br>
This too.<br>
<br>
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

--_000_DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0DM5PR12MB1132namp_--

--===============1495523717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1495523717==--
