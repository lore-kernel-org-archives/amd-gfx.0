Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47DC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BC764E45
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BC764E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F3D06EA2F;
	Thu,  4 Mar 2021 17:06:47 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EDB6EA2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 17:06:46 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id m25so17834058oie.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Mar 2021 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AQvT70tfnN2ximMfEkwqJJnZ1pWj5bO/BRxDZfKW2O0=;
 b=iQkLHpPr/diKbNLrI3TA0GNMhqfDAcmLqHm5T6ONIVpVZgPBykpxp+Jw3x+2ymMZeT
 83rfUc4eX7m2mieVdDkNpt6Om2Z8SaiVtUHHKtBc3gweFT9IHhdIuwmzhPHDw0dEBlB2
 WxjHGF8+Av0mL0NQBxMKlqOzTs8TsjqmS0mW4FByZmVD65xS5rzqWtSPxj7ZY3ehnEmg
 MPaEp6ghi5JKh3cMeqEI4S82mL+99ITCo1Eo5h+8Aiss25hJBDO2EfR6YyIQ5ttEZn8Q
 0MvCr+fVfG20MEVPtPuQ7sumY8pPqTMdRxfNDm1J2iqQeYm28Xj/c9VGpeEWoZDor/dA
 DPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AQvT70tfnN2ximMfEkwqJJnZ1pWj5bO/BRxDZfKW2O0=;
 b=CqNQI/1DxX3svrOXBrMkjqI3uDK8OU+zo/icn54iPgnDW0cUagluirQ2iQiPbp5uKH
 DxaGL3wg/9e/FMSjZ6RcxGG7gKkQFGZibf2Q78VSq9m3gbyy3E3qbA8N4obSkbchZ2B7
 K+GU9ln07RX/scsa5TuD5sXvVpcUZRIXf02j6NWl4TYEPdeEwq3Gv7oujwshihRfogbm
 RlEd6n4emZHsfMn6f4LRJ+NauV4mlzwxvfQDK0nR8nc73HgNxOJpTkUpenLnIoOwcGQM
 8L81YbwyIJ0SBtsHSQjVOyba4YXVDgrsEO7TPSb/px/g9CPZoCJ6o3NuJyb33Hp6sFDQ
 /63g==
X-Gm-Message-State: AOAM5311JdmdCpb69LgHae73SRLtB83LWv21OxJhXhUbIBJbH2kFuGaI
 K9gMWwnjwzwI2GFoW/jQh021nfZyGjcOzNmuorMFcMoW
X-Google-Smtp-Source: ABdhPJwDCdwwBCrpWNA+jVCCnWqBNrt3g0m/j9mEZeBYSIhXvhK1wmfFqO+uUfnDN2Uipt6mVgPmkiD0i9xwd6jhihM=
X-Received: by 2002:aca:fccb:: with SMTP id a194mr3478257oii.5.1614877606123; 
 Thu, 04 Mar 2021 09:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20210225164403.444369-1-alexander.deucher@amd.com>
In-Reply-To: <20210225164403.444369-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Mar 2021 12:06:21 -0500
Message-ID: <CADnq5_N8WQhLqaNs4eh5-qqzuSQ8pebcXsMfmwhKXjer38h0XQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable TMZ by default on Raven asics
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Thu, Feb 25, 2021 at 11:44 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> This has been stable for a while.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2f71d36d2856..21504ea9085f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -164,7 +164,7 @@ int amdgpu_discovery = -1;
>  int amdgpu_mes;
>  int amdgpu_noretry = -1;
>  int amdgpu_force_asic_type = -1;
> -int amdgpu_tmz;
> +int amdgpu_tmz = -1; /* auto */
>  int amdgpu_reset_method = -1; /* auto */
>  int amdgpu_num_kcq = -1;
>
> @@ -790,7 +790,7 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
>   *
>   * The default value: 0 (off).  TODO: change to auto till it is completed.
>   */
> -MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
> +MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto (default), 0 = off, 1 = on)");
>  module_param_named(tmz, amdgpu_tmz, int, 0444);
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index fe1a39ffda72..1a892526d020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -384,6 +384,16 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>  {
>         switch (adev->asic_type) {
>         case CHIP_RAVEN:
> +               if (amdgpu_tmz == 0) {
> +                       adev->gmc.tmz_enabled = false;
> +                       dev_info(adev->dev,
> +                                "Trusted Memory Zone (TMZ) feature disabled (cmd line)\n");
> +               } else {
> +                       adev->gmc.tmz_enabled = true;
> +                       dev_info(adev->dev,
> +                                "Trusted Memory Zone (TMZ) feature enabled\n");
> +               }
> +               break;
>         case CHIP_RENOIR:
>         case CHIP_NAVI10:
>         case CHIP_NAVI14:
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
