Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9833C43467
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 18:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6158B21527
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpXkE8j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6158B21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABAEE6EE75;
	Fri, 16 Oct 2020 18:10:40 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F60E6EE75
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 18:10:39 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d3so3884558wma.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbdIoNlv18KrWIM8MX74Eu826s9TZWX6ZSG6ZC9rJ8Q=;
 b=lpXkE8j1KrUOjAFnFtVh735kRZO7dI0LD+0swTD4nzX7KmeFMLez5FVazruTaeZPm5
 pyTbhirteKXqXO7UDIQtJxfFeRKGIht92CXoI6rM+/Txs3T8v2ahBZMDjwCJJfINWhCz
 OmquPbEv0IDytuKjwVgJC1ZZJu+/aWj5xCCQ9dx+XL1CqJ0QX/kNUw6gJDY5GAtgtT51
 2zNDkwb6qa0TAMBKDnSfyOupakkpT90kNioPzzLk+9lGBT3bqx4aqarAtAKQcaC/028t
 /pYV8EV+D28abuWpIzopFTM0qkS3b6omF9I3SobGzxAtrqCfC0+n2xSwSFxWcL6dPYL5
 0iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbdIoNlv18KrWIM8MX74Eu826s9TZWX6ZSG6ZC9rJ8Q=;
 b=CsxtbIAzUaRCgcsUv/OxS8LfgBIq1kj8O56A5bb7/V3Pt365TvrgOhrXrT98XJLGNj
 4iT9jyKxiRH3y2fKU/OzoKSVyAsAZ16T1DLhAyy6hwy38BDm2OAsDi1E32gpw15yHeBg
 LLNBpA+dwl8UQtm26gWKsOOok09JvUx9tXncowWpFWdzuwSqzYM2Hmsq8KTjaRiRUE8c
 +yUJIv6Cfn7TkcnS6L6ehBLQ/tTNJigIhz2SWqOalzeJFYQRs8UJ1v+fN4P4kto4Lcus
 66xB3bJaILf9WfubE/fF8h6jDkVBTWSE0+PAMrbJ0zNw2FeXUMQx4by7u4g96iEqVWvm
 T/eQ==
X-Gm-Message-State: AOAM5317nrMFaKvtVYbDK2ZrBgbuINGRYKpc5CKkrPdHyObNC3LQ1o+t
 kXADcZ6oFjiiQZB6FqNa1mfejTbSGvTpXYqGuS0=
X-Google-Smtp-Source: ABdhPJyO6ybvlfz66GpY4z5VdhNYLqgXbRjQkLSXa2hTJXN44oVcqTP9KD7QvDB2fqQDjk2tar66N4l2Uv5mjXhTrPE=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr4982155wma.70.1602871837889; 
 Fri, 16 Oct 2020 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <1602840103-21053-1-git-send-email-Prike.Liang@amd.com>
 <1602840103-21053-2-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1602840103-21053-2-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2020 14:10:26 -0400
Message-ID: <CADnq5_Pqa_60zia9ZFK=crMTQsTZvVe9iBAh4neFAk4VBr_Ggw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
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

On Fri, Oct 16, 2020 at 5:21 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> The new amdgpu_gfx_state_change_set() funtion can support set GFX power
> change status to D0/D3.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I presume we'll need something similar for renoir?  That can be a
follow up patch.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c           | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h           |  7 +++++++
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c     | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 +++++++++
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h         |  1 +
>  drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h      |  3 ++-
>  7 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d612033..e1d6c8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -789,3 +789,23 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>  failed_kiq_write:
>         pr_err("failed to write reg:%x\n", reg);
>  }
> +
> +/* amdgpu_gfx_state_change_set - Handle gfx power state change set
> + * @adev: amdgpu_device pointer
> + * @state: gfx power state(1 -eGpuChangeState_D0Entry and 2 -eGpuChangeState_D3Entry)
> + *
> + */
> +
> +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
> +{
> +
> +       mutex_lock(&adev->pm.mutex);
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
> index d43c116..73942b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -47,6 +47,12 @@ enum gfx_pipe_priority {
>         AMDGPU_GFX_PIPE_PRIO_MAX
>  };
>
> +/* Argument for PPSMC_MSG_GpuChangeState */
> +enum gfx_change_state {
> +       GpuChangeState_D0Entry = 1,
> +       GpuChangeState_D3Entry,
> +};
> +
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>
> @@ -387,4 +393,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>                                   struct amdgpu_iv_entry *entry);
>  uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>  void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
>  #endif
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index a7f92d0..e7b69dd 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -284,6 +284,7 @@ struct amd_pm_funcs {
>         int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input, uint32_t size);
>         int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
>         int (*smu_i2c_bus_access)(void *handle, bool acquire);
> +       int (*gfx_state_change_set)(void *handle, uint32_t state);
>  /* export to DC */
>         u32 (*get_sclk)(void *handle, bool low);
>         u32 (*get_mclk)(void *handle, bool low);
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index 7e6dcdf..4f319be 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -1321,6 +1321,25 @@ static int pp_set_powergating_by_smu(void *handle,
>         return ret;
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
> +
> +       return 0;
> +}
> +
>  static int pp_notify_smu_enable_pwe(void *handle)
>  {
>         struct pp_hwmgr *hwmgr = handle;
> @@ -1625,6 +1644,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
>         .switch_power_profile = pp_dpm_switch_power_profile,
>         .set_clockgating_by_smu = pp_set_clockgating_by_smu,
>         .set_powergating_by_smu = pp_set_powergating_by_smu,
> +       .gfx_state_change_set = pp_gfx_state_change_set,
>         .get_power_profile_mode = pp_get_power_profile_mode,
>         .set_power_profile_mode = pp_set_power_profile_mode,
>         .odn_edit_dpm_table = pp_odn_edit_dpm_table,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index c9cfe90..3f354da 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -319,6 +319,14 @@ static bool smu10_is_gfx_on(struct pp_hwmgr *hwmgr)
>         return false;
>  }
>
> +static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
> +{
> +       struct amdgpu_device *adev = hwmgr->adev;
> +       smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
> +
> +       return 0;
> +}
> +
>  static int smu10_disable_gfx_off(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev = hwmgr->adev;
> @@ -1394,6 +1402,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
>         .get_power_profile_mode = smu10_get_power_profile_mode,
>         .set_power_profile_mode = smu10_set_power_profile_mode,
>         .asic_reset = smu10_asic_reset,
> +       .gfx_state_change = smu10_gfx_state_change,
>  };
>
>  int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> index 15ed6cb..2c9580b 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -359,6 +359,7 @@ struct pp_hwmgr_func {
>         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
>         int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
>                                         bool disable);
> +       int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
>  };
>
>  struct pp_table_func {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> index df4677d..4c7e08b 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h
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
