Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D81C48BE8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39ED61261
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39ED61261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620676EA51;
	Fri, 18 Jun 2021 17:41:52 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6F46EA52
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:41:50 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 x22-20020a4a62160000b0290245cf6b7feeso2638144ooc.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=788q5XztB2C8+v/50NK5mXQJdzLrPOMMB/uqV5bDUbs=;
 b=JkuPTgyKdQvUnTMs6KalqR/3F4vm0h3GOgBxGgpkYoVwf00q+OWRgKt6h/KtDNW9X/
 CiTC6cm51IAiML4N98CP3CDMfC84crmoL+U2XA/TkEuNK2IN2euaIUikK2eUVK8fV6EX
 1EhzRLhDk2xs257inkaEFbsuZ+WQ0Op+be8LdvSzhJLTkRgNBQ3kZ2hdV911cLds7e9M
 khMnrQ+fIpe5XQOmriWGpd1cp4mPY+C2j/WNYsigSX0zHt533P7g0rZ5x5qYvxvtt0rs
 7SrmvrOTFXImuaLllDpfLvDD13bytvoenxBVAf6+ksBGBW/HNQ+18aGFIYZRVfguI6z3
 a9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=788q5XztB2C8+v/50NK5mXQJdzLrPOMMB/uqV5bDUbs=;
 b=hCfnJuTCdrzq/eeODoY3vjbwMhWMPkyEIq6G5cVqxfob7W9fJdEGQmrU61nWUBvhq7
 W2V2JrXLkL0vufdfZBj0PLywAvMlr4IHuSbOYQCEpnDDMBUdoVmUTGHfWORbLyJ71E6u
 NXYrrX5S+a0c0F70/bNKt3gsKFviwjYNuCVXivd5dXKd8k5O175c19fj+BFn8tGb5Og4
 1F0K2qPYDlFl0mlPtcQpmsEVdKhtVj9P1+bzfc/dwpt28VagOaBcVPZ7n4lntlTHR4r1
 GBtyYze2LNsKV+JaF/+sQ7QVJVQwY/ll4sWS2GOk2ppow4cDOXqvjaJ6Gk9Qm88h//qe
 Iv7A==
X-Gm-Message-State: AOAM533JWfpyt8lyh9aZIxF/TzlwwEbFQpn9mBi8xd7r2EEE1Fz7BsIS
 j14ZmyLyqxH/wmsnw7xdSYKzOQ2EVPBPyKo4dsc=
X-Google-Smtp-Source: ABdhPJyCqzYxF3yJXeSgJP9krcJf4P4YJvUxV07k4/IakGy0nQJl6SAMMU5hsNemKg8JxvGTJaL0UD1AV/RhiJMtEgE=
X-Received: by 2002:a4a:acc8:: with SMTP id c8mr3215333oon.72.1624038110283;
 Fri, 18 Jun 2021 10:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210618022337.2661813-1-yifan1.zhang@amd.com>
In-Reply-To: <20210618022337.2661813-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 13:41:39 -0400
Message-ID: <CADnq5_NY0eLo4J0VT6Z0E-17F65b0hvVr671wFQhXJksbqFzdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Revert enlarging CP_MEC_DOORBELL_RANGE
 patches.
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

Probably better to revert each patch individually for upstream.  With
that changed,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

On Thu, Jun 17, 2021 at 10:23 PM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> Revert "drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue."
> Revert "drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to cover full doorbell."
>
> This revert commits:
> a3b4cfb09aa9e73cc48caff77efc161a396aeddb.
> feae47198886d0df7b43876916a0e4366f159b45
>
> Reason for revert: side effect of enlarging CP_MEC_DOORBELL_RANGE may
> cause some APUs fail to enter gfxoff in certain user cases.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7bfe6f9d3a52..15ae9e33b925 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6974,12 +6974,8 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                         (adev->doorbell_index.kiq * 2) << 2);
> -               /* If GC has entered CGPG, ringing doorbell > first page doesn't
> -                * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
> -                * this issue.
> -                */
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -                       (adev->doorbell.size - 4));
> +                       (adev->doorbell_index.userqueue_end * 2) << 2);
>         }
>
>         WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 922420a2c102..044076ec1d03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3675,12 +3675,8 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                                         (adev->doorbell_index.kiq * 2) << 2);
> -               /* If GC has entered CGPG, ringing doorbell > first page doesn't
> -                * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
> -                * this issue.
> -                */
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -                                       (adev->doorbell.size - 4));
> +                                       (adev->doorbell_index.userqueue_end * 2) << 2);
>         }
>
>         WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
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
