Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681BEEB362A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 18:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0102910E577;
	Mon,  2 Mar 2026 18:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hY75gZbi";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B928F10E577
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 18:17:24 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12714f01940so196994c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2026 10:17:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772475444; cv=none;
 d=google.com; s=arc-20240605;
 b=gcpwFMWBrd85P+Dhj50z9CRFv5zMnhuuxNnZafMdDR0D4Zw/fnWgJ9F8A6A2nbuVAM
 r4HR9d7sP/H3K4thxg7iogioPFPn3NDMTfEjnnGZRsK6J/XYE3PkLC6FGxHDmb7WGB3K
 Ug71Iu33U3mH3oJqf6skfe3sDiVuOaX0PnSxg2yA2A58PzOiMoNqzbklOrHZuvLXpjvJ
 nVbTKA82KyW7TXMazmc7oqBjeboEDeZlQnEeFSQeoM3fzWqFxPGx1iaf9t7GgK6MXYQl
 Gq+yPlYONnfX3uCSuCW8bhG+j0wV2mdsyYhE6uZkK/f4CH3ZvLiYKWHAodpTvKyCJE4g
 FOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=durjHlG5guYLR/wsnRksSAWWBCFh90Y80v8kx3y7OeI=;
 fh=66rZtncR4IYLcl5U7BlcIffkJDvzCXKojmrODFCk14A=;
 b=jnA1tWQ2vAYBO15ec/OGTVG/V0d4uXfhP2sEXNK2zdeexEdLTsrhef3G3TZAVsiQWv
 ODL6aP87lEktqfDyH1UtALc8PXIBKShPs2IBoekCwcJ28d5/M6b9WNwuad72WvRE8hCs
 KeEDuwTbAgvFw7SpIbGQkkf756KYIEtEJHRH59DIW4eIO17inuGNIDE5tV836zTLHBkn
 3xNN7IBbFEuU+xd3ITK4NbAPk8qUwUktTXDV9bXdlfUs4EcpKqBJ8RPABcQQ1jBmslPW
 NgDvw/HF6xro0q/zFhvqoivOE6Jzenja0hMV7Etb63HM2jS4puPwVSJIMJPxaEWJ3uCk
 2QBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772475444; x=1773080244; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=durjHlG5guYLR/wsnRksSAWWBCFh90Y80v8kx3y7OeI=;
 b=hY75gZbioc6b9wA29rbm0s0eLsvL9nmgKkr/rnJDhWEbuenE5VyWbOzCgHhafpOjxt
 eJ1I74jAFhZwP81jZXtgsK2CmTdlJK0Z/yyDmKsTuhrIsZpnul+VPxt5oCsKx5eCJqbc
 CfIXAbdZU7rico5sq9ZEB7Und7kwEeUC+eGLdfDM00+VGgM9KNG71YkbsFtDUCer6vb0
 rqZXqBe5qJ0C5YLHeaVgacZDDyjeWs67UpGjXfTw8RbQkMDeVfnjudVBskVkXVl6ctSQ
 fvoIR9ofcomuXtg18aYfsqSuetS+B90gb4DgFbEjkBRYovKyPxpK39LvV7ZBdERfr1fR
 gC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772475444; x=1773080244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=durjHlG5guYLR/wsnRksSAWWBCFh90Y80v8kx3y7OeI=;
 b=rL2m2dkmwoL2TAZRAJmg9y20JZAKLuAT4KzlTydhWVjv5lXJkw+W6N1uWG4NyqZ7cl
 6QDzEAdK9XRT22sO1PkVd0whGcCU7VhOROETOWKVtcEzqxL465EGW0U5pouNqkOemyZV
 8jLepALwAG/C4K5LSzCnUzoLwXFo0D5bWQj1yxkxh49RQO0uBPSXG+CPnGdw+aRCVoC4
 AYo8QrJAVuH6SmGUf0Kp7NVgPrpOe99meT/UTjehzEEAsUQk1+HaWJ68HdhdUbuCh1VQ
 Ux1kNo5Jxa1e3Do8IBy6fB7S+SxuQ+D+lTbdQLadUeTVf+JLkkj/+LGDh/ClIzsND0is
 HCJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+wJMrgC3ywBvZ3pgIc85J7yom3kIulZler8nTSweik2dNXin1JK+3gJC3Shpa0agwhoKFORY9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOfMzUGf8o7gBEdl0INTPAN9w+1mNTiAsiRfGtq30rzHQLMKne
 jRFE1X15NjKMY2gC/VIaXT2DH3ZuWJ9w9cSrLSpdJZhpABpn7GStpNHkwbpg8pudiYzDwzb8K9S
 3zSRf+gS0f9plRB6dJ4j124GQ4hqoGgk=
X-Gm-Gg: ATEYQzxUK9jGuvJxQ1eaEepw7N1dPOsTrxDL7QmoXa3vy/UbrH+LOP09xqqy8r1W4tI
 DcTIK9abfI4fuYNDQpPPNIDVA3PLPICnyd4xPAvdMp7B3wKN7VDbr/PZyownVA5j4VJcbhVc9J7
 0ljrig16HrfNwFf1Gi6CbNQd7a9KO6q2lOZoOVIkA3BLyzMl3tljGPuXNmRZV8nnl3ZhD4rDDgd
 EzMo/KXq/eVpagQlD3bE1u3tZIsrmQDYz/XbsH9LLBV2Nqeo3j9kOa9Ol9nJe2bNs9YjWnCmorK
 TLUV202jbll55wJtHGFCm+zkTilzfV+ssbUCoUxSqrK6LQK5CdllFqCv3HnPXv3n/wHEfg==
X-Received: by 2002:a05:7022:62a7:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-1278fcdfab8mr2783078c88.4.1772475443639; Mon, 02 Mar 2026
 10:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20260302180852.1344171-1-sunil.khatri@amd.com>
In-Reply-To: <20260302180852.1344171-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2026 13:17:11 -0500
X-Gm-Features: AaiRm51mvhO9U20vtW-7HC3R-Gvz_NJt1wSuKN1GyhPkWX0dlCx5_OMwTdHp1Dk
Message-ID: <CADnq5_OeGHi3kHAMQkkf+0nG=6+gf5_tzfCh6V-R0RmW8eo-gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: refcount userqueues to avoid any
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

On Mon, Mar 2, 2026 at 1:09=E2=80=AFPM Sunil Khatri <sunil.khatri@amd.com> =
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 85 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 ++-
>  3 files changed, 76 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e07b2082cf25..bd62c95eeaad 100644
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
> @@ -985,6 +1004,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>                        struct drm_file *filp)
>  {
>         union drm_amdgpu_userq *args =3D data;
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>         int r;
>
>         if (!amdgpu_userq_enabled(dev))
> @@ -1001,9 +1021,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>                 break;
>
>         case AMDGPU_USERQ_OP_FREE:
> -               r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
> -               if (r)
> -                       drm_file_err(filp, "Failed to destroy usermode qu=
eue\n");
> +               amdgpu_userq_put(&fpriv->userq_mgr, args->in.queue_id);
>                 break;
>
>         default:
> @@ -1023,16 +1041,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr =
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
> @@ -1266,9 +1291,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq=
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
> @@ -1301,16 +1330,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_=
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
> +               amdgpu_userq_put(uq_mgr, queue_id);
>         }
>
>         return 0;
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
