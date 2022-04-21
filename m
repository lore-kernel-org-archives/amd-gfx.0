Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EF7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1BD10E30D;
	Thu, 21 Apr 2022 14:39:25 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813B710E30D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 14:39:24 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id e4so5836667oif.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w4iWAH/PIbRtrz6JOkSMhoTIMC4NsgZkCTwQW4PEpdc=;
 b=PtNFZaTVrtUd6IbsgI1iYswAdmmxeS7IdlLBd5W1f+a++ZI+fXvzA4jn90NV4e3pPu
 rIquFqGGe8ZvUsDAuZnZvgFOi2zSW0KI3bV8xTaal6F0LTOZM8IYN6l2+Tz6X6Q1fTyU
 k4rjouS2wIejduXtXLFHIRvJC6j/HqiAxBsXxi2LtQZ5DFzbebJPSIeQR7tFmPs4lo1l
 MZlR5PZREX1Ndkm/gthBoN8IARdB9wmrsEHv3i2gJXpcupiKYCz1mkYc3n4Qj4xY14JV
 vIOw0+mCEYKlAQdH47XlA0gGFRKu5GEHx+OLSZy1qXtZnq+VisQdAoA3bEcbFgyBGOC6
 i7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w4iWAH/PIbRtrz6JOkSMhoTIMC4NsgZkCTwQW4PEpdc=;
 b=q5eMSkqOf/3uf24QjVxewmo2f/SoVOxnpRroebhu4Oq+4+RAu6eqGzlI15hqW+wmgC
 vne3jK5RcEaYs/k9gFlEgLCxSYeSZd2sNW6ICMSCedaRHSn8tIFTQbg4eLJEn/I+ipcK
 IfA1q78RKlT2xQT4HN33vW+kIQpA5wZKdnrekNQ5LqTqwfIu4FltibZUkeMopxhGmFiK
 Xo8H/ePCfIOfOoFBuDYhDX0jceiSTsEoIhTtdy9VuFXrj61E+E1ufkIDfU9g5l7i0F1E
 GoEaDg04vtlCBaR9sJp1Q7eDrEWL2Ak0n5jBFJzDuhXnYNBUKGAd9wVUNHcQNL33FKrF
 y2aA==
X-Gm-Message-State: AOAM5339QBNlXzGx0tNkRBCekCzizivX4c21JdjwIQIMNfBIfWq1SPJw
 QPq6ucD57c2mrkAbMXeB3fCY4HEMEWT5UBOTvGYy5Tzr
X-Google-Smtp-Source: ABdhPJyGMaHUsEIH2edYCxw8XUiTuXRqDQJqZx6xzjbjPwZQvF+OSWBX4mNyeZSFMX2de7m3wqfLzGE6K3Tx7lFS9ME=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr15186oiw.253.1650551963810; Thu, 21 Apr
 2022 07:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Apr 2022 10:39:12 -0400
Message-ID: <CADnq5_Ouj602EgDEF_qU8ceypk9_EE2uk2toDnPtvNJReH33dw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in
 kfd_migrate
To: Yang Wang <KevinYang.Wang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 21, 2022 at 8:33 AM Yang Wang <KevinYang.Wang@amd.com> wrote:
>
> simplify programming with existing functions.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 3a29d857640b..43cd47723946 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -410,7 +410,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>         struct migrate_vma migrate;
>         unsigned long cpages = 0;
>         dma_addr_t *scratch;
> -       size_t size;
>         void *buf;
>         int r = -ENOMEM;
>
> @@ -421,9 +420,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>         migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
>         migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>
> -       size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
> -       size *= npages;
> -       buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       buf = kvcalloc(npages,
> +                      2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
> +                      GFP_KERNEL);
>         if (!buf)
>                 goto out;
>
> @@ -665,7 +664,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>         struct dma_fence *mfence = NULL;
>         struct migrate_vma migrate;
>         dma_addr_t *scratch;
> -       size_t size;
>         void *buf;
>         int r = -ENOMEM;
>
> @@ -676,9 +674,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>         migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>         migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
>
> -       size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
> -       size *= npages;
> -       buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +       buf = kvcalloc(npages,
> +                      2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
> +                      GFP_KERNEL);
> +
>         if (!buf)
>                 goto out;
>
> --
> 2.25.1
>
