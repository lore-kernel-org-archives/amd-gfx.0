Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FC5C4742C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD87206D9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ7GvHYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD87206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6686E3C6;
	Fri, 13 Nov 2020 06:58:56 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923636E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:58:54 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d142so7146890wmd.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 22:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GI4gYUEpNBNzu1RshxDcy92zgzF7IaeVv68jb2PLM+Y=;
 b=LZ7GvHYgrfbKdt3JbHRBAIofOhcgir4yD0Fs3I0ncrJ4rZF1GtUedg6CIaj0/SLczL
 NI5LSmz5REiiPu3iEkOfr4eXRBxTWJOjQf+REmnvGgDyGyalpwEBfT3dcTBr403y1GEX
 m7SgttRBnnDAOnK41Prdwf2I4QZ+PxFNGl4X6cE2uJq0qbPxQrXdFDIfXmXIe+zV3Q0+
 bfQN9BHn2l31Ij7fxOV6g3j15+juRpNhDqutFL5gjypjdRknc3oYjwHtJ7ftXg4xlphN
 lijbZJBfDAjA6UvK3MaDByA0ezM0eWaYEXgs8AgiO2I6jBDeI6Fe9EAcdFNvpfnA8NwY
 Jb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GI4gYUEpNBNzu1RshxDcy92zgzF7IaeVv68jb2PLM+Y=;
 b=Dm5GwdU6QPDkpUV9P9w5oSxLU0Vuhf51VhQhRhcA1dAE9hUa3NbAA9s3Df/qch5Eeu
 0+nkFSXvQdByPHWA3c3OylJVgbekyCzK20+fhg0VQfu/0vTmhpJ76zFvf8xb0cA0sWG9
 XqMG1RVD9G4PWJMxIEDHPqQcFVl2jAh93nbMuUjqjWdxVu5wmNW459fzlZ3Xum3R2b0l
 wjv/eZB2EimPxwODuJauO2NzVQlocGmHaUdLqYfVdZNXRVrTZM2UU4GBZFzMgaXXHoYJ
 gETL2R4V997Pvq++8ifpMOJlWLFz7QWM5ImKxROefXDGxEhLv0ReZRBJl1VVoZB7q3jb
 qZXA==
X-Gm-Message-State: AOAM532JekdcPw/BWtadEwhyL6faaA3f1BBesW2JZgiL2WP6i4wa7M1R
 pjqPX7JsBdINEERKS55Z8foiRstj+onBYwlwmR4=
X-Google-Smtp-Source: ABdhPJx6J+N8uYmaNZSPQN8+aLMzivIS2J4HaeHwFvJA4/6cmIKkhzEqnx48tIljHouOUxmFd1RbUqvXTeO+LUH6Se8=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr949363wmd.73.1605250733257; 
 Thu, 12 Nov 2020 22:58:53 -0800 (PST)
MIME-Version: 1.0
References: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
 <1605250397-15043-4-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1605250397-15043-4-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 01:58:42 -0500
Message-ID: <CADnq5_N-R5k+7iGaPamxGQWpnCcOMCdoJ-H1E3xRxMS27zKvBw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/pm: add gfx_state_change_set() for rn gfx
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

On Fri, Nov 13, 2020 at 1:53 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> The gfx_state_change_set() funtion can support set GFX power
> change status to D0/D3.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 18 +++++++++---------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 12 ++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  7 +++++++
>  4 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 380dd3a..cd2c676 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -828,14 +828,14 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>
>  void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
>  {
> -
> -       mutex_lock(&adev->pm.mutex);
> -
> -       if (adev->powerplay.pp_funcs &&
> -           adev->powerplay.pp_funcs->gfx_state_change_set)
> +       if (is_support_sw_smu(adev)) {
> +               smu_gfx_state_change_set(&adev->smu, state);
> +       } else {
> +               mutex_lock(&adev->pm.mutex);
> +               if (adev->powerplay.pp_funcs &&
> +                   adev->powerplay.pp_funcs->gfx_state_change_set)
>                         ((adev)->powerplay.pp_funcs->gfx_state_change_set(
> -                                       (adev)->powerplay.pp_handle, state));
> -
> -       mutex_unlock(&adev->pm.mutex);
> -
> +                               (adev)->powerplay.pp_handle, state));
> +               mutex_unlock(&adev->pm.mutex);
> +       }
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
> index 3999079..7b698c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2529,3 +2529,15 @@ int smu_enable_mgpu_fan_boost(struct smu_context *smu)
>
>         return ret;
>  }
> +
> +int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +       int ret = 0;
> +
> +       mutex_lock(&smu->mutex);
> +       if (smu->ppt_funcs->gfx_state_change_set)
> +               ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
> +       mutex_unlock(&smu->mutex);
> +
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 66c1026..46c44f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1136,6 +1136,12 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
>         return sizeof(struct gpu_metrics_v2_0);
>  }
>
> +static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +
> +       return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
> +}
> +
>  static const struct pptable_funcs renoir_ppt_funcs = {
>         .set_power_state = NULL,
>         .print_clk_levels = renoir_print_clk_levels,
> @@ -1171,6 +1177,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>         .set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>         .get_gpu_metrics = renoir_get_gpu_metrics,
> +       .gfx_state_change_set = renoir_gfx_state_change_set,
>  };
>
>  void renoir_set_ppt_funcs(struct smu_context *smu)
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
