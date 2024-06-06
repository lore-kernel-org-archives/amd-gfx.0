Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E875C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 13:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA69910E94B;
	Thu,  6 Jun 2024 13:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSvy6nsB";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4777B10E94B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 13:20:56 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1f6ab88dfaeso8563465ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717680055; x=1718284855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HklvSwROZYQb79U+tnWErAJqo2xBQdkA3DTa+SWuw8g=;
 b=cSvy6nsB0HRnErf1/dks9T+lqA7w5g9vhBqcFQQ+yyfhtlIo3qWApBC7p0sMMSrISN
 HRxRn1eqIBkYrYCuG/HAurDGNH5IAm29yCZT02/SkLOwy/bq4UqaZrueF2UQTt7nDlcX
 XiGTewcvgZ7v8lWdcN+30W9mafqKUMtOBGtjvuOHqaU2RjcJA+R00iDzym5cppge2es1
 Rn2hXh1jU3s0Y1nNWA1RZ0WX15nmPKJ4rZ+AhwcAEfgvDW8Rq+TtQtElCGG6uRKjaZ6O
 sKqnHmfeQfKICcOuW45RFcn/DJzYLm9qzwyaPin+FZOyHPzvbzTFtildXSNNVZjePq27
 anGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717680055; x=1718284855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HklvSwROZYQb79U+tnWErAJqo2xBQdkA3DTa+SWuw8g=;
 b=SlTHVtkBr2W30h3adjMC97Nq1TWw5oF4x4AQpci204unqsN59RygWQ1QrL1fKk3j8p
 zZv5XC2+fq9vB2s0Yuja/ii3jl0m+LoPzJxMwG+2DBdXTvp6RWC3HsheHB7rSsi5KInC
 EX0mk/xNfFOJD5AKqsMcQYphCXpc0bgsIFpgUsdXAZHuslDr6uBQ9TOf23mJRlhR1p+l
 nvE1EVdHI0zMXrSEHP0MH510yX05NcMYgZqb/XLpc0djIEojLVxHN/oKK63ES2NHfZPA
 VGdFLno3cHw4c3vIOhOPK0OfW9Bjp6M0xBu1ZBgoWuAVZAr9jEHWH0+qhxNTyE4DYLQe
 Mqbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW38AMayK6wesk5kC3gp+WeXMspOcyyE6LySXcZvDUm8n6Jp0gooOV+ooLilKsCUwG5eq7qaPQgs8QaeN4AgLwUF306k3MjNr9HEQzOAg==
X-Gm-Message-State: AOJu0YxsqtKvsFNiI/ys/g9eidxYiHwL6K/nvpGwe8LknLPJ2WX4ls18
 3kqyObNl9zYetxqNeFV2y/6KNVoaCZGSx3YV5Lta0otqcjx9GCNLSQ7g5xfixwPooLiegZpyRIO
 6/CTaybFhsGtZrOeSwd4X4fxnx7HI4Q==
X-Google-Smtp-Source: AGHT+IEvgqIv5SDAdxIqHtkUIcQWoZcGPH2tBu0OPOiGANy8W89ylKU+RcIPyxV1dsDWQ5ER8Vo8OB8phWVLgFSvHaA=
X-Received: by 2002:a17:903:183:b0:1f6:ad7f:62a5 with SMTP id
 d9443c01a7336-1f6ad7f6377mr39107305ad.63.1717680055457; Thu, 06 Jun 2024
 06:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240605123159.90950-1-christian.koenig@amd.com>
 <CADnq5_Pq4jh7VrageBKPX4Qp1sGWPHTte2s_pxL20iQiosjUyA@mail.gmail.com>
 <0e63d585-cba0-4941-ae9f-4de91ab15e67@amd.com>
In-Reply-To: <0e63d585-cba0-4941-ae9f-4de91ab15e67@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jun 2024 09:20:43 -0400
Message-ID: <CADnq5_PN6k+QwHVoMMU3+v6rwiMUt3dO2=ng4CKJCtPM24SYGg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: revert "take runtime pm reference when we
 attach a buffer"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, Jun 6, 2024 at 2:19=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 05.06.24 um 15:20 schrieb Alex Deucher:
>
> On Wed, Jun 5, 2024 at 8:32=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
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
> Won't that kind of defeat the purpose of P2P DMA?  I guess it's a
> trade off between performance and power savings.
>
>
> Not really. P2P is useful because ti avoids the extra bounce through syst=
em memory.
>
> But when the ASIC is powered down and not producing any new data there re=
ally is no extra bounce.
>
> The only use case which would make it mandatory to keep the runtime
> pm reference would be if we pin the buffer into VRAM, and that's not
> something we currently do.
>
> We'll need to bring this back if we ever support that?  I think we'll
> want that for P2P DMA with RDMA NICs that don't support ODP.  That's
> one of the big blockers for a lot of ROCm customers to migrate to the
> in box drivers.
>
>
> Yeah, but we need a completely different approach in that case.
>
> The problem is that calling pm_runtime_get_sync() from the DMA-buf callba=
cks is illegal in the first place because we have the reservation lock take=
n here which is also taken during resume.
>
> So this here never triggered or otherwise we would have seen a deadlock (=
I should probably mention that in the commit message).

Thanks.  With that added to the commit message, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Christian.
>
>
> Alex
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
>
