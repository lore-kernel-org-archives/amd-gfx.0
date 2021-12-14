Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA819C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 19:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCA910E145;
	Tue, 14 Dec 2021 19:15:01 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDC0010E145
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 19:14:59 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 47-20020a9d0332000000b005798ac20d72so21982747otv.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TpPSmZMh+C+MOYTc15F+1+8j1gJGR8M3j0SnYsXfCe4=;
 b=b30UJguDfmZpqXBRFghPUzx8l37dZ6eVfCua0ZoWuyBnqta8wp6rRun4zdxmdkAPde
 01YSpwTgGg7oGiRhaGU8eea+Eq840GnwhO0bKVncej55gOhyPFFVMDkJtNW69Cb7I3ud
 scjIzhbh/PhY1HyJGbsufG9OnG9oN5C+nsJ/l3Tnk5QhID6Mgi3fNRnSKRWA+7GqBZvn
 M1QrA46NHTMkEdm5j6eTRjtaUdENQNxE6o5y6oip42hr3BEJZHlwxg7qK2Qhr/2Bkln5
 O0qkCNVfhrb847IQOUU1EqlGd+H7tKLm9TIpNdVFiN+0BJOhYlXfdZEn3XQHByT/uo+d
 dAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TpPSmZMh+C+MOYTc15F+1+8j1gJGR8M3j0SnYsXfCe4=;
 b=FVYA+Kkzj9/aZ7cauaKU/sOOONYPahoK8La2xE+7qICYnhDoyWd4zNEUDxRTZkpmys
 yVHU/kDAq31ZY/2/El1qNjnA7NZBXrqn/fgO8/Q/ElgWm0YoJ2nC0BllMl7aOykgshjs
 BjYIngOYxfoxs18M1lilwghkGLyqsvkWSJzY2L4NjpuLiis09clJZTN3jzp5ihwbobI3
 6G8+RjiT3WjQuuthhOHIdkAURY54DnFNPMtNVs9medZwB+4idCNZ6ifeeiWEM7a3mh7S
 qir9ZkV4aAXPsKZVHqyovdQnMkg98y0zS8fbhFxp6yTmRwePiuCVQfxICnVd/HNOCCHw
 Z2rg==
X-Gm-Message-State: AOAM532LkT9NwyApSPbOy5kCANNxx6hZipu7vp/9GHBPcqAGoBDzuOL+
 LOx52A41077avplujyKJNMexLE4xtZdyTIk6cGE=
X-Google-Smtp-Source: ABdhPJy62RQakRCDQiiy4FIFxHK8Y49YFC3tL9aVff6gH5pl7Lqbj6cfL0eKv+llCmSQK9vOT6BCfcsIZgwxfOr3K4I=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr5901687oto.357.1639509298960; 
 Tue, 14 Dec 2021 11:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211214105254.594167-1-KevinYang.Wang@amd.com>
In-Reply-To: <20211214105254.594167-1-KevinYang.Wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Dec 2021 14:14:47 -0500
Message-ID: <CADnq5_P8xx04Q1kDcficgtKzj8ADBbWS4Hshhubrh3BELDzZkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add smu fw version check for ECC table support
To: Yang Wang <KevinYang.Wang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, Hawking Zhang <hawking.zhang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, hao.zhou@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 14, 2021 at 5:53 AM Yang Wang <KevinYang.Wang@amd.com> wrote:
>
> the smu firmware has been remove ECC TABLE support from 68.46.0.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 8 +-------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 2b9b9a7ba97a..78ce451d0b37 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -79,6 +79,8 @@
>  #define SMU_THROTTLER_PPM_BIT                  56
>  #define SMU_THROTTLER_FIT_BIT                  57
>
> +#define SMU_FW_VERSION(maj, min, rev)  ((maj & 0xffff) << 16 | (min & 0xff) << 8 | (rev & 0xff))
> +
>  struct smu_hw_power_state {
>         unsigned int magic;
>  };
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 0907da022197..7f8f00a19836 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -78,12 +78,6 @@
>
>  #define smnPCIE_ESM_CTRL                       0x111003D0
>
> -/*
> - * SMU support ECCTABLE since version 68.42.0,
> - * use this to check ECCTALE feature whether support
> - */
> -#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
> -
>  static const struct smu_temperature_range smu13_thermal_policy[] =
>  {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
> @@ -1780,7 +1774,7 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
>                 ret = -EOPNOTSUPP;
>         }
>
> -       if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
> +       if (smu_version < SMU_FW_VERSION(68, 42, 0) || smu_version >= SMU_FW_VERSION(68, 46, 0))
>                 ret = -EOPNOTSUPP;
>
>         return ret;
> --
> 2.25.1
>
