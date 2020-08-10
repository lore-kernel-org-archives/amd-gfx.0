Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8121C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9399223117
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex3Z5zxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9399223117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B4389948;
	Mon, 10 Aug 2020 15:38:37 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F44789948
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 15:38:35 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id x5so7999098wmi.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9HDkfajPYullYtgeMKRzPIuRUyFXpvaTmVtuD4dMvpU=;
 b=Ex3Z5zxwI7G0L/H8/ovgbnl1GkVcAZ5pzomB+YXbOkRVcuHmFiLV5HuKPTyWiD6g+6
 gM2uuc70oB2/Gs/XBA6LjTsIUPamnWv6YOz8dvuKfVFonSoy/EiSJmrrLwMLFiGrExUr
 sMLcLWQTdnz9NSWwwz2Fd7VFyDnyj1hL80EqHTddL8HJUPouWdDIhiLqir1I0LXGyPEL
 GJ8URYwR97W9JkyyZeJQnLeiIWmuNCKpSrUwDeKJPDXvWAfmVVDcneSuf0bV9zZgCInK
 Os6slxVivxSQDQ5xKKzsnom3qhjz3yKmkU/8ucHxnJExryYS5xlrKZHcDcf+iqQOesTY
 OrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9HDkfajPYullYtgeMKRzPIuRUyFXpvaTmVtuD4dMvpU=;
 b=gIiQRXBBO1jpUPll8EgB5rmqmxh1cEkCDTJ1YkvpZvNS0Ke2vwSVo5/PL072SPYMcp
 K3PoP4NyK6KWLA26UAZAvpsVqeJT0GlxO4QjVgfec2rw/1B4YZiLoWiWzkvXH0hqv2jd
 qnfazrhZM69c0vKar5ce/p/wivD+m658c53LipmpSy28/qMEW0OgkQvl9r+bUVvNsACc
 KfLyEzXo0nNKOHyifiMGHDH3XILc8OZRrhuNTwGBWUN/wV3FDRPvgnWCpUzrm58OZ2W6
 pqy9SUUj8Bh8k/FfaOQavwcMWg9GHedv+hBYA2j9V67e8wwtab4ZBhfF7aIsYJfOY6Dg
 17qQ==
X-Gm-Message-State: AOAM5318PMNd78+8I+QCAGTjUg8uq2kathzdq7F/eF4AEMkBOYOIpe7F
 oBLbAmYN2/Wwi7dt+qTNhqqFYzisV85VebjtNis=
X-Google-Smtp-Source: ABdhPJytAO3sXsGh0JRAA92NnWQJyL9iTygpkSb4vU3BkFaOu1Gjbk9NucVxTW1pf1ELVAH1GJ1Uzq/LQG4GX7Rhupo=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr25552220wml.73.1597073913946; 
 Mon, 10 Aug 2020 08:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200808204235.12313-1-daniel@octaforge.org>
 <20200808204235.12313-2-daniel@octaforge.org>
In-Reply-To: <20200808204235.12313-2-daniel@octaforge.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2020 11:38:22 -0400
Message-ID: <CADnq5_P4fH0Bt6YcAy+msbeodhEts4knumsJxnGbgFXC+NojSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/display: use GFP_ATOMIC in
 dcn20_validate_bandwidth_internal
To: Daniel Kolesa <daniel@octaforge.org>
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

On Sat, Aug 8, 2020 at 4:51 PM Daniel Kolesa <daniel@octaforge.org> wrote:
>
> GFP_KERNEL may and will sleep, and this is being executed in
> a non-preemptible context; this will mess things up since it's
> called inbetween DC_FP_START/END, and rescheduling will result
> in the DC_FP_END later being called in a different context (or
> just crashing if any floating point/vector registers/instructions
> are used after the call is resumed in a different context).
>
> Signed-off-by: Daniel Kolesa <daniel@octaforge.org>

We should probably find a way to pre-allocate this, but in the
meantime, I'll apply the patch.

Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 991eddd10952..c31d1f30e505 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -3141,7 +3141,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
>         int vlevel = 0;
>         int pipe_split_from[MAX_PIPES];
>         int pipe_cnt = 0;
> -       display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
> +       display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
>         DC_LOGGER_INIT(dc->ctx->logger);
>
>         BW_VAL_TRACE_COUNT();
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
