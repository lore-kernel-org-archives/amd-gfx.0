Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2D8C35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B891310E144;
	Sat, 22 Mar 2025 18:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJaM2pTh";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8368110E144
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:46:13 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-86d377306ddso1369457241.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742669172; x=1743273972; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cku8xQHABUYZorINAvXwDqOzEC6i0JUL/3imDoT6gnI=;
 b=NJaM2pThiqs7Z5lC2HM3oOoJrIZynHZEV4tm3aWNTqyYj59P+o5qhdWVhPtsI8g/oI
 ODfWW4yGqZUtnJCgguJ3cZWDmlW50XsmWo7VlUUty3Gf8EqCinjoM+vkr+PmE5BlZNpV
 kVs0vmVLt72rvq/spCadW5fMy5ilqcWczjt6nKx7ES3JSssr4pGQjifeKBnPcRqLc4Y1
 lXws9o8E4bJrmqXmmnQOvNARZd1ToQOfGknEBfUYB6CACwqm6EJUXx0AGXLxovIP0wwf
 IY18chliCvGqiNIs0j5DH1Z7AhCnzRAhPhXecEb3NZVzXxSuMmyWkiYBNx+1zji6rx67
 jrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742669172; x=1743273972;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cku8xQHABUYZorINAvXwDqOzEC6i0JUL/3imDoT6gnI=;
 b=ZeepyB0jZ3UAMvGshVFdHZHpVlZ7TxbsdS/RjUXUbqtAuBilymnsOaV4hTbUzFh1ui
 zE2HM6tA3hS6muWC5WwZzrDAGFbMLwD6Zxe0DZ/CQuI9jY0FusiN6Vms43asextSVR6B
 G82q1gSi3mnQd8tpJV0aI1vFyA7BW2H5+2E+8XkbTd6pyW0gIqgWx71blup1CDpqUzbU
 KWFjkBu14QHxq/oDEZ8+Q0CfpjF91Dg3CmoIQx6oDEEUoUamrPHnOv2nRco/TYg1bZsa
 0UbNGPFlvXuHdzzdK50GpzThL0NTgY2tjPjOf1UM0KlWY28lntu+GR1Uwij0YeVK8a6M
 hA1Q==
X-Gm-Message-State: AOJu0YyHqznvBjgnyXIob0sHh4tAGplIGDAk8kSohYgEW/z9VDjRzJhX
 0ec3/ugbmDxUlCpg0lSi69uPpCYQIokFbyV63fZutiii5HML6t2kwBNemfyrQLZrw5nR8d0rRoL
 BONgtuiVI+ysHL6lAtf+6lOZ1dha38g==
X-Gm-Gg: ASbGncvjAs71i1w4EYNfC3P6H1mcdopTdDKjF+1BvsDWWRIUgoIipLq7p+6tr+abWGM
 Afww6cJD3dXxwNh3g3jv28kjZke/mOGhGOqg0Th/CMRpu38b0qZJMhO0tF0iWu5NZDDoBf2qYmt
 4woZ5BViUkOswzpC9WRoBBg5ph
X-Google-Smtp-Source: AGHT+IEdEnKLRuUBc5mtMMUQQY/FKH1cfvkvn2joM1xqLI82iEAkc9RvsORIbhxjtSZ0YU+cspsq7SjJnKtW+w7XCaE=
X-Received: by 2002:a05:6102:f8b:b0:4c1:a395:c57b with SMTP id
 ada2fe7eead31-4c50d632784mr6969059137.24.1742669172183; Sat, 22 Mar 2025
 11:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
 <20250322183746.86002-6-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322183746.86002-6-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 22 Mar 2025 14:46:01 -0400
X-Gm-Features: AQ5f1Jru0neAy-1UEM782xWgxkfQAPZ3EXSnCuQAJBKSHh3OfA7yHcyeh4E0bTI
Message-ID: <CAPEhTTEFbj0h8o+24X9k_8YhBWc8MxfXvoyOKkpWWQGTg8nByw@mail.gmail.com>
Subject: Re: [PATCH 6/5] drm/amdgpu: fix style in dce_v8_0.c and in vi.c
To: amd-gfx@lists.freedesktop.org
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

This should be titled patch 5/5. There was initially another one in
the lot about radeon. However, it was removed from the series and sent
alone.
Alexandre

On Sat, Mar 22, 2025 at 2:37=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Bring things on a single line and fix spacing.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
>  drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index f008615343c3..533851beb27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -3233,8 +3233,7 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs =
=3D {
>         .set_powergating_state =3D dce_v8_0_set_powergating_state,
>  };
>
> -static void
> -dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
> +static void dce_v8_0_encoder_mode_set(struct drm_encoder *encoder,
>                           struct drm_display_mode *mode,
>                           struct drm_display_mode *adjusted_mode)
>  {
> @@ -3330,8 +3329,7 @@ static void dce_v8_0_ext_commit(struct drm_encoder =
*encoder)
>
>  }
>
> -static void
> -dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
> +static void dce_v8_0_ext_mode_set(struct drm_encoder *encoder,
>                       struct drm_display_mode *mode,
>                       struct drm_display_mode *adjusted_mode)
>  {
> @@ -3343,8 +3341,7 @@ static void dce_v8_0_ext_disable(struct drm_encoder=
 *encoder)
>
>  }
>
> -static void
> -dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
> +static void dce_v8_0_ext_dpms(struct drm_encoder *encoder, int mode)
>  {
>
>  }
> @@ -3407,7 +3404,6 @@ static void dce_v8_0_encoder_add(struct amdgpu_devi=
ce *adev,
>                         amdgpu_encoder->devices |=3D supported_device;
>                         return;
>                 }
> -
>         }
>
>         /* add a new one */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a83505815d39..bcabcf27c3d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -61,19 +61,27 @@
>
>  #include "vid.h"
>  #include "vi.h"
> +
>  #include "gmc_v8_0.h"
>  #include "gmc_v7_0.h"
> +
>  #include "gfx_v8_0.h"
> +
>  #include "sdma_v2_4.h"
>  #include "sdma_v3_0.h"
> +
>  #include "dce_v10_0.h"
>  #include "dce_v11_0.h"
> +
>  #include "iceland_ih.h"
>  #include "tonga_ih.h"
>  #include "cz_ih.h"
> +
>  #include "uvd_v5_0.h"
>  #include "uvd_v6_0.h"
> +
>  #include "vce_v3_0.h"
> +
>  #if defined(CONFIG_DRM_AMD_ACP)
>  #include "amdgpu_acp.h"
>  #endif
> --
> 2.49.0
>
