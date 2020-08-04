Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFB2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 19:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA43B20842
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwjnDDyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA43B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4984D6E2A9;
	Tue,  4 Aug 2020 19:55:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9786E2A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 19:55:22 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id f7so38566444wrw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=boBTdRE+Kr6//OPQkLD2J8JPaLXPzNGJ1iYl9S0gmUk=;
 b=WwjnDDyuJaux0KCl7O80QbuJvZ+2YKdztr0plAsNPpZPIT5hjjTgcz6LzEbKyJL4Zi
 WHUxvTOAJxOYyZVMgu3vl061oFk2mhMPzCjw/L+5dM9VcbswsfQxEShif/7IwHoVIihA
 HcfRY9RbZZ3HK2a+Vr8p1VlG03fTo75wMhJT3eTZ0W20H53UzwfsT3srMQ6/Lhtq1jFg
 /vXlqTLX2y0QwFch8LcI3cN4Aca4ikG42ngY7qEOIHS0CYSCXQurDMPgkRspVPLMD4JH
 hbkG9ehoFK41c95ED7mRrmnXRsW+untE9xOox/EiWbLZQ0W1HiT37ZBANIXmDB4bl/Zh
 c1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=boBTdRE+Kr6//OPQkLD2J8JPaLXPzNGJ1iYl9S0gmUk=;
 b=G++4dUsPeZwnFLg0dT2olQlkSn3Fu/QKsql42l9J4WDEGxPpWAi0TPTB7AVEIUxvVd
 QFA59oGLshLdQitryPO3l52YZtWo86EofStFQB5yYOW4ek2dRgDUn7v7q9byJps8NoBF
 PCVVKVQXR7n5cLXDaFOQTynzDxbZsEH3CHvC0umXvZE2J3VwMy4RzwuDAzEeBQ3vqhKa
 5vSNC2Yl4C20Yk1uR7nWNVxUfJGqVagOiM/cndtRE5ymlmloQKcQWv5P5Ad2ZxM6Ec1u
 VoTXCzJrow1SQquVh+dXj/iMO1HnfwSxPWyZp4fnf1pS+807Pin+fmsxG2nA6GiVLdTR
 nFQQ==
X-Gm-Message-State: AOAM5318iwVzXzFc/Uxvs151LGh6oFwkDPVCFYDZ40Txyt/4SClV3vHg
 D320YbrdA5Z7+Js7Od2Mcm8E0GCA1E6kYv0nMII=
X-Google-Smtp-Source: ABdhPJxNCcVZL2/FYf9uFdyDNtXiuqWrWlt500f6OwFg/ZXFtyOozNArBExaqg0XuUr+vVrOJ/gT9AIspzbgMTRTkSI=
X-Received: by 2002:adf:a351:: with SMTP id d17mr20551427wrb.111.1596570921498; 
 Tue, 04 Aug 2020 12:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200803044648.28805-1-evan.quan@amd.com>
 <20200803044648.28805-2-evan.quan@amd.com>
In-Reply-To: <20200803044648.28805-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 15:55:09 -0400
Message-ID: <CADnq5_PdkoNLFM8ho-Yjq2sfOLkobZ3vTQbX9BdxgzU0eauhbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: put VCN/JPEG into PG ungate state
 before dpm table setup
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
 Matt Coffin <mcoffin13@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 3, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As VCN related dpm table setup needs VCN be in PG ungate state. Same logics
> applies to JPEG.
>
> Change-Id: I94335efc4e0424cfe0991e984c938998fd8f1287
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 38 +++++++++++++++++-----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 85b04c48bd09..1349d05c5f3d 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -134,7 +134,8 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>  }
>
>  static int smu_dpm_set_vcn_enable(struct smu_context *smu,
> -                                 bool enable)
> +                                 bool enable,
> +                                 int *previous_pg_state)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -148,6 +149,9 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>         if (atomic_read(&power_gate->vcn_gated) ^ enable)
>                 goto out;
>
> +       if (previous_pg_state)
> +               *previous_pg_state = atomic_read(&power_gate->vcn_gated);
> +
>         ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
>         if (!ret)
>                 atomic_set(&power_gate->vcn_gated, !enable);
> @@ -159,7 +163,8 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>  }
>
>  static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
> -                                  bool enable)
> +                                  bool enable,
> +                                  int *previous_pg_state)
>  {
>         struct smu_power_context *smu_power = &smu->smu_power;
>         struct smu_power_gate *power_gate = &smu_power->power_gate;
> @@ -173,6 +178,9 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
>         if (atomic_read(&power_gate->jpeg_gated) ^ enable)
>                 goto out;
>
> +       if (previous_pg_state)
> +               *previous_pg_state = atomic_read(&power_gate->jpeg_gated);
> +
>         ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
>         if (!ret)
>                 atomic_set(&power_gate->jpeg_gated, !enable);
> @@ -212,7 +220,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>          */
>         case AMD_IP_BLOCK_TYPE_UVD:
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               ret = smu_dpm_set_vcn_enable(smu, !gate);
> +               ret = smu_dpm_set_vcn_enable(smu, !gate, NULL);
>                 if (ret)
>                         dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>                                 gate ? "gate" : "ungate");
> @@ -230,7 +238,7 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>                                 gate ? "gate" : "ungate");
>                 break;
>         case AMD_IP_BLOCK_TYPE_JPEG:
> -               ret = smu_dpm_set_jpeg_enable(smu, !gate);
> +               ret = smu_dpm_set_jpeg_enable(smu, !gate, NULL);
>                 if (ret)
>                         dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
>                                 gate ? "gate" : "ungate");
> @@ -407,6 +415,7 @@ static int smu_late_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
> +       int vcn_gate, jpeg_gate;
>         int ret = 0;
>
>         if (!smu->pm_enabled)
> @@ -418,6 +427,14 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> +       /*
> +        * 1. Power up VCN/JPEG as the succeeding smu_set_default_dpm_table()
> +        *    needs VCN/JPEG up.
> +        * 2. Save original gate states and then we can restore back afterwards.
> +        */
> +       smu_dpm_set_vcn_enable(smu, true, &vcn_gate);
> +       smu_dpm_set_jpeg_enable(smu, true, &jpeg_gate);
> +
>         /*
>          * Set initialized values (get from vbios) to dpm tables context such as
>          * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> @@ -429,6 +446,11 @@ static int smu_late_init(void *handle)
>                 return ret;
>         }
>
> +       /* Restore back to original VCN/JPEG power gate states */
> +       smu_dpm_set_vcn_enable(smu, !vcn_gate, NULL);
> +       smu_dpm_set_jpeg_enable(smu, !vcn_gate, NULL);

Copy paste typo.  This should be !jpeg_gate.  With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +
> +
>         ret = smu_populate_umd_state_clk(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
> @@ -991,8 +1013,8 @@ static int smu_hw_init(void *handle)
>
>         if (smu->is_apu) {
>                 smu_powergate_sdma(&adev->smu, false);
> -               smu_dpm_set_vcn_enable(smu, true);
> -               smu_dpm_set_jpeg_enable(smu, true);
> +               smu_dpm_set_vcn_enable(smu, true, NULL);
> +               smu_dpm_set_jpeg_enable(smu, true, NULL);
>                 smu_set_gfx_cgpg(&adev->smu, true);
>         }
>
> @@ -1132,8 +1154,8 @@ static int smu_hw_fini(void *handle)
>
>         if (smu->is_apu) {
>                 smu_powergate_sdma(&adev->smu, true);
> -               smu_dpm_set_vcn_enable(smu, false);
> -               smu_dpm_set_jpeg_enable(smu, false);
> +               smu_dpm_set_vcn_enable(smu, false, NULL);
> +               smu_dpm_set_jpeg_enable(smu, false, NULL);
>         }
>
>         if (!smu->pm_enabled)
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
