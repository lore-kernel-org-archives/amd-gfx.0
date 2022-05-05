Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6A5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 17:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7209310E761;
	Thu,  5 May 2022 17:11:55 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B649910E761
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 17:11:53 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 h10-20020a056830400a00b00605e92cc450so3320399ots.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 May 2022 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gN2WgKkfBFFDcmt7/onwYflqGGOgHT3rzO2HMuTaBBs=;
 b=Dw7lysJp47xsIxm0ZPVY4t7YiYtZp138XDM4LO3jy1ZdwfKVMRR8zglzpNGsnFNcj6
 Ct6KBp4/4cVmGiSfm6Lt+NFciQ2RhF/GHjFvXcamBSZNBSPkTEYNx9Bfljsod8rt0VcR
 9J6wTbdQDEP8LrYAYkzHS/1e/SDeGwr7yCHAMjczYcbot1MxQb8apnOqo3P6s9NnS06x
 L/PV4xgsXDrumQT3W2q1pNSggL5PXX6bqkF0enZCGDXy1LdXdsO23w1nK33bR3RjCRHQ
 j8/g4uG9kLcBrSq+ASgge2HynpVbuhOYqIHDoIDz1GRCkgQoKLbaR6HJDBr52GVvQou0
 R/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gN2WgKkfBFFDcmt7/onwYflqGGOgHT3rzO2HMuTaBBs=;
 b=01LaGN+JMHBxhPiRYjVLq5rFxPmgJ2aqp2k+WEQUjRKPvKfxKUFruo3TccKC+NAr7m
 d4CwI3dOcXFwTi+Pkg57U9P5UbIFZ3E8l2cxZ9ymIjYVqPyZpf+OeoBCTWnet1kOdTOg
 zjRbWsUZhVaD0gXGc7UP/I1DeBL29dYXk7usi7f3ejSoPc2JlN143z8//sFG7KfKteUA
 TqFTm5H1bIq0wVOqLYjK61B0gUpx+RDa8047H6ANz9ErsEdptkyyle3IIK+yKy02spAl
 34e4nZeFPgsVqaN/aLJqSoa2q2KgyZZt1xWgnn3wkJOREtgE08nOql7kK0xGdZZGNWJr
 1sVg==
X-Gm-Message-State: AOAM531aBvO4xlILsMbuX6BIP6vukK6daPEpLq4LodNLVMxcBdumPMx7
 1Daq6WyHLQVPbHNfuVUf3uPaAcDWFCMbi9R4z0U=
X-Google-Smtp-Source: ABdhPJzO5P6xDhz2xMFfBqyNhhf8bzUVjnP6K9rBGjxULsbgrzth/KyYT2YElsuWQUHV3LqJnqer1uTPmiltQYyEUN4=
X-Received: by 2002:a9d:195:0:b0:605:eb43:5b84 with SMTP id
 e21-20020a9d0195000000b00605eb435b84mr10000669ote.357.1651770713040; Thu, 05
 May 2022 10:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220505164859.21754-1-James.Zhu@amd.com>
In-Reply-To: <20220505164859.21754-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 May 2022 13:11:41 -0400
Message-ID: <CADnq5_MADhhV4OuN7BvrMdDTMVgi5ERu+GGjkP8yREw07RqEtw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fixed compiling error
To: James Zhu <James.Zhu@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 5, 2022 at 12:49 PM James Zhu <James.Zhu@amd.com> wrote:
>
> Fixed compiling error.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index 08fd61622f95..f4f97f0f5c64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -21,7 +21,7 @@
>   *
>   */
>
> -#include "amdgpu_vcn.h"
> +#include "amdgpu.h"
>
>  void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>         u64 seq, uint32_t flags)
> --
> 2.35.1
>
