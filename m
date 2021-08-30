Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCCC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 13:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771A360295
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 13:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 771A360295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2066489D99;
	Mon, 30 Aug 2021 13:22:15 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07F989D99;
 Mon, 30 Aug 2021 13:22:13 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 107-20020a9d0bf4000000b0051b8be1192fso8119258oth.7; 
 Mon, 30 Aug 2021 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9GJx6Kj9IjxLJYmuty3jtd9bUP+GAh0xyATeMOQii1M=;
 b=BbhQ2dtKVYkxPMKSzZmga7KtTBhnO8N9JAmOR+uoykhXz4lVLr3ytMqZx+d7QHzMIc
 RlALZ1v4kHg9gvHkJ3k3rba7vmb9AQOoCQ6c6chhcwpx9ZeHM/L9FZoXrRhckJbHzOXY
 NF4AcpS69lwKnwi/N64psjGN6fLgiyNnVuyFsa8hAvtBRm2WH61Dd/4qxSrclnKVDalR
 nN5iF0dEH1CvXjlWg3Fy4eZtYEA9TPhjLLC5WZQtnNVZzZWXVRFmZlT7JHNIOZOzzgqd
 jjp8gGO5k9FTf/BDnnU/2qUAQ3diWuX7VtItjGolObvmOzpcJ/sDNT2ObpySIkjp8cH/
 Rx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9GJx6Kj9IjxLJYmuty3jtd9bUP+GAh0xyATeMOQii1M=;
 b=K7kR7GK1J7x7xHh2WK3I9sJyHd5r5funW2mAR77JkEz60W85dSVjnGkV5UzYAVT93S
 Gn0R0Bebq0lLT+IglLHlvm21waWqYBTT+ZEGRK8ydksWNSTewhWQ1aXv3SnMtU85KzgZ
 G+39kZC32kx1LKCYyVhqDwbzcnizGTPvdB0ogtmNbsmtdh4Vp6vphGFkougoAhx4lENm
 HpNy6DdnSQ8iCFjdSgf5uMnCPyTHQq9cnosFc/+86ORDKZFzmH8mtPAsZW9PeCStVyUj
 u7q4EmmJ5hFkiZ0Ro9eRmVLauM6W/OqTJgU2gJoMvvfvspQ2UYfpHycLO8wFP1te/E52
 yiMw==
X-Gm-Message-State: AOAM532ygykQx/lxxbTCJStywaEmJr+rPjDdnYEn5yv7RV8YliKsOkHT
 kqWAF4zGklX2XC/Up9IyqSSiOXvb0V7DD4GGAWqU2N5+
X-Google-Smtp-Source: ABdhPJzFLQ2trCwLX1OPN8Uak8yPPZeAXV1f000MypUK7xCJvG9iafmpCu4oiWHYhMqkN3Gnmc5OKyePibTRVm+yFIE=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr19191447otf.311.1630329733265; 
 Mon, 30 Aug 2021 06:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210828084116.1642-1-caihuoqing@baidu.com>
In-Reply-To: <20210828084116.1642-1-caihuoqing@baidu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Aug 2021 09:22:02 -0400
Message-ID: <CADnq5_MvefFonTAtC1WS7HkdX8feAV8SaLe0-4d5nec=3xxX8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Make use of the helper macro
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

On Sat, Aug 28, 2021 at 4:41 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Use the helper macro SET_RUNTIME_PM_OPS() instead of the verbose
> operators ".runtime_suspend/.runtime_resume/.runtime_idle", because
> the SET_RUNTIME_PM_OPS() is a nice helper macro that could be brought
> in to make code a little clearer, a little more concise.
>

I think this makes readability worse and just causes code churn.

Alex


> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b6640291f980..9e5fb8d2e0e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1699,6 +1699,8 @@ long amdgpu_drm_ioctl(struct file *filp,
>  }
>
>  static const struct dev_pm_ops amdgpu_pm_ops = {
> +       SET_RUNTIME_PM_OPS(amdgpu_pmops_runtime_suspend,
> +                          amdgpu_pmops_runtime_resume, amdgpu_pmops_runtime_idle)
>         .prepare = amdgpu_pmops_prepare,
>         .complete = amdgpu_pmops_complete,
>         .suspend = amdgpu_pmops_suspend,
> @@ -1707,9 +1709,6 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>         .thaw = amdgpu_pmops_thaw,
>         .poweroff = amdgpu_pmops_poweroff,
>         .restore = amdgpu_pmops_restore,
> -       .runtime_suspend = amdgpu_pmops_runtime_suspend,
> -       .runtime_resume = amdgpu_pmops_runtime_resume,
> -       .runtime_idle = amdgpu_pmops_runtime_idle,
>  };
>
>  static int amdgpu_flush(struct file *f, fl_owner_t id)
> --
> 2.25.1
>
