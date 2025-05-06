Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A6C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C355D10E6D7;
	Tue,  6 May 2025 15:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XCbPCmkm";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E508B10E6D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:18:41 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-309e54e469cso342659a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 May 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746544721; x=1747149521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2inp0+XC+fk+tK3keTYobhojil3MkPJV1ltn4W2eQjw=;
 b=XCbPCmkml1vtlEbvce1ZQUJTfjaqkBnV3F8evwY5OoF9/49VLq/3qrCm44cE+YLPut
 4x2nbpM9yLfG3xbZhF4KXTrE5U0wJLyPdHeriDaxaibsDybt0WSzrSWGBrtqulJDRv43
 DKNDcOIyytalkujup5EGW1fMrGqTpckuk32i3/JTTV/Nxlq/7ChNLEMIfOmEyAeLXyyC
 R5md/Pmuj7V5xX8uNGoVyoINP0CAVuGOeNkx9Qhbm1ZI8nOktdzPVK5H7iMdEiIFz266
 mryXOBZv/UXb0AAaUmt7HC8D9IfHYrRs7qHV4+uI4SoN5iyuNf7ns9/Vhet0kqJ0dQpd
 eGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746544721; x=1747149521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2inp0+XC+fk+tK3keTYobhojil3MkPJV1ltn4W2eQjw=;
 b=qsKLHbYalun95eeMvr60tTbJcHhu8rjN6dnnI1CDHvgZmh6+MdQwoCDE4IA+NZ35+w
 iJe9NFj7+k+ZeJaTB903xBcGvxYIo0iNC1UL6k6vQeGOmnmWe42ypjQqz9XEM1Czle1C
 ynwm+q8+zZpN+2I/gaa5nJysoJRtZ7QqbDLChlZ6O6Bld5H1QmnzsQDdhx+A0WOD4jeC
 IjlIg74ku9VxFDK7r1s0MxDl3kVUkHyjT5Ik/4MUUia69G260uorRcFSJHD0Bx9Wjd3k
 zoBIsgPgq/BNa/V7J4Te8lZ2iP2nD/Gfpkvz+hKQhLI1jpchiJ17mYiklo1o1l6tskoJ
 lvqA==
X-Gm-Message-State: AOJu0YznJldpDsNOxwuK5OK/7DEu1QYvjFLT5+KwppRH0gjFS+kWZeES
 sJ2wDO+jwbv1zVJEbqccblYPv/Gazd2WnPm6VGTAdWrufXPOzrAu8ybyAa3Buv6XKrLljPCCQNO
 hSujhk9VL0QkIk2xJ9hoyJe8ejeZ9ag==
X-Gm-Gg: ASbGnctgwu4mvTM3uegOTAdw2hWM8q55CtzLr6+m9LLB1M6eq6KRD7OrUA4lexKyZ9h
 9drCrjzF1paWKMOU/t9C6AWn4KQMzsEdepPk/q0TOvm6tFhmu51dRg49j9E1MyfaUwjjB1fkDCM
 IbTVBudJA9s0rw4YQurAHa+A==
X-Google-Smtp-Source: AGHT+IEKfO8D478UOc5LDfEUj0yqG/wULPHk5cLj5AqXDcPYGkDtwS4VjALnbfNyRTDnI4iY+ypmGeTCNdK5W7/xpHk=
X-Received: by 2002:a17:90b:350e:b0:306:b593:4551 with SMTP id
 98e67ed59e1d1-30a4e689b33mr9637967a91.6.1746544721457; Tue, 06 May 2025
 08:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250429134739.1523228-1-alexander.deucher@amd.com>
In-Reply-To: <20250429134739.1523228-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:18:29 -0400
X-Gm-Features: ATxdqUEJN5JMoPB_FuoIz_7yO_OYmQP-NcYB2-TVoXd3kdvaQ1CglPeBdbP0pxE
Message-ID: <CADnq5_NTU4P4cds4_eN_ENDPjjHOnjg=cyovQM+QSW8Pysuvbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

Alex

On Tue, Apr 29, 2025 at 9:58=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This is an optional TA which is only available on
> certain embedded systems.  Mark it as optional to avoid
> user confusion.  This mirrors what we already do for
> other optional TAs.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4181
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index d54bb13772622..1c843b888475e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2214,7 +2214,8 @@ static int psp_securedisplay_initialize(struct psp_=
context *psp)
>
>         if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
>             !psp->securedisplay_context.context.bin_desc.start_addr) {
> -               dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta=
 ucode is not available\n");
> +               dev_info(psp->adev->dev,
> +                        "SECUREDISPLAY: optional securedisplay ta ucode =
is not available\n");
>                 return 0;
>         }
>
> --
> 2.49.0
>
