Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB41C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4C3205CA
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4C3205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1578E6E514;
	Wed, 27 Jan 2021 04:55:04 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261776E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:55:03 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id q3so235597oog.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jan 2021 20:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z+gp/zPHW6IqyE2uDe5sPdbRKzYt3lEJIQLjSresZpQ=;
 b=tFgVAZZIulFkL9+jEf69QrE9etdmR3nLrmvP9dwSd+WOrypUtoPq9u+ZM85+4jPq9v
 lOjZ1synBa5p92FBcXl+fWr1+7hdWkW5D54lCsfsjqrMhNnCMiyI7O2x7aVLND/M+Qtp
 EGq+oLncTn/4YzkwB0QwJg0jyG70MzVMk5KTbZ7wheBl+qJ+hGOpw4RJogoXaDp3VywP
 oUf+PndMrmgdxlZwZMYCozJrXa95zLCYjQ4wTFJmgRrTi+u2x8JbR4xAWQIvMPyNsHv5
 FbAG7RUCJhzCuNiTV5uI3zauCrMc62n6eyeTA81Hyf9NtgPxgAXoHBPkpKUVpD4QAWLm
 gIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z+gp/zPHW6IqyE2uDe5sPdbRKzYt3lEJIQLjSresZpQ=;
 b=rJyhyro4WjL3ZgBJ5gx5lHV6g1pBhzCbLpCVhka3CfhXT0aAY2DX7zEGldn973YQqu
 XAS7DbLc7h0WhvxQCuZ+vQztjpDO6FGLgjzFP1rPI86p+0vW4CzgTCNso981zbp9s/Un
 eeIV+cy8NUF8qwDuki5Id1TRmGgUmZI76MYkfulvoO20wBgKCQ6EA9H96vGMfENBmLWq
 aWt186TXFWvpdT0dWxQuITpQixxdTO7MQfXJbA29NXtFb0srawxRAJ1xD0E3ix0Hka+4
 UJzdydYbBSYFyymCltzMD28UW1DQk1IRbVvaZx26LAkAa4YSpdD7ccRbhMDSKUqRpTWf
 wonA==
X-Gm-Message-State: AOAM5328shIh7UEnFSjjd2pTBxEenEImFhZ4jyw8wq3WrfLOr6vLbakh
 mNXTQHnLdvIclEGFrI13z5Zj91rwRioMT/lPCK4=
X-Google-Smtp-Source: ABdhPJx84lAFjyLK3jKKFpYISqYYqeznNnwtOfCfIzxgIPwWtf43bahuVj/ZBSAfza0zxGwSL+SJd5MAfKcXtgjaxeE=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr6386437oof.61.1611723302434;
 Tue, 26 Jan 2021 20:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20210127014146.10902-1-kenneth.feng@amd.com>
In-Reply-To: <20210127014146.10902-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Jan 2021 23:54:51 -0500
Message-ID: <CADnq5_PXPj6Fyzpe2wV_Bejx+JtihrbeatM605ATCuYNuzK-Vw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Enable gfx DCS feature
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: Tao Zhou <tao.zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 26, 2021 at 8:42 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> Background:
> Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> When the current/power/temperature exceeds the limit with the heavy workload,
> the gfx core can be shut off and powered on back and forth.
> The ON time and OFF time is determined by the firmware according to
> the accumulated power credits.
> This feature is different from gfxoff.Gfxoff is applied in the idle case
> and DCS is applied in the case with heavey workload.There are two types of DCS:
> Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D fullscreen
> and VR workload.
> Since we only supports Async DCS now,disalbe DCS when the 3D fullscreen or
> the VR workload type is chosen.
>
> Verification:
> The power is lowerer or the perf/watt is increased in the throttling case.
> To be simplified, the entry/exit counter can be observed from the firmware.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 24f3c96a5e5e..436d94cbb166 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>         }
>
> +       if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>         if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>                                         | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> @@ -1437,6 +1440,15 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>                                     1 << workload_type, NULL);
>
> +       /* have to disable dcs if it's the 3D fullscreen or VR workload type */
> +       if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +               smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
> +               ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> +                       WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT || workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> +               if (ret)
> +                       return ret;
> +       }
> +

Since we don't support FA DCS yet, should we just drop this hunk for
now?  I think the workload profile stuff should be independent of FA
DCS.  Also so we want to add a ppfeaturemask flag to easily allow us
to disable this at driver load time?

Alex


>         return ret;
>  }
>
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
