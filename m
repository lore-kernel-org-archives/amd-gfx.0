Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A99C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C77310E1ED;
	Thu,  6 Mar 2025 15:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RZU+8gcO";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BFB10E20F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:19:44 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so210822a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 07:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741274384; x=1741879184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEHNmhNkvIrrDFsmliGoxCfSM1PFcCxYWqi6XI8LSUc=;
 b=RZU+8gcO4g1RDu3nFXsNR3kpQumnO3uOneF1O3n5VH0IzndAebbdESsGogXbtgJrvC
 MNSmPjp6xjapig79QuKlYZ5j3GskxOvDGT+Meb8wMmWaqgYA8Pe4gwg+k3HkPdhlIQ04
 cwWs+HeKbrhrsCHHhRenCGZa1FY2ZjbNwvTvKUvYWEcb+VyzEKpAKtLUiCkyzsMZ490C
 XeX1kLau9yjEis9HYPwLDRutos1ICL3zkeDRoPqAi6wE2Rjq1yqFzKiV7loudBkCdCsi
 lZUCgxN2YwgELrBSV/fJhRX7S4gzh2LHGfllupy2Rn2E3QCPmsjc+avsbnAQz2xw0NXG
 j57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741274384; x=1741879184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEHNmhNkvIrrDFsmliGoxCfSM1PFcCxYWqi6XI8LSUc=;
 b=evL8wMZftRCtZkiOqvzrE98dl2BhJLbRU/RYtESFkDPnHjQ3WQ4Nj3wQlONEvHJRBb
 P1ltx1MCRl8N0ZdAcVjCcbF6Q6B4jTN9gWbDmuh2ixAOZ3x7ecpPNe4OrwXmkkiWXeWT
 thmSFiWwCD1zoxpu+ogOmYSuyrA5nwSXKlZ+lzvWbGQc/NzA+nagNt9ryJrwPw8tOAJx
 1597kZmrXcngJxuRDlR3cJJCDZp8kZmAtMvJImI3KF365x3VJM86E5IGYUocVh+ai8Do
 cum9jmgUTL9febAx5JCCPCU44wWC1LXAruWwjjYVPYrjInHMlpeRdqhx8usYoUIXjxot
 4JnQ==
X-Gm-Message-State: AOJu0YyvN73YpYW1rHdb+ktMrdYYb1c6S7PQm3CALc9LMtttTZ7wYWKe
 +3SKtqgJoeS9XqtRdWH7AbUpv+U1jKA44orSqenOXN/OjKfv3OMhjEmpE8SKRvup1yvXJFr56ax
 DM/Rwxnoz0AlzUfKFXk2llB/hvJIM0g==
X-Gm-Gg: ASbGncv+nIdtVzLuROFhCRUigAPL147mRQmTyx00gqBqI39vK/pE3ghfp1fMhQdlxkV
 I8SO61tJMSfo0VYP6X8ByMGPJqMYZXSnIx6OjXmsrnQy1LMgZQqnTTU0eVGuKxYdMX0X53/5IUi
 xDv8y4iTFI3I9Nl06GxAjLNFX0mw==
X-Google-Smtp-Source: AGHT+IGNCCgI5U5X6iErquItcNz33VRkA4sECKZLr4lFZBNqoXhe8dnqqWMEWy8JnkYY4g97LueD4cvyQbkEzIojq5A=
X-Received: by 2002:a17:90b:4f8d:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-2ff7970d32cmr222877a91.5.1741274384057; Thu, 06 Mar 2025
 07:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
 <20250306014958.785021-2-alexandre.f.demers@gmail.com>
In-Reply-To: <20250306014958.785021-2-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 10:19:32 -0500
X-Gm-Features: AQ5f1JpNYKnk6f0ApSturzNZaWvnYgwu4lt4VNmQ1Cyb-YDobNUnzhDDvj-c1nI
Message-ID: <CADnq5_O65aDEgaVkzZ1xZyqEgqHr4nR1WDWPJ94jKRtu629o9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: add or move defines for DCE6 in sid.h
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

On Wed, Mar 5, 2025 at 9:08=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> For coherence with DCE8 et DCE10, add or move some values under sid.h.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>

This change doesn't build.  Please adjust the order of the patches as
needed to make sure they all build.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
>  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
>  3 files changed, 55 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index a72fd7220081..185401d66961 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -32,6 +32,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_pm.h"
>  #include "amdgpu_i2c.h"
> +#include "sid.h"
>  #include "atom.h"
>  #include "amdgpu_atombios.h"
>  #include "atombios_crtc.h"
> @@ -59,31 +60,31 @@ static void dce_v6_0_set_irq_funcs(struct amdgpu_devi=
ce *adev);
>
>  static const u32 crtc_offsets[6] =3D
>  {
> -       SI_CRTC0_REGISTER_OFFSET,
> -       SI_CRTC1_REGISTER_OFFSET,
> -       SI_CRTC2_REGISTER_OFFSET,
> -       SI_CRTC3_REGISTER_OFFSET,
> -       SI_CRTC4_REGISTER_OFFSET,
> -       SI_CRTC5_REGISTER_OFFSET
> +       CRTC0_REGISTER_OFFSET,
> +       CRTC1_REGISTER_OFFSET,
> +       CRTC2_REGISTER_OFFSET,
> +       CRTC3_REGISTER_OFFSET,
> +       CRTC4_REGISTER_OFFSET,
> +       CRTC5_REGISTER_OFFSET
>  };
>
>  static const u32 hpd_offsets[] =3D
>  {
> -       mmDC_HPD1_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD2_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD3_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD4_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD5_INT_STATUS - mmDC_HPD1_INT_STATUS,
> -       mmDC_HPD6_INT_STATUS - mmDC_HPD1_INT_STATUS,
> +       HPD0_REGISTER_OFFSET,
> +       HPD1_REGISTER_OFFSET,
> +       HPD2_REGISTER_OFFSET,
> +       HPD3_REGISTER_OFFSET,
> +       HPD4_REGISTER_OFFSET,
> +       HPD5_REGISTER_OFFSET
>  };
>
>  static const uint32_t dig_offsets[] =3D {
> -       SI_CRTC0_REGISTER_OFFSET,
> -       SI_CRTC1_REGISTER_OFFSET,
> -       SI_CRTC2_REGISTER_OFFSET,
> -       SI_CRTC3_REGISTER_OFFSET,
> -       SI_CRTC4_REGISTER_OFFSET,
> -       SI_CRTC5_REGISTER_OFFSET,
> +       CRTC0_REGISTER_OFFSET,
> +       CRTC1_REGISTER_OFFSET,
> +       CRTC2_REGISTER_OFFSET,
> +       CRTC3_REGISTER_OFFSET,
> +       CRTC4_REGISTER_OFFSET,
> +       CRTC5_REGISTER_OFFSET,
>         (0x13830 - 0x7030) >> 2,
>  };
>
> @@ -1359,13 +1360,13 @@ static void dce_v6_0_audio_enable(struct amdgpu_d=
evice *adev,
>
>  static const u32 pin_offsets[7] =3D
>  {
> -       (0x1780 - 0x1780),
> -       (0x1786 - 0x1780),
> -       (0x178c - 0x1780),
> -       (0x1792 - 0x1780),
> -       (0x1798 - 0x1780),
> -       (0x179d - 0x1780),
> -       (0x17a4 - 0x1780),
> +       AUD0_REGISTER_OFFSET,
> +       AUD1_REGISTER_OFFSET,
> +       AUD2_REGISTER_OFFSET,
> +       AUD3_REGISTER_OFFSET,
> +       AUD4_REGISTER_OFFSET,
> +       AUD5_REGISTER_OFFSET,
> +       AUD6_REGISTER_OFFSET,
>  };
>
>  static int dce_v6_0_audio_init(struct amdgpu_device *adev)
> @@ -2876,22 +2877,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_st=
ate(struct amdgpu_device *adev,
>
>         switch (crtc) {
>         case 0:
> -               reg_block =3D SI_CRTC0_REGISTER_OFFSET;
> +               reg_block =3D CRTC0_REGISTER_OFFSET;
>                 break;
>         case 1:
> -               reg_block =3D SI_CRTC1_REGISTER_OFFSET;
> +               reg_block =3D CRTC1_REGISTER_OFFSET;
>                 break;
>         case 2:
> -               reg_block =3D SI_CRTC2_REGISTER_OFFSET;
> +               reg_block =3D CRTC2_REGISTER_OFFSET;
>                 break;
>         case 3:
> -               reg_block =3D SI_CRTC3_REGISTER_OFFSET;
> +               reg_block =3D CRTC3_REGISTER_OFFSET;
>                 break;
>         case 4:
> -               reg_block =3D SI_CRTC4_REGISTER_OFFSET;
> +               reg_block =3D CRTC4_REGISTER_OFFSET;
>                 break;
>         case 5:
> -               reg_block =3D SI_CRTC5_REGISTER_OFFSET;
> +               reg_block =3D CRTC5_REGISTER_OFFSET;
>                 break;
>         default:
>                 DRM_DEBUG("invalid crtc %d\n", crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/=
amdgpu/si_enums.h
> index 4e935baa7b91..cdf8eebaa392 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
> +++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
> @@ -121,13 +121,6 @@
>  #define CURSOR_UPDATE_LOCK             (1 << 16)
>  #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
>
> -#define SI_CRTC0_REGISTER_OFFSET                0
> -#define SI_CRTC1_REGISTER_OFFSET                0x300
> -#define SI_CRTC2_REGISTER_OFFSET                0x2600
> -#define SI_CRTC3_REGISTER_OFFSET                0x2900
> -#define SI_CRTC4_REGISTER_OFFSET                0x2c00
> -#define SI_CRTC5_REGISTER_OFFSET                0x2f00
> -
>  #define DMA0_REGISTER_OFFSET 0x000
>  #define DMA1_REGISTER_OFFSET 0x200
>  #define ES_AND_GS_AUTO       3
> diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgp=
u/sid.h
> index 9a39cbfe6db9..32a4e7d450c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sid.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sid.h
> @@ -1991,12 +1991,29 @@
>
>  //#dce stupp
>  /* display controller offsets used for crtc/cur/lut/grph/viewport/etc. *=
/
> -#define SI_CRTC0_REGISTER_OFFSET                0 //(0x6df0 - 0x6df0)/4
> -#define SI_CRTC1_REGISTER_OFFSET                0x300 //(0x79f0 - 0x6df0=
)/4
> -#define SI_CRTC2_REGISTER_OFFSET                0x2600 //(0x105f0 - 0x6d=
f0)/4
> -#define SI_CRTC3_REGISTER_OFFSET                0x2900 //(0x111f0 - 0x6d=
f0)/4
> -#define SI_CRTC4_REGISTER_OFFSET                0x2c00 //(0x11df0 - 0x6d=
f0)/4
> -#define SI_CRTC5_REGISTER_OFFSET                0x2f00 //(0x129f0 - 0x6d=
f0)/4
> +#define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6df=
0 - 0x6df0)/4
> +#define CRTC1_REGISTER_OFFSET                 (0x1e7c - 0x1b7c) //(0x79f=
0 - 0x6df0)/4
> +#define CRTC2_REGISTER_OFFSET                 (0x417c - 0x1b7c) //(0x105=
f0 - 0x6df0)/4
> +#define CRTC3_REGISTER_OFFSET                 (0x447c - 0x1b7c) //(0x111=
f0 - 0x6df0)/4
> +#define CRTC4_REGISTER_OFFSET                 (0x477c - 0x1b7c) //(0x11d=
f0 - 0x6df0)/4
> +#define CRTC5_REGISTER_OFFSET                 (0x4a7c - 0x1b7c) //(0x129=
f0 - 0x6df0)/4
> +
> +/* hpd instance offsets */
> +#define HPD0_REGISTER_OFFSET                 (0x1807 - 0x1807)
> +#define HPD1_REGISTER_OFFSET                 (0x180a - 0x1807)
> +#define HPD2_REGISTER_OFFSET                 (0x180d - 0x1807)
> +#define HPD3_REGISTER_OFFSET                 (0x1810 - 0x1807)
> +#define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
> +#define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
> +
> +/* audio endpt instance offsets */
> +#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
> +#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
> +#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
> +#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
> +#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
> +#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
> +#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
>
>  #define CURSOR_WIDTH 64
>  #define CURSOR_HEIGHT 64
> --
> 2.48.1
>
