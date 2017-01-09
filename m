From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: refine vce3.0 initialize.
Date: Mon, 9 Jan 2017 17:53:20 +0000
Message-ID: <CY4PR12MB17686B9EB91BC0D3CCABA41FF7640@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483968878-1370-1-git-send-email-Rex.Zhu@amd.com>,
 <BN6PR12MB1652DFF695E7EA9413F49C27F7640@BN6PR12MB1652.namprd12.prod.outlook.com>,
 <CY4PR12MB176891CF60F99D5E2B57952CF7640@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152091616=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB176891CF60F99D5E2B57952CF7640-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1152091616==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17686B9EB91BC0D3CCABA41FF7640CY4PR12MB1768namp_"

--_000_CY4PR12MB17686B9EB91BC0D3CCABA41FF7640CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I suspect the patch I NAK'ed on 4.9 "worked but with odd clocks" because it=
 never engaged PG properly.  I'm finding on 4.9 and 4.7 if PG is enabled VC=
E doesn't wake properly.


I've found a "good commit" on 4.7 so I'll continue bisecting.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 9, 2017 11:58
To: Deucher, Alexander; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: refine vce3.0 initialize.


Just a heads up there is a CG/PG regression.  On the tip of 4.7 I can encod=
e with cg/pg disabled but with it enabled it locks up.


I'll try to bisect.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 9, 2017 09:34
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH] drm/amdgpu: refine vce3.0 initialize.

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Monday, January 09, 2017 8:35 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex
> Subject: [PATCH] drm/amdgpu: refine vce3.0 initialize.
>
> 1. disable vce cg when vce hw initialize.
> 2. initizlize vce clock to 10KHz.
> 3: no need to set bypass clock to vce.
>
> Change-Id: I18d5c2debc6688be201af8bb85022ac25020bd8f
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Does this patch fix this bug by any chance?

https://bugzilla.kernel.org/show_bug.cgi?id=3D191281

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++---------------
>  drivers/gpu/drm/amd/amdgpu/vi.c       | 32
> +++++++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 5fb0b7f..eb99ee6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -223,6 +223,9 @@ static int vce_v3_0_start(struct amdgpu_device
> *adev)
>        struct amdgpu_ring *ring;
>        int idx, r;
>
> +     vce_v3_0_override_vce_clock_gating(adev, true); /* force all clocks
> on */
> +     amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
> +
>        ring =3D &adev->vce.ring[0];
>        WREG32(mmVCE_RB_RPTR, ring->wptr);
>        WREG32(mmVCE_RB_WPTR, ring->wptr);
> @@ -701,17 +704,7 @@ static int vce_v3_0_process_interrupt(struct
> amdgpu_device *adev,
>        return 0;
>  }
>
> -static void vce_v3_0_set_bypass_mode(struct amdgpu_device *adev, bool
> enable)
> -{
> -     u32 tmp =3D RREG32_SMC(ixGCK_DFS_BYPASS_CNTL);
> -
> -     if (enable)
> -             tmp |=3D GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;
> -     else
> -             tmp &=3D ~GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;
>
> -     WREG32_SMC(ixGCK_DFS_BYPASS_CNTL, tmp);
> -}
>
>  static int vce_v3_0_set_clockgating_state(void *handle,
>                                          enum amd_clockgating_state state=
)
> @@ -720,11 +713,6 @@ static int vce_v3_0_set_clockgating_state(void
> *handle,
>        bool enable =3D (state =3D=3D AMD_CG_STATE_GATE) ? true : false;
>        int i;
>
> -     if ((adev->asic_type =3D=3D CHIP_POLARIS10) ||
> -             (adev->asic_type =3D=3D CHIP_TONGA) ||
> -             (adev->asic_type =3D=3D CHIP_FIJI))
> -             vce_v3_0_set_bypass_mode(adev, enable);
> -
>        if (!(adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG))
>                return 0;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 16ba943..b9924e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -789,7 +789,37 @@ static int vi_set_uvd_clocks(struct amdgpu_device
> *adev, u32 vclk, u32 dclk)
>
>  static int vi_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32
> ecclk)
>  {
> -     /* todo */
> +     int r, i;
> +     struct atom_clock_dividers dividers;
> +     u32 tmp;
> +
> +     r =3D amdgpu_atombios_get_clock_dividers(adev,
> +
> COMPUTE_GPUCLK_INPUT_FLAG_DEFAULT_GPUCLK,
> +                                            ecclk, false, &dividers);
> +     if (r)
> +             return r;
> +
> +     for (i =3D 0; i < 100; i++) {
> +             if (RREG32_SMC(ixCG_ECLK_STATUS) &
> CG_ECLK_STATUS__ECLK_STATUS_MASK)
> +                     break;
> +             mdelay(10);
> +     }
> +     if (i =3D=3D 100)
> +             return -ETIMEDOUT;
> +
> +     tmp =3D RREG32_SMC(ixCG_ECLK_CNTL);
> +     tmp &=3D ~(CG_ECLK_CNTL__ECLK_DIR_CNTL_EN_MASK |
> +             CG_ECLK_CNTL__ECLK_DIVIDER_MASK);
> +     tmp |=3D dividers.post_divider;
> +     WREG32_SMC(ixCG_ECLK_CNTL, tmp);
> +
> +     for (i =3D 0; i < 100; i++) {
> +             if (RREG32_SMC(ixCG_ECLK_STATUS) &
> CG_ECLK_STATUS__ECLK_STATUS_MASK)
> +                     break;
> +             mdelay(10);
> +     }
> +     if (i =3D=3D 100)
> +             return -ETIMEDOUT;
>
>        return 0;
>  }
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB17686B9EB91BC0D3CCABA41FF7640CY4PR12MB1768namp_
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
<p>I suspect the patch I NAK'ed on 4.9 &quot;worked but with odd clocks&quo=
t; because it never engaged PG properly. &nbsp;I'm finding on 4.9 and 4.7 i=
f PG is enabled VCE doesn't wake properly.</p>
<p><br>
</p>
<p>I've found a &quot;good commit&quot; on 4.7 so I'll continue bisecting.<=
/p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Monday, January 9, 2017 11:58<br>
<b>To:</b> Deucher, Alexander; Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: refine vce3.0 initialize.</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Just a heads up there is a CG/PG regression. &nbsp;On the tip of 4.7 I c=
an encode with cg/pg disabled but with it enabled it locks up.</p>
<p><br>
</p>
<p>I'll try to bisect.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, January 9, 2017 09:34<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: refine vce3.0 initialize.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Monday, January 09, 2017 8:35 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH] drm/amdgpu: refine vce3.0 initialize.<br>
&gt; <br>
&gt; 1. disable vce cg when vce hw initialize.<br>
&gt; 2. initizlize vce clock to 10KHz.<br>
&gt; 3: no need to set bypass clock to vce.<br>
&gt; <br>
&gt; Change-Id: I18d5c2debc6688be201af8bb85022ac25020bd8f<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Does this patch fix this bug by any chance?<br>
<br>
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D191281">https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D191281</a><br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 &#43;&#43;&#43;------=
---------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; | 32<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;-<br>
&gt;&nbsp; 2 files changed, 34 insertions(&#43;), 16 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; index 5fb0b7f..eb99ee6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; @@ -223,6 &#43;223,9 @@ static int vce_v3_0_start(struct amdgpu_device=
<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx, r;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_gating(adev,=
 true); /* force all clocks<br>
&gt; on */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, 10000, =
10000);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vce.r=
ing[0];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_RPTR, ring-&=
gt;wptr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_WPTR, ring-&=
gt;wptr);<br>
&gt; @@ -701,17 &#43;704,7 @@ static int vce_v3_0_process_interrupt(struct<=
br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -static void vce_v3_0_set_bypass_mode(struct amdgpu_device *adev, bool=
<br>
&gt; enable)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SMC(ixGCK_DFS_BYPASS_CNTL=
);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp |=3D GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp &amp;=3D ~GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SMC(ixGCK_DFS_BYPASS_CNTL, tmp);<br>
&gt; -}<br>
&gt; <br>
&gt;&nbsp; static int vce_v3_0_set_clockgating_state(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state)<br>
&gt; @@ -720,11 &#43;713,6 @@ static int vce_v3_0_set_clockgating_state(voi=
d<br>
&gt; *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable =3D (state =3D=
=3D AMD_CG_STATE_GATE) ? true : false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_POLARIS1=
0) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (adev-&gt;asic_type =3D=3D CHIP_TONGA) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (adev-&gt;asic_type =3D=3D CHIP_FIJI))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; vce_v3_0_set_bypass_mode(adev, enable);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp=
; AMD_CG_SUPPORT_VCE_MGCG))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; index 16ba943..b9924e3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; @@ -789,7 &#43;789,37 @@ static int vi_set_uvd_clocks(struct amdgpu_de=
vice<br>
&gt; *adev, u32 vclk, u32 dclk)<br>
&gt; <br>
&gt;&nbsp; static int vi_set_vce_clocks(struct amdgpu_device *adev, u32 evc=
lk, u32<br>
&gt; ecclk)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_clock_dividers dividers;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_atombios_get_clock_dividers=
(adev,<br>
&gt; &#43;<br>
&gt; COMPUTE_GPUCLK_INPUT_FLAG_DEFAULT_GPUCLK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecclk, false, &amp;dividers);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100; i&#43;&#43;) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (RREG32_SMC(ixCG_ECLK_STATUS) &amp;<br>
&gt; CG_ECLK_STATUS__ECLK_STATUS_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D 100)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SMC(ixCG_ECLK_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~(CG_ECLK_CNTL__ECLK_DIR_CN=
TL_EN_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; CG_ECLK_CNTL__ECLK_DIVIDER_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D dividers.post_divider;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SMC(ixCG_ECLK_CNTL, tmp);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100; i&#43;&#43;) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (RREG32_SMC(ixCG_ECLK_STATUS) &amp;<br>
&gt; CG_ECLK_STATUS__ECLK_STATUS_MASK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; mdelay(10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D 100)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -ETIMEDOUT;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB17686B9EB91BC0D3CCABA41FF7640CY4PR12MB1768namp_--

--===============1152091616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1152091616==--
