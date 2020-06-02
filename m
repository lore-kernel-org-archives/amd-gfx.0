Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C84C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8FC206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5O3fcjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8FC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99B96E3F0;
	Tue,  2 Jun 2020 14:32:47 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E846E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 14:32:46 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d128so3379171wmc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pf9U0xu97gNdFtPjIGR38qEJWn/idB+yZFWdxgQw2/E=;
 b=V5O3fcjhwieYn0kOV88EjhHEwjiJuV+IQrF/t56MZumkNU4VIH6kC2kyMfgxwmbk3O
 zYQhs/6mJ/2M05Rq39Ucb4/0hWEGda3jKmAYkXrQSLxdCk2xWLp5sDTTKdozhvQUEyJq
 9CuITgQfCn6FbGWFV8HdDZqvAUIrPTmZbEJIa2y7ld1udRMrs0EtFnJ+6P7WBZfvt01r
 FoxDUx+5l4feqcJwAjcY0BwIFP7iF4MmtN72qrp2VSgMQgJekci9R19SBVlTEqYaR21X
 kYgr5I65oJyd7uldtxVVdeTS4jvU8obo6Zx04PLUjDP+Wc3aN8HZqJiLJ7AH3PPnEZTZ
 bQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pf9U0xu97gNdFtPjIGR38qEJWn/idB+yZFWdxgQw2/E=;
 b=uCLEESbdIAhK6gxIoeHnXx55OSNE8gHrBBpcTU4X5TR00HTRonHtZTf8xlapxltL3k
 18EVd6nFbSVnnlDwGoaTQwg4CCFRFLIC6w9sf8ABHe/YGGd7HnGrKHCEVbkdWRvelghJ
 OU/Se+SLW6VFJXNQNfHCOou9LqYM0kenSoqWbqTqtXlrc9KipV26QjwGIIoj2gWBzQLA
 8ahJAJFodKG25ro5mAAu8M6OHQ266ioJPFKaQkgRUSWyXhV7ORHVpn734BQm7yaIXRX1
 XyAQelKrLdMpU6vLKy3SX4reYyV7mbtWAdGJn9BYPNpbrEafk6q4vm0I0s03OaH3t16U
 nEZg==
X-Gm-Message-State: AOAM530zClvGdHnmVMcoaDPMSNW0pJOOhgnEcbMxErdEohJMAC2vgDPC
 k6jAQnJh5E1G4Bu0TDGnLvoc5/JpvsBkr90hCsBGCg==
X-Google-Smtp-Source: ABdhPJznm6n2EbkWRifbC5wLUQ2Jmg9mW44ZEZhfaJ2+I37rQ76UU4Q7dAE7mhkYdvkBZT+vdy5hVAHSgzrj1udiH20=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr4478219wmj.56.1591108365276; 
 Tue, 02 Jun 2020 07:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <1591020460-7020-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1591020460-7020-1-git-send-email-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 10:32:34 -0400
Message-ID: <CADnq5_NxX3rkAc__c+BZWJZSmhHuH+Bw-Y+zaQNc4M-W9nVVjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: use existed smu_dpm_set* interfaces to
 implement powergate functions
To: Huang Rui <ray.huang@amd.com>
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

On Mon, Jun 1, 2020 at 10:08 AM Huang Rui <ray.huang@amd.com> wrote:
>
> Abstract powergate_vcn/jpeg functions, using smu_dpm_set* to implement it.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 --
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  2 --
>  drivers/gpu/drm/amd/powerplay/smu_internal.h   |  7 +++----
>  drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 22 ----------------------
>  5 files changed, 19 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 3bb6ab4..846d099 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -2736,3 +2736,19 @@ uint32_t smu_get_pptable_power_limit(struct smu_context *smu)
>
>         return ret;
>  }
> +
> +int smu_powergate_vcn(struct smu_context *smu, bool gate)
> +{
> +       if (!smu->is_apu)
> +               return 0;
> +
> +       return smu_dpm_set_uvd_enable(smu, !gate);
> +}
> +
> +int smu_powergate_jpeg(struct smu_context *smu, bool gate)
> +{
> +       if (!smu->is_apu)
> +               return 0;
> +
> +       return smu_dpm_set_jpeg_enable(smu, !gate);
> +}
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index ae2c318..e68d554 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -508,8 +508,6 @@ struct pptable_funcs {
>         int (*populate_smc_tables)(struct smu_context *smu);
>         int (*check_fw_version)(struct smu_context *smu);
>         int (*powergate_sdma)(struct smu_context *smu, bool gate);
> -       int (*powergate_vcn)(struct smu_context *smu, bool gate);
> -       int (*powergate_jpeg)(struct smu_context *smu, bool gate);
>         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
>         int (*write_pptable)(struct smu_context *smu);
>         int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 95eb445..6241d2e 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -930,8 +930,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .check_fw_status = smu_v12_0_check_fw_status,
>         .check_fw_version = smu_v12_0_check_fw_version,
>         .powergate_sdma = smu_v12_0_powergate_sdma,
> -       .powergate_vcn = smu_v12_0_powergate_vcn,
> -       .powergate_jpeg = smu_v12_0_powergate_jpeg,
>         .send_smc_msg_with_param = smu_v12_0_send_msg_with_param,
>         .set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
>         .gfx_off_control = smu_v12_0_gfx_off_control,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 40c35bc..2889eb2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -40,10 +40,6 @@
>         ((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable((smu)) : 0)
>  #define smu_powergate_sdma(smu, gate) \
>         ((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdma((smu), (gate)) : 0)
> -#define smu_powergate_vcn(smu, gate) \
> -       ((smu)->ppt_funcs->powergate_vcn ? (smu)->ppt_funcs->powergate_vcn((smu), (gate)) : 0)
> -#define smu_powergate_jpeg(smu, gate) \
> -       ((smu)->ppt_funcs->powergate_jpeg ? (smu)->ppt_funcs->powergate_jpeg((smu), (gate)) : 0)
>
>  #define smu_get_vbios_bootup_values(smu) \
>         ((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
> @@ -214,4 +210,7 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
>  #define smu_set_power_source(smu, power_src) \
>         ((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
>
> +int smu_powergate_vcn(struct smu_context *smu, bool gate);
> +int smu_powergate_jpeg(struct smu_context *smu, bool gate);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 4fc68d4..7c3da532 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -182,28 +182,6 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
>                 return smu_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
>  }
>
> -int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)
> -{
> -       if (!smu->is_apu)
> -               return 0;
> -
> -       if (gate)
> -               return smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
> -       else
> -               return smu_send_smc_msg(smu, SMU_MSG_PowerUpVcn, NULL);
> -}
> -
> -int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate)
> -{
> -       if (!smu->is_apu)
> -               return 0;
> -
> -       if (gate)
> -               return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
> -       else
> -               return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
> -}
> -
>  int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
>  {
>         if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
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
