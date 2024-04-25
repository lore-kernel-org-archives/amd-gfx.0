Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255C2C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D00811A480;
	Thu, 25 Apr 2024 13:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQls+8Jx";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D313211A480
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:40:30 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so728047a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714052430; x=1714657230; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0qTKMPM5Wr5MlkAKVVobtsRu9qVgyFWtgNmj9Mslic=;
 b=UQls+8Jx0pqkHLLt32Z0SLCUwaDxp+I2pBbxjijUQ7dO7z75bZXTZfx1Zheyg/w4Ox
 uuX8/x+GNCoIb2FwSRYLXasEgwaC3B0BVT9g1aoeAgnwaItCexEYmJoNPHahCxif+l8y
 9bpNLTfuk3oYrDoVnla/bSUcb7RaetRLJIXu9nihCqnPuzhTKb4GBtxONojjZK7HkKkn
 Cad1dEOxGcAfwUk+A+QVu5nQOrKi5zDgFT7LCOAL3aG0KQL3IIGHrtQCxQnHWOr7VPmR
 iV1bPUpTLMT5iCk+6jy7zenHsQWWmWinth7yCrOn5GbdHO+DjX7VyZrI+w4XZGG2S8F1
 LXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714052430; x=1714657230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0qTKMPM5Wr5MlkAKVVobtsRu9qVgyFWtgNmj9Mslic=;
 b=bq7lxLTJ7KeLstFaavTBRGMmPyb8dhZFuOMX7Ge4e2HyYWFGme6eqbZtERvUu7CeWE
 P9dsGLl75Oiukt94RGYd62ctNzYYsEtYDjzFyd2zQszWNIMo44eVmfP97a84TaaPJi8D
 7PPpzQ0eLwgB5RHAsj+GBuDX9cYf+CpO4sMGfZiB0GdK6hlAkPdb8HXIwmY615FQbU6l
 xLKAfvRI9eTbr3mRM8MEh8qPOtVngAfSQ5GPsX/lyD2qcstB2ymOO+CyD8VIt2l5TxtS
 /UQl3rB7krNZds54OBhLOblYv2BFuoObZ7OKhJ7EZ9p6eW1dF5rTAfNyxSvnXE4WMWde
 89WQ==
X-Gm-Message-State: AOJu0YxF3t1lwYocRomYsQ0PlAN3u6qN63TcVM8Uxpt2qS3L+7JvZiQD
 +7HNzO0JoqhzjA7Gt6rNSdyqfWZGE6SxXjfovub9zYwkzfP/+bka1KnP1dNYzJ+qrATBhzNJsZg
 lf8LbWOTujGA21ROHLBIX7MxuTwY=
X-Google-Smtp-Source: AGHT+IGwv4v0xVHLTPtHRGkVjj4U/qWVNxdDWuqMHjApuA5LwikLmv0yDVDVChD61lBlqcAaVVSGJq9ljGzbyreNjpo=
X-Received: by 2002:a17:90a:bb18:b0:2a7:cd5:faa6 with SMTP id
 u24-20020a17090abb1800b002a70cd5faa6mr5070085pjr.44.1714052430039; Thu, 25
 Apr 2024 06:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
 <20240425094743.134248-6-Jack.Xiao@amd.com>
In-Reply-To: <20240425094743.134248-6-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:40:17 -0400
Message-ID: <CADnq5_OuNdjtxu4JoJGz77LKPj7b0zNw7BJcquNWah74_bAwiA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/gfx: enable mes to map legacy queue support
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Hawking.Zhang@amd.com, Christian.Koenig@amd.com, Likun.Gao@amd.com
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

Series looks good to me.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Apr 25, 2024 at 6:07=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> Enable mes to map legacy queue support.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index d95555dc5485..172b7ba5d0a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -622,10 +622,28 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *ade=
v, int xcc_id)
>                 queue_mask |=3D (1ull << amdgpu_queue_mask_bit_to_set_res=
ource_bit(adev, i));
>         }
>
> -       DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring=
->pipe,
> -                                                       kiq_ring->queue);
>         amdgpu_device_flush_hdp(adev, NULL);
>
> +       if (adev->enable_mes)
> +               queue_mask =3D ~0ULL;
> +
> +       if (adev->enable_mes) {
> +               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +                       j =3D i + xcc_id * adev->gfx.num_compute_rings;
> +                       r =3D amdgpu_mes_map_legacy_queue(adev,
> +                                                       &adev->gfx.comput=
e_ring[j]);
> +                       if (r) {
> +                               DRM_ERROR("failed to map compute queue\n"=
);
> +                               return r;
> +                       }
> +               }
> +
> +               return 0;
> +       }
> +
> +       DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring=
->pipe,
> +                kiq_ring->queue);
> +
>         spin_lock(&kiq->ring_lock);
>         r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
>                                         adev->gfx.num_compute_rings +
> @@ -636,9 +654,6 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev,=
 int xcc_id)
>                 return r;
>         }
>
> -       if (adev->enable_mes)
> -               queue_mask =3D ~0ULL;
> -
>         kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
>         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
>                 j =3D i + xcc_id * adev->gfx.num_compute_rings;
> @@ -665,6 +680,20 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev=
, int xcc_id)
>
>         amdgpu_device_flush_hdp(adev, NULL);
>
> +       if (adev->enable_mes) {
> +               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +                       j =3D i + xcc_id * adev->gfx.num_gfx_rings;
> +                       r =3D amdgpu_mes_map_legacy_queue(adev,
> +                                                       &adev->gfx.gfx_ri=
ng[j]);
> +                       if (r) {
> +                               DRM_ERROR("failed to map gfx queue\n");
> +                               return r;
> +                       }
> +               }
> +
> +               return 0;
> +       }
> +
>         spin_lock(&kiq->ring_lock);
>         /* No need to map kcq on the slave */
>         if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
> --
> 2.41.0
>
