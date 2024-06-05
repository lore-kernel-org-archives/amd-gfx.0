Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1A0C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 13:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A0610E161;
	Wed,  5 Jun 2024 13:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7GjhD7R";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A9510E161
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 13:20:44 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7024791a950so644050b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717593644; x=1718198444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLr4OqkdFIH3NCjFocDB/9hKvtKqZZcvIwWhFtHM8ZE=;
 b=F7GjhD7RpK19uSM5HiukydPqexpcmA8oNtpyY1ALEfRN6PkGAa/wFnGkx3OScB4F8p
 paZPKex2IxaQMDnEcIDxHaHswdPJsoXsoVbTHCsW02HATs5Rj6P8T3yXggWUN3apYoIT
 6vwXF+w9WeYE4+iKku+Owh6ZVSxqp99awguhDdyarggxyMo7D9Q1L0S4HyRVR6a+Hpto
 saJGMzKQV+MkqXY6so6GUwhuu03ZGxDMiVzmOedsn3xcCiNVhh4YspHOOrn2e5wCQIAs
 LclhkG6DXpQyEOW4wWaGXd7ZnZVarOxZpbpAo/r4Q7WNTshbgpHK/dS0WfELizLLTOBU
 zl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717593644; x=1718198444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLr4OqkdFIH3NCjFocDB/9hKvtKqZZcvIwWhFtHM8ZE=;
 b=VygtdVtCjDMwtfwPiiirKe+TuzEfobrqmytTLBr83qgj9PWbs5Eew7rWb+RFwJXHqY
 bI7ycapm/QnmIP8U5joBp1d6YTA69mS0Dm0CkfKwkAzqRGQWuOtGs/FP7gtaF+0wtxkZ
 FACQbxY3QmwdwW3zOvY8S4ViVj5PpeKSG+7YULk9IcXSbXGeLkqg9FFldecZHsabgguc
 lxR+mSlD8lvcnFEAURr1eUobK6ZRcvBG23kxoqiUCkNmXB40qkXgrYZKgcbjoQFtzGkr
 ciuteii24vC26djetsgHV0jRhSDIFEIYKlYOSdEVusce2alYNDPlsfk7qrD/qZM5qUQM
 aXiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWABCH/Awqi+F4Hwvy9SogVUioIdxusb/O7pIxXUoMFUAdxs90IQiISMTIsL5TPEqzwrEnMJwUtFlwswNibzUqAZrZLPBb4ObQjvESnpA==
X-Gm-Message-State: AOJu0YxLtLPZSzqtUt5CoXyAtV3UKEKQFUZ6FxnnfKk6XuFzsPHCs0ax
 iRINs+btQOapuJbxMJLKkoJPErqwsBXJd9irtlQbZJadValIPtnQ515CafwgvrsvA8iAGSvmK2z
 qZnLURHRpuI2z8VkPgkhtnHzZiSU=
X-Google-Smtp-Source: AGHT+IFF9RxMFZTmdoQA0r40peksDY2z5VP8dz23Mx10HxJA2TWoNMQcdH891VLPFoTSOB9WhGHvVt7OPYssyfCBlO0=
X-Received: by 2002:a17:90a:17cb:b0:2bd:47fe:6dec with SMTP id
 98e67ed59e1d1-2c25303f6c3mr8474617a91.5.1717593643813; Wed, 05 Jun 2024
 06:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240605123159.90950-1-christian.koenig@amd.com>
In-Reply-To: <20240605123159.90950-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Jun 2024 09:20:32 -0400
Message-ID: <CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: revert "take runtime pm reference when we
 attach a buffer"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: shashank.sharma@amd.com, Pierre.Jabbour@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Jun 5, 2024 at 8:32=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit b8c415e3bf989be1b749409951debe6b36f5c78c and
> commit 425285d39afddaf4a9dab36045b816af0cc3e400.
>
> Taking a runtime pm reference for DMA-buf is actually completely
> unnecessary.
>
> When the buffer is in GTT it is still accessible even when the GPU
> is powered down and when it is in VRAM the buffer gets migrated to
> GTT before powering down.
>

Won't that kind of defeat the purpose of P2P DMA?  I guess it's a
trade off between performance and power savings.

> The only use case which would make it mandatory to keep the runtime
> pm reference would be if we pin the buffer into VRAM, and that's not
> something we currently do.

We'll need to bring this back if we ever support that?  I think we'll
want that for P2P DMA with RDMA NICs that don't support ODP.  That's
one of the big blockers for a lot of ROCm customers to migrate to the
in box drivers.

Alex

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 33 ---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   | 15 ----------
>  3 files changed, 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 0b3b10d21952..ab848047204c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -41,8 +41,6 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
> -#include <linux/pm_runtime.h>
> -#include "amdgpu_trace.h"
>
>  /**
>   * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
> @@ -63,37 +61,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabu=
f,
>         if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>                 attach->peer2peer =3D false;
>
> -       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> -       trace_amdgpu_runpm_reference_dumps(1, __func__);
> -       if (r < 0)
> -               goto out;
> -
>         return 0;
> -
> -out:
> -       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -       trace_amdgpu_runpm_reference_dumps(0, __func__);
> -       return r;
> -}
> -
> -/**
> - * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> - *
> - * @dmabuf: DMA-buf where we remove the attachment from
> - * @attach: the attachment to remove
> - *
> - * Called when an attachment is removed from the DMA-buf.
> - */
> -static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> -                                 struct dma_buf_attachment *attach)
> -{
> -       struct drm_gem_object *obj =3D dmabuf->priv;
> -       struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> -       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> -
> -       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> -       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -       trace_amdgpu_runpm_reference_dumps(0, __func__);
>  }
>
>  /**
> @@ -266,7 +234,6 @@ static int amdgpu_dma_buf_begin_cpu_access(struct dma=
_buf *dma_buf,
>
>  const struct dma_buf_ops amdgpu_dmabuf_ops =3D {
>         .attach =3D amdgpu_dma_buf_attach,
> -       .detach =3D amdgpu_dma_buf_detach,
>         .pin =3D amdgpu_dma_buf_pin,
>         .unpin =3D amdgpu_dma_buf_unpin,
>         .map_dma_buf =3D amdgpu_dma_buf_map,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 10832b470448..bc3ac73b6b8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -181,7 +181,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struc=
t dma_fence **f, struct amd
>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>                                seq, flags | AMDGPU_FENCE_FLAG_INT);
>         pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> -       trace_amdgpu_runpm_reference_dumps(1, __func__);
>         ptr =3D &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_=
mask];
>         if (unlikely(rcu_dereference_protected(*ptr, 1))) {
>                 struct dma_fence *old;
> @@ -309,7 +308,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>                 dma_fence_put(fence);
>                 pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>                 pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -               trace_amdgpu_runpm_reference_dumps(0, __func__);
>         } while (last_seq !=3D seq);
>
>         return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index f539b1d00234..2fd1bfb35916 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -554,21 +554,6 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>                       __entry->value)
>  );
>
> -TRACE_EVENT(amdgpu_runpm_reference_dumps,
> -           TP_PROTO(uint32_t index, const char *func),
> -           TP_ARGS(index, func),
> -           TP_STRUCT__entry(
> -                            __field(uint32_t, index)
> -                            __string(func, func)
> -                            ),
> -           TP_fast_assign(
> -                          __entry->index =3D index;
> -                          __assign_str(func, func);
> -                          ),
> -           TP_printk("amdgpu runpm reference dump 0x%x: 0x%s\n",
> -                     __entry->index,
> -                     __get_str(func))
> -);
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> --
> 2.34.1
>
