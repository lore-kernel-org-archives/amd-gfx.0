Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFA5CFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 14:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FAA410E2CE;
	Mon, 24 Nov 2025 14:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVo0leJu";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3313010E2CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 14:26:19 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7c9011d6039so29825b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 06:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763994379; x=1764599179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oZlfhgRYsiwvEZig8E+1NJeIYQ/7RVLTX7Inc6Tl8M=;
 b=UVo0leJu2vS3XxJS+pMHTeerfdm82MVolqwQN8exV2UG+vJJCk8CU+NabU9myxy4oA
 3rDnZYXVxKI/K2FAYc9DdcGqGlWfU7rwjLtTZufA01Kq+MNSUKfodNsAmuAxeZxFBGc0
 40ztNu30fhYxorlXAU6XzCczQkAMzDgy82aVGPVPSIKJCK7ospN3XR5/hMg5mHmgiog+
 MzzKlpKLrUGw3Ta6qAVnRKK6x3RaKQBU01s0A6g4+jaHw63DaRW+/3lQfhaVKt6+DfXw
 XFnXwV8lSPFYRojdNgfmFSn86Y3jb8HD6WZA7fVEe24VUkSQa+HHFRhcs0afk3RZUNgv
 jjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763994379; x=1764599179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oZlfhgRYsiwvEZig8E+1NJeIYQ/7RVLTX7Inc6Tl8M=;
 b=o2wnIjs13IWqHbZuEuqXnAOD9VfMWDWiL4v9zdGm0u2QQHiKqzzqN6cvJWXlq0/9ky
 YB1Ga3syY5YLwKHxo1NoH6hOXe1/GMbqth8vGxFYzVmsGSHUYUZngjnOg9kpoNTdXcLz
 eiQMlSsXAj6JgkrvVEyErtumxu/Pw6Y48NLdL7/P00wqG0Z/+PvqTSIZk7BYiQQ3B0OE
 U919+7zfsdluOUCcggU7N8OUWTSccS9zQf0WJxFoIOnSQCWkoZMaBneFUSLpL4xxJ3cA
 /lZwWOBJgAff8l9RwU+nJeWNl05WW1hUoTvtk4mdkh5vJi2a5PfehON9De2Mxq+HLtTT
 RF1g==
X-Gm-Message-State: AOJu0YyNEsETiTgFaEGX+RzNAGHZR3Zo+NDKRgnBBh6Weu75wVOVvvIp
 bBA+6YHgibC1RnpF41hBJOy0fpeajR52DBp4uMrAbiRDYFeTm1Q+bCKwyAysIF1lF029cuj6LPp
 pYpv0v50rHLbiMLTnmUZMSRD4Uxogz64=
X-Gm-Gg: ASbGncukNo2KywV/e9DZtx+J+kLWL31rkeCw1Q5o3f5Szar/NdneiTBjb+2prV/xNaG
 04BXBPBLlzH6Veq4imr7G2VRlThWxf4cdYFNso8yqrqCBxka4MnhKuNickGQXtqVdTvfCjmWCY/
 kGJjYcKfRRRTLvYU+NMU7Moz2WDbuTPgYjeuj9y7OWo8DurBTZOMq496YDxagJLzZEf2NSMTflh
 qepbrmUF9l/ofDYfVBgRvEkEj0dFjjckej321dfy2DviBIA57HbyZ93i9yQGMAONs1DWY6vb1eh
 8NnD7A==
X-Google-Smtp-Source: AGHT+IFDhy17E/a0AFk/m+4atwjc8F0VwoffUS+z8eTVUH2+uGVC4JJWzEUym1ZPEOVO91oY4K890WkLfYIjxOI8ylo=
X-Received: by 2002:a05:7022:ea48:10b0:11b:aff2:4cd5 with SMTP id
 a92af1059eb24-11c9d717ef2mr4780515c88.2.1763994378523; Mon, 24 Nov 2025
 06:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20251124085821.2759840-1-lijo.lazar@amd.com>
 <20251124085821.2759840-3-lijo.lazar@amd.com>
In-Reply-To: <20251124085821.2759840-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Nov 2025 09:26:07 -0500
X-Gm-Features: AWmQ_bnyjen6BSCia-8yEsrDd8CTcXjfVQUn5YUXaqTNg3Ff3ZfWjTb4SMIe2bw
Message-ID: <CADnq5_PyW6rv5CdyynNKgjkK3OTxGJgf=eVYaOFTT8TwadjE=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Rename userq_mgr_xa to userq_xa
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Jesse.Zhang@amd.com
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

Nice cleanup.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Nov 24, 2025 at 9:24=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Rename since it is an xarray of userq pointers
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 22 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 ++--
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  4 ++--
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index f765c481aada..2f97f35e0af5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -398,7 +398,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermo=
de_queue *queue,
>         uq_funcs->mqd_destroy(queue);
>         amdgpu_userq_fence_driver_free(queue);
>         /* Use interrupt-safe locking since IRQ handlers may access these=
 XArrays */
> -       xa_erase_irq(&uq_mgr->userq_mgr_xa, (unsigned long)queue_id);
> +       xa_erase_irq(&uq_mgr->userq_xa, (unsigned long)queue_id);
>         xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>         queue->userq_mgr =3D NULL;
>         list_del(&queue->userq_va_list);
> @@ -410,7 +410,7 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermo=
de_queue *queue,
>  static struct amdgpu_usermode_queue *
>  amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>  {
> -       return xa_load(&uq_mgr->userq_mgr_xa, qid);
> +       return xa_load(&uq_mgr->userq_xa, qid);
>  }
>
>  void
> @@ -769,7 +769,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>                 goto unlock;
>         }
>
> -       r =3D xa_alloc(&uq_mgr->userq_mgr_xa, &qid, queue, XA_LIMIT(1, AM=
DGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> +       r =3D xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +                    XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>         if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id=
\n");
>                 amdgpu_userq_fence_driver_free(queue);
> @@ -792,7 +793,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>                 r =3D amdgpu_userq_map_helper(queue);
>                 if (r) {
>                         drm_file_err(uq_mgr->file, "Failed to map Queue\n=
");
> -                       xa_erase(&uq_mgr->userq_mgr_xa, qid);
> +                       xa_erase(&uq_mgr->userq_xa, qid);
>                         amdgpu_userq_fence_driver_free(queue);
>                         uq_funcs->mqd_destroy(queue);
>                         kfree(queue);
> @@ -917,8 +918,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>         int ret =3D 0, r;
>
>         /* Resume all the queues for this process */
> -       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
> -
> +       xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>                 if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>                         drm_file_err(uq_mgr->file,
>                                      "trying restore queue without va map=
ping\n");
> @@ -1161,7 +1161,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
> -       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
> +       xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>                 r =3D amdgpu_userq_preempt_helper(queue);
>                 if (r)
>                         ret =3D r;
> @@ -1196,7 +1196,7 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mg=
r *uq_mgr)
>         unsigned long queue_id;
>         int ret;
>
> -       xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
> +       xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>                 struct dma_fence *f =3D queue->last_fence;
>
>                 if (!f || dma_fence_is_signaled(f))
> @@ -1246,7 +1246,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *=
userq_mgr, struct drm_file *f
>                           struct amdgpu_device *adev)
>  {
>         mutex_init(&userq_mgr->userq_mutex);
> -       xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
> +       xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>         userq_mgr->adev =3D adev;
>         userq_mgr->file =3D file_priv;
>
> @@ -1263,13 +1263,13 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mg=
r *userq_mgr)
>
>         mutex_lock(&userq_mgr->userq_mutex);
>         amdgpu_userq_detect_and_reset_queues(userq_mgr);
> -       xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
> +       xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
>                 amdgpu_userq_wait_for_last_fence(queue);
>                 amdgpu_userq_unmap_helper(queue);
>                 amdgpu_userq_cleanup(queue, queue_id);
>         }
>
> -       xa_destroy(&userq_mgr->userq_mgr_xa);
> +       xa_destroy(&userq_mgr->userq_xa);
>         mutex_unlock(&userq_mgr->userq_mutex);
>         mutex_destroy(&userq_mgr->userq_mutex);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 7c6dfc0e27a8..1eaa94f8a291 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -91,11 +91,11 @@ struct amdgpu_userq_funcs {
>  /* Usermode queues for gfx */
>  struct amdgpu_userq_mgr {
>         /**
> -        * @userq_mgr_xa: Per-process user queue map (queue ID =E2=86=92 =
queue)
> +        * @userq_xa: Per-process user queue map (queue ID =E2=86=92 queu=
e)
>          * Key: queue_id (unique ID within the process's userq manager)
>          * Value: struct amdgpu_usermode_queue
>          */
> -       struct xarray                   userq_mgr_xa;
> +       struct xarray                   userq_xa;
>         struct mutex                    userq_mutex;
>         struct amdgpu_device            *adev;
>         struct delayed_work             resume_work;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index f44cb17b1e2f..25f178536469 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -542,7 +542,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,
>         }
>
>         /* Retrieve the user queue */
> -       queue =3D xa_load(&userq_mgr->userq_mgr_xa, args->queue_id);
> +       queue =3D xa_load(&userq_mgr->userq_xa, args->queue_id);
>         if (!queue) {
>                 r =3D -ENOENT;
>                 goto put_gobj_write;
> @@ -904,7 +904,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,
>                  */
>                 num_fences =3D dma_fence_dedup_array(fences, num_fences);
>
> -               waitq =3D xa_load(&userq_mgr->userq_mgr_xa, wait_info->wa=
itq_id);
> +               waitq =3D xa_load(&userq_mgr->userq_xa, wait_info->waitq_=
id);
>                 if (!waitq) {
>                         r =3D -EINVAL;
>                         goto free_fences;
> --
> 2.49.0
>
