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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2159C5519F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AD82078D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOPw2PN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AD82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38876E113;
	Thu, 12 Nov 2020 19:55:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F47A6E113
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:55:07 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id r17so7340937wrw.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 11:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uwv27WR/HKlsEgtnafOe7d4aznmQgFFA5xbywdCBbfc=;
 b=SOPw2PN0dzeYLYyLkE8mXSZ43+PjRKXw9jdSgiHaKoEudBv46vNzr+ud5vcI74c6Nb
 YEwQT6aUzMDBcbF9Mj7Zh2ns5JTLsPg3Cbu/Bd1Y71DRuUnbgx1VF14BHjiq7wmRhQ4p
 3OcC+IAOdVue67HyVSLq1kvweArC+PISL39rq2OU9/Qk9zXHbSAtzDZJ5lZBJm1X66Wm
 JyEu3phWEE8z5djUCKJoWbaurlixUqLqqkefJ6AXfj9+XjLAgR6UewJJMNjAStlXdDUt
 lFI1+hZV83Cetj9YDnpTigAkAnkMqNlloOrNLihODf+sCTnIZWA0tM+609Q1u2fFTh/N
 vMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uwv27WR/HKlsEgtnafOe7d4aznmQgFFA5xbywdCBbfc=;
 b=YWOoa5irtGDiAaLsUEF5LX97GKgJdevwc9eUtJqpw0gGAdQfpVSJvEAWxJsabovClb
 hetYWn+Vod6RoGSl+0/4ROb8wChbRNrRDJIkiaI6EKzsncgavGCVU5dosPJELZmD8x3J
 kqGtq9gvklgEsKqIiiUPR2L8Xta8gE96IYYtRpo5VDvhbmlCbl4K/pskyOSpixhg3gjn
 jRBKHuCyJzDoFHiT/5r8Y5wExmD7CgkRPJai1rk7jN1vxhBSJnnzgNs/cbLSadXZbxKq
 znlaIvbNI7sgICDDZU7m12pZnO3VxNC3Z2dfvG9hvdoYAdv0SFuSW2yBLh/R4Xx+BPmN
 xf5g==
X-Gm-Message-State: AOAM530bYMmBr1bcOamNqmul9nuplKaE4JdoCdhFbuKnc49JZxsLWx3Q
 t5d1k1Woga5Bf+YZGJaJJXk9GOpx41r9sMF0+5A=
X-Google-Smtp-Source: ABdhPJzSFHeS99pfl2SfHwQIQBFQQANkfpJIp9nA19hNgEMpqYyUl6jGOeBr/Whjeg2uitCcStkNe6r6mzRWa6na5lw=
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr1286714wru.397.1605210905756; 
 Thu, 12 Nov 2020 11:55:05 -0800 (PST)
MIME-Version: 1.0
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
 <1605164796-22215-5-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1605164796-22215-5-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2020 14:54:54 -0500
Message-ID: <CADnq5_PqsJf9hJjYoTzUzaFKT-MXvDOARH8dxHT74=GwCEdNEA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd/pm: add gfx_state_change_set() for rn gfx
 power switch
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
> The gfx_state_change_set() funtion can support set GFX power
> change status to D0/D3.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         |  3 +++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 10 ++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  7 +++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 380dd3a..60c0a6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -838,4 +838,7 @@ void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_sta
>
>         mutex_unlock(&adev->pm.mutex);
>
> +       if (is_support_sw_smu(adev))
> +               smu_gfx_state_change_set(&adev->smu, state);

maybe move this up with the powerplay code for consistency?

> +
>  }
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 9724d6f..ae8ff7b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -576,6 +576,7 @@ struct pptable_funcs {
>         int (*post_init)(struct smu_context *smu);
>         void (*interrupt_work)(struct smu_context *smu);
>         int (*gpo_control)(struct smu_context *smu, bool enablement);
> +       int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
>  };
>
>  typedef enum {
> @@ -764,6 +765,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
>  ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
>
>  int smu_enable_mgpu_fan_boost(struct smu_context *smu);
> +int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
>
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 3999079..35465a6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2529,3 +2529,13 @@ int smu_enable_mgpu_fan_boost(struct smu_context *smu)
>
>         return ret;
>  }
> +
> +int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +       int ret = 0;
> +

I think we need to lock the smu->mutex here?

Alex

> +       if (smu->ppt_funcs->gfx_state_change_set)
> +               ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
> +
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 66c1026..9423f36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1136,6 +1136,13 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
>         return sizeof(struct gpu_metrics_v2_0);
>  }
>
> +static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +
> +       return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
> +}
> +
>  static const struct pptable_funcs renoir_ppt_funcs = {
>         .set_power_state = NULL,
>         .print_clk_levels = renoir_print_clk_levels,
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
