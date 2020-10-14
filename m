Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4137CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 19:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9327E206DC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc6fMElY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9327E206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16466EB47;
	Wed, 14 Oct 2020 19:59:31 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F7F6EB47
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 19:59:30 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id n18so481368wrs.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9iJNDrlHOazvZzCIV3ounVnjxRltoSWx6yhY2lXo42U=;
 b=Nc6fMElYoL5BEEwWa4F3fTknB3jtkpegi4/JrBRx79mROOpkdejwuG+LD8arHL6R7x
 jSsbEjTl7QzIeXHUG6cefmJORhUE5Oo2lhsSTyvfi0XcOnYiA8SbPVfFDA4acXxMZkf/
 T409vHtTLYv4fvKoXmxr1Teq/65OS1WKGj5+kIhIp6GwT1pR5oZ7LsRY8fjxdclaFiTf
 2IMVKxaf3MUefKoHkm7hPU9opfrepGoMJTTp0EVY1g8ouaJJuvU8taG0jpNzKVEARVWt
 GtlDkREwz092TsIZh54+fMThdbGwcz60/bPlbW5b5XaS2RKq/kR0nyu5sNHHL/ytTCMz
 9A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9iJNDrlHOazvZzCIV3ounVnjxRltoSWx6yhY2lXo42U=;
 b=SfTp6hRNZLQ9ei9Rs/+sF/AQTt7/nnzJdKahUYKhxLxoh4HKcwrL7iarhUJsVCCgyW
 BfQB4ZI8Wbam0JsC7BWSzm1+6Bq56/LNaVAjckCSBu0daFve2VmHo6OcNsOq4srIOoSA
 mtzbKvOV3503+09FxjfjSy9+gYsh3OC07wQtGaHG935DCK52EoL3rMZXDkD+p9BuiaGc
 vO6Wlhf0zfYAWdQAwu9MdPGVZCKtRV7+QBUvDAAECEECsJKnESqppjwqoDEONubR4t0m
 tOT5H57ULEBcrBskBnMf7nvrIUWSWrWPR2Y29C4Wop/AoO2g6Wc3jSpE5cuIPUjpCbFA
 d7iQ==
X-Gm-Message-State: AOAM531b0BqMQYWyS0WtZRFNGqdj4L1+iosNf2mVqeOpTV+iraQ45Kyg
 Z0uh8WxBX+yB7wc1C8dB2c5OiPxwGZKAlzdA4Zk=
X-Google-Smtp-Source: ABdhPJx5ae4zBhiK4H+fTAde97q5kmkdlTLMETpySUJ2Ag9V8Bi8xkfyDiqL3QZHNuytfODO5Qv2+Lq7+MaYIl26dZY=
X-Received: by 2002:a5d:6642:: with SMTP id f2mr445616wrw.374.1602705568993;
 Wed, 14 Oct 2020 12:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201014071812.8396-1-evan.quan@amd.com>
 <20201014071812.8396-5-evan.quan@amd.com>
In-Reply-To: <20201014071812.8396-5-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2020 15:59:17 -0400
Message-ID: <CADnq5_P-JVy7HzuUJL9X=ceBd51Z=qywGBPHsOdYFhRUOiUfUw@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd/pm: properly setting GPO feature on UMD
 pstate entering/exiting
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2020 at 3:18 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Disable/enable the GPO feature on UMD pstate entering/exiting.
>
> Change-Id: I4bd4b560b945227044df918c9066ffbbc17728ca
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
>  drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 ++
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
>  5 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f21d8dcac9ae..32f3738a6a6f 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -574,6 +574,7 @@ struct pptable_funcs {
>         int (*get_fan_parameters)(struct smu_context *smu);
>         int (*post_init)(struct smu_context *smu);
>         void (*interrupt_work)(struct smu_context *smu);
> +       int (*gpo_control)(struct smu_context *smu, bool enablement);
>  };
>
>  typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index b1a18fbb7682..f6403881f265 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -184,6 +184,7 @@
>         __SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
>         __SMU_DUMMY_MAP(PowerUpCvip),                    \
>         __SMU_DUMMY_MAP(PowerDownCvip),                  \
> +       __SMU_DUMMY_MAP(SetGpoFeaturePMask),             \
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 92869eb297d8..18e0db34a3ee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1407,6 +1407,7 @@ static int smu_enable_umd_pstate(void *handle,
>                 if (*level & profile_mode_mask) {
>                         smu_dpm_ctx->saved_dpm_level = smu_dpm_ctx->dpm_level;
>                         smu_dpm_ctx->enable_umd_pstate = true;
> +                       smu_gpo_control(smu, false);
>                         amdgpu_device_ip_set_powergating_state(smu->adev,
>                                                                AMD_IP_BLOCK_TYPE_GFX,
>                                                                AMD_PG_STATE_UNGATE);
> @@ -1432,6 +1433,7 @@ static int smu_enable_umd_pstate(void *handle,
>                         amdgpu_device_ip_set_powergating_state(smu->adev,
>                                                                AMD_IP_BLOCK_TYPE_GFX,
>                                                                AMD_PG_STATE_GATE);
> +                       smu_gpo_control(smu, true);
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index c27806fd07e0..71cb000306a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -127,6 +127,7 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
>         MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,                       0),
>         MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,                  0),
>         MSG_MAP(SetMGpuFanBoostLimitRpm,        PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
> +       MSG_MAP(SetGpoFeaturePMask,             PPSMC_MSG_SetGpoFeaturePMask,          0),
>  };
>
>  static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
> @@ -2714,6 +2715,26 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
>                                                NULL);
>  }
>
> +static int sienna_cichlid_gpo_control(struct smu_context *smu,
> +                                     bool enablement)
> +{
> +       int ret = 0;
> +
> +       if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFX_GPO_BIT)) {
> +               if (enablement)
> +                       ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                       SMU_MSG_SetGpoFeaturePMask,
> +                                                       GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
> +                                                       NULL);
> +               else
> +                       ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                       SMU_MSG_SetGpoFeaturePMask,
> +                                                       0,
> +                                                       NULL);
> +       }
> +
> +       return ret;
> +}
>  static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
>         .set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
> @@ -2795,6 +2816,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .deep_sleep_control = smu_v11_0_deep_sleep_control,
>         .get_fan_parameters = sienna_cichlid_get_fan_parameters,
>         .interrupt_work = smu_v11_0_interrupt_work,
> +       .gpo_control = sienna_cichlid_gpo_control,
>  };
>
>  void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index c7e1fe5f442d..f7be2d1a0ff2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -89,6 +89,7 @@
>  #define smu_deep_sleep_control(smu, enablement)                                smu_ppt_funcs(deep_sleep_control, 0, smu, enablement)
>  #define smu_get_fan_parameters(smu)                                    smu_ppt_funcs(get_fan_parameters, 0, smu)
>  #define smu_post_init(smu)                                             smu_ppt_funcs(post_init, 0, smu)
> +#define smu_gpo_control(smu, enablement)                               smu_ppt_funcs(gpo_control, 0, smu, enablement)
>
>  #endif
>  #endif
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
