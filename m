From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6
Date: Fri, 2 Sep 2016 12:06:25 +0000
Message-ID: <CY4PR12MB1768E928FEE6FB1E223BC444F7E50@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20160901174447.13037-1-tom.stdenis@amd.com>
 <20160901174447.13037-4-tom.stdenis@amd.com>,
 <717365b4-0cdd-95a4-9e8c-4b04660844c6@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0440529322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <717365b4-0cdd-95a4-9e8c-4b04660844c6-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0440529322==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768E928FEE6FB1E223BC444F7E50CY4PR12MB1768namp_"

--_000_CY4PR12MB1768E928FEE6FB1E223BC444F7E50CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The "adev" variable must be in scope when using the RREG32/WREG32 (and deri=
vatives) macros.


Tom


________________________________
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Sent: Thursday, September 1, 2016 23:22
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6



On 09/02/2016 03:44 AM, Tom St Denis wrote:
> Various whitespace and logical simplifications for gfx6.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 40 +++++------------------------=
------
>  1 file changed, 5 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 5f508c96496f..63ca77937714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1211,11 +1211,8 @@ static void gfx_v6_0_gpu_init(struct amdgpu_device=
 *adev)
>                                 SC_EARLYZ_TILE_FIFO_SIZE(adev->gfx.config=
.sc_earlyz_tile_fifo_size)));
>
>        WREG32(VGT_NUM_INSTANCES, 1);
> -
>        WREG32(CP_PERFMON_CNTL, 0);
> -
>        WREG32(SQ_CONFIG, 0);
> -
>        WREG32(PA_SC_FORCE_EOV_MAX_CNTS, (FORCE_EOV_MAX_CLK_CNT(4095) |
>                                          FORCE_EOV_MAX_REZ_CNT(255)));
>
> @@ -1240,7 +1237,6 @@ static void gfx_v6_0_gpu_init(struct amdgpu_device =
*adev)
>        WREG32(PA_CL_ENHANCE, CLIP_VTX_REORDER_ENA | NUM_CLIP_SEQ(3));
>
>        udelay(50);
> -
>  }
>
>
> @@ -1661,21 +1657,14 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu_d=
evice *adev)
>
>  static u32 gfx_v6_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>  {
> -     u32 rptr;
> -
> -     rptr =3D ring->adev->wb.wb[ring->rptr_offs];
> -
> -     return rptr;
> +     return ring->adev->wb.wb[ring->rptr_offs];
>  }
>
>  static u32 gfx_v6_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>  {
>        struct amdgpu_device *adev =3D ring->adev;

Also adev seems to be unused here?

> -     u32 wptr;
>
> -     wptr =3D RREG32(CP_RB0_WPTR);
> -
> -     return wptr;
> +     return RREG32(CP_RB0_WPTR);
>  }
>
>  static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> @@ -1688,9 +1677,7 @@ static void gfx_v6_0_ring_set_wptr_gfx(struct amdgp=
u_ring *ring)
>
>  static u32 gfx_v6_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  {
> -     u32 rptr =3D ring->adev->wb.wb[ring->rptr_offs];
> -
> -     return rptr;
> +     return ring->adev->wb.wb[ring->rptr_offs];
>  }
>
>  static u32 gfx_v6_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> @@ -1770,14 +1757,12 @@ static int gfx_v6_0_cp_compute_resume(struct amdg=
pu_device *adev)
>        ring->wptr =3D 0;
>        WREG32(CP_RB1_WPTR, ring->wptr);
>
> -
>        rptr_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
>        WREG32(CP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
>        WREG32(CP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
>
>        mdelay(1);
>        WREG32(CP_RB1_CNTL, tmp);
> -
>        WREG32(CP_RB1_BASE, ring->gpu_addr >> 8);
>
>        ring =3D &adev->gfx.compute_ring[1];
> @@ -1797,7 +1782,6 @@ static int gfx_v6_0_cp_compute_resume(struct amdgpu=
_device *adev)
>
>        mdelay(1);
>        WREG32(CP_RB2_CNTL, tmp);
> -
>        WREG32(CP_RB2_BASE, ring->gpu_addr >> 8);
>
>        adev->gfx.compute_ring[0].ready =3D true;
> @@ -1825,12 +1809,7 @@ static void gfx_v6_0_cp_enable(struct amdgpu_devic=
e *adev, bool enable)
>
>  static int gfx_v6_0_cp_load_microcode(struct amdgpu_device *adev)
>  {
> -     int r;
> -
> -     r =3D gfx_v6_0_cp_gfx_load_microcode(adev);
> -
> -     return r;
> -
> +     return gfx_v6_0_cp_gfx_load_microcode(adev);
>  }
>
>  static void gfx_v6_0_enable_gui_idle_interrupt(struct amdgpu_device *ade=
v,
> @@ -2172,7 +2151,6 @@ static void gfx_v6_0_rlc_stop(struct amdgpu_device =
*adev)
>        WREG32(RLC_CNTL, 0);
>
>        gfx_v6_0_enable_gui_idle_interrupt(adev, false);
> -
>        gfx_v6_0_wait_for_rlc_serdes(adev);
>  }
>
> @@ -2223,11 +2201,8 @@ static int gfx_v6_0_rlc_resume(struct amdgpu_devic=
e *adev)
>                return -EINVAL;
>
>        gfx_v6_0_rlc_stop(adev);
> -
>        gfx_v6_0_rlc_reset(adev);
> -
>        gfx_v6_0_init_pg(adev);
> -
>        gfx_v6_0_init_cg(adev);
>
>        WREG32(RLC_RL_BASE, 0);
> @@ -2254,7 +2229,6 @@ static int gfx_v6_0_rlc_resume(struct amdgpu_device=
 *adev)
>        WREG32(RLC_UCODE_ADDR, 0);
>
>        gfx_v6_0_enable_lbpw(adev, gfx_v6_0_lbpw_supported(adev));
> -
>        gfx_v6_0_rlc_start(adev);
>
>        return 0;
> @@ -2278,7 +2252,6 @@ static void gfx_v6_0_enable_cgcg(struct amdgpu_devi=
ce *adev, bool enable)
>                WREG32(RLC_SERDES_WR_CTRL, 0x00b000ff);
>
>                gfx_v6_0_wait_for_rlc_serdes(adev);
> -
>                gfx_v6_0_update_rlc(adev, tmp);
>
>                WREG32(RLC_SERDES_WR_CTRL, 0x007000ff);
> @@ -2931,13 +2904,10 @@ static bool gfx_v6_0_is_idle(void *handle)
>  static int gfx_v6_0_wait_for_idle(void *handle)
>  {
>        unsigned i;
> -     u32 tmp;
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>        for (i =3D 0; i < adev->usec_timeout; i++) {
> -             tmp =3D RREG32(GRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK;
> -
> -             if (!tmp)
> +             if (gfx_v6_0_is_idle(handle))
>                        return 0;
>                udelay(1);
>        }
>


--_000_CY4PR12MB1768E928FEE6FB1E223BC444F7E50CY4PR12MB1768namp_
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
<p>The &quot;adev&quot; variable must be in scope when using the RREG32/WRE=
G32 (and derivatives) macros.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Edward O'Callaghan =
&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 1, 2016 23:22<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6</=
font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
<br>
On 09/02/2016 03:44 AM, Tom St Denis wrote:<br>
&gt; Various whitespace and logical simplifications for gfx6.<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 40 &#43;&#43;&#43;&#43;&=
#43;------------------------------<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 35 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v6_0.c<br>
&gt; index 5f508c96496f..63ca77937714 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; @@ -1211,11 &#43;1211,8 @@ static void gfx_v6_0_gpu_init(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SC_EARLYZ_TILE_FIFO_SIZE(ade=
v-&gt;gfx.config.sc_earlyz_tile_fifo_size)));<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(VGT_NUM_INSTANCES, 1)=
;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_PERFMON_CNTL, 0);<=
br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(SQ_CONFIG, 0);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(PA_SC_FORCE_EOV_MAX_C=
NTS, (FORCE_EOV_MAX_CLK_CNT(4095) |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; FORCE_EOV_MAX_REZ_CNT(255)));<br>
&gt;&nbsp; <br>
&gt; @@ -1240,7 &#43;1237,6 @@ static void gfx_v6_0_gpu_init(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(PA_CL_ENHANCE, CLIP_V=
TX_REORDER_ENA | NUM_CLIP_SEQ(3));<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt; -<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; <br>
&gt; @@ -1661,21 &#43;1657,14 @@ static int gfx_v6_0_cp_gfx_resume(struct a=
mdgpu_device *adev)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static u32 gfx_v6_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)<=
br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 rptr;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rptr =3D ring-&gt;adev-&gt;wb.wb[ring-&gt;rp=
tr_offs];<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return rptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ring-&gt;adev-&gt;wb.wb[ring-&gt;=
rptr_offs];<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static u32 gfx_v6_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)<=
br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
<br>
Also adev seems to be unused here?<br>
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 wptr;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D RREG32(CP_RB0_WPTR);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return wptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32(CP_RB0_WPTR);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)=
<br>
&gt; @@ -1688,9 &#43;1677,7 @@ static void gfx_v6_0_ring_set_wptr_gfx(struc=
t amdgpu_ring *ring)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static u32 gfx_v6_0_ring_get_rptr_compute(struct amdgpu_ring *ri=
ng)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 rptr =3D ring-&gt;adev-&gt;wb.wb[ring-&g=
t;rptr_offs];<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return rptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ring-&gt;adev-&gt;wb.wb[ring-&gt;=
rptr_offs];<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static u32 gfx_v6_0_ring_get_wptr_compute(struct amdgpu_ring *ri=
ng)<br>
&gt; @@ -1770,14 &#43;1757,12 @@ static int gfx_v6_0_cp_compute_resume(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB1_WPTR, ring-&gt=
;wptr);<br>
&gt;&nbsp; <br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rptr_addr =3D adev-&gt;wb.gp=
u_addr &#43; (ring-&gt;rptr_offs * 4);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB1_RPTR_ADDR, low=
er_32_bits(rptr_addr));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB1_RPTR_ADDR_HI, =
upper_32_bits(rptr_addr) &amp; 0xFF);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB1_CNTL, tmp);<br=
>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB1_BASE, ring-&gt=
;gpu_addr &gt;&gt; 8);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;gfx.c=
ompute_ring[1];<br>
&gt; @@ -1797,7 &#43;1782,6 @@ static int gfx_v6_0_cp_compute_resume(struct=
 amdgpu_device *adev)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB2_CNTL, tmp);<br=
>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(CP_RB2_BASE, ring-&gt=
;gpu_addr &gt;&gt; 8);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.compute_ring[0]=
.ready =3D true;<br>
&gt; @@ -1825,12 &#43;1809,7 @@ static void gfx_v6_0_cp_enable(struct amdgp=
u_device *adev, bool enable)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int gfx_v6_0_cp_load_microcode(struct amdgpu_device *adev=
)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v6_0_cp_gfx_load_microcode(adev);<=
br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return gfx_v6_0_cp_gfx_load_microcode(ad=
ev);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp; static void gfx_v6_0_enable_gui_idle_interrupt(struct amdgpu_dev=
ice *adev,<br>
&gt; @@ -2172,7 &#43;2151,6 @@ static void gfx_v6_0_rlc_stop(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(RLC_CNTL, 0);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_enable_gui_idle_int=
errupt(adev, false);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_wait_for_rlc_serdes=
(adev);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; @@ -2223,11 &#43;2201,8 @@ static int gfx_v6_0_rlc_resume(struct amdgp=
u_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_rlc_stop(adev);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_rlc_reset(adev);<br=
>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_init_pg(adev);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_init_cg(adev);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(RLC_RL_BASE, 0);<br>
&gt; @@ -2254,7 &#43;2229,6 @@ static int gfx_v6_0_rlc_resume(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(RLC_UCODE_ADDR, 0);<b=
r>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_enable_lbpw(adev, g=
fx_v6_0_lbpw_supported(adev));<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v6_0_rlc_start(adev);<br=
>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -2278,7 &#43;2252,6 @@ static void gfx_v6_0_enable_cgcg(struct amdg=
pu_device *adev, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32(RLC_SERDES_WR_CTRL, 0x00b000ff);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gfx_v6_0_wait_for_rlc_serdes(adev);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gfx_v6_0_update_rlc(adev, tmp);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32(RLC_SERDES_WR_CTRL, 0x007000ff);<br>
&gt; @@ -2931,13 &#43;2904,10 @@ static bool gfx_v6_0_is_idle(void *handle)=
<br>
&gt;&nbsp; static int gfx_v6_0_wait_for_idle(void *handle)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D RREG32(GRBM_STATUS) &amp; GRBM_STATUS__GUI_ACTIVE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!tmp)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (gfx_v6_0_is_idle(handle))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768E928FEE6FB1E223BC444F7E50CY4PR12MB1768namp_--

--===============0440529322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0440529322==--
