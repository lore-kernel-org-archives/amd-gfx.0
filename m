Return-Path: <SRS0=S4aW=CO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B4C43461
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C51206B8
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7+RJy62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C51206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FAA6E134;
	Sat,  5 Sep 2020 15:44:32 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36246E134
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2020 15:44:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id u18so9380519wmc.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Sep 2020 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4JcAKLePu+3O1bqO2JCc50b487VFiR6oPJrByHpo7NA=;
 b=m7+RJy62jeA18Xets2zPJ9WiT+aPvEQMu3WjclVQImmSuedTU+j8UKKg5AWABqC3Nk
 xMrs8LdJWdHrB4Lw3WoHlf4Tf3s/CM5EbLqbPMcscI+OP5rdYT/Tvb5VUyr1IBeTAs2R
 WlySlZdC27h8YvME0Y6Ve5bL4zT443bo6SHj0lMEeBBS3fut5v6KhOR7wQXYj7YpUCtl
 pjVTsDXYXdWLMKsqIY9z0Mi+cwp0QM7offnjPyd7BYKYaGqJlcFIR4kAm3CObhfWSiNG
 yg9iLQIidCciMn61NPBGbwnNZbC5uBn3WQxgwYvx38cr+fYzOYpRh9q/YakHyGEE9Wwf
 K8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4JcAKLePu+3O1bqO2JCc50b487VFiR6oPJrByHpo7NA=;
 b=tkYOizDI25371bjucozAoJM2hxmhixRnGx1l7OQWgvhIWEiD/va4BexEoxk2Pf2mJn
 /qELZaDzp4QlVNmhBDHp9SIqtDpY2Grhmkoi1azQslrwk+uyEEwQxoNS8VfhoqterAmk
 yMFENrh16yGQqFPx7bAHFV1aK9u5CUjiq/yBuuDuSJ7X9tIIfoRzPnO+ut3SSIC1JsVt
 5ynrIgNJbdAeL3Hi1sz4JkFkR2sssQuhuGPT2eRP1YNT7PYM2yEKw2zAXbqOzSl5tGns
 jGkQbuNULzcScr7CLDrUz+CT2F00TSwB6/k4JSO3qxOpa4Hb9uEYoH19jG0tPmxi8uUI
 YcSw==
X-Gm-Message-State: AOAM532aX1Vt1jMvxKPOPlcbCTsitmk82wF8SufDMdz7QMpeoF3R7Xth
 jscNlxeOc1A0Nm8gqKTTNlBNgLucH/Y2VxEw2J0=
X-Google-Smtp-Source: ABdhPJzkYblg3t8dOpKBoA8o/C1+qrmz0EwepTL3z/bFGI9b61Jz9ULFGA987nlSu4d/mAIuuumTqZ2/Eo1Hcz/K948=
X-Received: by 2002:a1c:a953:: with SMTP id s80mr12327249wme.70.1599320670420; 
 Sat, 05 Sep 2020 08:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200904081443.19768-1-evan.quan@amd.com>
 <20200904081443.19768-2-evan.quan@amd.com>
In-Reply-To: <20200904081443.19768-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 5 Sep 2020 11:44:19 -0400
Message-ID: <CADnq5_N7DbR-mgAM4bC7tkZr=hv0hvm+_NsVFtjtzN6qeg+n2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: correct Renoir UMD Stable Pstate settings
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
 Huang Rui <ray.huang@amd.com>, changzhu <changfeng.zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 4, 2020 at 4:15 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Update the UMD stable Pstate settings with correct clocks.
>
> Change-Id: Ia14eb8e23c513cad0bd633fbeb99ed694c7e3f7e
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 52 ++++++++++++++++++-
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h   |  1 +
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index f4c55e8b5221..8a0bc7f5ec03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -832,9 +832,59 @@ static int renoir_set_performance_level(struct smu_context *smu,
>                 ret = renoir_force_dpm_limit_value(smu, false);
>                 break;
>         case AMD_DPM_FORCED_LEVEL_AUTO:
> -       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>                 ret = renoir_unforce_dpm_levels(smu);
>                 break;
> +       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetHardMinGfxClk,
> +                                                     RENOIR_UMD_PSTATE_GFXCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetHardMinFclkByFreq,
> +                                                     RENOIR_UMD_PSTATE_FCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetHardMinSocclkByFreq,
> +                                                     RENOIR_UMD_PSTATE_SOCCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetHardMinVcn,
> +                                                     RENOIR_UMD_PSTATE_VCNCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetSoftMaxGfxClk,
> +                                                     RENOIR_UMD_PSTATE_GFXCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetSoftMaxFclkByFreq,
> +                                                     RENOIR_UMD_PSTATE_FCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetSoftMaxSocclkByFreq,
> +                                                     RENOIR_UMD_PSTATE_SOCCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               ret = smu_cmn_send_smc_msg_with_param(smu,
> +                                                     SMU_MSG_SetSoftMaxVcn,
> +                                                     RENOIR_UMD_PSTATE_VCNCLK,
> +                                                     NULL);
> +               if (ret)
> +                       return ret;
> +               break;
>         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>         case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>                 ret = renoir_get_profiling_clk_mask(smu, level,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
> index 8c3f004cdf8d..11c3c22fecbe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.h
> @@ -29,5 +29,6 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
>  #define RENOIR_UMD_PSTATE_GFXCLK       700
>  #define RENOIR_UMD_PSTATE_SOCCLK       678
>  #define RENOIR_UMD_PSTATE_FCLK         800
> +#define RENOIR_UMD_PSTATE_VCNCLK       0x022D01D8
>
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
