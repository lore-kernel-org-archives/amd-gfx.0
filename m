Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE820CAC594
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 18:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B73910EB7E;
	Thu, 11 Sep 2025 18:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JfjN+Sa9";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B7710EB7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 18:55:10 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24b14d062acso1584885ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757616910; x=1758221710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UT1VAnCzDWPyX0Sktkag9wuWPeIVg8TqdvLUofeQAH8=;
 b=JfjN+Sa9AkJ4XOveImDFc7x3OWSDHENEwSuIfr7gfMkS/X/TWopLXpHuu3VOkBy8Cu
 oLG+NmnV5BnW6DT2vkIAI/nLNcUsPi9DqNc0BNbywHHt+2QU6qEacv1RvmOgfRBCTv4c
 2J0naTMiNsLSXaQYfDw1oZ4VD850Xfi8KK3HB9VL+J3QBFDnjWtfXiTZxlFBn5hHzNrc
 2n7Fk0KfaLeE2u0d3yIzUJuf/VthH4Id6lXnmbxWjbJNrs1jZ81yULDUP3IFQbO2c20d
 Zu1bvrob7o2ufUC8jpSt1FVPusAas21XxnpQCxsuP+21IqhFP0qmJAJPfL6shvBB7Ky/
 EUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757616910; x=1758221710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UT1VAnCzDWPyX0Sktkag9wuWPeIVg8TqdvLUofeQAH8=;
 b=OjeSkNf0/ad81MJXw11XRdq7x9N3mj4vA3RiXWcuEADAKaQjXbgxvcNw0GznjE2Gg/
 E6zd5KiIGwA4Z0Z75NjiUqtQ1qHMiyDZruXhS+hubTpZ7KXYkkhV72ZoIV09W/b3Xtgg
 IxMg8Vig5cb1PjOwYF7yTaXdj1OS2UXA9hcbXqMkN26gD+rWHw4sqF04foG2rCHxNOYr
 TykmoANNGWpzfTohg6ONIQWuAEHkPnB04sshLA9oisFmh9uZO6qfKGU+Bnj3dB6w5G8o
 zh0mJNtFd3ephbZNSm3WDTAlfikzy9QJsdiFhzAV+r3K7nYK75HdsYqUbZCW0rhYAttg
 PXGw==
X-Gm-Message-State: AOJu0YwbXBGOMy3C9XNIoBQ8YESzmkBB45cnZ+U8Inbw4wun22Xxcm9M
 Ja9hAuLrYDAV8VmX+96s6t7X8DTDZdbZHezdEifvgZkoetRo9hGZ1C6Y83F0JKiTp6tJReIAhoV
 cV2LNdveHd4YLlf6MV71PLUCES9Dj0nuazw==
X-Gm-Gg: ASbGnctOAEwBB/xlrkS++sd1TFmuli24OPlg/OCrXHUy78HgskHEyXkNflD9J2jyZku
 bYkQ3FzjxT3r3C3VWeWegOxV4mYsbGMSdSoF9vkhlvM2ZLDCdACEYIi1LBfIPiVfMXLmzHgDPtQ
 MzUnQf7fvzai1IkQulT3lvdI47tYLBzfrskjkgyhHd2hh01RvM6QeScJei7qh+QsHMGKT2nXNpU
 bAp/u+Un7qlxQqJ8A==
X-Google-Smtp-Source: AGHT+IE7NxADKZojE1vOvNIY3SjkBBy8esdvuYvRDU2Hki3LAV88kYZUN1kv+p7/P2rD7IMYMeQdchKZo81KxkJveSw=
X-Received: by 2002:a17:902:d50b:b0:248:b43a:3ff with SMTP id
 d9443c01a7336-25d26c49e0bmr1941205ad.8.1757616909448; Thu, 11 Sep 2025
 11:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 14:54:57 -0400
X-Gm-Features: Ac12FXzoOerCm08qgQhOmhM2-QzvFl3aQSYLLIAafBJCvXqWXWwas6nsUlmF8io
Message-ID: <CADnq5_M+Ys+v=proV=Jg3cDh0REEg0EB+-VtwvMkCdGt9BTXLg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Sunil Khatri <sunil.khatri@amd.com>
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

On Wed, Sep 10, 2025 at 7:37=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Add an API to query queue status such as whether the
> queue is hung or whether vram is lost.
>

We need mesa code before we can land this new interface.

Alex

> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 85b3ca14f81e..7292f7bfcd13 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -334,6 +334,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
> +#define AMDGPU_USERQ_OP_QUERY_STATUS   3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -346,6 +347,12 @@ union drm_amdgpu_ctx {
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
>
> +
> +/* the queue is hung */
> +#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
> +/* indicate vram lost since queue was created */
> +#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
> +
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
> @@ -427,9 +434,16 @@ struct drm_amdgpu_userq_out {
>         __u32 _pad;
>  };
>
> +/* The structure to carry output of userqueue ops */
> +struct drm_amdgpu_userq_out_query_state {
> +       __u32 flags;
> +       __u32 _pad;
> +};
> +
>  union drm_amdgpu_userq {
>         struct drm_amdgpu_userq_in in;
>         struct drm_amdgpu_userq_out out;
> +       struct drm_amdgpu_userq_out_query_state out_qs;
>  };
>
>  /* GFX V11 IP specific MQD parameters */
> --
> 2.34.1
>
