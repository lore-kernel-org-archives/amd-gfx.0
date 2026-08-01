Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3389C55172
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Aug 2026 10:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E057010E2FE;
	Sat,  1 Aug 2026 10:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLiR0l+o";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A579410E2FE
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Aug 2026 10:17:17 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7e6b554044fso1604352a34.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 01 Aug 2026 03:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785579437; cv=none;
 d=google.com; s=arc-20260327;
 b=E2wWnfFNtKGwwTu0vtpxB684JYd+TJtGXCjDD2mC5VoLocsKDwTm9X5YW0cKao2Qt0
 mofPVLRqPgkpYO0oaAyG27ytknmUcEMIL7f7iJjFmL4uUVqQrRAvw9pFdfiJgijDnqvj
 GBtNYCANrm7F+i+7vaHyr9Ifp8CR5SnlxI8+5hAK4m6dJY8/Vfin8fXafcR/NJ/xQzCo
 XBQmsFPYCXxLgQFChBCJcJMCaRJWOsj4ms4l9lYHpT6dEQfsBLqUVHggPWrLxCeUXzhZ
 2pU/HhMpnz8w7qSzbid/7EjJowBAfZpLS1rNlN4OsaGsuW7AokQuMhXzQEkjoDwstRj5
 jxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
 fh=GwzrV6RZiHe1SwXwgk+oTgA//qFk4T1UC2oLgq5M3Nw=;
 b=MK6epW23h2XCPPXrzs44YANgVPJJilfhopJiCh5cteCnzLwrimdxCwFDIWGHrg2v+W
 K5y+xp8nffYhGKX2dgJDbHvWr//4HM3iHXNxAIUYmaqtnG6oFCLeGKI88F3yB1D4DFht
 URdnfvrPz/tkHqJpT/7uHDgQ5EwUdpNA1FRMax+XNjezg3ZH9l7CUUTJQFmXkJuXvov9
 VYOCp3SSlQXufLb0Q8CJupyZi5dLHe/pevyOS5DlmUKUYo3fUo95TuqU70ASYp1F/19L
 x030mTLsxRTYi6RampVGRd4MXdMJ1IVw57O5vLjwZjX7gwPufDUyshHqq7wbYtKL860B
 xDbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785579437; x=1786184237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
 b=PLiR0l+oTjCWRnKb/zXLuWxoWFCsp14sQX6MaJ1DHqk0i8GpKTj5Qao34LU9ZUwMwp
 tx3zx0bq5/ZBruBQkXI2RswpAgxRbqce04i1nFspk8wne8fscNwvxtNkiSsPd8ljo04+
 dmSSG6qS8K5JNS8AcrGEVPblJyxzFAb5Bty+kslx+uvdvEasqyPdq0jVUx/b9pt5pPgO
 Ege7Lf3RM2kMc+2WwJ5X9qhWSYYYS841sHPZpStGc4JwVtTZDA5TQ6e0XlQVZSqKWDdD
 iQy8V9c45wY7PLKVgRi7OWx6esja4UnQ+qb7YmZ1HJZk52haZ24kQrkT8WY5empf0xf/
 yuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785579437; x=1786184237;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6SVVCVf5N1O+YrNArJsl/K5UcjWXbA/FoyoLNaVP5k8=;
 b=pBesA7uLquQ1wHJ8/fFcQjAIhMj5cXRDxft8ic0zOezx/jBA+zzoGlLYXr+0slx/p4
 U3imi0H2mN7pMFhEcBqnP09CVb3DzhMmjLvwt+ypbADZIeW8cv0REUENdqcxaT97+Fgv
 qVouji0JQC0CdYwMOEZePYJ534gGJXJ4tWTXEz/C0QfBMTcEayd0OJNIZd3PANXDuVNs
 /NhhPw3yw/n2jQiUtW655owHzbJ0z2HY4STRVTrJeUG0gd5MMOtA8LXgSvkGm2FTvjuZ
 BlvaC5z4hQFIwxvQpHq2bWfUsbXC3dweBvaY+he26e/u03P2DWYPG/yPNTPdlVkaC3kZ
 1REQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn02nuzF8AaeGe0409+ae9TmpmwSFZ7CJzplc4tR8zuO55pa+GtJXLksp5ZKsSPAApKt0rUUrZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj7zGlGY/S3uasq1IpMAnIx1NXuNFYiKIX0mq4fCRxbYMLg8L7
 o/n6ntIl7+/79uwn2M8vOEFOGyW5ZasUdPhzxyRynSIEoFPNS04ekfRIWqea8ZuDTQPq0+J6ljR
 OW3rwolF3MGHdF/LT6zlJrHXeTAO23cs=
X-Gm-Gg: AR+sD12cog4jdYfQp0bxvAGAE8+qvXAuBViYtvsycr4LzoHfPNpFsUdLj41998kDh8s
 Z/QWeQG8dVAydWTTgKpGxb7YBhXO6vN1WyMFa6xPuj2zhWzMaa2/461moZwEbMvGbVp4UeMy2qi
 IxuSiAYJuGMhIuzOnmwtAHHM8y7oSPz0HvyClWhfACMbSomDh5yfMuSUMG6pSAmqxeSy0kjsnd0
 hHGr9SzZex7LTc4LES8wSUimzrS41jcIFRTl9vrtdCr1PWt6xYps++u2x+nriPpDhICaOczGSh+
 mWZVWYKuYBc1rY3owbyiWW1N+4IglLcDoxrcH2sNVKftEw==
X-Received: by 2002:a05:6830:64c8:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7f196d407e0mr6475364a34.5.1785579436652; Sat, 01 Aug 2026
 03:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <df5f0d9bb8f11d098f086bd2ace5aa0cef4c77d7.camel@web.de>
 <20260801071724.12998-1-spasswolf@web.de>
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 1 Aug 2026 15:17:04 +0500
X-Gm-Features: AUfX_mySPDS1tX6sBksLt_ubqUTn6yupd7v5vPVdQi51p4TGShRSsHENrQ2zzec
Message-ID: <CABXGCsMFa25HyOdcSX8QR8_=58=uJT+HMVhyus=rOFHBML25=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,
 END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
 "# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Aug 1, 2026 at 12:17=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
>  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED()=
.
> Also fix the error path in dc_create_stream_for_sink().
>
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - P=
art 1")
> Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de=
/
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index cdcf140bc1bb..accad9e20e88 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -229,7 +229,7 @@ struct dc_stream_state *dc_create_stream_for_sink(
>
>  fail:
>         if (stream)
> -               kfree(stream);
> +               DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
>
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_sta=
te, const struct dc_plane
>   ***********************************************************************=
*******/
>  struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
>  {
> -       struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
> -                                                         GFP_ATOMIC);
> +       struct dc_plane_state *plane_state;
> +       DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D kvzalloc_obj(*plan=
e_state, GFP_ATOMIC));


This hunk breaks the build when CONFIG_DRM_AMD_DC_FP=3Dn.

dc_surface.c gets DC_RUN_WITH_PREEMPTION_ENABLED only indirectly, via
dc.h -> dc_types.h -> os_types.h, and there the include is guarded:

#if defined(CONFIG_DRM_AMD_DC_FP)
#include "amdgpu_dm/dc_fpu.h"
#endif

With DC_FP=3Dn nothing defines the macro in that file.  dc_stream.c is not
affected because it includes dc_fpu.h directly.

This is not only exotic architectures: DRM_AMD_DC has

select DRM_AMD_DC_FP if ARCH_HAS_KERNEL_FPU_SUPPORT && \
!(CC_IS_CLANG && (ARM64 || LOONGARCH || RISCV))

so an arm64 clang build is enough.  On amd-staging-drm-next with your
patch applied:

  $ make LLVM=3D1 ARCH=3Darm64 allmodconfig
  $ make LLVM=3D1 ARCH=3Darm64 drivers/gpu/drm/amd/amdgpu/
  dc_surface.c:89:2: error: call to undeclared function
    'DC_RUN_WITH_PREEMPTION_ENABLED'; ISO C99 and later do not support
    implicit function declarations [-Wimplicit-function-declaration]
     89 |  DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
kvzalloc_obj(*plane_state, GFP_ATOMIC));

A plain x86_64 build (DC_FP=3Dy) is clean, which is presumably why it did
not show up for you.

Adding

#include "dc_fpu.h"

to dc_surface.c fixes it, and matches what dc_stream.c already does.
Please do not copy the local fallback that sits below that include in
dc_stream.c:

#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
#endif

It is dead code there - dc_fpu.h defines the macro in every branch - and
in a new file it would compile cleanly while quietly doing nothing.

One unrelated note: you kept Cc: stable # v7.1, but this version is
rebased onto next-20260729, where the update_scratch allocation is gone
from dc_create_stream_for_sink().  It does not apply to current mainline
either, so older trees will need a separate backport - worth saying so
in the commit message.

With the include added I can give this a Tested-by on dcn32 (RX 7900
XTX), which exercises the DML1 phantom-plane path rather than the dml21
one you hit.

--=20
Best Regards,
Mikhail Gavrilov.
