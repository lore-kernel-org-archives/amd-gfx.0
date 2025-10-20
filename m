Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74895CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F2B10E4A4;
	Mon, 20 Oct 2025 17:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ge+hAN+s";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A28F10E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 17:36:52 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-29245cb814cso5740635ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760981811; x=1761586611; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Kw+DUSuhasSbUlmsR8H2xpHl/nE0oa3TZ7/sbrQmIA=;
 b=ge+hAN+s04aiyL6TUon2RfsyhW/yY3sHYYntHjQtAN5Nidnt+1bDp1KM1lP1iFMFEi
 Lh5hfhM7a+Ggv4rcLRukKd39DEo9wFHNr99bch+wlJEKaEOevsJ76vyRv+4rQVeHdzu0
 jsSKGsUE6kKmAaV7JB7H4ZQe0SmrowN2m+5n1x90uqKCVKYjs65u+WTlGXdcGNaQz5fy
 UHycTK7xvhw/ZjV/YEmW8k0YoP1ZBm71bjGu6UDl4/n+SHe21x7ArsvZN4KprwV/tJD1
 9oA+WrhELk+4hxbaypJ2M9VyYeq2Mld4GU0iInKiMhasEgKM44E2qTZ3kE5fPrKJOQdx
 Otnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760981811; x=1761586611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Kw+DUSuhasSbUlmsR8H2xpHl/nE0oa3TZ7/sbrQmIA=;
 b=Yjx78nytxvNNM+Kn6d26P1sxWOY3EEuL9yO22oWi48NgZKiAhCgXrAyoTB5lQ80SSy
 gYRS8seSLE84OH1pNl7ZOIhEsyq0hoZGtopDlQ7LGRxXr88ND8V7pSFphA+rX4pn3gwQ
 x9vfhe6xiJcj9vgvgXqyJHb/8mQwqTwAyducwV2P9W9PVlqyACK/OWejQYKiuT4ZlWaL
 AuTFHD1jnwRUDsIN4gIg+UwZwX0m+7cT4amNh0PJNP/BvdLbA1Tu4RwO5sWKqN7jYlUU
 tx9JVvl5qE0JpkBjeMR/vcQsxX5fsYJdCvZvBxx/k99k2jKv10k4vsRkyF4HwI2ooh/Q
 FiNw==
X-Gm-Message-State: AOJu0Yw67ksBSuvSj2/2VEF7K+54YBZjYAV2BvWnIfxStzBu9+wtwJJX
 CHkqdENNdKNXDcESHOMdQudvcT+Lt9sWd7D3yoSh/zLOdMf/ffF++IJcsuxjlfS9bJ4L1hcvpje
 mVyrEWAkpx1X56Ib3wHBoYCliAOQirtS+dg==
X-Gm-Gg: ASbGncsBS7qaO1GpxRjGXYk1Cpsb7BGWgk2jsYSMvOIQdZRugv9aIHXaZFPx/XhRcm1
 BKaGraHuQCZN2Nhf7CVYhCszRr5LL1jOWgf3O7CxsyuowqYXxZLsuYmPhIFk98XZIjKynuGm114
 UOU8P6gBxAY3IBYgh6fquo/HFJhVqEN/4yR+DvBofyZy0y8Y8BiXq3/kC+fTLlXzQYvXqNZmW7d
 eysXIxPYTeHOQjCiNMbqSrmKAnznOyaywT/IqIgYKCgVtYOSVTxQefwKQqe9LG2vtmH8eM=
X-Google-Smtp-Source: AGHT+IGbrLu0YTW6iLe0GrGE6DbL5l2BzRBWZ5vyeU1mrBVgtj7euXowm9wExDiW7aAaF73/6qaGg+fR0aJyix5+UYU=
X-Received: by 2002:a17:903:94e:b0:26a:3c75:5241 with SMTP id
 d9443c01a7336-292d3fcce91mr1487625ad.9.1760981811395; Mon, 20 Oct 2025
 10:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251014211712.2524052-1-alexander.deucher@amd.com>
In-Reply-To: <20251014211712.2524052-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 13:36:39 -0400
X-Gm-Features: AS18NWBpMmkwLCv-vOSyUUpZeT5jO-5YrK5X3hDQMfpjix1QOVeLrH0l_FwjO7s
Message-ID: <CADnq5_MkDv9W0ozMFO3YQjKpqqd9SOc0xW8qwZ75Ap7BecVP8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: set default gfx reset masks for gfx6-8
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

Ping on this series.

On Tue, Oct 14, 2025 at 5:56=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> These were not set so soft recovery was inadvertantly
> disabled.
>
> Fixes: 6ac55eab4fc4 ("drm/amdgpu: move reset support type checks into the=
 caller")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 +++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 7693b79534267..80565392313f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3102,6 +3102,11 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                         return r;
>         }
>
> +       adev->gfx.gfx_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +       adev->gfx.compute_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0=
]);
> +
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 5976ed55d9dbd..2b7aba22ecc19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4399,6 +4399,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v7_0_gpu_early_init(adev);
>
> +       adev->gfx.gfx_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +       adev->gfx.compute_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0=
]);
> +
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 0856ff65288c0..8a81713d97aac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2023,6 +2023,11 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>
> +       adev->gfx.gfx_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +       adev->gfx.compute_supported_reset =3D
> +               amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0=
]);
> +
>         return 0;
>  }
>
> --
> 2.51.0
>
