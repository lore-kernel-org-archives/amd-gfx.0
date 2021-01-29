Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98013C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 19:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BCC64DE3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 19:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BCC64DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7BD36EC09;
	Fri, 29 Jan 2021 19:27:06 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921436EC09;
 Fri, 29 Jan 2021 19:27:05 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id i30so9688258ota.6;
 Fri, 29 Jan 2021 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=soh8pOn1T1DcxTY1XPnZj9TZgDqYse0vYVofp5N1pk0=;
 b=k2PxTxJsoShBobn+g2aJQ756Qotit4VnYGyN5pleotb/YOxh6ue5M3R2RxWIqBL5qO
 LuhxvL5iGqHXxLMvrt6dQgj+xiecomucEYhdfNLx1z/YpdWev1b/cgKZpYTFX1Bke9xg
 ULIlIIWGfJFs7dLWlQ0YdkKEKueZzaeBsU4uwFAM2mcXVMgE2wNwX9ZuYxxZantEBZf1
 hL8QYe9RMl1Hg0RfS0dvLLLQNn/o1X12VxSZ5J1KmfGot6ZT1Ga4K0Msq7pXcr2yrJ3t
 MnnES2BRldX+ECDbyEwxOnSvX2Nae1FDDFqmn2UtXOhJsqE500/T2psWnqr4k0H60WRP
 pqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=soh8pOn1T1DcxTY1XPnZj9TZgDqYse0vYVofp5N1pk0=;
 b=UL5eJDHrTfWBSumW6aOQm04YAPGn2CnBd9xiXF40umF+U1qU7O8dovZj6BIXyHb81q
 b/ynpgOGdS5yA9dSNWe6BxPfyzPDKJhsYGsGEd6xyar/haQwYie/zXF+aT/uZkuv3nvb
 cOI11T+CIxIWQsmKfPccV8J7NjN9WKC+XZGorwCT/rfrLu3CBu3TUsY5MOIn2lSHQ/SS
 Hd1OVyM+WasxJb9n89CDtGkSXJx4NaM5TY52oK8GwZoaoJ5d4AcwxUBT0LIik8eFfojX
 RvxvdLAwjbN7o5LusId0xv9jKlA+6Iqs1CYucOLeGKys0ICDC8o0iRM8DbWeL7IdLwKI
 B1Sw==
X-Gm-Message-State: AOAM532JQX9R4TvBNOJFoyVwKElpS2HfYHS2vLnPyNVWgjYpXOCjARb3
 l3EJreD4UZK1UbEWHf+G2n9cVNtuQ2gzL5xTnt8=
X-Google-Smtp-Source: ABdhPJxlTOWVyx5I+HBNBTVKPsK8MScCcBl7MtldcLXaXJhx7OQ6Ilrry7lRtrPDpA3Jl8x2fC8hKfH8JztSg/b3AiM=
X-Received: by 2002:a9d:1293:: with SMTP id g19mr3821708otg.311.1611948424891; 
 Fri, 29 Jan 2021 11:27:04 -0800 (PST)
MIME-Version: 1.0
References: <1611823774-20749-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611823774-20749-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Jan 2021 14:26:53 -0500
Message-ID: <CADnq5_NhUzGDff0xE4nH2mvvE8BwcbGXAUgqu7B4trbdwj1eng@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Simplify bool conversion
To: Abaci Team <abaci-bugfix@linux.alibaba.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 28, 2021 at 2:45 PM Abaci Team
<abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:3137:35-40:
> WARNING: conversion to bool not needed here
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Yang Li <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 017b67b8..fc03d91 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3134,7 +3134,7 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
>
>         pipe_ctx->stream_res.opp->funcs->opp_program_stereo(
>                 pipe_ctx->stream_res.opp,
> -               flags.PROGRAM_STEREO == 1 ? true:false,
> +               flags.PROGRAM_STEREO == 1,
>                 &stream->timing);
>
>         pipe_ctx->stream_res.tg->funcs->program_stereo(
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
