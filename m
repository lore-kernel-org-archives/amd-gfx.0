Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 17:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965F3613B1
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 17:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 965F3613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF036EB76;
	Thu, 18 Nov 2021 17:02:09 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F53D6EB76
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 17:02:08 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q25so15787861oiw.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UH8MibsxIuGnKW4GINIwMwfcjTg/L6yj7e+vF2gaidw=;
 b=Iv3VWh5gnfAyzLvWyaPJWiLC4scWV50QMliBQPLmTHcg4FRtpA/0XeKdXLV/GEI8y6
 ozKmiLGh7YA/xUumD86aQEJAhpuXs6hFwre426uyyiy5RRYqtamXsEIqiypARr4Zd/9G
 1GknnZSQigGHsJ0v9X5OoE4ufCJDhSYCYNSFll4b3hD2M+ffzWMfQQ09cN3iKWsRUbqm
 eYPuOfwg6PS/x1FZNoDuQj/jTwZ4XE2eyWH+7aZ6zbO6+EHOW0IvTUpdcwLZjQIc//4n
 vM1CPcx+sIRi7wdgiQLGxkSAez6AjDCm4JytDjpRwj6MOL0KQU0QqnSnjxZlwXIvXewQ
 xmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UH8MibsxIuGnKW4GINIwMwfcjTg/L6yj7e+vF2gaidw=;
 b=XJ8CSniEtoRquqhZLoSZrxqeJG/xxXYOJ/Otx9ARnWMUlaNgxqVbhf5bAQaMcIxv/x
 3c3ow9mHxdNOxS0rLacTFfGf08IK7Gm7+MJHZ9p/sKzI22yA8qiPIUFCMkiL4SFmGG5R
 N37F2fT4KTFCE0vjUZxf2m7DtarmlymQhQ8ivH4XmyZdL32GKXMn2lVGzCGTFKDWeb7m
 zAhhAoxm0xUNxxB3JZzReNkZTZjw1N7udYKiDe25c+CzH6TrtyDIUeLHy3ObwLTxsjvP
 fyEYkBk/c+v4/akVq4MV+xncxZaWRd8tLThLBoAsf5l+0sAmqSf3Sx7hU7mk1WO0QtUN
 S0Qw==
X-Gm-Message-State: AOAM5332Zcas1myKecM8f1LY9YnLU1a3tAjvVSEmOTf89RpQmdx6oX5H
 6mJnY6vrsKMMkjJXfBeaaRmGD3NCtqNw4UHw6uc=
X-Google-Smtp-Source: ABdhPJxNpxxZ4pxQf43plAWNeFUenDLBCnTysXJhVprCHN6BZu73phNr17u35RP6xmKjp6bl6uOJlHSh29dmRob1NKM=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr9186223oic.123.1637254927691; 
 Thu, 18 Nov 2021 09:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20211118165302.15821-1-hanghong.ma@amd.com>
In-Reply-To: <20211118165302.15821-1-hanghong.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Nov 2021 12:01:56 -0500
Message-ID: <CADnq5_M1dPi69MpJ1naoC3SPQZzArfGYMeJbFmu_UG6Xhbi=DQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop config guard for DC_LOG_DP2
To: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Nicholas.Choi@amd.com, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 11:53 AM Leo (Hanghong) Ma <hanghong.ma@amd.com> wrote:
>
> [Why & How]
> It doesn't make sense to guard DC_LOG_DP2 by CONFIG_DRM_AMD_DCN, and
> this also caused build failure for allmodconfig; So drop the guard
> to fix the compile failure;
>
> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

At some point we may want to rework what the DC_LOG stuff maps too
(e.g., use dev_debug or the newer drm interfaces).

Alex

> ---
>  drivers/gpu/drm/amd/display/include/logger_types.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
> index 370fad883e33..f093b49c5e6e 100644
> --- a/drivers/gpu/drm/amd/display/include/logger_types.h
> +++ b/drivers/gpu/drm/amd/display/include/logger_types.h
> @@ -72,9 +72,7 @@
>  #define DC_LOG_DSC(...) DRM_DEBUG_KMS(__VA_ARGS__)
>  #define DC_LOG_SMU(...) pr_debug("[SMU_MSG]:"__VA_ARGS__)
>  #define DC_LOG_DWB(...) DRM_DEBUG_KMS(__VA_ARGS__)
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>  #define DC_LOG_DP2(...) DRM_DEBUG_KMS(__VA_ARGS__)
> -#endif
>
>  struct dal_logger;
>
> @@ -126,9 +124,7 @@ enum dc_log_type {
>         LOG_MAX_HW_POINTS,
>         LOG_ALL_TF_CHANNELS,
>         LOG_SAMPLE_1DLUT,
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>         LOG_DP2,
> -#endif
>         LOG_SECTION_TOTAL_COUNT
>  };
>
> --
> 2.17.1
>
