Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D12AC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 15:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F0710E158;
	Wed, 19 Aug 2026 15:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CNJ48x9o";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5118610E158
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 15:51:59 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so136131a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 08:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787154719; cv=none;
 d=google.com; s=arc-20260327;
 b=B6SFB2TjNoGbEUW6uK7JAk04SoADz7FDCNuwLjJRpve5G7/7GnHV+yfMR02ORcfiub
 xAs4YYTbe9Mh/h5BqSbrFZhOGMHZ0uha9kxZPcNo87tMFu53O55hQ80xLTGp+Qzc6rkS
 fVvnZjfNccl8voeCNlU/Tf37xFOnV96WszowC28XKcjx3RxvbWxd4SHkp07plDEE1tMc
 SbgUdbS8MtwaCXcuF9RFxHXFNfz4CBqVdovkQuti6EbZuT/rFRzFaUreO/hEH2XCesEY
 mSseENVfkFZKXw8UTBd02yh5tZJ3maXsRdkj8dcmwXauDjRImwgC7+oVAHfzdgk8WyhA
 vEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2G12cX48EQxPkFaPuaR8+L0WFnCRrTQv2d4+am8+yMM=;
 fh=SugLP5RVdaxhUwUNVaE9THGi7Q/2QUv1guH9D3PyQLM=;
 b=XZkNlJzhSPDu3uRRBntB2/1Phc00UOuCXYzMDnnRCM4xonayGQz10f26x9FvsnWqBU
 h7BS6kzwU5AqGExVG1N3HTbtWVaDLxocgOCQNz/1Tje33Wtan4wmfz4/HgnUXYKbQR/X
 WmlwyoIZOQw1//sITTIKNS2xjinOL0pKGy51VdPWgxyL7zRB9moOaxch85De8qhOJVn9
 5RjSiDU9L6rZVfdyme3kC/fXGf+CtyyX8RkGn/rwW+AYA/F/xg/aDnhU7xb3tRxFeniq
 WvoP5QMhM2wZ12WaQ9K5ZgjBItPufbNf6bjM6QMQQz8l4zsllitL5UqjNeSES7YvQ1Lu
 OdCg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787154719; x=1787759519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2G12cX48EQxPkFaPuaR8+L0WFnCRrTQv2d4+am8+yMM=;
 b=CNJ48x9oLvdIBzDFwz/rOwHKaiepj7Se3r2zUGWZV1JPSLz8r6oEjzBL/m0kaXlFr0
 18DE9H34okgzfV8XfCXs8Ri1b+jR4IGih/9dsfcResTJDiKEtWb68hvbbRgdVL1JQNmZ
 B08M4ZP/2G0OcuK8x7TuSl7hYM7lOZOQHVY9oFgoQR2ZCBymxICV6Do5XUQerIBt3BsY
 ekG20vxoZ9LLXv6mKyax1PhrFI1sG3kps+fnXRXDiOk/bzxzadm9umeieVshm1OJynlU
 4miqVQrzk+Ld++yBnt0A0Fb2W6sjNDSuhPTtco6b8CbwoWs5nHhHUkmTNBmKl8nsR23w
 BlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154719; x=1787759519;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2G12cX48EQxPkFaPuaR8+L0WFnCRrTQv2d4+am8+yMM=;
 b=EXqfQ4ct//rmxPiWxh82lInxKXUafBTPGKwG3wBFYMMrdc3qJT34I0gCiWJNi9SMbi
 PXgZC2/O/8mfiD2Ol+yCWkVKXDoFWOuM8Z8JYFRH0AX79rDUwBDnfdtb/2lvRKze0kQ0
 mnd/Lv5mOVCAiHQ862thkclqOIc0FYZUeGhMJbK7VGKx4pnyDDRZtaSdQjQcVsCVUCIr
 KW01KkfgKsWPXyaEhiSCwEQmKzplnRHtzHIbQuwLMUft9WDd1rQWORJ8U4iGW7+U7uSg
 LtEmyarTso9X9BSFWHjK/zLIwy4aUQNUDXEkGR70z56KxBfIyzs0W8NwuunQud7mjusF
 SzkQ==
X-Gm-Message-State: AFuF++lgr6G9xqWWrRjQCGlprofNA8UWeceWXdK50NYNj6moy5e2xINy
 kLMDgkhWiMqNvkX29DbiUPIhWy5t2ADU8pj0LV2H9rMwMq6gyuFGijtiZAcB3ZQKqdZ4ItZuXdP
 2WCu00pe6CfN8Doliylhib3pqSVRM1cw=
X-Gm-Gg: AR+sD106naLAZ2Qu5O05J9bSKFi1PrG5Tu9yiWopN2WX/uBgOZIcMNyAbtUmdhbNRch
 BuY6YcQxeD3nWILDuMPkpXboB2nrIYZD1skx+SMygssq+KgvMi+5gg+kAW6z/CtD5nipgomW0MT
 diy1yvO92XKGnO4sXV9tJabj5JivTe/vufm6ebzBqfB7HqDUqFhhk7Y7LVU9Y7j/6ap1qMMLNmh
 3xggYyDjZ+a3EG+TolQk7VH/Y56sNcBz6OjCqfjHFk8Y4z4q70V9ygPDQ+DyDNp+mDXt94s+SP5
 uYvLgve/mGX7EsgGz2e/1XAWF2W6ekyqlLW7dufz4cFgY/eOypg7vMQuL5v7df2tpGIAAx81XIv
 ERktxQC9Qoa1cmU2cMbCjTgEzXSZdnUg=
X-Received: by 2002:a17:90a:e70e:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-39581285b54mr4983360a91.3.1787154718565; Wed, 19 Aug 2026
 08:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260814033302.406402-1-Prike.Liang@amd.com>
In-Reply-To: <20260814033302.406402-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Aug 2026 11:51:45 -0400
X-Gm-Features: AcwNN1UaW6H7lAu0ZPCCDzrHdT6PJDvOfZpyLpg9dxnW6aXfiX8xVgpbwU_qH9Q
Message-ID: <CADnq5_OMJpBgYYev6nBf7BJD-+WxPc5YS-42vHkxQH_udD5hCQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/userq: fix lock missing for userq fence
 error set
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Aug 13, 2026 at 11:50=E2=80=AFPM Prike Liang <Prike.Liang@amd.com> =
wrote:
>
> amdgpu_userq_fence_driver() and amdgpu_userq_fence_driver_destroy()
> don't acquire the dma_fence spinlock, so locking the dma_fence lock
> before test the signaled state and set error state.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 19af1adc2921..09e2079cfdbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -191,14 +191,15 @@ void amdgpu_userq_fence_driver_destroy(struct kref =
*ref)
>         struct dma_fence *f;
>
>         spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +       lockdep_assert_held(&fence_drv->fence_list_lock);
>         list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
>                 f =3D &fence->base;
> -
> -               if (!dma_fence_is_signaled(f)) {
> +               spin_lock(dma_fence_spinlock(f));
> +               if (!dma_fence_is_signaled_locked(f)) {
>                         dma_fence_set_error(f, -ECANCELED);
> -                       dma_fence_signal(f);
> +                       dma_fence_signal_locked(f);
>                 }
> -
> +               spin_unlock(dma_fence_spinlock(f));
>                 list_del(&fence->link);
>                 dma_fence_put(f);
>         }
> @@ -423,11 +424,16 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_u=
serq_fence *fence,
>         struct dma_fence *f;
>
>         spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -
> +       lockdep_assert_held(&fence_drv->fence_list_lock);
>         f =3D rcu_dereference_protected(&fence->base,
>                                       lockdep_is_held(&fence_drv->fence_l=
ist_lock));
> -       if (f && !dma_fence_is_signaled_locked(f))
> -               dma_fence_set_error(f, error);
> +       if (f) {
> +               /* nest f->lock inside fence_list_lock */
> +               spin_lock(dma_fence_spinlock(f));

Why do we need to take the fence spinlock for userqs, but not for
kernel queues?  See amdgpu_fence.c

Alex

> +               if (!dma_fence_is_signaled_locked(f))
> +                       dma_fence_set_error(f, error);
> +               spin_unlock(dma_fence_spinlock(f));
> +       }
>         spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>
> --
> 2.34.1
>
