Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16106C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 13:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F14F10EB83;
	Tue, 18 Aug 2026 13:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7uiKu5y";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A76010EB83
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 13:43:40 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84a32ff53fcso392572b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 06:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787060620; cv=none;
 d=google.com; s=arc-20260327;
 b=jHfgIiORcjyDv7cdCBgRmHoXUIrIaIMGl+iVQd/Rzi8f4AlluzFH0KwwEJqKTWK85d
 zg5VcaWLVmAtUMccc16TAkhOuv0REuLwuGhx87zARQ77sStwCugZoGXs1mLHlflTRsGv
 3aMfA0vfvPqCzh4Nf3vXbtuBr5SC648EWGDFwARjEDSUFS12MOWX9IfMK3AsYNJ2JpnS
 NfQSse3Xb8hkEhWRLxLbPsDjRk23ytYkhvgqqGjGZp+T8FOZxyN8PfzLGeTJ3VfeZzUO
 H0F+Ee5u1b5ZmkGeOXg6uF24VlZv2tx1JkDrI2v9uBJMamzYVSqQ1BHgLZ97Iu7M0d6u
 QHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8fSYLYU4E9VgTy383KEtldWmFrDlAXRpvz/op72bEwI=;
 fh=30Gc3uXyWcA/cQluxjpuKN44ivaqox8xoNlJU9s58rU=;
 b=PmEIcB4tuuwAzBDDU6/wHJuBaZ7OWGnCMb5s9pFxaf+U7DLYzIRkzt9dQ13x+usjOR
 S7wLnC0+dIZO2ZSBMS2cywlBwu+7N8rXVAGr8Is+O5iuxvCFJiGWfv9yPq1Bp0JO1YJf
 +AGCKnviu/uhU4gN/eMOmocOiwDJOqBImFEZwLMbQfU8sLn89zgLBSpJp7F1b79anjSu
 sqFVz0TfkW3HAZemQMQ0PCm1YZN5WSMSiHHA47ppnQUBSALek8zvcgtHJjKcyH8P9LaJ
 iG9dBU59BUzEOdJZ81zc5uVzCCU/tS+nOz4AbwYAFuEvqtKyMNa9vwkFCYuBel0U1oF1
 +ajw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787060620; x=1787665420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8fSYLYU4E9VgTy383KEtldWmFrDlAXRpvz/op72bEwI=;
 b=b7uiKu5yhG8z+7AGLyCFlMcvKts30DA8oD9yxmijiO9oR1bSmr+y1yZEuqZQr1YQqy
 3SnPiShMKVhza4Vd3TYUDnJDjZewwM3EQdVbhnxW4OOTorGQU0+lXF1miFA5Q0AYUZHp
 PCKNCb8d/Jwb2KI04mPr6rQi19odf8idzbIZa0kv+IsOhtIw7ntuV7H1cCpElbbwd6po
 gjE+QT+pW5zVB+zuAuLj9jEgLSm6GsH0Q8EL5lzxDLwQpmioYxRRgR39WpI1S5ddt29P
 J5/GIyMBRbCP8uWKxhY6p3aSzcqEHzYs/dLX+9wXarJ3Y2G1EdRGgpfEVLjXmMttXKlj
 kuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060620; x=1787665420;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8fSYLYU4E9VgTy383KEtldWmFrDlAXRpvz/op72bEwI=;
 b=MOdJ2ypxeia8+hwCz7q3K8lmEosskyN5Fna3WyrLE07HSbCmIWhk/ru6sNyXjyEJiT
 puW/QXWonh0rQ+nKzrbVWpKzuotSl1XnDdN8/kZLsIsWUZNbjDbh3xHIe9q4XGn9tYfy
 OECmRhowWBuR1vvaPHAe1rgBMI7zsfmSKN02m2Lhz83GU6DCN9MdozFz6vV/U7V10Drg
 jVmfIChFInJX3uZIQVZswAo1umJMTPGdFiH9EjrIQAPayo20zMbxlXYvuEksPi8yl2GF
 9E1v0+b7uG+QG3hGStCASlDtpYSUIVXew+GKRPHTYJid04LK5kGPZY/Jw0vRU+oQrnew
 110Q==
X-Gm-Message-State: AOJu0YxPvluMfr2bzSZ0hTwPsY5AqNqqdRgT3pG2jAfpvZ/iFlqMoqX+
 YpGjagpA96bxeKnBG3+uSRSxFQNo8i2LuUBybKtOSadz1VvuXSm/18KdrIaj0X19VAQFxKmrcJ1
 xchD6HuMVYkHQBpPBQ2G9LRwnMD9pYXI=
X-Gm-Gg: AR+sD13tN2ADHqeWnJPABTGOJM8JxAOgRi01h8L0k06vmbEG9f3au+uGNUeqilBZd+J
 C+VVW0J5Tjp+Y/ilO03z+WXP8u8Co++yMaThwLQ5c8lEhO/CEVazxTaMZhpspkuA7DdcC97/dnX
 8hZz687PgKjm7EKk7awjD8axDWFdRD5ARB+G8jTeszGngx+FWd3SzwExjJpIhUkpVjxiCCswjku
 gtT6eqIDqJVbJETnMNcYX0ls8dcMdp3l4NXzqRMqwujUSxW1QbogwSsM3zS4HGM44J6tlD2ItvY
 ik1tt2Mci54kqJrLa2eYn8CXhBukkowaU3Q0vKzIujyJSo6DXDJAKWYMhtu3IL38pbd7O1ZiF+s
 9wo6RKKh2Tlg8X+fYjVlvZGKkaDFgDa2yV2Kh6UrD018=
X-Received: by 2002:a17:90b:4a89:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-3933b889d59mr22760242a91.2.1787060619852; Tue, 18 Aug 2026
 06:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260806151103.122321-1-Sunday.Clement@amd.com>
In-Reply-To: <20260806151103.122321-1-Sunday.Clement@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 09:43:27 -0400
X-Gm-Features: AcwNN1UmkuW17cMykzt9w7dxfJ4CZ38sj1GrDpQn43EOMvuKXWd_ulVKn8AJVpk
Message-ID: <CADnq5_N7OcsceV6WJEva_VRM3mi9VYTyO4Tgktx+pismpmk32A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Reject zero-sized AQL queue allocations after
 size halving
To: Sunday Clement <Sunday.Clement@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com, 
 Alexander.Deucher@amd.com
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

On Thu, Aug 6, 2026 at 9:48=E2=80=AFPM Sunday Clement <Sunday.Clement@amd.c=
om> wrote:
>
> KFD_IOC_ALLOC_MEMORY_OF_GPU with flag
> KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM and size=3D1 triggers the AQL
> wraparound workaround (size >>=3D 1), reducing size to 0. The resulting
> zero passes through PAGE_ALIGN(0) =3D 0 without validation, bypassing the
> per-process VRAM quota check in reserve_mem_limit()
> (vram_used + 0 > vram_available is always false).
>
> The fix adds post-halving zero-size validation in the primary
> allocation path (amdgpu_amdkfd_gpuvm.c). The check happens after size
> halving but before reserve_mem_limit(), and uses err_alignment_size
> error path to properly clean up the allocated kgd_mem structure and
> mutex.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1e71829e0fc6..90a4a68478f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1795,6 +1795,11 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>                 size >>=3D 1;
>         aligned_size =3D PAGE_ALIGN(size);
>
> +       if(!aligned_size) { // reject AQL queue with size < 2

Switch to C-style comments.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +               ret =3D -EINVAL;
> +               goto err_alignment_size;
> +       }
> +
>         (*mem)->alloc_flags =3D flags;
>
>         amdgpu_sync_create(&(*mem)->sync);
> @@ -1886,6 +1891,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>         amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags, xcp_=
id);
>  err_reserve_limit:
>         amdgpu_sync_free(&(*mem)->sync);
> +err_alignment_size:
>         mutex_destroy(&(*mem)->lock);
>         if (gobj)
>                 drm_gem_object_put(gobj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 309510e23315..bb0a2c615326 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1200,7 +1200,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct fil=
e *filep,
>
>                 if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>                         size >>=3D 1;
> -               atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
> +               size =3D PAGE_ALIGN(size);
> +               atomic64_add(size, &pdd->vram_usage);
>         }
>
>         mutex_unlock(&p->mutex);
> --
> 2.43.0
>
