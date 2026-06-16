Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C3BCD98D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FA810E553;
	Tue, 16 Jun 2026 21:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InCrSFRL";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F08110E553
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:46:52 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3042a99f0ceso648319eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781646411; cv=none;
 d=google.com; s=arc-20240605;
 b=K109CMyrNq+d5cP8/Le+9NLCbKC04M8gAUstFMsiOXZpB/CXrdIpus0m9DqP1Wg7+Y
 1AhszjeROjUVdMO+Yx4Yc68IzIcOiN2FU9jHwJVc50HOYfVUueq3przfdpPDfuAQ3JnP
 fvTsEevLoN/fYb2Fu3yeFJ2YUxolesr8dbI+vk771nIkfOdCKzU2aJjxvEjQmAEYmsgT
 6yPDSg1T6NzkzPAZwBFQjZyOFkr/9aySdCQ4YzHChenxYjJw07wiVcJid13AdRzk91Z2
 Se5/5nZhKQIPdh1eWSEWFnd999KCsYSC4XRR5fDBkJoZ7nQQy/lqsfxdQXzsf9AG96WX
 Sosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9DPdDj+va0DHTclU/f7fJ4Eao9RAXa/o0/2XqSn83k0=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=UXhZvnatbrIbMHkUIOnxIDjrsmIHcxMjgdlmGSPLRGnEvEG46ekcCHeuksdvWIE9Hm
 IorXaPdK9rhzUoe3/OCCf5lx6gABfuVHtpL+A5qiCieqyJjIZZrtdHUcDO1j/GEjIHVn
 kdwbEPlg5YvplivBYipBLAIZ5RIshFRHKc9VOi17JJueGIqsP05grEimm6tg9/J87Dd6
 b+GclJzAC1rGvYVCTIaPP+txItfLg9mDQcnNB/Y9Mhi4Bn2Mql4O4PeNOLyh1PSTY9PT
 mIdmvamVVDVih33J8tQcDcUqDPMy44pikifLjdMzmwN2ea5VcaAc0hyWpT+Gw5LGjU9P
 dWuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781646411; x=1782251211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DPdDj+va0DHTclU/f7fJ4Eao9RAXa/o0/2XqSn83k0=;
 b=InCrSFRLRTnGQVdt1Swu8JL8gDR0XT20J5anQz+wg6xQ0VsPREvRh+65eBho3BwF3f
 E9RvMuBHk5FcBxxe+dD2QjnlmzKcI8FHOZpsRIznWS07nV/sbkEhJvQ5kok5ach9OsxT
 EnQMnv9qe1zD5fJfnm3r1SYqhIc0WKfZnug+WMj0fqqX9mSXPeddHOrch665V0i6Ypl1
 mPZXx1m8thiY5+sspfR/pOgT79hepcPGITqf2IQtuJCSqcYUy92fAXrYrPH3A93yAOti
 TQdoNKtfSif/K2Xuj842RAasyeSXB2h8QTHuFDzn9vj0dj/AXpv3MYJYrcUMh38GW2TT
 mHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646411; x=1782251211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9DPdDj+va0DHTclU/f7fJ4Eao9RAXa/o0/2XqSn83k0=;
 b=OwyY9yL/1jVxyFpdZo/usa/RxSMB019XndXhk+rRP/0zA7q+by1s/05Nf94qVimHRp
 piKUR1rzVdhQwUwpvrcw8oVdkSmGHXZu0On+7a/cP4YGbt7Ldzuy9jUASMdQeKbxxm9L
 9OBEDpq33UjmGYVQtTdaR5aHZ1fdVieGXLAx3AnqBKJie0q2VqRblRAu8dD0RBjzUHca
 vE7x8Dpn9IdM4RRxbuwTGahcs0qltEJV49Ir1wI2KHyNqBQ6US9hRSeUPAVLj96+YDIr
 Y5cV7fOFl9b9Vvb5wTEsj1Iad7vqcu0PVUu0o86e2chROVyi8G+Q9wSEydns1HxQDWr9
 QsOQ==
X-Gm-Message-State: AOJu0YyPlp1PVaEm2aAxk5NLnjAdD2JYTXULezt1Vkw0sslB7OWzvqdK
 //LFZ4Wg0dLZ4vK9Cu4du0LuzICRjQu3MWPJNcHnvWbLf04Bu2eRP1g2IOv91ZCmAd7B5H3LtlR
 iCSI0MXSkrD289R2s3kKp8b/RS3tkBPU=
X-Gm-Gg: Acq92OEOXpUpurMKC/VxhCX+Rb3n/1x3u9Bg61cCgfCRApmKrwUxcmfL33kbAlrihAY
 QvUyXzgtygULDAUK+MP74lSZ1soWlK331b4//FweNAWLX7pnQjpNrewcG9bVs6byb78hT2+s/Vg
 ey85axutfZEHtpl2gXIpwuG/sk35zu+2Su/acafNSNNPO2Nf+gDSmgiMnIuYPkCZxTHpVGz4j0s
 Zih4aiRCePBDegbYvXVXYysM/V9gSeE7qFeUFtBxfG0BoZdbPeJGRUfL35TkL86PgbILkxMEymS
 ohNGFBvQPjxaGdhyZpT4dEaUg0NtJj98EiM7C+UAj7MCUYlWZlQzQEJzzM2swEthVIBf7w==
X-Received: by 2002:a05:7301:19a2:b0:307:2877:b2b6 with SMTP id
 5a478bee46e88-30bc9f41490mr304354eec.3.1781646411190; Tue, 16 Jun 2026
 14:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 17:46:39 -0400
X-Gm-Features: AVVi8Cdka8wLmqK-naPUhUUA6jrXgm6eiweOUSRt4M0qbKZy3G2ez3henpbGczA
Message-ID: <CADnq5_OjqsxVGNAn6YkSaZg9WygBCJXoKnQLW=bKQ0a5yfE5yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify
 guilty user queue
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

On Thu, Jun 11, 2026 at 12:34=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>

Feel free to take over the authorship of this patch.  You've done most
of the work.

>
> If we get an interrupt for a bad user queue (bad opcode, etc.), add
> a helper to handle the reset for user queues.
>
> v2: squash in fixes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40 +++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 12 +++++++
>  2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index de6848b4fd67..231ffb29fe5e 100644
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
> @@ -1111,6 +1117,34 @@ static void amdgpu_userq_restore_worker(struct wor=
k_struct *work)
>         dma_fence_put(ev_fence);
>  }
>
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                   u32 pasid, u32 doorbell_offset)
> +{
> +       struct xarray *xa =3D &adev->userq_doorbell_xa;
> +       struct amdgpu_usermode_queue *queue;
> +       unsigned long flags, idx;
> +
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
> +       xa_lock_irqsave(xa, flags);
> +       xa_for_each(xa, idx, queue) {
> +               if (queue->vm && queue->vm->pasid =3D=3D pasid &&
> +                   queue->doorbell_offset =3D=3D doorbell_offset) {
> +                       WRITE_ONCE(queue->guilty, true);
> +                       mod_delayed_work(adev->reset_domain->wq,
> +                                        &queue->hang_detect_work, 0);

Why wouldn't we use queue_delayed_work()?  If we get multiple
interrupts we want to queue resets for all of them.  Additionally why
do we need the extra guilty tracking?

Alex

> +                       break;
> +               }
> +       }
> +       xa_unlock_irqrestore(xa, flags);
> +}
> +
>  static int
>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 9df1b78407f5..a55d57e2c169 100644
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
> @@ -176,6 +178,16 @@ int amdgpu_userq_post_reset(struct amdgpu_device *ad=
ev, bool vram_lost);
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *q=
ueue);
>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 door=
bell);
>
> +/*
> + * CP packs the per-process doorbell_id of the queue in
> + * CTXID0[9:0] on priv-fault (same encoding KFD uses via
> + * KFD_CTXID0_DOORBELL_ID_MASK)
> + */
> +#define AMDGPU_CTXID0_DOORBELL_ID_MASK 0x3ff
> +
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                   u32 pasid, u32 doorbell_offset);
> +
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>                                    struct amdgpu_usermode_queue *queue,
>                                    u64 addr, u64 expected_size, u64 *va_o=
ut);
> --
> 2.49.0
>
