Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35665C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 20:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049332078D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7pWbkTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049332078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B5189CDE;
	Mon,  8 Jun 2020 20:13:46 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1FE89CDE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 20:13:45 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q25so896067wmj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2020 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UHfQ7QdCNMGurTHQ9HtwTN07paYV9zB3N9DDHwaWGFI=;
 b=j7pWbkTrufS4nx072K1N+7OPAzcJW9caAEjR7eZGTVULEkyBfOFxwZfOWGT/E3cSc4
 dJ6kAxkhiZyXEDk6eC5f1AsSezwU3QNJZJbppkC6zcQYGqhXmvE8hF+st8eApszUpaRV
 t6ggYZAK53mIGX+GLrPGycML9WpIWhmoqQ7j5xqDF+LZJNtQWKKvW5LvYv5wr7fNRgwD
 JU8hxXv1BBj2XseEoV9+8cJTK0Qwp9XmN8FeRlvhJenSLmMachm3Ooxma5Tl8j2dTLmt
 2eiCIfXq3qH1Hpl7tPUSl+oCtt2Phf9fUbqu8CpBSHOV3Ni9ShvYhf/queVcI6FejzXq
 Ah1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UHfQ7QdCNMGurTHQ9HtwTN07paYV9zB3N9DDHwaWGFI=;
 b=tnwVNE1Lx+Ym8KlhDHMTim83xgTZc3faE7WpcLd2lPwymZ3mMRhOMNmpbRnGCwKsLE
 yGa2UEwxm+ieoiLB2xFqPAOFhY67VQ5aFlI4oa7Qk/4vod/kfIy/4MYBpHkmV9i+03KR
 wG2qg42YRlgDUrZAm80v7LNHG0lIXHl5bGa9JHGOSkyTy8gnW1hsdUg1hcqDHQUHW2UW
 ZJ5ZmmHhXnzU1UHxIdw3yuQiU01i2IMFUWGuT59RGT8vN97FKdMExc1ni6/cm+AuRaqC
 DbrPD/Or6gBa/meyNQqR0qqvSiYENIHT9VaPejVOMr8fP0/+yR6rUIzyNEZNH0Szxpmx
 V1ew==
X-Gm-Message-State: AOAM532GZzi4+5TuyRuEk1HJEw2ma1r0jTeVkBYtiknZiSrsVYpFBST/
 y11+dcg8tsJnfyNMPG4f73RFDoA3OojhVH+QZbI=
X-Google-Smtp-Source: ABdhPJykW/sx79oAlOV/2iMVe8UfBUsew9YB4StyWqlajdYUMYay/wGr5LQM58Z53Yzjg4rEFJwZpacd6/UaJnrP28c=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr391854wml.70.1591647224456; 
 Mon, 08 Jun 2020 13:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200605110411.27302-1-evan.quan@amd.com>
 <20200605110411.27302-3-evan.quan@amd.com>
In-Reply-To: <20200605110411.27302-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jun 2020 16:13:33 -0400
Message-ID: <CADnq5_NWE9nJAgxNOJhaqB3MtJDq6Gts4u9CaTYrjCNjjgESyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: correct the APIs' naming
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 5, 2020 at 7:04 AM Evan Quan <evan.quan@amd.com> wrote:
>
> 'UVD' is a HW engine name for Vega20 and before ASICs.
> For newer ASICs, the similar engine is named as 'VCN'.
>
> Change-Id: I5f1b9500ed5d35e395a5da32b81a78eb87bffc68
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 13 +++++++++----
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  4 ++--
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  2 +-
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  4 ++--
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  4 ++--
>  drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |  4 ++--
>  drivers/gpu/drm/amd/powerplay/smu_internal.h       |  4 ++--
>  7 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8ea100b3187b..b84eabfc1976 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -455,10 +455,15 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>                 return -EOPNOTSUPP;
>
>         switch (block_type) {
> +       /*
> +        * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> +        * AMD_IP_BLOCK_TYPE_UVD for VCN. So, here both of them are kept.
> +        */
>         case AMD_IP_BLOCK_TYPE_UVD:
> -               ret = smu_dpm_set_uvd_enable(smu, !gate);
> +       case AMD_IP_BLOCK_TYPE_VCN:
> +               ret = smu_dpm_set_vcn_enable(smu, !gate);
>                 if (ret)
> -                       dev_err(smu->adev->dev, "Failed to power %s UVD!\n",
> +                       dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>                                 gate ? "gate" : "ungate");
>                 break;
>         case AMD_IP_BLOCK_TYPE_GFX:
> @@ -1328,7 +1333,7 @@ static int smu_hw_init(void *handle)
>
>         if (smu->is_apu) {
>                 smu_powergate_sdma(&adev->smu, false);
> -               smu_dpm_set_uvd_enable(smu, true);
> +               smu_dpm_set_vcn_enable(smu, true);
>                 smu_dpm_set_jpeg_enable(smu, true);
>                 smu_set_gfx_cgpg(&adev->smu, true);
>         }
> @@ -1460,7 +1465,7 @@ static int smu_hw_fini(void *handle)
>
>         if (smu->is_apu) {
>                 smu_powergate_sdma(&adev->smu, true);
> -               smu_dpm_set_uvd_enable(smu, false);
> +               smu_dpm_set_vcn_enable(smu, false);
>                 smu_dpm_set_jpeg_enable(smu, false);
>         }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index b47b5f257671..e5ef279955d9 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2116,7 +2116,7 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
>         return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>
> -static int arcturus_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
> +static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -2557,7 +2557,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .dump_pptable = arcturus_dump_pptable,
>         .get_power_limit = arcturus_get_power_limit,
>         .is_dpm_running = arcturus_is_dpm_running,
> -       .dpm_set_uvd_enable = arcturus_dpm_set_uvd_enable,
> +       .dpm_set_vcn_enable = arcturus_dpm_set_vcn_enable,
>         .i2c_eeprom_init = arcturus_i2c_eeprom_control_init,
>         .i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
>         .get_unique_id = arcturus_get_unique_id,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 6f31485245bb..b731f9ab05fc 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -453,7 +453,7 @@ struct pptable_funcs {
>                                               *clocks);
>         int (*get_power_profile_mode)(struct smu_context *smu, char *buf);
>         int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
> -       int (*dpm_set_uvd_enable)(struct smu_context *smu, bool enable);
> +       int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
>         int (*dpm_set_jpeg_enable)(struct smu_context *smu, bool enable);
>         int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors sensor,
>                            void *data, uint32_t *size);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 70d93a0fd3d0..f21abda8c182 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -727,7 +727,7 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
>         return 0;
>  }
>
> -static int navi10_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
> +static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -2369,7 +2369,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .get_workload_type = navi10_get_workload_type,
>         .get_allowed_feature_mask = navi10_get_allowed_feature_mask,
>         .set_default_dpm_table = navi10_set_default_dpm_table,
> -       .dpm_set_uvd_enable = navi10_dpm_set_uvd_enable,
> +       .dpm_set_vcn_enable = navi10_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = navi10_dpm_set_jpeg_enable,
>         .get_current_clk_freq_by_table = navi10_get_current_clk_freq_by_table,
>         .print_clk_levels = navi10_print_clk_levels,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 7a4e1bd9bafd..6b5e60b4c039 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -349,7 +349,7 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
>         return pm_type;
>  }
>
> -static int renoir_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
> +static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -929,7 +929,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .get_dpm_clk_limited = renoir_get_dpm_clk_limited,
>         .print_clk_levels = renoir_print_clk_levels,
>         .get_current_power_state = renoir_get_current_power_state,
> -       .dpm_set_uvd_enable = renoir_dpm_set_uvd_enable,
> +       .dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
>         .get_current_clk_freq_by_table = renoir_get_current_clk_freq_by_table,
>         .force_dpm_limit_value = renoir_force_dpm_limit_value,
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 4be244787fad..a1a91ca85326 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -720,7 +720,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
>         return 0;
>  }
>
> -static int sienna_cichlid_dpm_set_uvd_enable(struct smu_context *smu, bool enable)
> +static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -2542,7 +2542,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .get_workload_type = sienna_cichlid_get_workload_type,
>         .get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
>         .set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
> -       .dpm_set_uvd_enable = sienna_cichlid_dpm_set_uvd_enable,
> +       .dpm_set_vcn_enable = sienna_cichlid_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
>         .get_current_clk_freq_by_table = sienna_cichlid_get_current_clk_freq_by_table,
>         .print_clk_levels = sienna_cichlid_print_clk_levels,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index f9041f981daf..8ffc68ee43fe 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -157,8 +157,8 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
>  #define smu_get_current_shallow_sleep_clocks(smu, clocks) \
>         ((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_funcs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
>
> -#define smu_dpm_set_uvd_enable(smu, enable) \
> -       ((smu)->ppt_funcs->dpm_set_uvd_enable ? (smu)->ppt_funcs->dpm_set_uvd_enable((smu), (enable)) : 0)
> +#define smu_dpm_set_vcn_enable(smu, enable) \
> +       ((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_vcn_enable((smu), (enable)) : 0)
>  #define smu_dpm_set_jpeg_enable(smu, enable) \
>         ((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
