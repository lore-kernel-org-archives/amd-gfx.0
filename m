From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: S3 resumed failed after 4-5 times loop
Date: Thu, 18 Aug 2016 15:24:19 +0000
Message-ID: <CY4PR12MB1687869929F2F96EF9541E0BFB150@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1471524131-5357-1-git-send-email-Jim.Qu@amd.com>,
 <8b1a399d-0054-c356-8775-60cdd83d5004@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1511359392=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8b1a399d-0054-c356-8775-60cdd83d5004-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1511359392==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687869929F2F96EF9541E0BFB150CY4PR12MB1687namp_"

--_000_CY4PR12MB1687869929F2F96EF9541E0BFB150CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

do we need to check those status(lmi status,firmware loaded, vce status and=
 etc) when vce suspend?


it is weird that we didn't implement vce suspend function as hw spec sugges=
ted.


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Thursday, August 18, 2016 9:27:57 PM
To: Qu, Jim; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: S3 resumed failed after 4-5 times loop

Am 18.08.2016 um 14:42 schrieb jimqu:
> phenomenon: software hang when device resume back, read UVD fence is 0xff=
ffffff
> and read pcie pid is 0xffff.
> the issue is caused by VCE reset when update cg setting. according to HW =
programming
> guide, adjust update VCE cg sequence.
>
> Change-Id: I18b12eea21c045908cdd23f93a0b196b87bfed6c
> Signed-off-by: JimQu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>

You should probably note in the commit log that this only applies to
systems with VCE2, e.g. CIK.

Additional to that please make sure that it applies cleanly to the
amd-staging-4.6 branch.

With that made sure the patch is Reviewed-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 123 +++++++++++++++++++++++----=
-------
>   1 file changed, 84 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vce_v2_0.c
> index 9e70df9..6ce7c07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -40,10 +40,12 @@
>   #define VCE_V2_0_FW_SIZE    (256 * 1024)
>   #define VCE_V2_0_STACK_SIZE (64 * 1024)
>   #define VCE_V2_0_DATA_SIZE  (23552 * AMDGPU_MAX_VCE_HANDLES)
> +#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK        0x02
>
>   static void vce_v2_0_mc_resume(struct amdgpu_device *adev);
>   static void vce_v2_0_set_ring_funcs(struct amdgpu_device *adev);
>   static void vce_v2_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vce_v2_0_wait_for_idle(void *handle);
>
>   /**
>    * vce_v2_0_ring_get_rptr - get read pointer
> @@ -96,6 +98,49 @@ static void vce_v2_0_ring_set_wptr(struct amdgpu_ring =
*ring)
>                WREG32(mmVCE_RB_WPTR2, ring->wptr);
>   }
>
> +static int vce_v2_0_lmi_clean(struct amdgpu_device *adev)
> +{
> +     int i, j;
> +
> +     for (i =3D 0; i < 10; ++i) {
> +             for (j =3D 0; j < 100; ++j) {
> +                     uint32_t status =3D RREG32(mmVCE_LMI_STATUS);
> +
> +                     if (status & 0x337f)
> +                             return 0;
> +                     mdelay(10);
> +             }
> +     }
> +
> +     return -ETIMEDOUT;
> +}
> +
> +static int vce_v2_0_firmware_loaded(struct amdgpu_device *adev)
> +{
> +     int i, j;
> +
> +     for (i =3D 0; i < 10; ++i) {
> +             for (j =3D 0; j < 100; ++j) {
> +                     uint32_t status =3D RREG32(mmVCE_STATUS);
> +
> +                     if (status & VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK)
> +                             return 0;
> +                     mdelay(10);
> +             }
> +
> +             DRM_ERROR("VCE not responding, trying to reset the ECPU!!!\=
n");
> +             WREG32_P(mmVCE_SOFT_RESET,
> +                     VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> +                     ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             mdelay(10);
> +             WREG32_P(mmVCE_SOFT_RESET, 0,
> +                     ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             mdelay(10);
> +     }
> +
> +     return -ETIMEDOUT;
> +}
> +
>   /**
>    * vce_v2_0_start - start VCE block
>    *
> @@ -106,7 +151,7 @@ static void vce_v2_0_ring_set_wptr(struct amdgpu_ring=
 *ring)
>   static int vce_v2_0_start(struct amdgpu_device *adev)
>   {
>        struct amdgpu_ring *ring;
> -     int i, j, r;
> +     int r;
>
>        vce_v2_0_mc_resume(adev);
>
> @@ -137,26 +182,7 @@ static int vce_v2_0_start(struct amdgpu_device *adev=
)
>
>        WREG32_P(mmVCE_SOFT_RESET, 0, ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MAS=
K);
>
> -     for (i =3D 0; i < 10; ++i) {
> -             uint32_t status;
> -             for (j =3D 0; j < 100; ++j) {
> -                     status =3D RREG32(mmVCE_STATUS);
> -                     if (status & 2)
> -                             break;
> -                     mdelay(10);
> -             }
> -             r =3D 0;
> -             if (status & 2)
> -                     break;
> -
> -             DRM_ERROR("VCE not responding, trying to reset the ECPU!!!\=
n");
> -             WREG32_P(mmVCE_SOFT_RESET, VCE_SOFT_RESET__ECPU_SOFT_RESET_=
MASK,
> -                             ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> -             mdelay(10);
> -             WREG32_P(mmVCE_SOFT_RESET, 0, ~VCE_SOFT_RESET__ECPU_SOFT_RE=
SET_MASK);
> -             mdelay(10);
> -             r =3D -1;
> -     }
> +     r =3D vce_v2_0_firmware_loaded(adev);
>
>        /* clear BUSY flag */
>        WREG32_P(mmVCE_STATUS, 0, ~1);
> @@ -338,31 +364,50 @@ static void vce_v2_0_set_sw_cg(struct amdgpu_device=
 *adev, bool gated)
>
>   static void vce_v2_0_set_dyn_cg(struct amdgpu_device *adev, bool gated)
>   {
> -     u32 orig, tmp;
> +     if (vce_v2_0_wait_for_idle(adev)) {
> +             DRM_INFO("VCE is busy, Can't set clock gateing");
> +             return;
> +     }
>
> -     tmp =3D RREG32(mmVCE_CLOCK_GATING_B);
> -     tmp &=3D ~0x00060006;
> +     WREG32_P(mmVCE_LMI_CTRL2, 0x100, ~0x100);
> +
> +     if (vce_v2_0_lmi_clean(adev)) {
> +             DRM_INFO("LMI is busy, Can't set clock gateing");
> +             return;
> +     }
> +
> +     WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +     WREG32_P(mmVCE_SOFT_RESET,
> +              VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> +              ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +     WREG32(mmVCE_STATUS, 0);
> +
> +     if (gated)
> +             WREG32(mmVCE_CGTT_CLK_OVERRIDE, 0);
> +     /* LMI_MC/LMI_UMC always set in dynamic, set {CGC_*_GATE_MODE, CGC_=
*_SW_GATE} =3D {0, 0} */
>        if (gated) {
> -             tmp |=3D 0xe10000;
> +             /* Force CLOCK OFF , set {CGC_*_GATE_MODE, CGC_*_SW_GATE} =
=3D {*, 1} */
> +             WREG32(mmVCE_CLOCK_GATING_B, 0xe90010);
>        } else {
> -             tmp |=3D 0xe1;
> -             tmp &=3D ~0xe10000;
> +             /* Force CLOCK ON, set {CGC_*_GATE_MODE, CGC_*_SW_GATE} =3D=
 {1, 0} */
> +             WREG32(mmVCE_CLOCK_GATING_B, 0x800f1);
>        }
> -     WREG32(mmVCE_CLOCK_GATING_B, tmp);
>
> -     orig =3D tmp =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> -     tmp &=3D ~0x1fe000;
> -     tmp &=3D ~0xff000000;
> -     if (tmp !=3D orig)
> -             WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +     /* Set VCE_UENC_CLOCK_GATING always in dynamic mode {*_FORCE_ON, *_=
FORCE_OFF} =3D {0, 0}*/;
> +     WREG32(mmVCE_UENC_CLOCK_GATING, 0x40);
>
> -     orig =3D tmp =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> -     tmp &=3D ~0x3fc;
> -     if (tmp !=3D orig)
> -             WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +     /* set VCE_UENC_REG_CLOCK_GATING always in dynamic mode */
> +     WREG32(mmVCE_UENC_REG_CLOCK_GATING, 0x00);
>
> -     if (gated)
> -             WREG32(mmVCE_CGTT_CLK_OVERRIDE, 0);
> +     WREG32_P(mmVCE_LMI_CTRL2, 0, ~0x100);
> +     if(!gated) {
> +             WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_=
VCPU_CNTL__CLK_EN_MASK);
> +             mdelay(100);
> +             WREG32_P(mmVCE_SOFT_RESET, 0, ~VCE_SOFT_RESET__ECPU_SOFT_RE=
SET_MASK);
> +
> +             vce_v2_0_firmware_loaded(adev);
> +             WREG32_P(mmVCE_STATUS, 0, ~VCE_STATUS__JOB_BUSY_MASK);
> +     }
>   }
>
>   static void vce_v2_0_disable_cg(struct amdgpu_device *adev)


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687869929F2F96EF9541E0BFB150CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; =
background-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>do we need to check those status(lmi status,firmware loaded, vce status =
and etc) when vce suspend?</p>
<p><br>
</p>
<p>it is weird that we didn't implement vce suspend function as hw spec sug=
gested.</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 18, 2016 9:27:57 PM<br>
<b>To:</b> Qu, Jim; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: S3 resumed failed after 4-5 tim=
es loop</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 18.08.2016 um 14:42 schrieb jimqu:<br>
&gt; phenomenon: software hang when device resume back, read UVD fence is 0=
xffffffff<br>
&gt; and read pcie pid is 0xffff.<br>
&gt; the issue is caused by VCE reset when update cg setting. according to =
HW programming<br>
&gt; guide, adjust update VCE cg sequence.<br>
&gt;<br>
&gt; Change-Id: I18b12eea21c045908cdd23f93a0b196b87bfed6c<br>
&gt; Signed-off-by: JimQu &lt;Jim.Qu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
You should probably note in the commit log that this only applies to <br>
systems with VCE2, e.g. CIK.<br>
<br>
Additional to that please make sure that it applies cleanly to the <br>
amd-staging-4.6 branch.<br>
<br>
With that made sure the patch is Reviewed-by: Christian K=F6nig <br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 123 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;-----------<br>
&gt;&nbsp;&nbsp; 1 file changed, 84 insertions(&#43;), 39 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v2_0.c<br>
&gt; index 9e70df9..6ce7c07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
&gt; @@ -40,10 &#43;40,12 @@<br>
&gt;&nbsp;&nbsp; #define VCE_V2_0_FW_SIZE&nbsp;&nbsp;&nbsp; (256 * 1024)<br=
>
&gt;&nbsp;&nbsp; #define VCE_V2_0_STACK_SIZE (64 * 1024)<br>
&gt;&nbsp;&nbsp; #define VCE_V2_0_DATA_SIZE&nbsp; (23552 * AMDGPU_MAX_VCE_H=
ANDLES)<br>
&gt; &#43;#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x02<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vce_v2_0_mc_resume(struct amdgpu_device *adev)=
;<br>
&gt;&nbsp;&nbsp; static void vce_v2_0_set_ring_funcs(struct amdgpu_device *=
adev);<br>
&gt;&nbsp;&nbsp; static void vce_v2_0_set_irq_funcs(struct amdgpu_device *a=
dev);<br>
&gt; &#43;static int vce_v2_0_wait_for_idle(void *handle);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * vce_v2_0_ring_get_rptr - get read pointer<br>
&gt; @@ -96,6 &#43;98,49 @@ static void vce_v2_0_ring_set_wptr(struct amdgp=
u_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_WPTR2, ring-&gt;wptr);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static int vce_v2_0_lmi_clean(struct amdgpu_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 10; &#43;&#43;i) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; for (j =3D 0; j &lt; 100; &#43;&#43;j) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status =3D=
 RREG32(mmVCE_LMI_STATUS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status &amp; 0x=
337f)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vce_v2_0_firmware_loaded(struct amdgpu_device *adev)<b=
r>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 10; &#43;&#43;i) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; for (j =3D 0; j &lt; 100; &#43;&#43;j) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t status =3D=
 RREG32(mmVCE_STATUS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status &amp; VC=
E_STATUS_VCPU_REPORT_FW_LOADED_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;VCE not responding, trying to reset the ECPU!!!\n&q=
uot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_SOFT_RESET__ECP=
U_SOFT_RESET_MASK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__EC=
PU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_P(mmVCE_SOFT_RESET, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__EC=
PU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * vce_v2_0_start - start VCE block<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -106,7 &#43;151,7 @@ static void vce_v2_0_ring_set_wptr(struct amdg=
pu_ring *ring)<br>
&gt;&nbsp;&nbsp; static int vce_v2_0_start(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i, j, r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v2_0_mc_resume(adev);<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -137,26 &#43;182,7 @@ static int vce_v2_0_start(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SOFT_RESET, 0=
, ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 10; &#43;&#43;i) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t status;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (j =3D 0; j &lt; 100; &#43;&#43;j) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D RREG32(mmVCE=
_STATUS);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status &amp; 2)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (status &amp; 2)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;VCE not responding, trying to reset the ECPU!!!\n&quot;=
);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET, VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mdelay(10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET, 0, ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mdelay(10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D -1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vce_v2_0_firmware_loaded(adev);<br=
>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear BUSY flag */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_STATUS, 0, ~1=
);<br>
&gt; @@ -338,31 &#43;364,50 @@ static void vce_v2_0_set_sw_cg(struct amdgpu=
_device *adev, bool gated)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vce_v2_0_set_dyn_cg(struct amdgpu_device *adev=
, bool gated)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 orig, tmp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vce_v2_0_wait_for_idle(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;VCE is busy, Can't set clock gateing&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmVCE_CLOCK_GATING_B);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~0x00060006;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CTRL2, 0x100, ~0x100)=
;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vce_v2_0_lmi_clean(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;LMI is busy, Can't set clock gateing&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_C=
NTL__CLK_EN_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_STATUS, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (gated)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_CGTT_CLK_OVERRIDE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* LMI_MC/LMI_UMC always set in dynamic,=
 set {CGC_*_GATE_MODE, CGC_*_SW_GATE} =3D {0, 0} */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gated) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp |=3D 0xe10000;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Force CLOCK OFF , set {CGC_*_GATE_MODE, CGC_*_SW_GATE} =3D {*, 1=
} */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0xe90010);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp |=3D 0xe1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp &amp;=3D ~0xe10000;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Force CLOCK ON, set {CGC_*_GATE_MODE, CGC_*_SW_GATE} =3D {1, 0} =
*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, 0x800f1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, tmp);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D tmp =3D RREG32(mmVCE_UENC_CLOCK_GAT=
ING);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~0x1fe000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~0xff000000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D orig)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmVCE_UENC_CLOCK_GATING, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Set VCE_UENC_CLOCK_GATING always in d=
ynamic mode {*_FORCE_ON, *_FORCE_OFF} =3D {0, 0}*/;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_CLOCK_GATING, 0x40);<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D tmp =3D RREG32(mmVCE_UENC_REG_CLOCK=
_GATING);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~0x3fc;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D orig)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* set VCE_UENC_REG_CLOCK_GATING always =
in dynamic mode */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_REG_CLOCK_GATING, 0x00=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gated)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmVCE_CGTT_CLK_OVERRIDE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CTRL2, 0, ~0x100);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(!gated) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNT=
L__CLK_EN_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mdelay(100);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_P(mmVCE_SOFT_RESET, 0, ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK=
);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vce_v2_0_firmware_loaded(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_P(mmVCE_STATUS, 0, ~VCE_STATUS__JOB_BUSY_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void vce_v2_0_disable_cg(struct amdgpu_device *adev=
)<br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1687869929F2F96EF9541E0BFB150CY4PR12MB1687namp_--

--===============1511359392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1511359392==--
