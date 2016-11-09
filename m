From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: refine uvd 6.0 clock gate feature.
Date: Wed, 9 Nov 2016 17:38:56 +0000
Message-ID: <CY4PR12MB17685B172DB80A467E722AECF7B90@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1478677305-12579-1-git-send-email-Rex.Zhu@amd.com>
 <1478677305-12579-4-git-send-email-Rex.Zhu@amd.com>,
 <MWHPR12MB169470FE725F398CB38380C7F7B90@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1387422272=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB169470FE725F398CB38380C7F7B90-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1387422272==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB17685B172DB80A467E722AECF7B90CY4PR12MB1768namp_"

--_000_CY4PR12MB17685B172DB80A467E722AECF7B90CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kinda buried trying to sort out the gfx6 boot failure but if someone can ju=
st email as an attachment the 5 patches I'll test them on my Stoney system =
(my CZ system is being used by the Tahiti board...)


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 9, 2016 11:03
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH 4/5] drm/amdgpu: refine uvd 6.0 clock gate feature.

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Rex Zhu
> Sent: Wednesday, November 09, 2016 2:42 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex
> Subject: [PATCH 4/5] drm/amdgpu: refine uvd 6.0 clock gate feature.
>
> Change-Id: I3b665f26689dd35750e1a6521cd5fac5456f7556
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Can someone make sure this doesn't regress CZ and ST?  As long as they are =
still ok, the patches 4, 5 are:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 112
> ++++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 00fad69..c697a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -42,6 +42,10 @@ static void uvd_v6_0_set_irq_funcs(struct
> amdgpu_device *adev);
>  static int uvd_v6_0_start(struct amdgpu_device *adev);
>  static void uvd_v6_0_stop(struct amdgpu_device *adev);
>  static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev);
> +static int uvd_v6_0_set_clockgating_state(void *handle,
> +                                       enum amd_clockgating_state state)=
;
> +static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
> +                              bool enable);
>
>  /**
>   * uvd_v6_0_ring_get_rptr - get read pointer
> @@ -151,8 +155,6 @@ static int uvd_v6_0_hw_init(void *handle)
>        uint32_t tmp;
>        int r;
>
> -     amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
> -
>        r =3D uvd_v6_0_start(adev);
>        if (r)
>                goto done;
> @@ -395,11 +397,11 @@ static int uvd_v6_0_start(struct amdgpu_device
> *adev)
>        lmi_swap_cntl =3D 0;
>        mp_swap_cntl =3D 0;
>
> +     amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
> +     uvd_v6_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
> +     uvd_v6_0_enable_mgcg(adev, true);
>        uvd_v6_0_mc_resume(adev);
>
> -     /* disable clock gating */
> -     WREG32_FIELD(UVD_CGC_CTRL, DYN_CLOCK_MODE, 0);
> -
>        /* disable interupt */
>        WREG32_FIELD(UVD_MASTINT_EN, VCPU_EN, 0);
>
> @@ -838,22 +840,69 @@ static int uvd_v6_0_process_interrupt(struct
> amdgpu_device *adev,
>        return 0;
>  }
>
> +static void uvd_v6_0_enable_clock_gating(struct amdgpu_device *adev,
> bool enable)
> +{
> +     uint32_t data1, data3;
> +
> +     data1 =3D RREG32(mmUVD_SUVD_CGC_GATE);
> +     data3 =3D RREG32(mmUVD_CGC_GATE);
> +
> +     data1 |=3D UVD_SUVD_CGC_GATE__SRE_MASK |
> +                  UVD_SUVD_CGC_GATE__SIT_MASK |
> +                  UVD_SUVD_CGC_GATE__SMP_MASK |
> +                  UVD_SUVD_CGC_GATE__SCM_MASK |
> +                  UVD_SUVD_CGC_GATE__SDB_MASK |
> +                  UVD_SUVD_CGC_GATE__SRE_H264_MASK |
> +                  UVD_SUVD_CGC_GATE__SRE_HEVC_MASK |
> +                  UVD_SUVD_CGC_GATE__SIT_H264_MASK |
> +                  UVD_SUVD_CGC_GATE__SIT_HEVC_MASK |
> +                  UVD_SUVD_CGC_GATE__SCM_H264_MASK |
> +                  UVD_SUVD_CGC_GATE__SCM_HEVC_MASK |
> +                  UVD_SUVD_CGC_GATE__SDB_H264_MASK |
> +                  UVD_SUVD_CGC_GATE__SDB_HEVC_MASK;
> +
> +     if (enable) {
> +             data3 |=3D (UVD_CGC_GATE__SYS_MASK       |
> +                     UVD_CGC_GATE__UDEC_MASK      |
> +                     UVD_CGC_GATE__MPEG2_MASK     |
> +                     UVD_CGC_GATE__RBC_MASK       |
> +                     UVD_CGC_GATE__LMI_MC_MASK    |
> +                     UVD_CGC_GATE__LMI_UMC_MASK   |
> +                     UVD_CGC_GATE__IDCT_MASK      |
> +                     UVD_CGC_GATE__MPRD_MASK      |
> +                     UVD_CGC_GATE__MPC_MASK       |
> +                     UVD_CGC_GATE__LBSI_MASK      |
> +                     UVD_CGC_GATE__LRBBM_MASK     |
> +                     UVD_CGC_GATE__UDEC_RE_MASK   |
> +                     UVD_CGC_GATE__UDEC_CM_MASK   |
> +                     UVD_CGC_GATE__UDEC_IT_MASK   |
> +                     UVD_CGC_GATE__UDEC_DB_MASK   |
> +                     UVD_CGC_GATE__UDEC_MP_MASK   |
> +                     UVD_CGC_GATE__WCB_MASK       |
> +                     UVD_CGC_GATE__VCPU_MASK      |
> +                     UVD_CGC_GATE__JPEG_MASK      |
> +                     UVD_CGC_GATE__SCPU_MASK      |
> +                     UVD_CGC_GATE__JPEG2_MASK);
> +             data3 &=3D ~UVD_CGC_GATE__REGS_MASK;
> +     } else {
> +             data3 =3D 0;
> +     }
> +
> +     WREG32(mmUVD_SUVD_CGC_GATE, data1);
> +     WREG32(mmUVD_CGC_GATE, data3);
> +}
> +
>  static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev)
>  {
> -     uint32_t data, data1, data2, suvd_flags;
> +     uint32_t data, data2;
>
>        data =3D RREG32(mmUVD_CGC_CTRL);
> -     data1 =3D RREG32(mmUVD_SUVD_CGC_GATE);
>        data2 =3D RREG32(mmUVD_SUVD_CGC_CTRL);
>
> +
>        data &=3D ~(UVD_CGC_CTRL__CLK_OFF_DELAY_MASK |
>                  UVD_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK);
>
> -     suvd_flags =3D UVD_SUVD_CGC_GATE__SRE_MASK |
> -                  UVD_SUVD_CGC_GATE__SIT_MASK |
> -                  UVD_SUVD_CGC_GATE__SMP_MASK |
> -                  UVD_SUVD_CGC_GATE__SCM_MASK |
> -                  UVD_SUVD_CGC_GATE__SDB_MASK;
>
>        data |=3D UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK |
>                (1 << REG_FIELD_SHIFT(UVD_CGC_CTRL,
> CLK_GATE_DLY_TIMER)) |
> @@ -886,11 +935,8 @@ static void uvd_v6_0_set_sw_clock_gating(struct
> amdgpu_device *adev)
>                        UVD_SUVD_CGC_CTRL__SMP_MODE_MASK |
>                        UVD_SUVD_CGC_CTRL__SCM_MODE_MASK |
>                        UVD_SUVD_CGC_CTRL__SDB_MODE_MASK);
> -     data1 |=3D suvd_flags;
>
>        WREG32(mmUVD_CGC_CTRL, data);
> -     WREG32(mmUVD_CGC_GATE, 0);
> -     WREG32(mmUVD_SUVD_CGC_GATE, data1);
>        WREG32(mmUVD_SUVD_CGC_CTRL, data2);
>  }
>
> @@ -937,6 +983,32 @@ static void uvd_v6_0_set_hw_clock_gating(struct
> amdgpu_device *adev)
>  }
>  #endif
>
> +static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
> +                              bool enable)
> +{
> +     u32 orig, data;
> +
> +     if (enable && (adev->cg_flags & AMD_CG_SUPPORT_UVD_MGCG))
> {
> +             data =3D RREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL);
> +             data |=3D 0xfff;
> +             WREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL, data);
> +
> +             orig =3D data =3D RREG32(mmUVD_CGC_CTRL);
> +             data |=3D UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +             if (orig !=3D data)
> +                     WREG32(mmUVD_CGC_CTRL, data);
> +     } else {
> +             data =3D RREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL);
> +             data &=3D ~0xfff;
> +             WREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL, data);
> +
> +             orig =3D data =3D RREG32(mmUVD_CGC_CTRL);
> +             data &=3D ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +             if (orig !=3D data)
> +                     WREG32(mmUVD_CGC_CTRL, data);
> +     }
> +}
> +
>  static int uvd_v6_0_set_clockgating_state(void *handle,
>                                          enum amd_clockgating_state state=
)
>  {
> @@ -947,17 +1019,17 @@ static int uvd_v6_0_set_clockgating_state(void
> *handle,
>                return 0;
>
>        if (enable) {
> -             /* disable HW gating and enable Sw gating */
> -             uvd_v6_0_set_sw_clock_gating(adev);
> -     } else {
>                /* wait for STATUS to clear */
>                if (uvd_v6_0_wait_for_idle(handle))
>                        return -EBUSY;
> -
> +             uvd_v6_0_enable_clock_gating(adev, true);
>                /* enable HW gates because UVD is idle */
>  /*           uvd_v6_0_set_hw_clock_gating(adev); */
> +     } else {
> +             /* disable HW gating and enable Sw gating */
> +             uvd_v6_0_enable_clock_gating(adev, false);
>        }
> -
> +     uvd_v6_0_set_sw_clock_gating(adev);
>        return 0;
>  }
>
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

--_000_CY4PR12MB17685B172DB80A467E722AECF7B90CY4PR12MB1768namp_
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
<p>Kinda buried trying to sort out the gfx6 boot failure but if someone can=
 just email as an attachment the 5 patches I'll test them on my Stoney syst=
em (my CZ system is being used by the Tahiti board...)</p>
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
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 9, 2016 11:03<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: refine uvd 6.0 clock gate featu=
re.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Rex Zhu<br>
&gt; Sent: Wednesday, November 09, 2016 2:42 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex<br>
&gt; Subject: [PATCH 4/5] drm/amdgpu: refine uvd 6.0 clock gate feature.<br=
>
&gt; <br>
&gt; Change-Id: I3b665f26689dd35750e1a6521cd5fac5456f7556<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Can someone make sure this doesn't regress CZ and ST?&nbsp; As long as they=
 are still ok, the patches 4, 5 are:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 112<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----=
-<br>
&gt;&nbsp; 1 file changed, 92 insertions(&#43;), 20 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; index 00fad69..c697a73 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; @@ -42,6 &#43;42,10 @@ static void uvd_v6_0_set_irq_funcs(struct<br>
&gt; amdgpu_device *adev);<br>
&gt;&nbsp; static int uvd_v6_0_start(struct amdgpu_device *adev);<br>
&gt;&nbsp; static void uvd_v6_0_stop(struct amdgpu_device *adev);<br>
&gt;&nbsp; static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *a=
dev);<br>
&gt; &#43;static int uvd_v6_0_set_clockgating_state(void *handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum amd_clockgating_state state);<br>
&gt; &#43;static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable);<br>
&gt; <br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * uvd_v6_0_ring_get_rptr - get read pointer<br>
&gt; @@ -151,8 &#43;155,6 @@ static int uvd_v6_0_hw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 10000, 1000=
0);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D uvd_v6_0_start(adev);<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto done;<br>
&gt; @@ -395,11 &#43;397,11 @@ static int uvd_v6_0_start(struct amdgpu_devi=
ce<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lmi_swap_cntl =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp_swap_cntl =3D 0;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_set_uvd_clocks(adev, 10000, =
10000);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_set_clockgating_state(adev, AMD=
_CG_STATE_UNGATE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_enable_mgcg(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_mc_resume(adev);<br=
>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* disable clock gating */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(UVD_CGC_CTRL, DYN_CLOCK_MODE, 0=
);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable interupt */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(UVD_MASTINT_EN,=
 VCPU_EN, 0);<br>
&gt; <br>
&gt; @@ -838,22 &#43;840,69 @@ static int uvd_v6_0_process_interrupt(struct=
<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; &#43;static void uvd_v6_0_enable_clock_gating(struct amdgpu_device *ad=
ev,<br>
&gt; bool enable)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data1, data3;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data1 =3D RREG32(mmUVD_SUVD_CGC_GATE);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data3 =3D RREG32(mmUVD_CGC_GATE);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data1 |=3D UVD_SUVD_CGC_GATE__SRE_MASK |=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SIT_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SMP_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SCM_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SDB_MASK |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SRE_H264_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SRE_HEVC_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SIT_H264_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SIT_HEVC_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SCM_H264_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SCM_HEVC_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SDB_H264_MASK |<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SDB_HEVC_MASK;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data3 |=3D (UVD_CGC_GATE__SYS_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__MPEG2=
_MASK&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__RBC_M=
ASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__LMI_M=
C_MASK&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__LMI_U=
MC_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__IDCT_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__MPRD_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__MPC_M=
ASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__LBSI_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__LRBBM=
_MASK&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
RE_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
CM_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
IT_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
DB_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__UDEC_=
MP_MASK&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__WCB_M=
ASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__VCPU_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__JPEG_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__SCPU_=
MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_GATE__JPEG2=
_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data3 &amp;=3D ~UVD_CGC_GATE__REGS_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data3 =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_SUVD_CGC_GATE, data1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_GATE, data3);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, data1, data2, suvd_flags;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, data2;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32(mmUVD_CGC_CT=
RL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; data1 =3D RREG32(mmUVD_SUVD_CGC_GATE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data2 =3D RREG32(mmUVD_SUVD_=
CGC_CTRL);<br>
&gt; <br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~(UVD_CGC_CTRL=
__CLK_OFF_DELAY_MASK |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; suvd_flags =3D UVD_SUVD_CGC_GATE__SRE_MASK |=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SIT_MASK |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SMP_MASK |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SCM_MASK |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUVD_CGC_GATE__SDB_MASK;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D UVD_CGC_CTRL__DYN_=
CLOCK_MODE_MASK |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; REG_FIELD_SHIFT(UVD_CGC_CTRL,<br>
&gt; CLK_GATE_DLY_TIMER)) |<br>
&gt; @@ -886,11 &#43;935,8 @@ static void uvd_v6_0_set_sw_clock_gating(stru=
ct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUV=
D_CGC_CTRL__SMP_MODE_MASK |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUV=
D_CGC_CTRL__SCM_MODE_MASK |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_SUV=
D_CGC_CTRL__SDB_MODE_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; data1 |=3D suvd_flags;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_CTRL, data)=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_GATE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_SUVD_CGC_GATE, data1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_SUVD_CGC_CTRL, =
data2);<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; @@ -937,6 &#43;983,32 @@ static void uvd_v6_0_set_hw_clock_gating(stru=
ct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp; }<br>
&gt;&nbsp; #endif<br>
&gt; <br>
&gt; &#43;static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 orig, data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (adev-&gt;cg_flags=
 &amp; AMD_CG_SUPPORT_UVD_MGCG))<br>
&gt; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data |=3D 0xfff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL, data);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; orig =3D data =3D RREG32(mmUVD_CGC_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data |=3D UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (orig !=3D data)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_CT=
RL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data &amp;=3D ~0xfff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_UVD_CTX(ixUVD_CGC_MEM_CTRL, data);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; orig =3D data =3D RREG32(mmUVD_CGC_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data &amp;=3D ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (orig !=3D data)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_CGC_CT=
RL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static int uvd_v6_0_set_clockgating_state(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state)<br>
&gt;&nbsp; {<br>
&gt; @@ -947,17 &#43;1019,17 @@ static int uvd_v6_0_set_clockgating_state(v=
oid<br>
&gt; *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* disable HW gating and enable Sw gating */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uvd_v6_0_set_sw_clock_gating(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* wait for STATUS to clear */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (uvd_v6_0_wait_for_idle(handle))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-EBUSY;<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uvd_v6_0_enable_clock_gating(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* enable HW gates because UVD is idle */<br>
&gt;&nbsp; /*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
vd_v6_0_set_hw_clock_gating(adev); */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* disable HW gating and enable Sw gating */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; uvd_v6_0_enable_clock_gating(adev, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uvd_v6_0_set_sw_clock_gating(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
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
</body>
</html>

--_000_CY4PR12MB17685B172DB80A467E722AECF7B90CY4PR12MB1768namp_--

--===============1387422272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1387422272==--
