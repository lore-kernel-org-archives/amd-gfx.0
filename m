Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906CDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F19206D5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STSFZNQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F19206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD2F6E0CA;
	Tue,  9 Jun 2020 19:54:33 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA2326E0CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 19:54:32 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id c71so3948899wmd.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2020 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QI5pqd2qXI3HQcgnPU+qwZms/tmWVCy+Q/QpBBpROvw=;
 b=STSFZNQOuvOKWOGp1K6NGdUim6hX2oKTRKkOpOqwvrTZKznSwKyVxt1U+VRPTkmPlL
 ok2Xu20zsnFEI10sKPkEgEMUaYmJ/Ei4ELolf0Ag3UOmNJacdpwU1VixzPP1bWMonmrL
 Hv7Cu1o6gsqoIK3jh+GEdYGE1etdQbLODueSUfEkmCpyGjxsnrVacvuqAkbzUoYj4dCf
 QETM+KbazGRTCJHFIaqJozb8RcTnl3G3j4z/hW7uLIRRe0WKOdk6wsUpTUTtvvgdJH4e
 xebHL7RlR4p7HtNPdC7GcwWthZsyLvI0/4oezkQef4OH2ZSBHPkQzsXHyGtKs5e+5/tf
 FYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QI5pqd2qXI3HQcgnPU+qwZms/tmWVCy+Q/QpBBpROvw=;
 b=F3/6bu+/Jh/zMYkmKk8eDwACusr/CLCI4JwGWXDTpK1YH5SjbGojfTyd30Q5b9um2S
 jpDrJXGANlgS2HgLFiPFk8nDGnzTYs5WVC9lhrxA3mpDsylLPqJOLlsbuwRbGaKAWe8G
 MJrzWJ+/c38M8RQo6PSOH7dBVS7tv7YO/Omc12uvvtXr8VHFkKW0pZiXqDOGLU6N1CX4
 5V8lF23xX0JRH/CtyyLEkWs6uIuBaf/kfJTgBvAqr/N1o+cCdOUUW8cQxP4UqOoTkGuI
 wOLm3I38zimtkhobrc8CUyEA/GJXdM496+PtQXfgF3MZ5wbjQVRCf/v3fLYnThBpdL6O
 OD0Q==
X-Gm-Message-State: AOAM533DB/anTbo+/t9KS/jv0gvpp3tjYBQGhJommcnQZnXc9S5iwTSD
 9xdcoz+OTeEqu1z2aPjHwdHncyHz+29uqdPrN9PJ5b/U
X-Google-Smtp-Source: ABdhPJwNtmtFUYkzCk9hyL/Ajw2vjcgHVgiIB74Humt9ez7JS8lBVln7ki7RKLUq1BET1RM01IMOkEws4fUJtkQl1jI=
X-Received: by 2002:a1c:6006:: with SMTP id u6mr5563688wmb.39.1591732471346;
 Tue, 09 Jun 2020 12:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200609102017.12478-1-evan.quan@amd.com>
 <20200609102017.12478-2-evan.quan@amd.com>
In-Reply-To: <20200609102017.12478-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 15:54:20 -0400
Message-ID: <CADnq5_Onr8VZtrxBsP_Z2sgYqqGTYMtO9BqL-6R9_NaEBpNj1A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/powerplay: revise the calling chain on sensor
 reading
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

On Tue, Jun 9, 2020 at 6:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Update the calling chain from "amdgpu_smu.c -> ${asic}_ppt.c ->
> smu_v11/12_0.c -> amdgpu_smu.c (smu_common_read_sensor())" to "
> "amdgpu_smu.c -> ${asic}_ppt.c -> smu_v11/12_0.c". This can help
> to maintain clear code layers. More similar changes will be coming.
>
> Change-Id: I95beba6c117b0cd3b0acea6158bf62240c6eac5a
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 81 ++++++++-----------
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  2 +-
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  2 +-
>  4 files changed, 35 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 78263de02678..c032680c52b0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -506,52 +506,6 @@ int smu_get_power_num_states(struct smu_context *smu,
>         return 0;
>  }
>
> -int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors sensor,
> -                          void *data, uint32_t *size)
> -{
> -       struct smu_power_context *smu_power = &smu->smu_power;
> -       struct smu_power_gate *power_gate = &smu_power->power_gate;
> -       int ret = 0;
> -
> -       if(!data || !size)
> -               return -EINVAL;
> -
> -       switch (sensor) {
> -       case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
> -               *((uint32_t *)data) = smu->pstate_sclk;
> -               *size = 4;
> -               break;
> -       case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
> -               *((uint32_t *)data) = smu->pstate_mclk;
> -               *size = 4;
> -               break;
> -       case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
> -               ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
> -               *size = 8;
> -               break;
> -       case AMDGPU_PP_SENSOR_UVD_POWER:
> -               *(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
> -               *size = 4;
> -               break;
> -       case AMDGPU_PP_SENSOR_VCE_POWER:
> -               *(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_VCE_BIT) ? 1 : 0;
> -               *size = 4;
> -               break;
> -       case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
> -               *(uint32_t *)data = power_gate->vcn_gated ? 0 : 1;
> -               *size = 4;
> -               break;
> -       default:
> -               ret = -EINVAL;
> -               break;
> -       }
> -
> -       if (ret)
> -               *size = 0;
> -
> -       return ret;
> -}
> -
>  int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
>                      void *table_data, bool drv2smu)
>  {
> @@ -2338,10 +2292,41 @@ int smu_read_sensor(struct smu_context *smu,
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>                 return -EOPNOTSUPP;
>
> +       if (!data || !size)
> +               return -EINVAL;
> +
>         mutex_lock(&smu->mutex);
>
> -       if (smu->ppt_funcs->read_sensor)
> -               ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
> +       switch (sensor) {
> +       case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
> +               *((uint32_t *)data) = smu->pstate_sclk;
> +               *size = 4;
> +               break;
> +       case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
> +               *((uint32_t *)data) = smu->pstate_mclk;
> +               *size = 4;
> +               break;
> +       case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
> +               ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
> +               *size = 8;
> +               break;
> +       case AMDGPU_PP_SENSOR_UVD_POWER:
> +               *(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
> +               *size = 4;
> +               break;
> +       case AMDGPU_PP_SENSOR_VCE_POWER:
> +               *(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_VCE_BIT) ? 1 : 0;
> +               *size = 4;
> +               break;
> +       case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
> +               *(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
> +               *size = 4;
> +               break;
> +       default:
> +               if (smu->ppt_funcs->read_sensor)
> +                       ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
> +               break;
> +       }
>
>         mutex_unlock(&smu->mutex);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 0d1429fc791b..41164a8fbe8a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -695,8 +695,6 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>
>  bool is_support_sw_smu(struct amdgpu_device *adev);
>  int smu_reset(struct smu_context *smu);
> -int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors sensor,
> -                          void *data, uint32_t *size);
>  int smu_sys_get_pp_table(struct smu_context *smu, void **table);
>  int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
>  int smu_get_power_num_states(struct smu_context *smu, struct pp_states_info *state_info);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index d10d15fc7492..1a17d853afbd 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1198,7 +1198,7 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         default:
> -               ret = smu_common_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
>                 break;
>         }
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 5b56e7579ff4..ae1035575808 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -226,7 +226,7 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         default:
> -               ret = smu_common_read_sensor(smu, sensor, data, size);
> +               ret = -EOPNOTSUPP;
>                 break;
>         }
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
