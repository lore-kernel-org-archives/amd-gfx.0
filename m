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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9179CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63463206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD7qc97h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63463206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D516E5C1;
	Thu,  4 Jun 2020 21:02:23 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F976E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 21:02:21 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id u13so6549249wml.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1/aUBcPsWx9fd2spnnTKNeWeRLHbIkxTWuZFOV81/mw=;
 b=qD7qc97h4p4NSkEJ0Hk+iu2hiqVreCIo6MIylEahhYu2zvg15oM7WtoDWackSMkazB
 eG3uz/hnsGxGDSjlT+pQreInk2GbgZS3GiuJwe8PnTW+R3PVnqi4ZN5gToZKHAWdSb+b
 9oGFmVp+CeffPKUGbevT4H1LWkQv3F3J3tUxyjf/PR+wtmO+JHcwrQ6lKSXFVYi09Q5Z
 U+/IH+3NmG7VpPkpKGr1lEc7RFDNky/kSTmfoxixxxGYMFC4aIgq4w7V0kjwZ8Q0iMdj
 AY4v+QsxqV1bl8AkCcjDEsR50ORE3dJJNVTHu599K9ihYAx+cnGuUW8mjmx2SbLk2UeM
 ZLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1/aUBcPsWx9fd2spnnTKNeWeRLHbIkxTWuZFOV81/mw=;
 b=koIqK7H04fKqR21K2ZURaXzqYS76pVjadEIxOVTqEbKMUgPgJ1T7Ji0Io0MUHTyxi+
 BfbjVQztblRKKoBMJ11ohhYiOkV4lEqlPnBlXf4c3tOgPdhyiWtdVTXl+p54/twu5kv4
 i18qli1ygrrW28V5Agpx0rrouvP992jwIdsbsqm2m4bYA9SLCMjaTTo+I0hRbym29acq
 5xxhzVGb+GoiUR4qwSbgcblDXW5ZW//W1eFPPioBsbKEtDXne6EP8A+1+1R7E+hgONsP
 be/gSz0gt8zG7XXnP81COlvNY5BM6KooHDmXl6LzNzPWpMxrAQQvuC2mHKns72r2d7y+
 NXnw==
X-Gm-Message-State: AOAM533/Id9YUDI4P4EFXPuKb5cJ9ffzXq2N5OrdyPgT983yDUaoai1E
 9raxOT+I9LIEyc+7zjDozx+AVLaER4ZrxnnoXlzks40l
X-Google-Smtp-Source: ABdhPJx29CKNY5Pex2EBS5u0IXpdm8Yg+890SIjF5ZzBI98MWK3VOONMjHbTW0QPbNSYPLwAkab+7pY+PE0JxPxn9Gc=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr5834841wmj.56.1591304540194; 
 Thu, 04 Jun 2020 14:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-11-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-11-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 17:02:09 -0400
Message-ID: <CADnq5_NRG0YRyqvqaL+-Dhv4rEgWaKDzeVDAM6ntqRiiRH4bnA@mail.gmail.com>
Subject: Re: [PATCH 11/16] drm/amd/powerplay: resort those operations
 performed in hw setup
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

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Those common operations(for all ASICs) are placed first and followed
> by ASIC specific ones. While the display related are placed at the last.
>
> Change-Id: Id45caee98273c8c0b9c1c9f2713fcf8106e02000
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Typo in the subject and clarification:

drm/amd/powerplay: sort the operations performed in hw setup

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 61 +++++++++++-----------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4c1f7c36b74b..b3410d111316 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1134,6 +1134,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> +       /*
> +        * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
> +        */
> +       ret = smu_set_tool_table_location(smu);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> +        * pool location.
> +        */
> +       ret = smu_notify_memory_pool_location(smu);
> +       if (ret)
> +               return ret;
> +
>         /* smu_dump_pptable(smu); */
>         /*
>          * Copy pptable bo in the vram to smc with SMU MSGs such as
> @@ -1147,6 +1162,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         ret = smu_run_btc(smu);
>         if (ret)
>                 return ret;
> +
>         ret = smu_feature_set_allowed_mask(smu);
>         if (ret)
>                 return ret;
> @@ -1155,6 +1171,21 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> +       if (!smu_is_dpm_running(smu))
> +               pr_info("dpm has been disabled\n");
> +
> +       ret = smu_override_pcie_parameters(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_enable_thermal_alert(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +       if (ret)
> +               return ret;
> +
>         ret = smu_disable_umc_cdr_12gbps_workaround(smu);
>         if (ret) {
>                 pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> @@ -1185,36 +1216,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       ret = smu_override_pcie_parameters(smu);
> -       if (ret)
> -               return ret;
> -
> -       /*
> -        * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
> -        */
> -       ret = smu_set_tool_table_location(smu);
> -       if (ret)
> -               return ret;
> -
> -       if (!smu_is_dpm_running(smu))
> -               pr_info("dpm has been disabled\n");
> -
> -       /*
> -        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> -        * pool location.
> -        */
> -       ret = smu_notify_memory_pool_location(smu);
> -       if (ret)
> -               return ret;
> -
> -       ret = smu_enable_thermal_alert(smu);
> -       if (ret)
> -               return ret;
> -
> -       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> -       if (ret)
> -               return ret;
> -
>         return ret;
>  }
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
