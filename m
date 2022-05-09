Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44C710EE31;
	Mon,  9 May 2022 14:47:55 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B5D10EE31
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:47:55 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id m25so15402044oih.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 May 2022 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZY0ISHPkY+v4EDRYGBLtZ0OjYoMTJ4K7pokkMqIcezk=;
 b=l2UshGMlvhH7R1WDaojiatZdm6jvHPx93LuZS2yPDz39OqTsDnwYQ0w3P4V4uY4vHj
 Bj5ZPrCNU1vTyAhnY+J0JleYdsTylLNh15he0VHtgicGFWpSnqeseaRMDODKVkMujTQ9
 6UQb0r/LMLBwEVUQw4iAiw9HSMMJf4YV/2wdtfoP5sEkdMOXwJ7YpGhDz/VUJlb1/ySF
 upO/sTqDOa3eWheRQJwVPZfFRrp4CrFjyJ7A1LKZvGmOQlNAjr8/hRgo3MDDw1PEFl4X
 w1JPY9ZNJ4IvCK632NtW+DEKhGBKyw4S3QM1MU07S1Tg3c3Y49BAf5Ff1+2hiZJOQNrD
 PsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZY0ISHPkY+v4EDRYGBLtZ0OjYoMTJ4K7pokkMqIcezk=;
 b=klxGVziirxdUAJ2CH+3r/BHuuFb6pHHg8qmFf3R+71kDX3fgxhXH9AsAc42a2ZJJFP
 gPMHqoz4UitsdRmhoT9GyHxOLy4nYVDutUrjKRDfbfoG+FAO9szQGZsaEkD3drlYUUpU
 6g1r5qvGT431a1miOcehGYsqQAtGVuXqzO8g5G1zVCUUUV1/wIbdYg6iJOojGLoRUkCR
 PthrroAZ6uUwgDT98Q2uUuBiKlgdzz3LG8knobd9vJR1pJIwuzuy7XF8+7/v2ArqtIT+
 QPUC+D2BVh0JuQ/sLyubiOPb46BW+zB4lw4rSVe3h16xe2cxNerPGsVGAsS0i0mw9ON3
 3+pw==
X-Gm-Message-State: AOAM5332nYxIRO1v4ohM6r5g8fxEu23y2koYnI5p+VAoTYsZQqBylIGI
 vEdGtGwysvsKtaNm6NNurIHttbVBGAeBMYJHYys=
X-Google-Smtp-Source: ABdhPJx0JgFLpuMziBad6tNpNWB0p3iredaDkytbAy0xTVXBgXO4Kgx6rnQwWv/R77O5sZkD4ongkgYVhaVuYMl8JbE=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr10612810oib.200.1652107674598; Mon, 09
 May 2022 07:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220507070537.1344218-1-evan.quan@amd.com>
In-Reply-To: <20220507070537.1344218-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 May 2022 10:47:43 -0400
Message-ID: <CADnq5_NxziXk8jPYOrVA9UP7P=MX__DNLYpPbtFk-FRbEYPwoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: suppress compile warning about possible
 unaligned accesses
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 7, 2022 at 3:06 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Suppress the following compile warning:
>    In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_0_ppt.c:39:
> >> drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v13_0_0_pptable.h:194:39:
> warning: field overdrive_table within 'struct smu_13_0_0_powerplay_table' is
> less aligned than 'struct smu_13_0_0_overdrive_table' and is usually due to
> 'struct smu_13_0_0_powerplay_table' being packed,
> which can lead to unaligned accesses [-Wunaligned-access]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: Ibba9dbfcc6440d0bdf0fbe0534ce6a82ab6d5d10
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> index 670f2ef67868..566a0da59e53 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
> @@ -22,6 +22,8 @@
>  #ifndef SMU_13_0_0_PPTABLE_H
>  #define SMU_13_0_0_PPTABLE_H
>
> +#pragma pack(push, 1)
> +
>  #define SMU_13_0_0_TABLE_FORMAT_REVISION 15
>
>  //// POWERPLAYTABLE::ulPlatformCaps
> @@ -194,7 +196,8 @@ struct smu_13_0_0_powerplay_table
>      struct smu_13_0_0_overdrive_table overdrive_table;
>      uint8_t padding1;
>      PPTable_t smc_pptable; //PPTable_t in driver_if.h
> -} __attribute__((packed));
> +};
>
> +#pragma pack(pop)
>
>  #endif
> --
> 2.29.0
>
