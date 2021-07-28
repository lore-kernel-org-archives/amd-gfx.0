Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CA3C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 13:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D8A60EC0
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 13:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64D8A60EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9A66EAC1;
	Wed, 28 Jul 2021 13:46:03 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBFC6EAC4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 13:46:01 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 i39-20020a9d17270000b02904cf73f54f4bso2139991ota.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ewrJnwMxkWxle/xBofTK8uOtXpy54WWE+9PZU7JDt4=;
 b=XKtticZhT+AAxlWGpm/+S8nd77JY8JiElwPTawP5pw1tRqVWT76q9ouZUIFsl9iK95
 nA+9UPE0gH9c1CFT7RZKpxmWvfO6u0I0ZmvNvXKtik38mUP/8vnxe9vwMC8rDEtCVUTI
 dhXf8DQ8DcOHhEIAilvpy3q2AR5d5Rp+HURcEi31wh3A9KoWDsfIrnPCWR6w1XW9lhsb
 Z6nRVi7OpG+yM1kNd2N1tSyP1uQHcxV/fGPtcs+0xuT8txO9lSf4FVID6ZG9C9HtvDNn
 zYU1V/3ncddUdyeSfQHJmC6msnsT4Zf/GXgw8+ymUhVVJhYx7s9iJomXlfnmu2IlGgM1
 oFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ewrJnwMxkWxle/xBofTK8uOtXpy54WWE+9PZU7JDt4=;
 b=ldZzhEWJ5lfiUZLb75uo++C8GjT6+/Y2mnr7I/DvelV6WhoGiLjrc+d+lztE6qfGfS
 GEn98UsF+x3YAASJZ/JDMRYWVYHDltJYjj5na9G5xhxtTqXPrQg0uX9EbuOOqiz7MLEP
 9BNQzjmcOTdl5IsYWerCsWX7dq/amhcMkvkJ8G+hc2o9cNPl/t965S2L9EwjImM8lXP7
 yVE+ygs4gMW/dil+HvbbBUX3/J50dAkqEs2BPwo92Bpqi1eJEdpQgnLcmDppZfvyfnlW
 5+YF56RmonvPdp+XJB3lo/Y+3a+N7PhivtW0HLZHiUXhh7+jU8BaP2w51zzvPbqSjAdm
 Alhw==
X-Gm-Message-State: AOAM530orQsGzcCvBHUVGmRVZ+4poRodMSvA6mzL62SW2SOt/QQvsNoa
 mm3UAv4IjMcdVMgFyxTOWUhRiVTFcuMHqtMAPWQ=
X-Google-Smtp-Source: ABdhPJwgaDWnBbDOBnzepI2XFMgsTc6+gTl/3SKo5M6encovBS1eUu9INMkOHo8R0mPCAZlwZcX72ayW3wG78ggtobI=
X-Received: by 2002:a05:6830:1f3b:: with SMTP id
 e27mr26574oth.311.1627479960508; 
 Wed, 28 Jul 2021 06:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210728061018.2512047-1-yifan1.zhang@amd.com>
In-Reply-To: <20210728061018.2512047-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jul 2021 09:45:49 -0400
Message-ID: <CADnq5_Oc-TY9e9=wEnhY7mgV8gBpxM=qPSwomW4ceQ-ondngGw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
To: Yifan Zhang <yifan1.zhang@amd.com>
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

On Wed, Jul 28, 2021 at 2:10 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

I assume this won't break gfxoff?  The last time we changed this, it
broke a bunch of scenarios.  Won't this cause just about all doorbells
to wake gfx?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 03acc777adf7..70b64b510743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3675,7 +3675,15 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                                         (adev->doorbell_index.kiq * 2) << 2);
> -               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +               /* In renoir, if GC has entered CGPG, ringing doorbell > first page
> +                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
> +                * workaround this issue.
> +                */
> +               if (adev->asic_type == CHIP_RENOIR)
> +                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> +                                       (adev->doorbell.size - 4));
> +               else
> +                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>                                         (adev->doorbell_index.userqueue_end * 2) << 2);
>         }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
