Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2930C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 19:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A423A64EB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 19:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A423A64EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A756EA56;
	Wed, 10 Mar 2021 19:41:40 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55336EA56
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 19:41:38 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id x78so20449536oix.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XU1mPa0cf5DbNwb7yvv+rQdJ7HDcUZLmRtC2BrNrqNs=;
 b=J9MjwJLRoy/YJ3SJNFtEpnkB1VZKwEv7FoClixv2Y8vIM11YL5NMzjk1+86IfGqYJG
 m1txJ6ooBhLHfH67HwMDkFmvYd+SPEDO/I19Ip65BYaPmQhydil+89jnO9qq4mMh/NMM
 SsjWxaKOBPOVll64o1GlaThamy8f2KY6pyiWBC4h5K10elwWpChDTTpj8YM4GcPLXrny
 keTMjD+MwLUI0JgsuUlkWNscrXnrqKiA7qPR8ikC679dZmyGBVxz/vVLEm9sUodqrkfc
 Cg0arBfX5+T5nvZmun8AqOvyJE8ua6OftiNwFGzwOzMdl3WmkEJ6N7roUQ4vAtesBcsk
 cnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XU1mPa0cf5DbNwb7yvv+rQdJ7HDcUZLmRtC2BrNrqNs=;
 b=qc7dsks3Li6j/4rlrOw7uUrTASzKLDwM076gmM08I7aIPk6sYq/lxB0whxjz/bHbg2
 R0xB/v3axDb4HYy0OIejkv1AP+eKQwsz5i81qYeuEdhQSsl6xweAilJIojXzOjAcxWbQ
 YKh80n5HYru9OawD9GNRqMJp2xtnDj09mLTatM6g2nmMdlU7SDs5kJOhjfmhPJWoM+XI
 TJU10WnkH2htzM7B5CK2SxCaKnTV1souvC74XNHiLLpIBjkZ87jaGFPlLUHiovMgKqJS
 ilbfXuVVkq56O+T/nFJNxRmxcSk4w9YL37rlu5zF5ST73FD0DStSC4+lL0dG7a8BzFYR
 Jr3g==
X-Gm-Message-State: AOAM531KjlC4gW3dfS+YS+gBQ2xws6+xZ4HV/+tXIJhih+jeYH3jU+ka
 JZq8T6SEw9d+w/FElbf7u9Pwa09QnZPkXTlrVp4=
X-Google-Smtp-Source: ABdhPJxwdMd6p2GZoVeMTxnjU86noW/ZQbmYSVmj0QLE7fsFgdJQ0DwMgD/N6K9xrYlqirWM4fhkoNeb0LIYEiFBfG0=
X-Received: by 2002:aca:af10:: with SMTP id y16mr3572274oie.120.1615405297925; 
 Wed, 10 Mar 2021 11:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20210310175457.9754-1-shaoyun.liu@amd.com>
In-Reply-To: <20210310175457.9754-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Mar 2021 14:41:26 -0500
Message-ID: <CADnq5_OpsrHVTNExGoJKgeHRPtv2a=-TMB6QR72mYBXJNcZUOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: Add LightSBR SMU MSG support
To: shaoyunl <shaoyun.liu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 10, 2021 at 12:55 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> This new MSG provide the interface for driver to enable/disable the Light Secondary Bus Reset
> support from SMU. When enabled, SMU will only do minimum NBIO response to the SBR request and
> leave the real HW reset to be handled by driver later. When disabled (default state),SMU will
> pass the request to PSP for a HW reset
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: I5f0e48730d2b4b48fed8137aa57c683d5b3d1b9f
> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h           |  7 +++++++
>  drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h       |  7 +++++++
>  drivers/gpu/drm/amd/pm/inc/smu_types.h            |  1 +
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h            |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         | 12 ++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 10 ++++++++++
>  7 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 00186a3b29be..369f0267b1f2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1149,6 +1149,11 @@ struct pptable_funcs {
>          *                                      parameters to defaults.
>          */
>         int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
> +
> +       /**
> +        * @set_lightSBR: Set lightSBR mode for the SMU.
> +        */
> +       int (*set_lightSBR)(struct smu_context *smu, bool enable);

Please don't use CamelCase.  Call this set_light_sbr.  Same comments below.

Alex


>  };
>
>  typedef enum {
> @@ -1350,5 +1355,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
>  int smu_enable_mgpu_fan_boost(void *handle);
>  int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
>
> +int smu_set_lightSBR(struct smu_context *smu, bool enable);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> index 79afb132164e..45f5d29bc705 100644
> --- a/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h
> @@ -120,6 +120,13 @@
>  #define PPSMC_MSG_ReadSerialNumTop32            0x40
>  #define PPSMC_MSG_ReadSerialNumBottom32                 0x41
>
> +/* paramater for MSG_LightSBR
> + * 1 -- Enable light secondary bus reset, only do nbio respond without further handling,
> + *      leave driver to handle the real reset
> + * 0 -- Disable LightSBR, default behavior, SMU will pass the reset to PSP
> + */
> +#define PPSMC_MSG_LightSBR                      0x42
> +
>  typedef uint32_t PPSMC_Result;
>  typedef uint32_t PPSMC_Msg;
>  #pragma pack(pop)
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index aa4822202587..92f72d770a99 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -214,6 +214,7 @@
>         __SMU_DUMMY_MAP(SetSlowPPTLimit),                \
>         __SMU_DUMMY_MAP(GetFastPPTLimit),                \
>         __SMU_DUMMY_MAP(GetSlowPPTLimit),                \
> +       __SMU_DUMMY_MAP(LightSBR),                       \
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index bf570a7af6a7..7c7b149e7a83 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -295,5 +295,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>
>  void smu_v11_0_interrupt_work(struct smu_context *smu);
>
> +int smu_v11_0_set_lightSBR(struct smu_context *smu, bool enable);
> +
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 502e1b926a06..58f508c36084 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2934,6 +2934,18 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
>         return ret;
>  }
>
> +int smu_set_lightSBR(struct smu_context *smu, bool enable)
> +{
> +       int ret = 0;
> +
> +       mutex_lock(&smu->mutex);
> +       ret = smu->ppt_funcs->set_lightSBR(smu, enable);
> +       mutex_unlock(&smu->mutex);
> +
> +       return ret;
> +}
> +
> +
>  static const struct amd_pm_funcs swsmu_pm_funcs = {
>         /* export for sysfs */
>         .set_fan_control_mode    = smu_pp_set_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index f76d1b8aeecc..73a30208aa71 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -142,6 +142,7 @@ static const struct cmn2asic_msg_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
>         MSG_MAP(GmiPwrDnControl,                     PPSMC_MSG_GmiPwrDnControl,                 0),
>         MSG_MAP(ReadSerialNumTop32,                  PPSMC_MSG_ReadSerialNumTop32,              1),
>         MSG_MAP(ReadSerialNumBottom32,               PPSMC_MSG_ReadSerialNumBottom32,           1),
> +       MSG_MAP(LightSBR,                            PPSMC_MSG_LightSBR,                        0),
>  };
>
>  static const struct cmn2asic_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
> @@ -2363,6 +2364,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = arcturus_get_fan_parameters,
>         .interrupt_work = smu_v11_0_interrupt_work,
> +       .set_lightSBR = smu_v11_0_set_lightSBR,
>  };
>
>  void arcturus_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 1882a0643f7a..29aef6eeb55b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1601,6 +1601,16 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
>         return ret;
>  }
>
> +int smu_v11_0_set_lightSBR(struct smu_context *smu, bool enable)
> +{
> +       int ret = 0;
> +
> +       ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LightSBR, enable ? 1 : 0, NULL);
> +
> +       return ret;
> +}
> +
> +
>  int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
>                                                  uint32_t *min, uint32_t *max)
>  {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
