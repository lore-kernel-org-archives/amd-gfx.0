Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCDBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BDC60FC0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12BDC60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBE389803;
	Thu, 30 Sep 2021 14:12:01 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CABA89803
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:12:00 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id u22so7423976oie.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=un67s0+UogBGJNSkuPfni5Dlt5mijLUjBDTjBsLAn/c=;
 b=MoHiWw7d+e5Ho7Pf7xkw1hUAuiEAJyTOFWAjGWFR6bblzSKvg1erMTUsL5WAsX6gej
 jB++HekHEdEgEl8h7pcTW5ojjF7rWGOIM/wxC7mCuu+fWZJ9EDc9APwxliySj3fIGZcZ
 RQvchJqQ8qz0+CCcZ84Am2Zph8vT/pucI7SiD6kDuc6s4UxkAO6zuklGLk/0fyPF+13k
 XzVJn7Fepr7TJ7pBQo0DmFDGBTIjEPQ7PCMMVVT/GRRR4xLfmjYOcXsp/urO5hmN6pzc
 NzkD7ZOQFItK09/ppvtUDUwQMOLZBax9GVV7Ghc4wav1o1jI77xc9HkAj6REWKYn8nSo
 x4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=un67s0+UogBGJNSkuPfni5Dlt5mijLUjBDTjBsLAn/c=;
 b=CdANuV3KVlVMhdX7A90+hjJSJ1YACjt8+ffvlKy4tQOPkYE7zbzbuv7DBnZbBGneAl
 CKsObial/dtt1ujlNGSiLjWEDG1DqUybQqs9cgTg7UGnK4CHPJdvZJy6wPgWEDKGZGej
 HtBY5h6Kt+gxxAPudIcSULglHTbMbarIv/Un0TnYA7zeKEZxy/HzIVIc9ks+37uY0JDb
 KAcl5JNyVrFjI77V2F5DGAeQ9qL1+RE4KYxRGslih28FSIaqPSOwvvSHjTEVYUHARlfL
 y1AYVisdE+imx1kX/NOB1bHAPIpe34/USIrqkgI0dCCDTMapbpjSS9DbCbRs2yogU65y
 4OGA==
X-Gm-Message-State: AOAM530O0ao4zYlRCuJdMNCM15lEChRJYbKFrTfjURMsWYemII4aDjR3
 9nEqzV5q+irAFVq7zwyR7X79ZxLVuiRKQSDkWxRbh5g2
X-Google-Smtp-Source: ABdhPJzwuh1KiZ8RRgvHFsRanuiX/Oz2159pwcp2LZo63fXkGTebQi5xKTcPFS+/UNDkFKaar4V+ZFPSeMKsYUqQ/4w=
X-Received: by 2002:aca:706:: with SMTP id 6mr2944398oih.5.1633011119752; Thu,
 30 Sep 2021 07:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210930140227.64818-1-harry.wentland@amd.com>
In-Reply-To: <20210930140227.64818-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 10:11:48 -0400
Message-ID: <CADnq5_OLVho6EHMoz-+-W4iGh2kz5EZAKHCsouTjcnXMH9SL_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Don't use mpreferred-stack-boundary for
 clang on DCN201
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Zhan Liu <Zhan.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Thu, Sep 30, 2021 at 10:02 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> We were erroneously setting IS_OLD_GCC for clang since we didn't
> check first whether we're doing a GCC build.
>
> See dcn30/Makefile for reference.
>
> Fixes: 4ac93fa0ec12 ("drm/amd/display: add cyan_skillfish display support")
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index d98d69705117..f68038ceb1b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -14,9 +14,12 @@ ifdef CONFIG_PPC64
>  CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
>  endif
>
> +ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
> +endif
>
>  ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
> --
> 2.33.0
>
