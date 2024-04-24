Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9BBC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 03:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11C010FAAA;
	Wed, 24 Apr 2024 03:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYv/S1Vd";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A9510FAAA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 03:34:07 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2a564ca6f67so5322186a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713929647; x=1714534447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23xrwg+BavifwBEi61N1w1mXaQsBlO2gH0x7DPL10J4=;
 b=DYv/S1VdpoMRi4K6NmLjID9JBqyephnJvc1O6ft72BQ2fvE1FSt35F8LaKZrslkCzE
 U5aS7XmvfozjdMAKjKETRhbAQjJLSOjRI/YuaZxE/Qz+kSgyZoe7u6HmwcMecnL9ncHR
 BV2pWY8XhC00cRTI3xKNiZRjkf9molkJSyxWY9oJ8QuYoZgM3UPANwSpoWj13Met3bWA
 Nq6V7ieNHocwJ9MSDV5gdVwmImUf04gf66pUsjjQUx4MRy3Y5RJ2Qc/WcY6hhQfE33/0
 TXzLqo8CyNdoaydQxlCX/lS7b5jYA1/yGOgpGajGIYxBFfYVa41gf7JP6kAlb0it62QA
 nKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713929647; x=1714534447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23xrwg+BavifwBEi61N1w1mXaQsBlO2gH0x7DPL10J4=;
 b=Rp5+YRnLX5ygqn8nVeEbGwmaRTXrKWnlAgGIMDY1BEhfSeIfheX+br6/lDRLx9mUyz
 BofI+31qW+ALBqyvnl8KcIYy7+/qJTdiV5TsVWCT0iSi3ZXwvEgqiYzzbEUq+Sw/SfIK
 W0RQHzxCHluhNkDI34s7offyIqx5vYJxPUT5a0bEraC9ehW1/vpYMkE6uMUl7UxhOObV
 f0k/nr44iUqvE5FXwY7ziU2Z48GyqsSOQGCuwZVHWS/U+HWuAamcqAyY63efetox+H85
 U4K2CwDTzmb9lxIO2P0+S3seyEhyWLmQ+/Ec+Ngcef9tQ+HlMSCnOKUmHdv1nT1jVF4n
 SNTw==
X-Gm-Message-State: AOJu0YwDHXnbU2hy0nAAIotOrn7sHPR3Dop455h9RuBniQILt7olHhRj
 4t8V3LCEvjB2jWFyPe3R6c86/QYtZlyf4KduWEWRTo5cebefjjmMJfURKyUkfeBjn6DPzlXmdSi
 Oet5Oq3FUwhufjEqXeDzzkxBai1M=
X-Google-Smtp-Source: AGHT+IEqrtkqWijtvS+tHdoYvVGtqknFeCqxzAH2Jykn9uGwrE9XN4sfuZdBfExVS74PpHLKVcyBHvGtAJcbZQetRFs=
X-Received: by 2002:a17:90a:f489:b0:2ac:30ac:be4d with SMTP id
 bx9-20020a17090af48900b002ac30acbe4dmr1079920pjb.30.1713929646792; Tue, 23
 Apr 2024 20:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240424024914.727436-1-jesse.zhang@amd.com>
In-Reply-To: <20240424024914.727436-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 23:33:54 -0400
Message-ID: <CADnq5_NGWy0rq3DBxd0V8_cToRs5yaTAsNwvDE5pFnXM0SV17Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: add check before free wb entry
To: jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, tim.huang@amd.com
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

On Tue, Apr 23, 2024 at 11:27=E2=80=AFPM <jesse.zhang@amd.com> wrote:
>
> From: Jesse Zhang <jesse.zhang@amd.com>
>
> check if ring is not mes queue before free wb entry.

Minor clarification to the commit text:

Check if ring is not a mes queue before freeing the wb entry because we onl=
y
allocate a wb entry when it's not a mes queue.

With that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 45a2d0a5a2d7..b7d33d78bce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 43e64b2da575..cc9e961f0078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 1f4877195213..c833b6b8373b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 5);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> --
> 2.25.1
>
