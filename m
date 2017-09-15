From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add GPU reset functionality for Vega10
Date: Fri, 15 Sep 2017 08:14:31 +0000
Message-ID: <CY1PR12MB0474031DB47F7973953B58E48C6C0@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1505462264-672-1-git-send-email-Ken.Wang@amd.com>,
 <a3211a01-77ab-a4ca-8cac-9b126c62aacc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026225975=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3211a01-77ab-a4ca-8cac-9b126c62aacc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2026225975==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0474031DB47F7973953B58E48C6C0CY1PR12MB0474namp_"

--_000_CY1PR12MB0474031DB47F7973953B58E48C6C0CY1PR12MB0474namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

sure, thanks.

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, September 15, 2017 4:13:45 PM
To: Wang, Ken; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Add GPU reset functionality for Vega10

Am 15.09.2017 um 09:57 schrieb Ken.Wang-5C7GfCeVMHo@public.gmane.org:
> From: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
>
> V2
>
> Signed-off-by: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

Acked-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

I would give an rb, but I can't judge if the PSP stuff is actually
correct, maybe wait for Alex to have a look as well.

Regards,
Christian.

> Change-Id: I6fd2c216a84747313f18db25a444be5ed43b4f4b
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 21 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  3 +++
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  7 ++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.h     |  2 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      | 34 +++++++++++++++++++++++=
+++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/soc15.c         | 27 ++++++++++++-----------=
-
>   8 files changed, 83 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index fc1c5437..2ad9737 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2644,7 +2644,8 @@ static bool amdgpu_need_full_reset(struct amdgpu_de=
vice *adev)
>                if ((adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_GMC) ||
>                    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_SMC) ||
>                    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_=
TYPE_ACP) ||
> -                 (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_DCE)) {
> +                 (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_DCE) ||
> +                  adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_PSP) {
>                        if (adev->ip_blocks[i].status.hang) {
>                                DRM_INFO("Some block need full reset!\n");
>                                return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 8a1ee97..8e53650 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -62,6 +62,7 @@ static int psp_sw_init(void *handle)
>                psp->cmd_submit =3D psp_v3_1_cmd_submit;
>                psp->compare_sram_data =3D psp_v3_1_compare_sram_data;
>                psp->smu_reload_quirk =3D psp_v3_1_smu_reload_quirk;
> +             psp->mode1_reset =3D psp_v3_1_mode1_reset;
>                break;
>        case CHIP_RAVEN:
>                psp->init_microcode =3D psp_v10_0_init_microcode;
> @@ -72,6 +73,7 @@ static int psp_sw_init(void *handle)
>                psp->ring_destroy =3D psp_v10_0_ring_destroy;
>                psp->cmd_submit =3D psp_v10_0_cmd_submit;
>                psp->compare_sram_data =3D psp_v10_0_compare_sram_data;
> +             psp->mode1_reset =3D psp_v10_0_mode1_reset;
>                break;
>        default:
>                return -EINVAL;
> @@ -497,6 +499,22 @@ static int psp_resume(void *handle)
>        return ret;
>   }
>
> +static bool psp_check_reset(void* handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     if (adev->asic_type =3D=3D CHIP_VEGA10)
> +             return true;
> +
> +     return false;
> +}
> +
> +static int psp_reset(void* handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     return psp_mode1_reset(&adev->psp);
> +}
> +
>   static bool psp_check_fw_loading_status(struct amdgpu_device *adev,
>                                        enum AMDGPU_UCODE_ID ucode_type)
>   {
> @@ -540,8 +558,9 @@ const struct amd_ip_funcs psp_ip_funcs =3D {
>        .suspend =3D psp_suspend,
>        .resume =3D psp_resume,
>        .is_idle =3D NULL,
> +     .check_soft_reset =3D psp_check_reset,
>        .wait_for_idle =3D NULL,
> -     .soft_reset =3D NULL,
> +     .soft_reset =3D psp_reset,
>        .set_clockgating_state =3D psp_set_clockgating_state,
>        .set_powergating_state =3D psp_set_powergating_state,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 1b7d12d..ce465455 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -76,6 +76,7 @@ struct psp_context
>                                  struct amdgpu_firmware_info *ucode,
>                                  enum AMDGPU_UCODE_ID ucode_type);
>        bool (*smu_reload_quirk)(struct psp_context *psp);
> +     int (*mode1_reset)(struct psp_context *psp);
>
>        /* fence buffer */
>        struct amdgpu_bo                 *fw_pri_bo;
> @@ -139,6 +140,8 @@ struct amdgpu_psp_funcs {
>                ((psp)->bootloader_load_sos ? (psp)->bootloader_load_sos((=
psp)) : 0)
>   #define psp_smu_reload_quirk(psp) \
>                ((psp)->smu_reload_quirk ? (psp)->smu_reload_quirk((psp)) =
: false)
> +#define psp_mode1_reset(psp) \
> +             ((psp)->mode1_reset ? (psp)->mode1_reset((psp)) : false)
>
>   extern const struct amd_ip_funcs psp_ip_funcs;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v10_0.c
> index 6b324da..cbc43bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -406,3 +406,10 @@ bool psp_v10_0_compare_sram_data(struct psp_context =
*psp,
>
>        return true;
>   }
> +
> +
> +int psp_v10_0_mode1_reset(struct psp_context *psp)
> +{
> +     DRM_INFO("psp mode 1 reset not supported now! \n");
> +     return -EINVAL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h b/drivers/gpu/drm/amd=
/amdgpu/psp_v10_0.h
> index 3af3ad1..451e830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h
> @@ -45,4 +45,6 @@ extern int psp_v10_0_cmd_submit(struct psp_context *psp=
,
>   extern bool psp_v10_0_compare_sram_data(struct psp_context *psp,
>                                       struct amdgpu_firmware_info *ucode,
>                                       enum AMDGPU_UCODE_ID ucode_type);
> +
> +extern int psp_v10_0_mode1_reset(struct psp_context *psp);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/=
amdgpu/psp_v3_1.c
> index eb73931..4e70bad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -530,3 +530,37 @@ bool psp_v3_1_smu_reload_quirk(struct psp_context *p=
sp)
>        reg =3D RREG32_SOC15(NBIO, 0, mmPCIE_DATA2);
>        return (reg & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true =
: false;
>   }
> +
> +int psp_v3_1_mode1_reset(struct psp_context *psp)
> +{
> +     int ret;
> +     uint32_t offset;
> +     struct amdgpu_device *adev =3D psp->adev;
> +
> +     offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
> +
> +     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
> +
> +     if (ret) {
> +             DRM_INFO("psp is not working correctly before mode1 reset!\=
n");
> +             return -EINVAL;
> +     }
> +
> +     /*send the mode 1 reset command*/
> +     WREG32(offset, 0x70000);
> +
> +     mdelay(1000);
> +
> +     offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
> +
> +     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
> +
> +     if (ret) {
> +             DRM_INFO("psp mode 1 reset failed!\n");
> +             return -EINVAL;
> +     }
> +
> +     DRM_INFO("psp mode1 reset succeed \n");
> +
> +     return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h b/drivers/gpu/drm/amd/=
amdgpu/psp_v3_1.h
> index 5af2231..b05dbad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h
> @@ -53,4 +53,5 @@ extern bool psp_v3_1_compare_sram_data(struct psp_conte=
xt *psp,
>                                       struct amdgpu_firmware_info *ucode,
>                                       enum AMDGPU_UCODE_ID ucode_type);
>   extern bool psp_v3_1_smu_reload_quirk(struct psp_context *psp);
> +extern int psp_v3_1_mode1_reset(struct psp_context *psp);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index a74d616..9c75961 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -407,18 +407,27 @@ static int soc15_read_register(struct amdgpu_device=
 *adev, u32 se_num,
>        return -EINVAL;
>   }
>
> -static void soc15_gpu_pci_config_reset(struct amdgpu_device *adev)
> +static int soc15_asic_reset(struct amdgpu_device *adev)
>   {
>        u32 i;
>
> -     dev_info(adev->dev, "GPU pci config reset\n");
> +     amdgpu_atombios_scratch_regs_engine_hung(adev, true);
> +
> +     dev_info(adev->dev, "GPU reset\n");
>
>        /* disable BM */
>        pci_clear_master(adev->pdev);
> -     /* reset */
> -     amdgpu_pci_config_reset(adev);
>
> -     udelay(100);
> +     pci_save_state(adev->pdev);
> +
> +     for (i =3D 0; i < AMDGPU_MAX_IP_NUM; i++) {
> +             if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_PSP){
> +                     adev->ip_blocks[i].version->funcs->soft_reset((void=
 *)adev);
> +                     break;
> +             }
> +     }
> +
> +     pci_restore_state(adev->pdev);
>
>        /* wait for asic to come out of reset */
>        for (i =3D 0; i < adev->usec_timeout; i++) {
> @@ -430,14 +439,6 @@ static void soc15_gpu_pci_config_reset(struct amdgpu=
_device *adev)
>                udelay(1);
>        }
>
> -}
> -
> -static int soc15_asic_reset(struct amdgpu_device *adev)
> -{
> -     amdgpu_atombios_scratch_regs_engine_hung(adev, true);
> -
> -     soc15_gpu_pci_config_reset(adev);
> -
>        amdgpu_atombios_scratch_regs_engine_hung(adev, false);
>
>        return 0;



--_000_CY1PR12MB0474031DB47F7973953B58E48C6C0CY1PR12MB0474namp_
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
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>sure, thanks.<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 15, 2017 4:13:45 PM<br>
<b>To:</b> Wang, Ken; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add GPU reset functionality for Veg=
a10</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 15.09.2017 um 09:57 schrieb Ken.Wang-5C7GfCeVMHo@public.gmane.org:<b=
r>
&gt; From: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; V2<br>
&gt;<br>
&gt; Signed-off-by: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Acked-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
I would give an rb, but I can't judge if the PSP stuff is actually <br>
correct, maybe wait for Alex to have a look as well.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; Change-Id: I6fd2c216a84747313f18db25a444be5ed43b4f4b<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 3 &#43;=
&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; =
| 21 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&nbsp; =
|&nbsp; 3 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 7 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v10_0.h&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 2 &#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; | 34 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v3_1.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 27 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;------------<br>
&gt;&nbsp;&nbsp; 8 files changed, 83 insertions(&#43;), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index fc1c5437..2ad9737 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2644,7 &#43;2644,8 @@ static bool amdgpu_need_full_reset(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_=
IP_BLOCK_TYPE_GMC) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-=
&gt;type =3D=3D AMD_IP_BLOCK_TYPE_SMC) ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-=
&gt;type =3D=3D AMD_IP_BLOCK_TYPE_ACP) ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D =
AMD_IP_BLOCK_TYPE_DCE)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-&gt;type =3D=
=3D AMD_IP_BLOCK_TYPE_DCE) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;typ=
e =3D=3D AMD_IP_BLOCK_TYPE_PSP) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ade=
v-&gt;ip_blocks[i].status.hang) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;Some block need ful=
l reset!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.c<br>
&gt; index 8a1ee97..8e53650 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; @@ -62,6 &#43;62,7 @@ static int psp_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;cmd_submit =3D psp_v3_1_cmd_submit;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;compare_sram_data =3D psp_v3_1_compare_sram_dat=
a;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;smu_reload_quirk =3D psp_v3_1_smu_reload_quirk;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; psp-&gt;mode1_reset =3D psp_v3_1_mode1_reset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;init_microcode =3D psp_v10_0_init_microcode;<br=
>
&gt; @@ -72,6 &#43;73,7 @@ static int psp_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;ring_destroy =3D psp_v10_0_ring_destroy;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;cmd_submit =3D psp_v10_0_cmd_submit;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; psp-&gt;compare_sram_data =3D psp_v10_0_compare_sram_da=
ta;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; psp-&gt;mode1_reset =3D psp_v10_0_mode1_reset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; @@ -497,6 &#43;499,22 @@ static int psp_resume(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static bool psp_check_reset(void* handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA1=
0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int psp_reset(void* handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return psp_mode1_reset(&amp;adev-&gt;psp=
);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static bool psp_check_fw_loading_status(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum AMDGPU_UCODE_ID ucode_type)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -540,8 &#43;558,9 @@ const struct amd_ip_funcs psp_ip_funcs =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .suspend =3D psp_suspend,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D psp_resume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_idle =3D NULL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .check_soft_reset =3D psp_check_reset,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_idle =3D NULL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D NULL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D psp_reset,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =3D p=
sp_set_clockgating_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D p=
sp_set_powergating_state,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.h<br>
&gt; index 1b7d12d..ce465455 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; @@ -76,6 &#43;76,7 @@ struct psp_context<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware=
_info *ucode,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum AMDGPU_UCODE_ID u=
code_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*smu_reload_quirk)(str=
uct psp_context *psp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*mode1_reset)(struct psp_context *p=
sp);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fence buffer */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; *fw_pri_bo;<br>
&gt; @@ -139,6 &#43;140,8 @@ struct amdgpu_psp_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((psp)-&gt;bootloader_load_sos ? (psp)-&gt;bootloader_l=
oad_sos((psp)) : 0)<br>
&gt;&nbsp;&nbsp; #define psp_smu_reload_quirk(psp) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((psp)-&gt;smu_reload_quirk ? (psp)-&gt;smu_reload_quir=
k((psp)) : false)<br>
&gt; &#43;#define psp_mode1_reset(psp) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ((psp)-&gt;mode1_reset ? (psp)-&gt;mode1_reset((psp)) : false)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; extern const struct amd_ip_funcs psp_ip_funcs;<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/psp_v10_0.c<br>
&gt; index 6b324da..cbc43bb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&gt; @@ -406,3 &#43;406,10 @@ bool psp_v10_0_compare_sram_data(struct psp_c=
ontext *psp,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt; &#43;int psp_v10_0_mode1_reset(struct psp_context *psp)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;psp mode 1 reset not supp=
orted now! \n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h b/drivers/gpu/drm/=
amd/amdgpu/psp_v10_0.h<br>
&gt; index 3af3ad1..451e830 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h<br>
&gt; @@ -45,4 &#43;45,6 @@ extern int psp_v10_0_cmd_submit(struct psp_conte=
xt *psp,<br>
&gt;&nbsp;&nbsp; extern bool psp_v10_0_compare_sram_data(struct psp_context=
 *psp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_firmware_info *ucode,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; enum AMDGPU_UCODE_ID ucode_type);<br>
&gt; &#43;<br>
&gt; &#43;extern int psp_v10_0_mode1_reset(struct psp_context *psp);<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/a=
md/amdgpu/psp_v3_1.c<br>
&gt; index eb73931..4e70bad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
&gt; @@ -530,3 &#43;530,37 @@ bool psp_v3_1_smu_reload_quirk(struct psp_con=
text *psp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D RREG32_SOC15(NBIO, 0=
, mmPCIE_DATA2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (reg &amp; MP1_FIRMWA=
RE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true : false;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;int psp_v3_1_mode1_reset(struct psp_context *psp)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;a=
dev;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP=
0_SMN_C2PMSG_64);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_wait_for(psp, offset, 0x8000=
0000, 0x8000FFFF, false);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;psp is not working correctly before mode1 reset!\n&q=
uot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*send the mode 1 reset command*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(offset, 0x70000);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1000);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP=
0_SMN_C2PMSG_33);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_wait_for(psp, offset, 0x8000=
0000, 0x80000000, false);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_INFO(&quot;psp mode 1 reset failed!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;psp mode1 reset succeed \=
n&quot;);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h b/drivers/gpu/drm/a=
md/amdgpu/psp_v3_1.h<br>
&gt; index 5af2231..b05dbad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h<br>
&gt; @@ -53,4 &#43;53,5 @@ extern bool psp_v3_1_compare_sram_data(struct ps=
p_context *psp,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct amdgpu_firmware_info *ucode,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; enum AMDGPU_UCODE_ID ucode_type);<br>
&gt;&nbsp;&nbsp; extern bool psp_v3_1_smu_reload_quirk(struct psp_context *=
psp);<br>
&gt; &#43;extern int psp_v3_1_mode1_reset(struct psp_context *psp);<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/=
amdgpu/soc15.c<br>
&gt; index a74d616..9c75961 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -407,18 &#43;407,27 @@ static int soc15_read_register(struct amdgpu=
_device *adev, u32 se_num,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static void soc15_gpu_pci_config_reset(struct amdgpu_device *adev)<br=
>
&gt; &#43;static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU pci config =
reset\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engine_hung=
(adev, true);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU reset\n=
&quot;);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable BM */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_clear_master(adev-&gt;pd=
ev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* reset */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pci_config_reset(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; udelay(100);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pci_save_state(adev-&gt;pdev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_IP_NUM; =
i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLOCK_TYPE=
_PSP){<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[=
i].version-&gt;funcs-&gt;soft_reset((void *)adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pci_restore_state(adev-&gt;pdev);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come out=
 of reset */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt; @@ -430,14 &#43;439,6 @@ static void soc15_gpu_pci_config_reset(struct=
 amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -}<br>
&gt; -<br>
&gt; -static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engine_hung(ade=
v, true);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; soc15_gpu_pci_config_reset(adev);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs=
_engine_hung(adev, false);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR12MB0474031DB47F7973953B58E48C6C0CY1PR12MB0474namp_--

--===============2026225975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2026225975==--
