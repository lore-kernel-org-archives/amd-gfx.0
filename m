Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB17C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE7E206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtD0Z7HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE7E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6056E5C1;
	Thu,  4 Jun 2020 20:50:31 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4926E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 20:50:30 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id l11so7599829wru.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 13:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zwB/26mXAk8XGnvGpr7hwTCJMEcWrWhf2twVW3WzGSo=;
 b=KtD0Z7HNZv0pf252o72eZR2+3uwRvNoJNR2f+W4+IEX1xPZ7WziiMh0nFpp8yrczhD
 ZJtDsj8dnGrtaiCWxcY4TFlpB5blTrvvwNLb8lmF08Z6SR1FjqKhPAllNarZelbF89yg
 EpjqwiI/oIHzurhsVLP9/gx4ZovMhLge6UagshEyGuRk+K2d8ooNGqr81uuOIUZsmgpU
 xYPDX6zrqKMNrenKKwhkMBnMWhEpmmAFObl3tvxMiXMSR568sFVn0zBENkmAw9fmsMZS
 c+ik6jKV8BWjC+U66aBsqLomf7IpGS00/8n/s2y/s97stdRejIq56XRjLw5bqpf+R94C
 6+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zwB/26mXAk8XGnvGpr7hwTCJMEcWrWhf2twVW3WzGSo=;
 b=IlMSQchC8LEBlzNUGDG3dNBrUBpIjGHRnPiw24k0eN5LihJ/b4B/OP3GrP+QffAd+N
 CFsQfUdq0HUzgL7lTyjxIuvFUr4a+MgBRRYve2ohbGB/QIUL5G+0ryFy/UYCwXN2gzgK
 FXhm8iKw7LgoxKm5j84fhaHv6ACVJAodibh3x2W/e1kcXqHMedF21rOGVtnAyT+4gIiU
 GaavgRGKhq21Vvr8t8uht831S7au28w8+BS6HaYUli4xPswYSdBqDyQdKSRTms9VD8JC
 xtXzYBa1KUb4CNDrluCwKnmCbGUf70Vye+BUIANeMtfjtY+bz2vvnuKCn82V7sF/sd4s
 uMUw==
X-Gm-Message-State: AOAM532ZNeqSPD5gCV9WQz8oSBjUQSfpv8mFYbvdC076Z/CF6KmQEVF2
 6WahbNk7UFZRb3SMwYjdNB/7r++npfKvXJ/pY1VysTrx
X-Google-Smtp-Source: ABdhPJyX+mO2e/qMTR46jh6wAOaoEFkVnpAvP5Fsq9YRzjFdqdfS8u7maMgGjE5/Dn4+AXWY8SmP1RT8aDl94eyMUSo=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr6026839wrq.362.1591303828541; 
 Thu, 04 Jun 2020 13:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-2-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 16:50:15 -0400
Message-ID: <CADnq5_MJpQT2B9oXUuaVKCh4ZfNKMwhCD+AEe5PoTjJV33G=3w@mail.gmail.com>
Subject: Re: [PATCH 02/16] drm/amd/powerplay: drop unused APIs and unnecessary
 checks
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

On Thu, Jun 4, 2020 at 12:46 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Minor code cleanups.
>
> Change-Id: I6d240241e78cae17288c1d49dbae6ab1796b1128
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 74 ++++---------------
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
>  2 files changed, 16 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b2c1ad95edf7..bd0fe71dffde 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -720,30 +720,6 @@ int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mask mask
>         return ret;
>  }
>
> -int smu_feature_set_supported(struct smu_context *smu,
> -                             enum smu_feature_mask mask,
> -                             bool enable)
> -{
> -       struct smu_feature *feature = &smu->smu_feature;
> -       int feature_id;
> -       int ret = 0;
> -
> -       feature_id = smu_feature_get_index(smu, mask);
> -       if (feature_id < 0)
> -               return -EINVAL;
> -
> -       WARN_ON(feature_id > feature->feature_num);
> -
> -       mutex_lock(&feature->mutex);
> -       if (enable)
> -               test_and_set_bit(feature_id, feature->supported);
> -       else
> -               test_and_clear_bit(feature_id, feature->supported);
> -       mutex_unlock(&feature->mutex);
> -
> -       return ret;
> -}
> -
>  static int smu_set_funcs(struct amdgpu_device *adev)
>  {
>         struct smu_context *smu = &adev->smu;
> @@ -823,22 +799,10 @@ int smu_get_atom_data_table(struct smu_context *smu, uint32_t table,
>         return 0;
>  }
>
> -static int smu_initialize_pptable(struct smu_context *smu)
> -{
> -       /* TODO */
> -       return 0;
> -}
> -
>  static int smu_smc_table_sw_init(struct smu_context *smu)
>  {
>         int ret;
>
> -       ret = smu_initialize_pptable(smu);
> -       if (ret) {
> -               pr_err("Failed to init smu_initialize_pptable!\n");
> -               return ret;
> -       }
> -
>         /**
>          * Create smu_table structure, and init smc tables such as
>          * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
> @@ -1137,19 +1101,16 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 return ret;
>         }
>
> -       if (smu->ppt_funcs->set_power_source) {
> -               /*
> -                * For Navi1X, manually switch it to AC mode as PMFW
> -                * may boot it with DC mode.
> -                */
> -               if (adev->pm.ac_power)
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
> -               else
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
> -               if (ret) {
> -                       pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> -                       return ret;
> -               }
> +       /*
> +        * For Navi1X, manually switch it to AC mode as PMFW
> +        * may boot it with DC mode.
> +        */
> +       ret = smu_set_power_source(smu,
> +                                  adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> +                                  SMU_POWER_SOURCE_DC);
> +       if (ret) {
> +               pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
> +               return ret;
>         }
>
>         ret = smu_notify_display_change(smu);
> @@ -2138,15 +2099,12 @@ int smu_set_ac_dc(struct smu_context *smu)
>                 return 0;
>
>         mutex_lock(&smu->mutex);
> -       if (smu->ppt_funcs->set_power_source) {
> -               if (smu->adev->pm.ac_power)
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
> -               else
> -                       ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
> -               if (ret)
> -                       pr_err("Failed to switch to %s mode!\n",
> -                              smu->adev->pm.ac_power ? "AC" : "DC");
> -       }
> +       ret = smu_set_power_source(smu,
> +                                  smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
> +                                  SMU_POWER_SOURCE_DC);
> +       if (ret)
> +               pr_err("Failed to switch to %s mode!\n",
> +                      smu->adev->pm.ac_power ? "AC" : "DC");
>         mutex_unlock(&smu->mutex);
>
>         return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 13fc5773ba45..210432187ceb 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -670,8 +670,6 @@ extern int smu_feature_set_enabled(struct smu_context *smu,
>                                    enum smu_feature_mask mask, bool enable);
>  extern int smu_feature_is_supported(struct smu_context *smu,
>                                     enum smu_feature_mask mask);
> -extern int smu_feature_set_supported(struct smu_context *smu,
> -                                    enum smu_feature_mask mask, bool enable);
>
>  int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
>                      void *table_data, bool drv2smu);
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
