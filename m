Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A42CCD1A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 20:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A6010E501;
	Mon, 20 Oct 2025 20:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="imY/yiKC";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025A910E501
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 20:30:51 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-290dc630a04so5846965ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760992251; x=1761597051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/SNhk514hO7/b7hnOyn8JzJlldf1DFHhFP+h1fvaew=;
 b=imY/yiKCOFIJxiEGek7Qu6AyvEPgxt/Uq/RhkBCr1wA4NAwm3fINWHYNK1N4cc7/ma
 +9si5ILgZ5GEw/polKoGlY9hnVOlr0fBpNya2zUfORzUoquI3k3wDuOVK3xfnpqqQVT6
 ZrQOYzsq1qBLeWDduCsJ/RuDFicwkygeGUv0NuXg5ZVawkYUu7yuxeL6MjDWyJ7mwZxS
 wcmdMvyO/1tJAfQPzFK48Z6vQuiBPnB3GGPbuPHfY1STOxP4O4BNrP52pyTAAFEUBvfk
 dWerltZBgUl2hHqwJAdNwPfFQdLewPBrULmHmjwuaudzkjNnGdu+gxA/M4FAqHhHZNJ4
 avqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760992251; x=1761597051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/SNhk514hO7/b7hnOyn8JzJlldf1DFHhFP+h1fvaew=;
 b=KxLjvqMabsHve9KO9kR7aFdzYTab5aL8xbIw0zaIKHG3LCejTEVtf1pOWMHk3Sl3ao
 pTozqLXPxPH7kXpF6IzfdCCnwiCEkl8s/hkEt+NKQzZ9aKKFMPu5ecy4IGEoZLvIciPl
 Yg+w4TO4LVxlghEKHkPvX6781z+/O071vJLQPv5IRHvicKpopJVOBTYXZzGcV7YpjCA4
 Z9rIlrmCTaPWDH+A0SFJig8Tcb8lmmY5zW+IsW66LxVZGObfXLl6i7+iV8Vi0kvjiSK4
 bE7ddfM7U7oLorVPspanvbbq51syNcmhrgOK5TS+Gky8B+CPE8CSzH17ELtB59OU20wT
 9Lrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWONdiUwYBwnZ37Ao/PrAlwN0BPWBvkERY6gD8W1cP21kRrRsVmfkzumKJEW/4nb4GY3rbLzWYg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyG5I7Rirmny7DBIjxp+my9hNXZ5HyDQDYaSm0f89TXdojZEBMu
 OzylEMhBN15lpGdPCRQA9zs1H8OpjAbcdzUVmJg5k53if9ORDd9WgByijBF2uRA6e+7AZ3909CH
 Z8ZJGp+83CU9E12VTvqiij0KYL4/fPzU=
X-Gm-Gg: ASbGncsLqLOlrDGZ5VH6TSD7Ngi2wW9a4U5HOhyP32Xd08fD3hoiU7EHuWuRTwx149d
 1RMN6mhNEHGWCl2txjkBdqL1m79wNqkYH/OECd53R0c4zEwVKBHrTj7UeQOFPzGuq0O/Z1JSdam
 jlbkKhqbvR0Yo4XOz0Ai7rDbUpOrwJ5vJs7uBcWKjEj//5s39Rt7mybZvWbutrnbxCmqoDhU3TH
 DCRqgQz1OAgmKmXJQoEdFPPppT6v2amOQeFfZLRKlqPrlDVq9JCYY1zgc7MEsZ7e9QdZUAp1UHa
 WypzLA==
X-Google-Smtp-Source: AGHT+IFJn9lnKZKWEn4cIpcZiLgVjWX3rb6MHSb77Pod5up2bwVpbGagkAaVkJ3hYyT7x8XOgDrt2oupD0uJhjB2IPM=
X-Received: by 2002:a17:903:1212:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-292d3fb7f7dmr5143195ad.6.1760992251359; Mon, 20 Oct 2025
 13:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-2-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-2-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 16:30:40 -0400
X-Gm-Features: AS18NWCFQsviUBBdfzsmyCtY66n2EmrUVW_LmDPRP-KYjQq7MfnnV4S13l9FZyc
Message-ID: <CADnq5_PxBe=3LvO3HOW=gXXsNwjk6R0qqwXh0WXAt6vp=E_ZCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Mon, Oct 20, 2025 at 4:06=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 5ec5c3ff22bb..29de8dbe2917 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type=
 type)
>   * @ring: amdgpu_ring structure holding ring information
>   * @ndw: number of dwords to allocate in the ring buffer
>   *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> + * inspecting the code, you may encounter places where this function is =
invoked
> + * like this: amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are =
integer
> + * numbers. The idea of using each integer addition instead of the final=
 result
> + * is to explicitly indicate each block of operation that will be insert=
ed into
> + * the ring.
> + *
> + * Returns:
> + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> + * maximum dword allowed for one submission.
>   */
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
> @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ri=
ng *ring, unsigned int ndw)
>                 ring->funcs->begin_use(ring);
>  }
>
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
>   * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 87b962df5460..e83589619a92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
> --
> 2.51.0
>
