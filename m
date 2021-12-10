Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A57C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8284410E328;
	Fri, 10 Dec 2021 23:09:56 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CB710E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:09:56 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 x3-20020a05683000c300b0057a5318c517so11089407oto.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1/ZLyQ+TJQmZrKTkGtfn4p04ePiEY6i7dKWp5z3zbj0=;
 b=WjEFxG1U/G6X8pos33sDQcH1sE25NgKZYXAvPd5BBN2oNPyf2kku2S2E642U92quiT
 Riz23pnR8hX58CG6N7FqC/ARI4FEq4D2IIFy53koaHSTFAnYJdiCCM/jwEH2rKcsZnr1
 oVeHoZ95zbSzTiucsXaKIhlThb9SzFeVJTILtEmCLk+pvwCEE9CgsatGp4HJ10DDeBxp
 BPPxc4Qs2q03imv3z3simIcNCyPkXY0GhG5Pk7lVkENSITaOd/VdWKiPzmULPVBPQ0DG
 PI+07Uw7aDaQBsfcyDTwnPH8CoMuEJrSQVnC2F3Sr+VCoBzQE6CHGRFJCmKbIf7BIQXq
 hAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1/ZLyQ+TJQmZrKTkGtfn4p04ePiEY6i7dKWp5z3zbj0=;
 b=oUlCjOQbwWNxFX0owvMG2eFtHSiuDhfcj7RaJOcGgnG6AGGLiUmxDn7bIdWrnmryQU
 y9DK6sKZiHiEStn5V0opkyTIlkkkrliqCOlrDAa6DpRW8dEGdZ2An9sNgp8aPlc3/4+L
 nYI3rQbTDJOQqbE/ouirXttNJy97VBO8FPFCdauIdyqYMboDENkcmT1itVMr03XC8bB3
 smv6kmkyjN8l5pq2nky1Pp6bs1Pe2LlOAmrf+pV9pzGGNwHPgxhQEq4cQzQ+ql/DAjFX
 uYZrzzSwvuCmbhwUqhyG2nryaHOHdQ1X2oKIDjk4fDwTOPN/IjdXW/HaGKQ0TiKjmYB8
 X1Gg==
X-Gm-Message-State: AOAM5309SJBNV4isDLYExIUig0EZRwygWB3EqGUKX8eIEMi8Bww4mAgC
 QTSTlUsOMQIfAdW/kL07B6Ce2DTMOU/GVw3NzJM=
X-Google-Smtp-Source: ABdhPJxK+JQa3OqaIi+5mGXys76LxMEu0zbh0zBrOb/qngcazaoNNy347mR4pgjIO/QZze1tK2zJAlAQE5d4ocNxUqc=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr13727505otn.299.1639177795599; 
 Fri, 10 Dec 2021 15:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20211209154722.4018279-1-isabbasso@riseup.net>
 <20211209154722.4018279-5-isabbasso@riseup.net>
In-Reply-To: <20211209154722.4018279-5-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Dec 2021 18:09:44 -0500
Message-ID: <CADnq5_NveF8-GBQOJzEnrOQt5eXFF3zSDUeVCJ7UH7dcNGpyQw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] drm/amdgpu: re-format file header comments
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Dec 9, 2021 at 12:02 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
> Fix the warning below:
>
>  warning: Cannot understand  * \file amdgpu_ioc32.c
>  on line 2 - I thought it was a doc line
>
> Changes since v1:
> - As suggested by Alexander Deucher:
>   1. Reduce diff to minimum as this DOC section doesn't provide much
>      value.
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> index 5cf142e849bb..a7efca6354b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file amdgpu_ioc32.c
>   *
>   * 32-bit ioctl compatibility routines for the AMDGPU DRM.
> --
> 2.34.1
>
