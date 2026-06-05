Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDF0CD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 20:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F3611AAF6;
	Fri,  5 Jun 2026 20:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XyL9bpMj";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9E111AAF6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 20:14:27 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30741f821cfso281550eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 13:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780690466; cv=none;
 d=google.com; s=arc-20240605;
 b=L3fRPiQT8bOX0fh2Fh8elRRlvjaWCrE4C3L3dUoeGDWmez6cjaOk8Ieu+YPfawt2Bn
 L4DVT+2ZpP+V+M9tAC6tf5S/CaGy2A+YXusAPJR+wr9SoZA8dzza1c03HTwQNx3bbais
 uEp/2d0nejGbbnh8X9dTW+63ph+Vv94/mzxhd7tRYRsJae1u8GzyF6UFzew8m1tfY16q
 LhfsfE0vek1IreH1z410XDQA7gc94wCWPABTnsdmWcyIpwBqVBIcp1OAG+eDweVBiKrX
 EZM3wEhGtdW6kF8zkgAVCCy1CifmoODlt1FIqQZRTEkZ6WVlamnpJ5jrcwJM5lGfbej/
 U+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4gTrSDLGyJF9iLo0KtvOeeI0eTO0T0D8kcHwKiMqh2w=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=L1P7Rzc+Td0sH1iTHd2ksXy1oFwSaZykHVPe5z5jzgHqMY9J8ADrIAXJN0YuY7Cc0e
 npa43FyMIJ7y4waj4Y7LdlGZsJOkLuaKHuznVZePO7UT4GBzReVHXuyGC5t9/gHtUAhr
 E6lJunY+vDuDLOtO39ij8VJzD3lj8rZ0MOe2TNXLp4t9xHosedTW3BZqB2OowtpyVkBy
 HJiTlTAfWXiDFjfFWfzuo2dr+RB79ODfRCOHN8vjE/9VOeMucSSA9rXMew+GoZTs1WLG
 baFO/MUeFi8ly93+7Ru4loRVug0dES0I7Rhi6VnwNBe8DMMUMyvZ67jsp834pZogbwTK
 UZdQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780690466; x=1781295266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gTrSDLGyJF9iLo0KtvOeeI0eTO0T0D8kcHwKiMqh2w=;
 b=XyL9bpMjijMVWnqc0B+d0P1h5AZX28KD2oBOpaRcKUX1MNUZlnnFiLJTaG6KkUOBUd
 PDpxG0B7rZNzujfij8B+QWyo29Y7nmJr5/yQSHaNDzMImriP31WcSN64ILqAfBR1JdOW
 X4uqLmJy1W+Ex9Go+zuW5Ew2eczaRx5azMiqLfnxLSnvIgvf34rLjNF/Bz2bRpnw31nK
 8E3LKHC0WDbB4znjGWadN2rhrn4d6t2M+L/gmHMC6Gsb01LgAbs7Pm3r5ceETOPF39ZO
 F0Vaubi5V8JfFd60+hf517MOFnH/bbQ8N/S8w+FyqnOI7q7bH/WAVSirh8x78yHUsc5T
 WSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780690466; x=1781295266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4gTrSDLGyJF9iLo0KtvOeeI0eTO0T0D8kcHwKiMqh2w=;
 b=EZePL5PjH3DQyTIGkTwL6i1+9t5VvTme1pTNwYR2fkATN8zI5rGNWB3X3jto7KFYqs
 z+4lRWfuRxPEFRQFpsF6yq4rZubRMnJRCDy596td5jiFKxof288G3phyQ144A1LJj+3D
 Hu7vHW9Jdsp5Gi/rwcqcTDV+JAyhoF+G8sQVpM9FjK2eNxLuAnkc+XTXBsCEcV0jSEEQ
 TDm+dYhII2atZ/4PZGo4JhCIuuYQt7e9OAO1Et8jPR7ELedKZd1zsgpDfImw8mA1X5Zg
 WuzD4YeapPlJ3byqySSdYH8Ii72Hh6apnAVCSsAFARcP+XLVlbXzJKViA29NMZB/K8lJ
 v3aA==
X-Gm-Message-State: AOJu0Ywz9u8W7+5H7QoRBTu2hJ0c0zPBLpFuZ9cATyA4KxG9wv9Zz5zh
 yJBQ/3duDA96isorbZVfbi7ZAkhVWItoTK5img9DJizWI9wH2NCuDBTew9uJEY+8Hkz22EQ1Wvl
 qH+Y6dQVYLJzbMS9XJYQmaUlL4BqbXIY=
X-Gm-Gg: Acq92OFJpZU7EkNaCu/x5qEGkIjQwdmfAnU7keESvfgdMWqTWXkIwpLz39P7fgUr2hB
 IL6JbGyHR2cLFpzOZOwvMlXMBs4fprAOB/+LlT4GpDaa6dcC9QFnuDo4/mXvRf9aT0uGLSzazT7
 5A/e4tkcAR5DfqJD/KZwn9KIVKowKdY43SmKbLxyM5Q0Veqqazm/nJ9p2z687dyo6+4uAePwGsU
 LV8KywDRgNl9knKl+mie2JVCAgKt6HmLSJvvpfGV979FOKktS4smj/xXQy9F/GMNkfaxVXzAgra
 ESatrEEReUoAm6Cuacnh9QtVEIYLWcMMTdFOm3Hv9rzclNYr3hG0yg1fW51pHdNoALDgHBmd2uN
 mJ4iG
X-Received: by 2002:a05:7022:e01:b0:134:c6ab:a516 with SMTP id
 a92af1059eb24-13806759a9dmr1116123c88.6.1780690466291; Fri, 05 Jun 2026
 13:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260605103144.2537331-1-Jesse.Zhang@amd.com>
 <20260605103144.2537331-4-Jesse.Zhang@amd.com>
In-Reply-To: <20260605103144.2537331-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 16:14:14 -0400
X-Gm-Features: AVHnY4JwmAroeXjrLfY5rbr7f5KJjxqmm3Jre1n-aNrAUdfHdkBkpRqXLPRuoms
Message-ID: <CADnq5_MbDbev_4GTPE0jWYhxTasotJuaBUtp0XwQRJ0ZVyDR_Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu/userq: identify guilty user queue from
 priv-fault IRQ
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Fri, Jun 5, 2026 at 6:39=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> CP priv-fault IRQ carries the offending queue's per-process
> doorbell_id in src_data[0][9:0] (same encoding KFD extracts via
> KFD_CTXID0_DOORBELL_ID_MASK), with pasid in entry->pasid. The
> existing lookup against BAR-absolute doorbell_index never matches
> this payload, so the targeted-reset path is never taken.
>
> Cache args->in.doorbell_offset on the queue and look it up by the
> (vm->pasid, doorbell_offset) pair. Add a queue->guilty flag set by
> the IRQ and consumed via xchg in hang_detect_work; on a hit, route
> compute reset through amdgpu_gfx_reset_mes_compute(..., queue, ...)
> and fire hang_detect immediately via mod_delayed_work(..., 0)
> (queue_delayed_work() is a no-op when the work is already armed at
> submit time).

I would reorder/squash these patches to add support for handling the
IH token format for this interrupt and then implement the interrupt
handling for the user queues.

Alex

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 ++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 10 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 10 ++++--
>  4 files changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 99c5adf3cb24..231ffb29fe5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -140,9 +140,14 @@ static void amdgpu_userq_hang_detect_work(struct wor=
k_struct *work)
>                                                  AMDGPU_RESET_TYPE_PER_QU=
EUE)) {
>                 int r;
>
> -               if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
> -                       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NU=
LL, NULL, NULL, NULL);
> -               else
> +               if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> +                       struct amdgpu_usermode_queue *guilty_uq;
> +
> +                       /* IRQ-side WRITE_ONCE(guilty,true) hand-off via =
xchg */
> +                       guilty_uq =3D xchg(&queue->guilty, false) ? queue=
 : NULL;
> +                       r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NU=
LL,
> +                                                        guilty_uq, NULL,=
 NULL);
> +               } else
>                         r =3D userq_funcs->reset(queue);
>                 if (r)
>                         gpu_reset =3D true;
> @@ -671,6 +676,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         }
>
>         queue->doorbell_index =3D index;
> +       queue->doorbell_offset =3D (u32)args->in.doorbell_offset;
>         r =3D uq_funcs->mqd_create(queue, &args->in);
>         if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> @@ -1111,16 +1117,31 @@ static void amdgpu_userq_restore_worker(struct wo=
rk_struct *work)
>         dma_fence_put(ev_fence);
>  }
>
> -void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 door=
bell)
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                   u32 pasid, u32 doorbell_offset)
>  {
>         struct xarray *xa =3D &adev->userq_doorbell_xa;
>         struct amdgpu_usermode_queue *queue;
> -       unsigned long flags;
> +       unsigned long flags, idx;
>
> +       /*
> +        * CP priv-fault payload is (pasid, src_data[0] & 0x3ff) =E2=80=
=94 the same
> +        * per-process doorbell encoding KFD extracts via
> +        * KFD_CTXID0_DOORBELL_ID_MASK. Find the offending queue by the
> +        * (vm->pasid, doorbell_offset) pair, mark it guilty and fire
> +        * hang_detect immediately (queue_delayed_work() would no-op if t=
he
> +        * work is already armed at submit time).
> +        */
>         xa_lock_irqsave(xa, flags);
> -       queue =3D xa_load(xa, doorbell);
> -       if (queue)
> -               amdgpu_userq_start_hang_detect_work(queue);
> +       xa_for_each(xa, idx, queue) {
> +               if (queue->vm && queue->vm->pasid =3D=3D pasid &&
> +                   queue->doorbell_offset =3D=3D doorbell_offset) {
> +                       WRITE_ONCE(queue->guilty, true);
> +                       mod_delayed_work(adev->reset_domain->wq,
> +                                        &queue->hang_detect_work, 0);
> +                       break;
> +               }
> +       }
>         xa_unlock_irqrestore(xa, flags);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 5a2ae33135da..1e765cd765ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
>         enum amdgpu_userq_state state;
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
> +       u32                     doorbell_offset;
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
> @@ -86,6 +87,7 @@ struct amdgpu_usermode_queue {
>          * Delayed work which runs when userq_fences time out.
>          */
>         struct delayed_work     hang_detect_work;
> +       bool                    guilty;
>         struct kref             refcount;
>
>         union {
> @@ -175,7 +177,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *ade=
v);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *q=
ueue);
>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 door=
bell);
> -void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev, u32 door=
bell);
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                   u32 pasid, u32 doorbell_offset);
>
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>                                    struct amdgpu_usermode_queue *queue,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index ea323d241324..27d0a3dbfce8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6681,10 +6681,16 @@ static int gfx_v11_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset =3D entry->src_data[0];
> +       /*
> +        * CP packs the per-process doorbell_id in src_data[0][9:0]; uppe=
r
> +        * bits hold other CTXID0 fields. Same mask KFD uses
> +        * (KFD_CTXID0_DOORBELL_ID_MASK).
> +        */
> +       u32 doorbell_offset =3D entry->src_data[0] & 0x3ff;
>
>         if (adev->enable_mes && doorbell_offset) {
> -               amdgpu_userq_process_reset_irq(adev, doorbell_offset);
> +               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +                                              doorbell_offset);
>         } else if (!adev->gfx.disable_kq) {
>                 u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
>                 u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b3f1bbf3fc13..7c269cb75e07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5009,10 +5009,16 @@ static int gfx_v12_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u32 doorbell_offset =3D entry->src_data[0];
> +       /*
> +        * CP packs the per-process doorbell_id in src_data[0][9:0]; uppe=
r
> +        * bits hold other CTXID0 fields. Same mask KFD uses
> +        * (KFD_CTXID0_DOORBELL_ID_MASK).
> +        */
> +       u32 doorbell_offset =3D entry->src_data[0] & 0x3ff;
>
>         if (adev->enable_mes && doorbell_offset) {
> -               amdgpu_userq_process_reset_irq(adev, doorbell_offset);
> +               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +                                              doorbell_offset);
>         } else if (!adev->gfx.disable_kq) {
>                 u8 me_id, pipe_id, queue_id;
>                 struct amdgpu_ring *ring;
> --
> 2.49.0
>
