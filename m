Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F89C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9F820759
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI+YsFIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9F820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835406E40B;
	Thu, 12 Nov 2020 19:49:05 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198936E40B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:49:05 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p8so7303092wrx.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LmqVtaA45pxZfZOQrXqBFj2o/AtOcZCU9qTqqtN9P7w=;
 b=NI+YsFIbR8nhIcuYzV3jG00jAvE5dfQ7W8rjnXn6srVtFA2te67Gvdx4ULsttJh/LS
 44XwaUiicM4ZsH1ZGLOhu4PDs9MZDk+/5l4Ndfaw08nFKQvKGy0YgAZLBjyb0F9qC7wM
 l6oSiGQikHoc+hQo1gACqros1AaaYefWzY+RLGo502ksdZSzmQgAfGXW7JdBwBRFj+Ye
 MuUnk2552/BhsilkQJvKutg3KyZNFvIihHZqp6hyycK+qpfPc06cqH3YzyTUoPGSFvXQ
 PCWj8Htw+o1fvOjmyXF4hqmOMZLG3GLF9WN+2MgYN6/Iul095py7NQQkjaQIVE1j/xx7
 0log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LmqVtaA45pxZfZOQrXqBFj2o/AtOcZCU9qTqqtN9P7w=;
 b=Dkv98nPUEn+F178tJWT0NyoFSkn1gelS2jD0uHF+y0C4iKMNzCospyVe5HotwkV4oo
 avvyiNpoZlD+3bY2uavszxRmr7oOg3ERv7Tch0X+x4NNm89tRRyNE1QHNqcJZilVTjDD
 +9tvUgjjKjZZlDOm7Ra4oH+S85eWbRMXtBLyUIROG/qQx3FHA2iKWkcaPmYA1IBEu75i
 2EChwZSm+4vh5J7MNQANKYS9B+h8gJ/UtRUh4Y/B0og3Y2l3cx+T/n0a4Qf3969/MILw
 46VntYlqfz6StmEx+mjHRr7B7sUc+06C4l12WFZFlQYcy+AOsugfrcalsLOBWZ5VqGB9
 NM/w==
X-Gm-Message-State: AOAM531EdD15QrGliVm4abgcVtrwSx/V9UTWNCpjW1DR/pjrwmfk24Pu
 RTg9/GNA8bdan8t8xBWdhfGcEofMmyk/QsSScL8=
X-Google-Smtp-Source: ABdhPJyalXy04FJbw6OVkdmriAJPGVfqFqsQVNSf2XXHjUbzAPrtq6bL+cq17p2LlwqIgkATpKZUIkbFO+9f9LdG3rY=
X-Received: by 2002:adf:804e:: with SMTP id 72mr1422183wrk.114.1605210543789; 
 Thu, 12 Nov 2020 11:49:03 -0800 (PST)
MIME-Version: 1.0
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
 <1605164796-22215-2-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1605164796-22215-2-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 14:48:52 -0500
Message-ID: <CADnq5_NoSjFugXnP8pzpGYdJdTKFVrLacmDMo+Q8+3t1+=yXVw@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
 power change entry
To: Prike Liang <Prike.Liang@amd.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 12, 2020 at 2:06 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> The new amdgpu_gfx_state_change_set() funtion can support set GFX power
> change status to D0/D3.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c              | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h              |  7 +++++++
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h       |  1 +
>  drivers/gpu/drm/amd/pm/inc/hwmgr.h                   |  1 +
>  drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h                |  3 ++-
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c     | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 10 ++++++++++
>  7 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 97a8f78..380dd3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -819,3 +819,23 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>         }
>         return amdgpu_num_kcq;
>  }
> +
> +/* amdgpu_gfx_state_change_set - Handle gfx power state change set
> + * @adev: amdgpu_device pointer
> + * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
> + *
> + */
> +
> +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
> +{
> +
> +       mutex_lock(&adev->pm.mutex);

pm.mutex is only relevant for the powerplay case.  swSMU uses
different locking.  Move the mutexes into the if clause.

Alex

> +
> +       if (adev->powerplay.pp_funcs &&
> +           adev->powerplay.pp_funcs->gfx_state_change_set)
> +                       ((adev)->powerplay.pp_funcs->gfx_state_change_set(
> +                                       (adev)->powerplay.pp_handle, state));
> +
> +       mutex_unlock(&adev->pm.mutex);
> +
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 671d4b3..6b5a8f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -47,6 +47,12 @@ enum gfx_pipe_priority {
>         AMDGPU_GFX_PIPE_PRIO_MAX
>  };
>
> +/* Argument for PPSMC_MSG_GpuChangeState */
> +enum gfx_change_state {
> +       sGpuChangeState_D0Entry = 1,
> +       sGpuChangeState_D3Entry,
> +};
> +
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>
> @@ -394,4 +400,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
>  int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
> +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
>  #endif
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 94132c7..f775aac 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -285,6 +285,7 @@ struct amd_pm_funcs {
>         int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input, uint32_t size);
>         int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
>         int (*smu_i2c_bus_access)(void *handle, bool acquire);
> +       int (*gfx_state_change_set)(void *handle, uint32_t state);
>  /* export to DC */
>         u32 (*get_sclk)(void *handle, bool low);
>         u32 (*get_mclk)(void *handle, bool low);
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> index 7e29ec2..1bb3794 100644
> --- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> @@ -366,6 +366,7 @@ struct pp_hwmgr_func {
>         int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
>                                         bool disable);
>         ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
> +       int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
>  };
>
>  struct pp_table_func {
> diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> index df4677d..4c7e08b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
> @@ -83,7 +83,8 @@
>  #define PPSMC_MSG_SetSoftMaxVcn                 0x34
>  #define PPSMC_MSG_PowerGateMmHub                0x35
>  #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
> -#define PPSMC_Message_Count                     0x37
> +#define PPSMC_MSG_GpuChangeState                0x37
> +#define PPSMC_Message_Count                     0x42
>
>  typedef uint16_t PPSMC_Result;
>  typedef int      PPSMC_Msg;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index eab9768..e0d2882 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1629,6 +1629,24 @@ static ssize_t pp_get_gpu_metrics(void *handle, void **table)
>         return size;
>  }
>
> +static int pp_gfx_state_change_set(void *handle, uint32_t state)
> +{
> +       struct pp_hwmgr *hwmgr = handle;
> +
> +       if (!hwmgr || !hwmgr->pm_en)
> +               return -EINVAL;
> +
> +       if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
> +               pr_info_ratelimited("%s was not implemented.\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&hwmgr->smu_lock);
> +       hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
> +       mutex_unlock(&hwmgr->smu_lock);
> +       return 0;
> +}
> +
>  static const struct amd_pm_funcs pp_dpm_funcs = {
>         .load_firmware = pp_dpm_load_fw,
>         .wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
> @@ -1691,4 +1709,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>         .set_df_cstate = pp_set_df_cstate,
>         .set_xgmi_pstate = pp_set_xgmi_pstate,
>         .get_gpu_metrics = pp_get_gpu_metrics,
> +       .gfx_state_change_set = pp_gfx_state_change_set,
>  };
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 133a084..50308a5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1439,6 +1439,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> +static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
> +
> +       return 0;
> +}
> +
>  static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>         .backend_init = smu10_hwmgr_backend_init,
>         .backend_fini = smu10_hwmgr_backend_fini,
> @@ -1485,6 +1494,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>         .set_power_profile_mode = smu10_set_power_profile_mode,
>         .asic_reset = smu10_asic_reset,
>         .set_fine_grain_clk_vol = smu10_set_fine_grain_clk_vol,
> +       .gfx_state_change = smu10_gfx_state_change,
>  };
>
>  int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
