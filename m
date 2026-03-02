Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F9EA4E2A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 16:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426FB10E362;
	Mon,  2 Mar 2026 16:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+JeiqHk";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED0610E362
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 16:16:48 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1273882d901so267477c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2026 08:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772468207; cv=none;
 d=google.com; s=arc-20240605;
 b=cOGURg+XZBc+MPuDXrX4BQnWrBj5wIdgQXY4UQzcrWZf3aWIOpg2dbyBpXPO6kTbPs
 f3OVhSU7gF8TYT0ly1OPehdiJxK31hqrMo1ZAFc/chsMxldiphvdTxsEuEWAzp8LOGic
 HltpN6rIOPrsdJNSSim/owAyzHuQKqzwRlED6pCEMbJUlgqcpX19JRuHr7B3dFZ5LrsM
 9hIKFlOayNfHgF7/pz/pOqbmF+YYdYkYhnHXqdsl+AQWwfVJWjWobdRZ0BfH4nPaQc+L
 xuJqD3coSDL/gYRqKQUfkFkYdA0T24nABKw45kzLIQWdV0LjD2lRmh4xmcOozC3xyJ8L
 W3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RaZZPVjXYGg9uHX9sHQWJ7zjWk+1DPHsIp0Xkrc/3XQ=;
 fh=j0DkRL2ebxQADTh7EgemN9EctI2OkuvJKFXoy+ZWIgo=;
 b=N61A0gaIjPHt0FZD4GkOax95x35uvTo4kHc7tGSXIeX2Pz2KPXmE2qyjI5IPNNsyGi
 S7uGps/Mc5Lwyt4K/kKPSvLoxL03OJoMIhjbFoxNX/OAafxhw8wIDTm3i3jqKSMppX8i
 1/vCW5mCOkyaRdqnvEn5CHww23WRbR3VvgKJgUbXWH3Me6elCGKbR0jYPsUucSh2ccJ2
 hsjXUydWmFfwFftfIEw84zihtNagTFGzafxsg2Wt0gqIVreAiotf3/Ru14o7y1D+L5qU
 nPlILRQ3dQPQ7IE4KUuXk72emrqTjDhR/5UpVQObpu8z+qUKFvz2L48jOFGhgqA8d5kq
 sIaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772468207; x=1773073007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaZZPVjXYGg9uHX9sHQWJ7zjWk+1DPHsIp0Xkrc/3XQ=;
 b=l+JeiqHk0VuT51ZfZv4pTz3Q5OBrj5FMBhP4GaNRhnkNtaqJ883Yd2+eaILMDRtBsG
 gh7I/OBpOeFr24/pF4ADE2lgZSJVeKp+6mzjU8OAocl2pDho3rAJS35H43Q4B9TTwuiM
 TglIf/kNOZgRg5QTxwGBDOLCwGzkTtZPPOem/7iRBWNkE0OmkKhV3jv5xsK7bq1CpH9O
 ehnEXn53VY2m+gZtfa+64j9kszPa0ObvYEEx8tE0qtG7mKJq+YGpI6wfmWAEMxoWbDEF
 wuzYDTxYR25MZchS+tAsZvYhRARElD8kW5khZg4xsz1CdIXvd7LQNBZ0EIpPsoO1a0nO
 6BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772468207; x=1773073007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RaZZPVjXYGg9uHX9sHQWJ7zjWk+1DPHsIp0Xkrc/3XQ=;
 b=LS0jka/a3AYhbK6ZgTVEXcob8BruxCBZc9M+85k/eOSpTwqDUdarjgILp5BURvSDEx
 /obpm1AC1sku+8JirVQE1mvGnuzt9krXF5rpU6FoKqzjBXxSCwn5WnX9XZhhJ/exOaqV
 v3PCGZR0vZ+wJ4X7DV/51BfhUD2jDAx4MUQUEu1Hxz3HNzrdgh+qnk/beaICLfmLALl0
 yIHgnHrixc36PKADPr7fl8P0FI2tGSecTeiWhGvbDqrnUBsGtVSifCNKzjVMU6691FHV
 qFZS5x/PRsA5DYRXGs++wkXMDWRMueygW86WCA4gqmtVaFg28lEHw0IZEDHvoEYaCCyB
 FRQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh3357iORW3p5gql8utngWmeOvuVUbXlpdGlIQ1Kt60LThdjR4hC9c+wbHe5lWjNIYchFj5qn1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/a7tM30iSeAUby6zkGpy3i3kwMcxiSk8GeYNmWiA1M2gpvy3j
 eoL9/f5qqVbZTBazjBtaHm5r0jYihLr8BpSVT0VhEnk3jvBJ3LJI6b9IbdGR3539Ku5K5ihtKsl
 fSPOGYPmzXJNV6jtPuf6wmB7yi21LNb4=
X-Gm-Gg: ATEYQzypNVUg5DTNvI7IFY32XqXGm5HgXFTNqLHIj2L+OUBUNcNEdsV6Jgy9vsmIQja
 6zC5RszlWAPvcHJp5cK6TVR+c63CQs9TLv9BrqmjV+oUkQcPjVqKgK4LDWQ09cgy1U2ojwBiP7V
 twBIlv76ldVRN5okWda9P0tlckZ4n01puwB6Z7r87Xjre6b5TIusuQfpcw2tTOsyu/ojBSntHDK
 7KDmmOmfEMSOqvE8YnejIzPg8alrRW3YP2ve6LcbWgEm1GGfFLdu/kp1kyHviWGP50cIFr7y0yi
 PQT3dDqWTR7KDh28XwwAoiTS4p2V53NnFOCXq85BkJWCd6QGPn5ru1AMVktk/vOURErFBA==
X-Received: by 2002:a05:7022:439e:b0:127:1186:812f with SMTP id
 a92af1059eb24-1278fd12699mr2598309c88.7.1772468207156; Mon, 02 Mar 2026
 08:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20260302133554.1233013-1-sunil.khatri@amd.com>
In-Reply-To: <20260302133554.1233013-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2026 11:16:35 -0500
X-Gm-Features: AaiRm53DBsZpKDJw8Vkm_qo2lQPbyJ4yVUqVUIAXrJ2i3w-cypfOhnXvwd1pDis
Message-ID: <CADnq5_NBdpKBvuVGWe2=po-aKwvszS4EWhmCH8hOCZzxjKW=tg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Mon, Mar 2, 2026 at 8:36=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> To avoid race condition and avoid UAF cases, implement kref
> based queues and protect the below operations using xa lock
> a. Getting a queue from xarray
> b. Increment/Decrement it's refcount
>
> Every time some one want to access a queue, always get via
> amdgpu_userq_get to make sure we have locks in place and get
> the object if active.
>
> A userqueue is destroyed on the last refcount is dropped which
> typically would be via IOCTL or during fini.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 85 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 ++-
>  3 files changed, 76 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..9eced6cad8fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -461,7 +461,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermo=
de_queue *queue,
>         uq_funcs->mqd_destroy(queue);
>         amdgpu_userq_fence_driver_free(queue);
>         /* Use interrupt-safe locking since IRQ handlers may access these=
 XArrays */
> -       xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>         xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>         queue->userq_mgr =3D NULL;
>         list_del(&queue->userq_va_list);
> @@ -470,12 +469,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_userm=
ode_queue *queue,
>         up_read(&adev->reset_domain->sem);
>  }
>
> -static struct amdgpu_usermode_queue *
> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> -{
> -       return xa_load(&uq_mgr->userq_xa, qid);
> -}
> -
>  void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>                              struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -625,22 +618,14 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq=
_mgr *uq_mgr,
>  }
>
>  static int
> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_user=
mode_queue *queue,
> +                    u32 queue_id)
>  {
> -       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> -       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> -       struct amdgpu_usermode_queue *queue;
>         int r =3D 0;
>
>         cancel_delayed_work_sync(&uq_mgr->resume_work);
>         mutex_lock(&uq_mgr->userq_mutex);
> -       queue =3D amdgpu_userq_find(uq_mgr, queue_id);
> -       if (!queue) {
> -               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue =
id to destroy\n");
> -               mutex_unlock(&uq_mgr->userq_mutex);
> -               return -EINVAL;
> -       }
>         amdgpu_userq_wait_for_last_fence(queue);
>         /* Cancel any pending hang detection work and cleanup */
>         if (queue->hang_detect_fence) {
> @@ -680,6 +665,38 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queu=
e_id)
>         return r;
>  }
>
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *=
uq_mgr, u32 qid)
> +{
> +       struct amdgpu_usermode_queue *queue;
> +
> +       xa_lock(&uq_mgr->userq_xa);
> +       queue =3D xa_load(&uq_mgr->userq_xa, qid);
> +       if (queue)
> +               kref_get(&queue->refcount);
> +
> +       xa_unlock(&uq_mgr->userq_xa);
> +       return queue;
> +}
> +
> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
> +{
> +       struct amdgpu_usermode_queue *queue;
> +
> +       xa_lock(&uq_mgr->userq_xa);
> +       queue =3D xa_load(&uq_mgr->userq_xa, qid);
> +
> +       if (queue && refcount_dec_and_test(&queue->refcount.refcount)) {
> +               __xa_erase(&uq_mgr->userq_xa, qid);
> +               xa_unlock(&uq_mgr->userq_xa);
> +
> +               if (amdgpu_userq_destroy(uq_mgr, queue, qid))
> +                       drm_file_err(uq_mgr->file, "Failed to destroy use=
rmode queue\n");
> +               return;
> +       }
> +
> +       xa_unlock(&uq_mgr->userq_xa);
> +}
> +
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
>                                         int priority)
>  {
> @@ -891,6 +908,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>
>         args->out.queue_id =3D qid;
>         atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +       /* drop this refcount during queue destroy */
> +       kref_init(&queue->refcount);
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -1001,9 +1020,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>                 break;
>
>         case AMDGPU_USERQ_OP_FREE:
> -               r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
> -               if (r)
> -                       drm_file_err(filp, "Failed to destroy usermode qu=
eue\n");
> +               struct amdgpu_fpriv *fpriv =3D filp->driver_priv;

Some compiler may complain about mixed declarations and code if you
don't put this block in { }.

> +
> +               amdgpu_userq_put(&fpriv->userq_mgr, args->in.queue_id);
>                 break;
>
>         default:
> @@ -1023,16 +1042,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr =
*uq_mgr)
>
>         /* Resume all the queues for this process */
>         xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +               queue =3D amdgpu_userq_get(uq_mgr, queue_id);
> +               if (!queue)
> +                       continue;
> +
>                 if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>                         drm_file_err(uq_mgr->file,
>                                      "trying restore queue without va map=
ping\n");
>                         queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> +                       amdgpu_userq_put(uq_mgr, queue_id);
>                         continue;
>                 }
>
>                 r =3D amdgpu_userq_restore_helper(queue);
>                 if (r)
>                         ret =3D r;
> +
> +               amdgpu_userq_put(uq_mgr, queue_id);
>         }
>
>         if (ret)
> @@ -1266,9 +1292,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq=
_mgr)
>         amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +               queue =3D amdgpu_userq_get(uq_mgr, queue_id);
> +               if (!queue)
> +                       continue;
>                 r =3D amdgpu_userq_preempt_helper(queue);
>                 if (r)
>                         ret =3D r;
> +               amdgpu_userq_put(uq_mgr, queue_id);
>         }
>
>         if (ret)
> @@ -1301,14 +1331,21 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_=
mgr *uq_mgr)
>         int ret;
>
>         xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> +               queue =3D amdgpu_userq_get(uq_mgr, queue_id);
> +               if (!queue)
> +                       continue;
> +
>                 struct dma_fence *f =3D queue->last_fence;
>
> -               if (!f || dma_fence_is_signaled(f))
> +               if (!f || dma_fence_is_signaled(f)) {
> +                       amdgpu_userq_put(uq_mgr, queue_id);
>                         continue;
> +               }
>                 ret =3D dma_fence_wait_timeout(f, true, msecs_to_jiffies(=
100));
>                 if (ret <=3D 0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for=
 fence=3D%llu:%llu\n",
>                                      f->context, f->seqno);
> +                       amdgpu_userq_put(uq_mgr, queue_id);
>                         return -ETIMEDOUT;
>                 }

Do you need a put here as well?

Alex

>         }
> @@ -1368,9 +1405,15 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr=
 *userq_mgr)
>         mutex_lock(&userq_mgr->userq_mutex);
>         amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
> +               queue =3D amdgpu_userq_get(userq_mgr, queue_id);
> +               if (!queue)
> +                       continue;
>                 amdgpu_userq_wait_for_last_fence(queue);
>                 amdgpu_userq_unmap_helper(queue);
>                 amdgpu_userq_cleanup(queue, queue_id);
> +               amdgpu_userq_put(userq_mgr, queue_id);
> +               /* Second put is for the reference taken in this function=
 itself */
> +               amdgpu_userq_put(userq_mgr, queue_id);
>         }
>
>         xa_destroy(&userq_mgr->userq_xa);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index f4d1d46ae15e..ec3ce485626d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>         struct dentry           *debugfs_queue;
>         struct delayed_work hang_detect_work;
>         struct dma_fence *hang_detect_fence;
> +       struct kref             refcount;
>
>         struct list_head        userq_va_list;
>  };
> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>         struct amdgpu_userq_obj *db_obj;
>  };
>
> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *=
uq_mgr, u32 qid);
> +void amdgpu_userq_put(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_fi=
le *filp);
>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c30512a6266..ba453361d2b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,
>                 goto put_gobj_read;
>
>         /* Retrieve the user queue */
> -       queue =3D xa_load(&userq_mgr->userq_xa, args->queue_id);
> +       queue =3D amdgpu_userq_get(userq_mgr, args->queue_id);
>         if (!queue) {
>                 r =3D -ENOENT;
>                 goto put_gobj_write;
> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,
>  free_syncobj_handles:
>         kfree(syncobj_handles);
>
> +       if (queue)
> +               amdgpu_userq_put(userq_mgr, args->queue_id);
> +
>         return r;
>  }
>
> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,
>                  */
>                 num_fences =3D dma_fence_dedup_array(fences, num_fences);
>
> -               waitq =3D xa_load(&userq_mgr->userq_xa, wait_info->waitq_=
id);
> +               waitq =3D amdgpu_userq_get(userq_mgr, wait_info->waitq_id=
);
>                 if (!waitq) {
>                         r =3D -EINVAL;
>                         goto free_fences;
> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid *data,
>  free_syncobj_handles:
>         kfree(syncobj_handles);
>
> +       if (waitq)
> +               amdgpu_userq_put(userq_mgr, wait_info->waitq_id);
> +
>         return r;
>  }
> --
> 2.34.1
>
