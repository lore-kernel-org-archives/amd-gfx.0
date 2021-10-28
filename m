Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A945C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4FE610FC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 14:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C4FE610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67BE6E0DA;
	Thu, 28 Oct 2021 14:47:02 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F726E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 14:47:01 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 64-20020a4a0d43000000b002b866fa13eeso2224721oob.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YjJkEjrfN/o6kLXrK1+HsFj+91RklH2MEUaJN8CEH6c=;
 b=TBUu8UhvvpD1wD3g3y/IhBBtoMFVwESofRl9lMYPF0lW/013xho2xUPKtk0YmGYfqP
 3wBGBtZ84pDI6mUXkmpGNO5JcikT1kpWNk3Sdh8u9u0zq8+U63rNojK0qMcd0aauLg4R
 F6S+bOsDjB9oiC7ayUQczwZXIKGJxPcGDDCryRkmqVe4OfQlagG+X0ADH9r6lc34D6Xh
 l9rLCkyi3nOJ2fVdRdOvewWdYO24hR5EaXkciyfIF76214FV5plFGfmzF3VxHvEn2N1g
 HDkfd41GTk14K+OUP3QxtyW+oEu3kDaCGmYXNhiHuQR4KWBSKU20FsV3+ycrsjt4Fh5B
 aKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YjJkEjrfN/o6kLXrK1+HsFj+91RklH2MEUaJN8CEH6c=;
 b=odQIJe2sYWZdU7mP4QCCBpXPd1N7FJF8+hC590CGywYyFBqNXqa72FgvFPxQ3qbnFj
 Fap7mq5U27zycm+udx26JOtvcmZ6qx0GRfv1yYCghEyxfLLhzliTkwxwIvHEDe5dPSbG
 DvWdiGsyvAy7JT+D3NVoihv3zzLPc/Flo/aZhPYhQmUFGfEgsRkD5UxdOCW7FI0sEdF+
 DVhiFqMcSAlCpEisAlIgtnmykUvYTvfPGKZLzjZaONfz0yqEo7UmL8IMF5A0MFghZfOx
 qgglwgfY7Yt6kRg3nJVLwEweft3NkRspeyMhhKusIumve+8ktzwVGYzhOpbtylH9X8hI
 LFHQ==
X-Gm-Message-State: AOAM531Uv7ARnstt/zSkcKy2tX6Z14J7UXtVS9Xhw/XP75ySautu0GTi
 M07ASnZHb7MCdWRDGXXhfN5N3r23f+t0+gFZ2Mw=
X-Google-Smtp-Source: ABdhPJx1q0XwmePJlVVF0orjiBUu8NOl9Xgc41EZiGYrXXXwSQyjtKiWSjjj4I4G/OkOEGAKHssLKx5xBqWRT2HAciI=
X-Received: by 2002:a4a:b881:: with SMTP id z1mr3324095ooo.68.1635432420657;
 Thu, 28 Oct 2021 07:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211027223953.1776162-1-alexander.deucher@amd.com>
In-Reply-To: <20211027223953.1776162-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Oct 2021 10:46:49 -0400
Message-ID: <CADnq5_NkHjMYMJpXMirvd7KDaOH8kF5t+XE9qiVoeR_DcfMxiA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not set
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping

On Wed, Oct 27, 2021 at 6:40 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Need to guard some things with CONFIG_DRM_AMD_DC_DCN.
>
> Fixes: 0c865d1d817b77 ("drm/amd/display: fix link training regression for 1 or 2 lane")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index a9e940bd7e83..49a4d8e85bf8 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -840,9 +840,11 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
>         uint32_t lane;
>
>         if (lt_settings->voltage_swing == NULL &&
> -                       lt_settings->pre_emphasis == NULL &&
> -                       lt_settings->ffe_preset == NULL &&
> -                       lt_settings->post_cursor2 == NULL)
> +           lt_settings->pre_emphasis == NULL &&
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +           lt_settings->ffe_preset == NULL &&
> +#endif
> +           lt_settings->post_cursor2 == NULL)
>
>                 return;
>
> @@ -853,9 +855,10 @@ static void override_lane_settings(const struct link_training_settings *lt_setti
>                         lane_settings[lane].PRE_EMPHASIS = *lt_settings->pre_emphasis;
>                 if (lt_settings->post_cursor2)
>                         lane_settings[lane].POST_CURSOR2 = *lt_settings->post_cursor2;
> -
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>                 if (lt_settings->ffe_preset)
>                         lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
> +#endif
>         }
>  }
>
> --
> 2.31.1
>
