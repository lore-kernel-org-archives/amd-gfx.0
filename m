From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 8/8] drm/amdgpu/psp: add psp memory training implementation
Date: Wed, 16 Oct 2019 02:19:57 +0000
Message-ID: <DM5PR12MB2535098825FB8316985B8A6995920@DM5PR12MB2535.namprd12.prod.outlook.com>
References: <20191014032118.14020-1-tianci.yin@amd.com>
 <20191014032118.14020-8-tianci.yin@amd.com>,
 <ee92928c-0484-b6d0-2230-1587dc4166af@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ee92928c-0484-b6d0-2230-1587dc4166af-5C7GfCeVMHo@public.gmane.org>
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
To: "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--_004_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_"

--_000_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks very much! Please review again.

Rico
________________________________
From: Tuikov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 16, 2019 1:59
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexa=
nder.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 8/8] drm/amdgpu/psp: add psp memory training implementa=
tion

On 2019-10-13 11:21 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> add memory training implementation code to save resume time.
>
> Change-Id: I625794a780b11d824ab57ef39cc33b872c6dc6c9
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   9 ++
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 159 ++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 8704f93cabf2..c2b776fd82b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -151,6 +151,7 @@ extern uint amdgpu_sdma_phase_quantum;
>  extern char *amdgpu_disable_cu;
>  extern char *amdgpu_virtual_display;
>  extern uint amdgpu_pp_feature_mask;
> +extern uint amdgpu_force_long_training;
>  extern int amdgpu_job_hang_limit;
>  extern int amdgpu_lbpw;
>  extern int amdgpu_compute_multipipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index da7cbee25c61..c7d086569acb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -127,6 +127,7 @@ char *amdgpu_disable_cu =3D NULL;
>  char *amdgpu_virtual_display =3D NULL;
>  /* OverDrive(bit 14) disabled by default*/
>  uint amdgpu_pp_feature_mask =3D 0xffffbfff;
> +uint amdgpu_force_long_training =3D 0;
>  int amdgpu_job_hang_limit =3D 0;
>  int amdgpu_lbpw =3D -1;
>  int amdgpu_compute_multipipe =3D -1;
> @@ -390,6 +391,14 @@ module_param_named(sched_hw_submission, amdgpu_sched=
_hw_submission, int, 0444);
>  MODULE_PARM_DESC(ppfeaturemask, "all power features enabled (default))")=
;
>  module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, uint, 0444);
>
> +/**
> + * DOC: forcelongtraining (uint)
> + * Force long memory training in resume.
> + * The default is zero, indicates short training in resume.
> + */
> +MODULE_PARM_DESC(forcelongtraining, "force memory long training");
> +module_param_named(forcelongtraining, amdgpu_force_long_training, uint, =
0444);
> +
>  /**
>   * DOC: pcie_gen_cap (uint)
>   * Override PCIE gen speed capabilities. See the CAIL flags in drivers/g=
pu/drm/amd/include/amd_pcie.h.
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v11_0.c
> index 2ba0f68ced10..b7efaa3e913c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -902,6 +902,162 @@ static int psp_v11_0_rlc_autoload_start(struct psp_=
context *psp)
>        return psp_rlc_autoload_start(psp);
>  }
>
> +static int psp_v11_0_memory_training_send_msg(struct psp_context *psp, i=
nt msg)
> +{
> +     int ret =3D 0;
> +     int i =3D 0;
> +     uint32_t data_32 =3D 0;

NAK!

Leave all of those integer variables uninitialized.

> +     struct amdgpu_device *adev =3D psp->adev;
> +
> +     data_32 =3D (psp->mem_train_ctx.c2p_train_data_offset >> 20);
> +     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, data_32);
> +     WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35, msg);
> +
> +     /*max 5s*/
> +     while (i < 50) {
> +             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SM=
N_C2PMSG_35),
> +                                0x80000000, 0x80000000, false);
> +             if (ret =3D=3D 0)
> +                     break;
> +             i++;
> +     }

NAK!

For-loop please:

for (i =3D 0; i < 50; i++) {
        ret =3D ...;
}

Regards,
Luben

> +     DRM_DEBUG("%s training %s, cost %d * %dms.\n",
> +               (msg =3D=3D PSP_BL__DRAM_SHORT_TRAIN) ? "short" : "long",
> +               (ret =3D=3D 0) ? "succeed" : "failed",
> +               i, adev->usec_timeout/1000);
> +     return ret;
> +}
> +
> +static int psp_v11_0_memory_training_fini(struct psp_context *psp)
> +{
> +     int ret =3D 0;
> +     struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
> +
> +     ctx->init =3D PSP_MEM_TRAIN_NOT_SUPPORT;
> +     if(ctx->sys_cache) {
> +             kfree(ctx->sys_cache);
> +             ctx->sys_cache =3D NULL;
> +     }
> +
> +     return ret;
> +}
> +
> +static int psp_v11_0_memory_training_init(struct psp_context *psp)
> +{
> +     int ret =3D 0;
> +     struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
> +
> +     if(ctx->init !=3D PSP_MEM_TRAIN_RESERVE_SUCCESS) {
> +             DRM_DEBUG("memory training does not support!\n");
> +             return 0;
> +     }
> +
> +     ctx->sys_cache =3D kzalloc(ctx->train_data_size, GFP_KERNEL);
> +     if(ctx->sys_cache =3D=3D NULL) {
> +             DRM_ERROR("alloc mem_train_ctx.sys_cache failed(%d)!\n", re=
t);
> +             ret =3D -ENOMEM;
> +             goto Err_out;
> +     }
> +
> +     DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_trai=
n_data_offset:%llx.\n",
> +               ctx->train_data_size,
> +               ctx->p2c_train_data_offset,
> +               ctx->c2p_train_data_offset);
> +     ctx->init =3D PSP_MEM_TRAIN_INIT_SUCCESS;
> +     return 0;
> +
> +Err_out:
> +     psp_v11_0_memory_training_fini(psp);
> +     return ret;
> +}
> +
> +/*
> + * save and restore proces
> + */
> +static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t o=
ps)
> +{
> +     int ret =3D 0;
> +     uint32_t p2c_header[4];
> +     struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
> +     uint32_t *pcache =3D (uint32_t*)ctx->sys_cache;
> +
> +     if (ctx->init =3D=3D PSP_MEM_TRAIN_NOT_SUPPORT) {
> +             DRM_DEBUG("Memory training does not support.\n");
> +             return 0;
> +     } else if (ctx->init !=3D PSP_MEM_TRAIN_INIT_SUCCESS) {
> +             DRM_ERROR("Please check initialization failure.\n");
> +             return -EINVAL;
> +     }
> +
> +     if (psp_v11_0_is_sos_alive(psp)) {
> +             DRM_DEBUG("sos is alive, skip memory training.\n");
> +             return 0;
> +     }
> +
> +     amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, p2=
c_header, sizeof(p2c_header), false);
> +     DRM_DEBUG("sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x=
,%08x]\n",
> +               pcache[0], pcache[1], pcache[2], pcache[3],
> +               p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3=
]);
> +
> +     if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
> +             DRM_DEBUG("short training depend on restore.\n");
> +             ops |=3D PSP_MEM_TRAIN_RESTORE;
> +     }
> +
> +     if ((ops & PSP_MEM_TRAIN_RESTORE) &&
> +         pcache[0] !=3D MEM_TRAIN_SYSTEM_SIGNATURE) {
> +             DRM_DEBUG("sys_cache[0] is invalid, restore depend on save.=
\n");
> +             ops |=3D PSP_MEM_TRAIN_SAVE;
> +     }
> +
> +     if (p2c_header[0] =3D=3D MEM_TRAIN_SYSTEM_SIGNATURE &&
> +         !(pcache[0] =3D=3D MEM_TRAIN_SYSTEM_SIGNATURE &&
> +           pcache[3] =3D=3D p2c_header[3])) {
> +             DRM_DEBUG("sys_cache is invalid or out-of-date, need save t=
raining data to sys_cache.\n");
> +             ops |=3D PSP_MEM_TRAIN_SAVE;
> +     }
> +
> +     if ((ops & PSP_MEM_TRAIN_SAVE) &&
> +         p2c_header[0] !=3D MEM_TRAIN_SYSTEM_SIGNATURE) {
> +             DRM_DEBUG("p2c_header[0] is invalid, save depend on long tr=
aining.\n");
> +             ops |=3D PSP_MEM_TRAIN_SEND_LONG_MSG;
> +     }
> +
> +     if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> +             ops &=3D ~PSP_MEM_TRAIN_SEND_SHORT_MSG;
> +             ops |=3D PSP_MEM_TRAIN_SAVE;
> +     }
> +
> +     DRM_DEBUG("mem training ops:%x.\n", ops);
> +
> +     if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> +             ret =3D psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRA=
M_LONG_TRAIN);
> +             if (ret) {
> +                     DRM_ERROR("send long training msg failed.\n");
> +                     return ret;
> +             }
> +     }
> +
> +     if (ops & PSP_MEM_TRAIN_SAVE) {
> +             amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_of=
fset, ctx->sys_cache, ctx->train_data_size, false);
> +     }
> +
> +     if (ops & PSP_MEM_TRAIN_RESTORE) {
> +             amdgpu_device_vram_access(psp->adev, ctx->c2p_train_data_of=
fset, ctx->sys_cache, ctx->train_data_size, true);
> +     }
> +
> +     if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
> +             ret =3D psp_v11_0_memory_training_send_msg(psp, (amdgpu_for=
ce_long_training > 0) ?
> +                                                      PSP_BL__DRAM_LONG_=
TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
> +             if (ret) {
> +                     DRM_ERROR("send training msg failed.\n");
> +                     return ret;
> +             }
> +     }
> +     ctx->training_cnt++;
> +     return ret;
> +}
> +
>  static const struct psp_funcs psp_v11_0_funcs =3D {
>        .init_microcode =3D psp_v11_0_init_microcode,
>        .bootloader_load_kdb =3D psp_v11_0_bootloader_load_kdb,
> @@ -922,6 +1078,9 @@ static const struct psp_funcs psp_v11_0_funcs =3D {
>        .ras_trigger_error =3D psp_v11_0_ras_trigger_error,
>        .ras_cure_posion =3D psp_v11_0_ras_cure_posion,
>        .rlc_autoload_start =3D psp_v11_0_rlc_autoload_start,
> +     .mem_training_init =3D psp_v11_0_memory_training_init,
> +     .mem_training_fini =3D psp_v11_0_memory_training_fini,
> +     .mem_training =3D psp_v11_0_memory_training,
>  };
>
>  void psp_v11_0_set_psp_funcs(struct psp_context *psp)
>


--_000_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_
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
Thanks very much! Please review again.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 16, 2019 1:59<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 8/8] drm/amdgpu/psp: add psp memory training imp=
lementation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-10-13 11:21 p.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; <br>
&gt; add memory training implementation code to save resume time.<br>
&gt; <br>
&gt; Change-Id: I625794a780b11d824ab57ef39cc33b872c6dc6c9<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp;&nbsp; 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |&nbsp;&nbsp; 9 &#43;&#4=
3;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp; | 159 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 3 files changed, 169 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 8704f93cabf2..c2b776fd82b5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -151,6 &#43;151,7 @@ extern uint amdgpu_sdma_phase_quantum;<br>
&gt;&nbsp; extern char *amdgpu_disable_cu;<br>
&gt;&nbsp; extern char *amdgpu_virtual_display;<br>
&gt;&nbsp; extern uint amdgpu_pp_feature_mask;<br>
&gt; &#43;extern uint amdgpu_force_long_training;<br>
&gt;&nbsp; extern int amdgpu_job_hang_limit;<br>
&gt;&nbsp; extern int amdgpu_lbpw;<br>
&gt;&nbsp; extern int amdgpu_compute_multipipe;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index da7cbee25c61..c7d086569acb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -127,6 &#43;127,7 @@ char *amdgpu_disable_cu =3D NULL;<br>
&gt;&nbsp; char *amdgpu_virtual_display =3D NULL;<br>
&gt;&nbsp; /* OverDrive(bit 14) disabled by default*/<br>
&gt;&nbsp; uint amdgpu_pp_feature_mask =3D 0xffffbfff;<br>
&gt; &#43;uint amdgpu_force_long_training =3D 0;<br>
&gt;&nbsp; int amdgpu_job_hang_limit =3D 0;<br>
&gt;&nbsp; int amdgpu_lbpw =3D -1;<br>
&gt;&nbsp; int amdgpu_compute_multipipe =3D -1;<br>
&gt; @@ -390,6 &#43;391,14 @@ module_param_named(sched_hw_submission, amdgp=
u_sched_hw_submission, int, 0444);<br>
&gt;&nbsp; MODULE_PARM_DESC(ppfeaturemask, &quot;all power features enabled=
 (default))&quot;);<br>
&gt;&nbsp; module_param_named(ppfeaturemask, amdgpu_pp_feature_mask, uint, =
0444);<br>
&gt;&nbsp; <br>
&gt; &#43;/**<br>
&gt; &#43; * DOC: forcelongtraining (uint)<br>
&gt; &#43; * Force long memory training in resume.<br>
&gt; &#43; * The default is zero, indicates short training in resume.<br>
&gt; &#43; */<br>
&gt; &#43;MODULE_PARM_DESC(forcelongtraining, &quot;force memory long train=
ing&quot;);<br>
&gt; &#43;module_param_named(forcelongtraining, amdgpu_force_long_training,=
 uint, 0444);<br>
&gt; &#43;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * DOC: pcie_gen_cap (uint)<br>
&gt;&nbsp;&nbsp; * Override PCIE gen speed capabilities. See the CAIL flags=
 in drivers/gpu/drm/amd/include/amd_pcie.h.<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/psp_v11_0.c<br>
&gt; index 2ba0f68ced10..b7efaa3e913c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&gt; @@ -902,6 &#43;902,162 @@ static int psp_v11_0_rlc_autoload_start(stru=
ct psp_context *psp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_rlc_autoload_star=
t(psp);<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static int psp_v11_0_memory_training_send_msg(struct psp_context =
*psp, int msg)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data_32 =3D 0;<br>
<br>
NAK!<br>
<br>
Leave all of those integer variables uninitialized.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D psp-&gt;a=
dev;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data_32 =3D (psp-&gt;mem_train_ctx.c2p_t=
rain_data_offset &gt;&gt; 20);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36=
, data_32);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35=
, msg);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /*max 5s*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt; 50) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG=
_35),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000, 0x80000000, fals=
e);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; i&#43;&#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
NAK! <br>
<br>
For-loop please:<br>
<br>
for (i =3D 0; i &lt; 50; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ...;<br>
}<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;%s training %s, cost %d =
* %dms.\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (msg =3D=3D PSP_BL__DRAM_SHORT_TRAIN) ? &quot;short&quo=
t; : &quot;long&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (ret =3D=3D 0) ? &quot;succeed&quot; : &quot;failed&quo=
t;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, adev-&gt;usec_timeout/1000);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int psp_v11_0_memory_training_fini(struct psp_context *psp=
)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;psp-&gt;mem_train_ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_TRAIN_NOT_SUPPO=
RT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ctx-&gt;sys_cache) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfree(ctx-&gt;sys_cache);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ctx-&gt;sys_cache =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int psp_v11_0_memory_training_init(struct psp_context *psp=
)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;psp-&gt;mem_train_ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ctx-&gt;init !=3D PSP_MEM_TRAIN_RESER=
VE_SUCCESS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;memory training does not support!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;sys_cache =3D kzalloc(ctx-&gt;tr=
ain_data_size, GFP_KERNEL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if(ctx-&gt;sys_cache =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;alloc mem_train_ctx.sys_cache failed(%d)!\n&quot;, =
ret);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D -ENOMEM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto Err_out;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;train_data_size:%llx,p2c=
_train_data_offset:%llx,c2p_train_data_offset:%llx.\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_TRAIN_INIT_SUCC=
ESS;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;Err_out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; psp_v11_0_memory_training_fini(psp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/*<br>
&gt; &#43; * save and restore proces<br>
&gt; &#43; */<br>
&gt; &#43;static int psp_v11_0_memory_training(struct psp_context *psp, uin=
t32_t ops)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t p2c_header[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;psp-&gt;mem_train_ctx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *pcache =3D (uint32_t*)ctx-&gt;=
sys_cache;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;init =3D=3D PSP_MEM_TRAIN_NO=
T_SUPPORT) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;Memory training does not support.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ctx-&gt;init !=3D PSP_MEM_TRA=
IN_INIT_SUCCESS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_ERROR(&quot;Please check initialization failure.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_v11_0_is_sos_alive(psp)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;sos is alive, skip memory training.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_access(psp-&gt;adev, =
ctx-&gt;p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;sys_cache[%08x,%08x,%08x=
,%08x] p2c_header[%08x,%08x,%08x,%08x]\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pcache[0], pcache[1], pcache[2], pcache[3],<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; p2c_header[0], p2c_header[1], p2c_header[2], p2c_header=
[3]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_SEND_SHORT_M=
SG) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;short training depend on restore.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops |=3D PSP_MEM_TRAIN_RESTORE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if ((ops &amp; PSP_MEM_TRAIN_RESTORE) &a=
mp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcache[0] !=3D M=
EM_TRAIN_SYSTEM_SIGNATURE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;sys_cache[0] is invalid, restore depend on save.\n&=
quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops |=3D PSP_MEM_TRAIN_SAVE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (p2c_header[0] =3D=3D MEM_TRAIN_SYSTE=
M_SIGNATURE &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(pcache[0] =3D=
=3D MEM_TRAIN_SYSTEM_SIGNATURE &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcac=
he[3] =3D=3D p2c_header[3])) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;sys_cache is invalid or out-of-date, need save trai=
ning data to sys_cache.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops |=3D PSP_MEM_TRAIN_SAVE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if ((ops &amp; PSP_MEM_TRAIN_SAVE) &amp;=
&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2c_header[0] !=
=3D MEM_TRAIN_SYSTEM_SIGNATURE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_DEBUG(&quot;p2c_header[0] is invalid, save depend on long train=
ing.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops |=3D PSP_MEM_TRAIN_SEND_LONG_MSG;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_SEND_LONG_MS=
G) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops &amp;=3D ~PSP_MEM_TRAIN_SEND_SHORT_MSG;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ops |=3D PSP_MEM_TRAIN_SAVE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;mem training ops:%x.\n&q=
uot;, ops);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_SEND_LONG_MS=
G) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_T=
RAIN);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;sen=
d long training msg failed.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_SAVE) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_device_vram_access(psp-&gt;adev, ctx-&gt;p2c_train_data_offs=
et, ctx-&gt;sys_cache, ctx-&gt;train_data_size, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_RESTORE) {<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_device_vram_access(psp-&gt;adev, ctx-&gt;c2p_train_data_offs=
et, ctx-&gt;sys_cache, ctx-&gt;train_data_size, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ops &amp; PSP_MEM_TRAIN_SEND_SHORT_M=
SG) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D psp_v11_0_memory_training_send_msg(psp, (amdgpu_force_long_=
training &gt; 0) ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_T=
RAIN);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;sen=
d training msg failed.\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;training_cnt&#43;&#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct psp_funcs psp_v11_0_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D psp_v11_=
0_init_microcode,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .bootloader_load_kdb =3D psp=
_v11_0_bootloader_load_kdb,<br>
&gt; @@ -922,6 &#43;1078,9 @@ static const struct psp_funcs psp_v11_0_funcs=
 =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_trigger_error =3D psp_v=
11_0_ras_trigger_error,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_cure_posion =3D psp_v11=
_0_ras_cure_posion,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rlc_autoload_start =3D psp_=
v11_0_rlc_autoload_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .mem_training_init =3D psp_v11_0_memory_=
training_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .mem_training_fini =3D psp_v11_0_memory_=
training_fini,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .mem_training =3D psp_v11_0_memory_train=
ing,<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; void psp_v11_0_set_psp_funcs(struct psp_context *psp)<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_--

--_004_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-psp-add-psp-memory-training-implementatio.patch"
Content-Description: 0001-drm-amdgpu-psp-add-psp-memory-training-implementatio.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-psp-add-psp-memory-training-implementatio.patch";
	size=7873; creation-date="Wed, 16 Oct 2019 02:19:24 GMT";
	modification-date="Wed, 16 Oct 2019 02:19:57 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYmVjOWEyNTAxYmNhMWZjOTE0YjJhMjZiNTg3ODcwNTcyYmM0NjRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiVGlhbmNpLllpbiIgPHRpYW5jaS55aW5AYW1kLmNvbT4KRGF0
ZTogTW9uLCAzMCBTZXAgMjAxOSAxNDoyOTozMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHUvcHNwOiBhZGQgcHNwIG1lbW9yeSB0cmFpbmluZyBpbXBsZW1lbnRhdGlvbih2MikKCmFk
ZCBtZW1vcnkgdHJhaW5pbmcgaW1wbGVtZW50YXRpb24gY29kZSB0byBzYXZlIHJlc3VtZSB0aW1l
LgoKQ2hhbmdlLUlkOiBJNjI1Nzk0YTc4MGIxMWQ4MjRhYjU3ZWYzOWNjMzNiODcyYzZkYzZjOQpS
ZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBUaWFuY2kuWWluIDx0aWFuY2kueWluQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgIHwgICAxICsKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICAgOSArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvcHNwX3YxMV8wLmMgIHwgMTU3ICsrKysrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBj
aGFuZ2VkLCAxNjcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgK
aW5kZXggODcwNGY5M2NhYmYyLi5jMmI3NzZmZDgyYjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdS5oCkBAIC0xNTEsNiArMTUxLDcgQEAgZXh0ZXJuIHVpbnQgYW1kZ3B1X3NkbWFfcGhh
c2VfcXVhbnR1bTsKIGV4dGVybiBjaGFyICphbWRncHVfZGlzYWJsZV9jdTsKIGV4dGVybiBjaGFy
ICphbWRncHVfdmlydHVhbF9kaXNwbGF5OwogZXh0ZXJuIHVpbnQgYW1kZ3B1X3BwX2ZlYXR1cmVf
bWFzazsKK2V4dGVybiB1aW50IGFtZGdwdV9mb3JjZV9sb25nX3RyYWluaW5nOwogZXh0ZXJuIGlu
dCBhbWRncHVfam9iX2hhbmdfbGltaXQ7CiBleHRlcm4gaW50IGFtZGdwdV9sYnB3OwogZXh0ZXJu
IGludCBhbWRncHVfY29tcHV0ZV9tdWx0aXBpcGU7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMKaW5kZXggZGE3Y2JlZTI1YzYxLi5jN2QwODY1NjlhY2IgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKQEAgLTEyNyw2ICsxMjcsNyBAQCBjaGFyICph
bWRncHVfZGlzYWJsZV9jdSA9IE5VTEw7CiBjaGFyICphbWRncHVfdmlydHVhbF9kaXNwbGF5ID0g
TlVMTDsKIC8qIE92ZXJEcml2ZShiaXQgMTQpIGRpc2FibGVkIGJ5IGRlZmF1bHQqLwogdWludCBh
bWRncHVfcHBfZmVhdHVyZV9tYXNrID0gMHhmZmZmYmZmZjsKK3VpbnQgYW1kZ3B1X2ZvcmNlX2xv
bmdfdHJhaW5pbmcgPSAwOwogaW50IGFtZGdwdV9qb2JfaGFuZ19saW1pdCA9IDA7CiBpbnQgYW1k
Z3B1X2xicHcgPSAtMTsKIGludCBhbWRncHVfY29tcHV0ZV9tdWx0aXBpcGUgPSAtMTsKQEAgLTM5
MCw2ICszOTEsMTQgQEAgbW9kdWxlX3BhcmFtX25hbWVkKHNjaGVkX2h3X3N1Ym1pc3Npb24sIGFt
ZGdwdV9zY2hlZF9od19zdWJtaXNzaW9uLCBpbnQsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyhw
cGZlYXR1cmVtYXNrLCAiYWxsIHBvd2VyIGZlYXR1cmVzIGVuYWJsZWQgKGRlZmF1bHQpKSIpOwog
bW9kdWxlX3BhcmFtX25hbWVkKHBwZmVhdHVyZW1hc2ssIGFtZGdwdV9wcF9mZWF0dXJlX21hc2ss
IHVpbnQsIDA0NDQpOwogCisvKioKKyAqIERPQzogZm9yY2Vsb25ndHJhaW5pbmcgKHVpbnQpCisg
KiBGb3JjZSBsb25nIG1lbW9yeSB0cmFpbmluZyBpbiByZXN1bWUuCisgKiBUaGUgZGVmYXVsdCBp
cyB6ZXJvLCBpbmRpY2F0ZXMgc2hvcnQgdHJhaW5pbmcgaW4gcmVzdW1lLgorICovCitNT0RVTEVf
UEFSTV9ERVNDKGZvcmNlbG9uZ3RyYWluaW5nLCAiZm9yY2UgbWVtb3J5IGxvbmcgdHJhaW5pbmci
KTsKK21vZHVsZV9wYXJhbV9uYW1lZChmb3JjZWxvbmd0cmFpbmluZywgYW1kZ3B1X2ZvcmNlX2xv
bmdfdHJhaW5pbmcsIHVpbnQsIDA0NDQpOworCiAvKioKICAqIERPQzogcGNpZV9nZW5fY2FwICh1
aW50KQogICogT3ZlcnJpZGUgUENJRSBnZW4gc3BlZWQgY2FwYWJpbGl0aWVzLiBTZWUgdGhlIENB
SUwgZmxhZ3MgaW4gZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9wY2llLmguCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jCmluZGV4IDJiYTBmNjhjZWQxMC4uZWQxZDRl
OWEzZThiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYwpAQCAtOTAyLDYg
KzkwMiwxNjAgQEAgc3RhdGljIGludCBwc3BfdjExXzBfcmxjX2F1dG9sb2FkX3N0YXJ0KHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwKQogCXJldHVybiBwc3BfcmxjX2F1dG9sb2FkX3N0YXJ0KHBzcCk7
CiB9CiAKK3N0YXRpYyBpbnQgcHNwX3YxMV8wX21lbW9yeV90cmFpbmluZ19zZW5kX21zZyhzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCwgaW50IG1zZykKK3sKKwlpbnQgcmV0OworCWludCBpOworCXVp
bnQzMl90IGRhdGFfMzI7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7
CisKKwlkYXRhXzMyID0gKHBzcC0+bWVtX3RyYWluX2N0eC5jMnBfdHJhaW5fZGF0YV9vZmZzZXQg
Pj4gMjApOworCVdSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfMzYsIGRhdGFf
MzIpOworCVdSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfMzUsIG1zZyk7CisK
KwkvKm1heCA1cyovCisJZm9yIChpID0gMDsgaSA8IDUwOyBpKyspIHsKKwkJcmV0ID0gcHNwX3dh
aXRfZm9yKHBzcCwgU09DMTVfUkVHX09GRlNFVChNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfMzUp
LAorCQkJCSAgIDB4ODAwMDAwMDAsIDB4ODAwMDAwMDAsIGZhbHNlKTsKKwkJaWYgKHJldCA9PSAw
KQorCQkJYnJlYWs7CisJfQorCURSTV9ERUJVRygiJXMgdHJhaW5pbmcgJXMsIGNvc3QgJWQgKiAl
ZG1zLlxuIiwKKwkJICAobXNnID09IFBTUF9CTF9fRFJBTV9TSE9SVF9UUkFJTikgPyAic2hvcnQi
IDogImxvbmciLAorCQkgIChyZXQgPT0gMCkgPyAic3VjY2VlZCIgOiAiZmFpbGVkIiwKKwkJICBp
LCBhZGV2LT51c2VjX3RpbWVvdXQvMTAwMCk7CisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlu
dCBwc3BfdjExXzBfbWVtb3J5X3RyYWluaW5nX2Zpbmkoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
Cit7CisJc3RydWN0IHBzcF9tZW1vcnlfdHJhaW5pbmdfY29udGV4dCAqY3R4ID0gJnBzcC0+bWVt
X3RyYWluX2N0eDsKKworCWN0eC0+aW5pdCA9IFBTUF9NRU1fVFJBSU5fTk9UX1NVUFBPUlQ7CisJ
aWYgKGN0eC0+c3lzX2NhY2hlKSB7CisJCWtmcmVlKGN0eC0+c3lzX2NhY2hlKTsKKwkJY3R4LT5z
eXNfY2FjaGUgPSBOVUxMOworCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHBzcF92
MTFfMF9tZW1vcnlfdHJhaW5pbmdfaW5pdChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKK3sKKwlp
bnQgcmV0OworCXN0cnVjdCBwc3BfbWVtb3J5X3RyYWluaW5nX2NvbnRleHQgKmN0eCA9ICZwc3At
Pm1lbV90cmFpbl9jdHg7CisKKwlpZiAoY3R4LT5pbml0ICE9IFBTUF9NRU1fVFJBSU5fUkVTRVJW
RV9TVUNDRVNTKSB7CisJCURSTV9ERUJVRygibWVtb3J5IHRyYWluaW5nIGRvZXMgbm90IHN1cHBv
cnQhXG4iKTsKKwkJcmV0dXJuIDA7CisJfQorCisJY3R4LT5zeXNfY2FjaGUgPSBremFsbG9jKGN0
eC0+dHJhaW5fZGF0YV9zaXplLCBHRlBfS0VSTkVMKTsKKwlpZiAoY3R4LT5zeXNfY2FjaGUgPT0g
TlVMTCkgeworCQlEUk1fRVJST1IoImFsbG9jIG1lbV90cmFpbl9jdHguc3lzX2NhY2hlIGZhaWxl
ZCFcbiIpOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3RvIEVycl9vdXQ7CisJfQorCisJRFJNX0RF
QlVHKCJ0cmFpbl9kYXRhX3NpemU6JWxseCxwMmNfdHJhaW5fZGF0YV9vZmZzZXQ6JWxseCxjMnBf
dHJhaW5fZGF0YV9vZmZzZXQ6JWxseC5cbiIsCisJCSAgY3R4LT50cmFpbl9kYXRhX3NpemUsCisJ
CSAgY3R4LT5wMmNfdHJhaW5fZGF0YV9vZmZzZXQsCisJCSAgY3R4LT5jMnBfdHJhaW5fZGF0YV9v
ZmZzZXQpOworCWN0eC0+aW5pdCA9IFBTUF9NRU1fVFJBSU5fSU5JVF9TVUNDRVNTOworCXJldHVy
biAwOworCitFcnJfb3V0OgorCXBzcF92MTFfMF9tZW1vcnlfdHJhaW5pbmdfZmluaShwc3ApOwor
CXJldHVybiByZXQ7Cit9CisKKy8qCisgKiBzYXZlIGFuZCByZXN0b3JlIHByb2NlcworICovCitz
dGF0aWMgaW50IHBzcF92MTFfMF9tZW1vcnlfdHJhaW5pbmcoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3AsIHVpbnQzMl90IG9wcykKK3sKKwlpbnQgcmV0OworCXVpbnQzMl90IHAyY19oZWFkZXJbNF07
CisJc3RydWN0IHBzcF9tZW1vcnlfdHJhaW5pbmdfY29udGV4dCAqY3R4ID0gJnBzcC0+bWVtX3Ry
YWluX2N0eDsKKwl1aW50MzJfdCAqcGNhY2hlID0gKHVpbnQzMl90KiljdHgtPnN5c19jYWNoZTsK
KworCWlmIChjdHgtPmluaXQgPT0gUFNQX01FTV9UUkFJTl9OT1RfU1VQUE9SVCkgeworCQlEUk1f
REVCVUcoIk1lbW9yeSB0cmFpbmluZyBkb2VzIG5vdCBzdXBwb3J0LlxuIik7CisJCXJldHVybiAw
OworCX0gZWxzZSBpZiAoY3R4LT5pbml0ICE9IFBTUF9NRU1fVFJBSU5fSU5JVF9TVUNDRVNTKSB7
CisJCURSTV9FUlJPUigiUGxlYXNlIGNoZWNrIGluaXRpYWxpemF0aW9uIGZhaWx1cmUuXG4iKTsK
KwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJaWYgKHBzcF92MTFfMF9pc19zb3NfYWxpdmUocHNw
KSkgeworCQlEUk1fREVCVUcoInNvcyBpcyBhbGl2ZSwgc2tpcCBtZW1vcnkgdHJhaW5pbmcuXG4i
KTsKKwkJcmV0dXJuIDA7CisJfQorCisJYW1kZ3B1X2RldmljZV92cmFtX2FjY2Vzcyhwc3AtPmFk
ZXYsIGN0eC0+cDJjX3RyYWluX2RhdGFfb2Zmc2V0LCBwMmNfaGVhZGVyLCBzaXplb2YocDJjX2hl
YWRlciksIGZhbHNlKTsKKwlEUk1fREVCVUcoInN5c19jYWNoZVslMDh4LCUwOHgsJTA4eCwlMDh4
XSBwMmNfaGVhZGVyWyUwOHgsJTA4eCwlMDh4LCUwOHhdXG4iLAorCQkgIHBjYWNoZVswXSwgcGNh
Y2hlWzFdLCBwY2FjaGVbMl0sIHBjYWNoZVszXSwKKwkJICBwMmNfaGVhZGVyWzBdLCBwMmNfaGVh
ZGVyWzFdLCBwMmNfaGVhZGVyWzJdLCBwMmNfaGVhZGVyWzNdKTsKKworCWlmIChvcHMgJiBQU1Bf
TUVNX1RSQUlOX1NFTkRfU0hPUlRfTVNHKSB7CisJCURSTV9ERUJVRygic2hvcnQgdHJhaW5pbmcg
ZGVwZW5kIG9uIHJlc3RvcmUuXG4iKTsKKwkJb3BzIHw9IFBTUF9NRU1fVFJBSU5fUkVTVE9SRTsK
Kwl9CisKKwlpZiAoKG9wcyAmIFBTUF9NRU1fVFJBSU5fUkVTVE9SRSkgJiYKKwkgICAgcGNhY2hl
WzBdICE9IE1FTV9UUkFJTl9TWVNURU1fU0lHTkFUVVJFKSB7CisJCURSTV9ERUJVRygic3lzX2Nh
Y2hlWzBdIGlzIGludmFsaWQsIHJlc3RvcmUgZGVwZW5kIG9uIHNhdmUuXG4iKTsKKwkJb3BzIHw9
IFBTUF9NRU1fVFJBSU5fU0FWRTsKKwl9CisKKwlpZiAocDJjX2hlYWRlclswXSA9PSBNRU1fVFJB
SU5fU1lTVEVNX1NJR05BVFVSRSAmJgorCSAgICAhKHBjYWNoZVswXSA9PSBNRU1fVFJBSU5fU1lT
VEVNX1NJR05BVFVSRSAmJgorCSAgICAgIHBjYWNoZVszXSA9PSBwMmNfaGVhZGVyWzNdKSkgewor
CQlEUk1fREVCVUcoInN5c19jYWNoZSBpcyBpbnZhbGlkIG9yIG91dC1vZi1kYXRlLCBuZWVkIHNh
dmUgdHJhaW5pbmcgZGF0YSB0byBzeXNfY2FjaGUuXG4iKTsKKwkJb3BzIHw9IFBTUF9NRU1fVFJB
SU5fU0FWRTsKKwl9CisKKwlpZiAoKG9wcyAmIFBTUF9NRU1fVFJBSU5fU0FWRSkgJiYKKwkgICAg
cDJjX2hlYWRlclswXSAhPSBNRU1fVFJBSU5fU1lTVEVNX1NJR05BVFVSRSkgeworCQlEUk1fREVC
VUcoInAyY19oZWFkZXJbMF0gaXMgaW52YWxpZCwgc2F2ZSBkZXBlbmQgb24gbG9uZyB0cmFpbmlu
Zy5cbiIpOworCQlvcHMgfD0gUFNQX01FTV9UUkFJTl9TRU5EX0xPTkdfTVNHOworCX0KKworCWlm
IChvcHMgJiBQU1BfTUVNX1RSQUlOX1NFTkRfTE9OR19NU0cpIHsKKwkJb3BzICY9IH5QU1BfTUVN
X1RSQUlOX1NFTkRfU0hPUlRfTVNHOworCQlvcHMgfD0gUFNQX01FTV9UUkFJTl9TQVZFOworCX0K
KworCURSTV9ERUJVRygibWVtIHRyYWluaW5nIG9wczoleC5cbiIsIG9wcyk7CisKKwlpZiAob3Bz
ICYgUFNQX01FTV9UUkFJTl9TRU5EX0xPTkdfTVNHKSB7CisJCXJldCA9IHBzcF92MTFfMF9tZW1v
cnlfdHJhaW5pbmdfc2VuZF9tc2cocHNwLCBQU1BfQkxfX0RSQU1fTE9OR19UUkFJTik7CisJCWlm
IChyZXQpIHsKKwkJCURSTV9FUlJPUigic2VuZCBsb25nIHRyYWluaW5nIG1zZyBmYWlsZWQuXG4i
KTsKKwkJCXJldHVybiByZXQ7CisJCX0KKwl9CisKKwlpZiAob3BzICYgUFNQX01FTV9UUkFJTl9T
QVZFKSB7CisJCWFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MocHNwLT5hZGV2LCBjdHgtPnAyY190
cmFpbl9kYXRhX29mZnNldCwgY3R4LT5zeXNfY2FjaGUsIGN0eC0+dHJhaW5fZGF0YV9zaXplLCBm
YWxzZSk7CisJfQorCisJaWYgKG9wcyAmIFBTUF9NRU1fVFJBSU5fUkVTVE9SRSkgeworCQlhbWRn
cHVfZGV2aWNlX3ZyYW1fYWNjZXNzKHBzcC0+YWRldiwgY3R4LT5jMnBfdHJhaW5fZGF0YV9vZmZz
ZXQsIGN0eC0+c3lzX2NhY2hlLCBjdHgtPnRyYWluX2RhdGFfc2l6ZSwgdHJ1ZSk7CisJfQorCisJ
aWYgKG9wcyAmIFBTUF9NRU1fVFJBSU5fU0VORF9TSE9SVF9NU0cpIHsKKwkJcmV0ID0gcHNwX3Yx
MV8wX21lbW9yeV90cmFpbmluZ19zZW5kX21zZyhwc3AsIChhbWRncHVfZm9yY2VfbG9uZ190cmFp
bmluZyA+IDApID8KKwkJCQkJCQkgUFNQX0JMX19EUkFNX0xPTkdfVFJBSU4gOiBQU1BfQkxfX0RS
QU1fU0hPUlRfVFJBSU4pOworCQlpZiAocmV0KSB7CisJCQlEUk1fRVJST1IoInNlbmQgdHJhaW5p
bmcgbXNnIGZhaWxlZC5cbiIpOworCQkJcmV0dXJuIHJldDsKKwkJfQorCX0KKwljdHgtPnRyYWlu
aW5nX2NudCsrOworCXJldHVybiAwOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBzcF9mdW5j
cyBwc3BfdjExXzBfZnVuY3MgPSB7CiAJLmluaXRfbWljcm9jb2RlID0gcHNwX3YxMV8wX2luaXRf
bWljcm9jb2RlLAogCS5ib290bG9hZGVyX2xvYWRfa2RiID0gcHNwX3YxMV8wX2Jvb3Rsb2FkZXJf
bG9hZF9rZGIsCkBAIC05MjIsNiArMTA3Niw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHNwX2Z1
bmNzIHBzcF92MTFfMF9mdW5jcyA9IHsKIAkucmFzX3RyaWdnZXJfZXJyb3IgPSBwc3BfdjExXzBf
cmFzX3RyaWdnZXJfZXJyb3IsCiAJLnJhc19jdXJlX3Bvc2lvbiA9IHBzcF92MTFfMF9yYXNfY3Vy
ZV9wb3Npb24sCiAJLnJsY19hdXRvbG9hZF9zdGFydCA9IHBzcF92MTFfMF9ybGNfYXV0b2xvYWRf
c3RhcnQsCisJLm1lbV90cmFpbmluZ19pbml0ID0gcHNwX3YxMV8wX21lbW9yeV90cmFpbmluZ19p
bml0LAorCS5tZW1fdHJhaW5pbmdfZmluaSA9IHBzcF92MTFfMF9tZW1vcnlfdHJhaW5pbmdfZmlu
aSwKKwkubWVtX3RyYWluaW5nID0gcHNwX3YxMV8wX21lbW9yeV90cmFpbmluZywKIH07CiAKIHZv
aWQgcHNwX3YxMV8wX3NldF9wc3BfZnVuY3Moc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCi0tIAoy
LjE3LjEKCg==

--_004_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--_004_DM5PR12MB2535098825FB8316985B8A6995920DM5PR12MB2535namp_--
