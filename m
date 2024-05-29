Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0990AC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 18:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C5F10E174;
	Wed, 29 May 2024 18:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kv+JHQY6";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B099F10EBEC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 18:07:59 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1f3469382f2so281225ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717006079; x=1717610879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Genr20yzaxeYNboJE0O8kmUsykG0eEI5mPQ7YJDNgE=;
 b=kv+JHQY6QNIwvHyOsVkPfxu/cotM5tBCg0ViHC9dtB7Gq+y8xKgAXv5ZA2VvNnuDxJ
 MFr93kGD+tfUW+6DBZ86I/cNw0lvt4iPP/YZF28pl07k09/QnK6oKDxbp0ZaqfLCTGqV
 0dJUzbm8qtLI/BO9OuKSjS62QJSoeTIjAZNyaNkARtvj04G9FvZFUk3+kn3kaSIuWCNg
 hhVwwgxkQ7UBu1MeNMZ4GiuUOv1szNRyPuCybbPBtQ5hLjAYw08OMIokeSczwaRFmzUv
 sU39FvQa8hKGxWokPXq/ofxFxpzIPgrzuEhEcgCcFaNabpLwgNevGRgG7cjreQvWNL46
 aZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717006079; x=1717610879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Genr20yzaxeYNboJE0O8kmUsykG0eEI5mPQ7YJDNgE=;
 b=sS9RTn+U270g2OEbio7tOJyANahA9JYw9uNxt/AyVyyxrG2bYouMmxyPAHZM5WvsdX
 bcotumAL2g6lIrZyUInyleK16eFmaADdOTG64Zk6RKYCenEi985fvciKHho39AVS+zH6
 5rngygEywYBqZfNLf2MnF5cF4hp/WAqhNXpsYKMH4UY8IhcATnX0KCqGimeBktHBfThX
 DBnPkxC6IDuruA2JFG5FGP6VfC5EP5tiolCsh0Q/gSAej6G7xDWY8LhhavB6Kl93S70T
 Qa3KdUYFm6pGdb/MrQqwE7HItintSlyOQR/4YCBILbBKk714o325GdXsq1j8xWP295ch
 jmfw==
X-Gm-Message-State: AOJu0YzEFfoqJCjq8dNlL2GXYGunHSFDKNoHlZ5Ua/y6GkKULgduMhwW
 6AeIj7+762R95P2IiH4rLvfaJOQc+sB/cLpRTcDhxh+4I7Dn8eYdPb89Vqd6VeMZZ9ynwflk+3o
 nXfl/syOlkVV5L+SLVAw1k0+p6BXvEQ==
X-Google-Smtp-Source: AGHT+IEL6P/nouTNaxARbZKmb/Xb7MLGRunwxP/uH8U+JbyzuO45FCB4pl0VMh6HEw2VnlxITin+uzGX3dlPBf0/bD4=
X-Received: by 2002:a17:902:f68a:b0:1f5:e796:f26b with SMTP id
 d9443c01a7336-1f5e796f806mr21203385ad.1.1717006078776; Wed, 29 May 2024
 11:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240508192345.3688461-1-alexander.deucher@amd.com>
In-Reply-To: <20240508192345.3688461-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 14:07:47 -0400
Message-ID: <CADnq5_M4YA_bV_nR--ZPZA_9c9TWqOJ=AVrBemtq7KfVi8n3kQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc24: use common nbio callback to set remap
 offset
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

On Wed, May 8, 2024 at 3:42=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> This fixes HDP flushes on systems with non-4K pages.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index 12900488dd618..66c7138fc6aa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -372,11 +372,9 @@ static const struct amdgpu_asic_funcs soc24_asic_fun=
cs =3D {
>
>  static int soc24_common_early_init(void *handle)
>  {
> -#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
> -       adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_REG_HOLE_O=
FFSET;
> +       adev->nbio.funcs->set_reg_remap(adev);
>         adev->smc_rreg =3D NULL;
>         adev->smc_wreg =3D NULL;
>         adev->pcie_rreg =3D &amdgpu_device_indirect_rreg;
> --
> 2.45.0
>
