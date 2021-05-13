Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C93EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 18:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA2861435
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 18:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA2861435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C786ED9B;
	Thu, 13 May 2021 18:00:45 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4EB6ED9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 18:00:44 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so3178921otc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0XrvtcfIHtasA33fu/ySauvpi4ynGhc8kNElogAZuk8=;
 b=Xn62tpIyQMShqQ/KHDnrRx2MQiNtdwHuzn4meOw50mkJU9dmQnp7UbaOBYNmMAOCYX
 2ySSgh8dbZNqzogj63aP1U1Y14Dcg4T1BTPu4tfceaWAJhh2lcYVpH6rXJ41x3Bwkhwb
 zY3CPoLb6LkI+f0Zo9XNUEamHBlmgiCAV7j/hR438hwlyMhRm+0Z0JCPxXl5+Q26i155
 evIXK8w5SMZLVZEApC9zbopC/H4b4y0IJIe9bL5ykAnTSVaiiUlFuHah/g7NDxHyM/7Q
 Y9yMuikuUwAJOh8JzU6vcOiFv6gzrEXxfMRpCvSAUFGEBhAATdmD2aiJtYveZHBXQZYU
 ECZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0XrvtcfIHtasA33fu/ySauvpi4ynGhc8kNElogAZuk8=;
 b=oGRHJ6d46bdJndaQrMh4ny4/SBXr7AQh/Qx86G3IJYNf2xq7+y5NXgF0CQLELXwZ0Y
 7mXXyq/u0L6ObtHeWBg5QeqQWjZzkgMWk5p9SABSYsYmFuorGgHi6tjvtBHxZDHgAOxf
 5KxEqPgv2stl+EiBQjmjI903jiwNzmXHSzxgQ+qCQgmOFgXXmyBeK+gnT2Lp5W544HoU
 98W33zEIwL1yxms6dZ/6uYw+KINBqDoSqhejh2G+mwDsACX1rhwUP2KbNgFG4FTQPZpY
 6PsQXIrlFQEJQKlDLcaJyRRutf8NYacnrE4/qC/FwZoyrniv2D9F3coyyXae4W5wzXmW
 ugdQ==
X-Gm-Message-State: AOAM530UCPjN0IGwtedHMM1/M9CBaon7Dptj52SCmZpmMZJO/98a9SQG
 i/i8rg72YburWTGLxML4ri5lY5TASDtv4lzokR/sNOfO
X-Google-Smtp-Source: ABdhPJyBy/IrCbPvjdiQO5ltwAf8tvHQu9RRqjmhdukf3o7P54KrDwuG0lwBpW/gOFlEvHPJU9Wne0LJsme/pD2ITgg=
X-Received: by 2002:a9d:74c6:: with SMTP id a6mr20815024otl.132.1620928843461; 
 Thu, 13 May 2021 11:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
 <20210513174539.27409-1-david.nieto@amd.com>
In-Reply-To: <20210513174539.27409-1-david.nieto@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 14:00:32 -0400
Message-ID: <CADnq5_NtPNk_6uhgPu8dSE-RPgRwMXYBHFvQ50WzEj_3N2bbHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
To: David M Nieto <david.nieto@amd.com>
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

On Thu, May 13, 2021 at 1:45 PM David M Nieto <david.nieto@amd.com> wrote:
>
> Free the resources if the fence needs to be ignored
> during the ratio calculation
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Will push it momentarily.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 01fe60fedcbe..9036c93b4a0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
>                 if (!fence)
>                         continue;
>                 s_fence = to_drm_sched_fence(fence);
> -               if (!dma_fence_is_signaled(&s_fence->scheduled))
> +               if (!dma_fence_is_signaled(&s_fence->scheduled)) {
> +                       dma_fence_put(fence);
>                         continue;
> +               }
>                 t1 = s_fence->scheduled.timestamp;
> -               if (t1 >= now)
> +               if (!ktime_before(t1, now)) {
> +                       dma_fence_put(fence);
>                         continue;
> +               }
>                 if (dma_fence_is_signaled(&s_fence->finished) &&
>                         s_fence->finished.timestamp < now)
>                         *total += ktime_sub(s_fence->finished.timestamp, t1);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
