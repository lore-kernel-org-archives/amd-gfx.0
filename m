Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4CCC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 19:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FEC613B9
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 19:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FEC613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B92F6EDAE;
	Thu, 13 May 2021 19:41:43 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419CF6EDAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 19:41:41 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id v22so21488950oic.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0SfD5LHKp9dFknS19QWR+aKvcw9cYHWivh+Q7/tU2Qo=;
 b=jaJcHbwaIrH1cFE6Z5wYB4Z4xhFYkngYqKTofBcKg+VKZLpepIg2e5eRuS0nmskmaQ
 2fndaNBWP07Ee19QEQIF1XfZ0HozOm+MipSrpzS5eAPKWfu3bpRhn+S0H3h3AIXbqbj5
 Tb/a3Mc6PpUkaj1eEiYNRChM0OqcTPNxVZTtcJV/4kBzl2Ichwo+9xEg75r95oAxmO0i
 k/QPJ3pg0LxaBRStT3Y2e9FpYLN9Zf58CVYNH8wm/mRmHNtPAYPUvjFMmXd+JvY8AYuM
 ETnpkABXdwkn+ZwTAtWLHeuLJ02hFDhlZ6S4TcBiPuIix1Q5+Ldbf//WxcVCFZ382VhB
 ZZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0SfD5LHKp9dFknS19QWR+aKvcw9cYHWivh+Q7/tU2Qo=;
 b=P1N+cy3W/dIPG6qWUdMxFyQFAl6VuHCWJxgHNKVaDySnsJ3G131vZmUwBfqh9Dn2XL
 Tel3pS6h4F6cFIX8T14oo3Joho0CNM3tE9Gynh3U0C8Y6NsgHp1Z/FnYI3+pj6e4FHF2
 DkRJtfwEJ6eJNU+58ULi4N0LmkPyooAxvKLdf4krHuEdm4oaQj+CLsC1WthsjqiIEp5A
 oSkKJGGi9Kex+ZjQGRYp+kLPPD3ttQ3jim92pVIBtYRUQD3WW1bLr4PvpV/6VRgzKuyZ
 waFWs2tRbt8CKRktLjsrGE1GHNzqE0+psEcn4CAGU9xnbHNd0HMoYJPunbc2WVWTiMNz
 LQng==
X-Gm-Message-State: AOAM5300EPzvHxsFT2g4sf3hDanceMpZeSrbiWrdKxuw20nobR2HbNfS
 1ohcuTfSwrJZV84AqKcAZDP0mkZwY9R8itiJIhc=
X-Google-Smtp-Source: ABdhPJxuR/ZL0So7GW1dC1byZz7flnHlwONX6AVxyk7asxASo1MI8e1WkEhmdGEJzid9rTTjmtxEamH0IwFd6nUCp/Q=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr30960450oig.120.1620934900581; 
 Thu, 13 May 2021 12:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR12MB448837F2FFA7B74AD3345C10F7529@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20210513053233.116683-1-luben.tuikov@amd.com>
In-Reply-To: <20210513053233.116683-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 May 2021 15:41:29 -0400
Message-ID: <CADnq5_OqBOafkMfUAzs7tiXsrjuNPKd=hLWUFCWPh5cah_Sp4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Don't query CE and UE errors
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 "for 3.8" <stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 1:32 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On QUERY2 IOCTL don't query counts of correctable
> and uncorrectable errors, since when RAS is
> enabled and supported on Vega20 server boards,
> this takes insurmountably long time, in O(n^3),
> which slows the system down to the point of it
> being unusable when we have GUI up.
>
> Fixes: ae363a212b14 ("drm/amdgpu: Add a new flag to AMDGPU_CTX_OP_QUERY_STATE2")
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 01fe60fedcbe..e1557020c49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -337,7 +337,6 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>  {
>         struct amdgpu_ctx *ctx;
>         struct amdgpu_ctx_mgr *mgr;
> -       unsigned long ras_counter;
>
>         if (!fpriv)
>                 return -EINVAL;
> @@ -362,21 +361,6 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
>         if (atomic_read(&ctx->guilty))
>                 out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_GUILTY;
>
> -       /*query ue count*/
> -       ras_counter = amdgpu_ras_query_error_count(adev, false);
> -       /*ras counter is monotonic increasing*/
> -       if (ras_counter != ctx->ras_counter_ue) {
> -               out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_UE;
> -               ctx->ras_counter_ue = ras_counter;
> -       }
> -
> -       /*query ce count*/
> -       ras_counter = amdgpu_ras_query_error_count(adev, true);
> -       if (ras_counter != ctx->ras_counter_ce) {
> -               out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_RAS_CE;
> -               ctx->ras_counter_ce = ras_counter;
> -       }
> -
>         mutex_unlock(&mgr->lock);
>         return 0;
>  }
> --
> 2.31.1.527.g2d677e5b15
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
