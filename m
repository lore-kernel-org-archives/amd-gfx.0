Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1AAC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 12:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F1261131
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 12:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41F1261131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BC0899BC;
	Mon, 30 Aug 2021 12:22:04 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CFB899B3;
 Mon, 30 Aug 2021 12:22:03 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id v2so19523821oie.6;
 Mon, 30 Aug 2021 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TVt1e9uzJnbQa+sZx0j5NcPt3T1ddsD8It/3qvzvAZo=;
 b=Z1f2F2UmCNQkkZDWuhMD03psKx8ZqCogR+NJwCA3mkrsdV38DIAvS4nTOpD/yhw4+c
 mCAcGyfHAQ2gCuhM3rD+7iY6O51ZES7A5pe6daydZhl0sUOtc+QW2YIA5LEZczQAMBtV
 L2w/Xs2lo02Ww2hu/xaVeUlF1aKWUA4EqX7T1ywj9dOhpnjt9HxgHxpR9mxzefkvIWJ4
 Qp++K1aYT4Qnvd36t6Ar+3i6d0UPvvutm7pLyeFr1Pu9/lPA2q2zvcxZwHv6cXsTXRVY
 JDbgwbr2XhUDIgqgSnej9fIk5X63M5Suqq67xHEBtA3OpnZDmCZSMI8MT+Xb8JeCeRKg
 SVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TVt1e9uzJnbQa+sZx0j5NcPt3T1ddsD8It/3qvzvAZo=;
 b=nzE94QivwRHthN+lB2/nMwrpsih8Q+5XHww+iirh0s1AeTPVFiO3yJ4hxh+m6vrZJK
 R3i1jLFX8nTLnvEDRBMRwrXHljVXYjIayOAX1EyfRSCyVe7z76PCT4BkWR4HiFegnZzQ
 Pc8z500F20l10GO1uiYTG3l4qBFqgfdFwOs0OrAIAGuUsIOlGK4U9KPKLJkjurWGHImX
 rOWWE+lKRC6dYBdAGoiCtTud8Ds512zfSTHuHtybyhthw/cofHMMIHl+fU3Dah0iNF97
 X4X8cYEdRVhv6wxPpzhttYYQ9sGtyKiAD52YX7o2eG0uvoKdrASOrLCZUAbHJ4zT9XRw
 VSSQ==
X-Gm-Message-State: AOAM532Iuq01iRkH4TUX9eZ/Qmk+0Yz0TlgKshHb28IIlM84WWcVl/Jl
 LV7ElpG8LvPD2s7UdBG7yIsap2kGsLwIlvtgXzA=
X-Google-Smtp-Source: ABdhPJxAzbMiGOOeMrQmB8f4bsV3JpAsntCMt+RolmdOd3i6ASErqrnvdObPFSZ3gLhgRErt5g0+9rKAy0xPr6sk6bo=
X-Received: by 2002:a05:6808:483:: with SMTP id
 z3mr22430601oid.5.1630326123046; 
 Mon, 30 Aug 2021 05:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210828085052.756-1-caihuoqing@baidu.com>
In-Reply-To: <20210828085052.756-1-caihuoqing@baidu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Aug 2021 08:21:52 -0400
Message-ID: <CADnq5_Oxs=BF+0v0-ZYQGVoBt-eE8zNXRcG4wWEP=1Wc=imPOw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Make use of the helper macro
 SET_RUNTIME_PM_OPS()
To: Cai Huoqing <caihuoqing@baidu.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 xinhui pan <Xinhui.Pan@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
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

On Sat, Aug 28, 2021 at 4:51 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
> operators ".runtime_suspend/.runtime_resume/.runtime_idle", because
> the SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
> in to make code a little clearer, a little more concise.

I don't personally think it really helps readability.  Just seems to
be code churn.

Alex


>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index b74cebca1f89..c2eb725e87f6 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -529,15 +529,14 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
>  #endif
>
>  static const struct dev_pm_ops radeon_pm_ops = {
> +       SET_RUNTIME_PM_OPS(radeon_pmops_runtime_suspend,
> +                          radeon_pmops_runtime_resume, radeon_pmops_runtime_idle)
>         .suspend = radeon_pmops_suspend,
>         .resume = radeon_pmops_resume,
>         .freeze = radeon_pmops_freeze,
>         .thaw = radeon_pmops_thaw,
>         .poweroff = radeon_pmops_freeze,
>         .restore = radeon_pmops_resume,
> -       .runtime_suspend = radeon_pmops_runtime_suspend,
> -       .runtime_resume = radeon_pmops_runtime_resume,
> -       .runtime_idle = radeon_pmops_runtime_idle,
>  };
>
>  static const struct file_operations radeon_driver_kms_fops = {
> --
> 2.25.1
>
