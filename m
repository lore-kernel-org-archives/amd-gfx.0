Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD32E7FDF3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 22:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4693A10E3B6;
	Mon,  2 Feb 2026 22:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xnczw5No";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32CD110E3B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 22:29:17 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso173517c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 14:29:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770071356; cv=none;
 d=google.com; s=arc-20240605;
 b=hxyQZM/NeGmuFNU/QVg+7bOZfVcJXVB/WpIza59ySaNv0Nb49mXqRHNQhbMgIf25Oq
 wTZ8t4rSZ0kq6QgZSwTQqawYrVZ7yTAZDrB6qFTSrKqhM6fobQXuoY0Kyc0VoVbZKPwO
 IJlgbA3zSGPGud9pQv7chuGMwRk6tteBu86fx8Bko+yqfhSssNK2mJtF9BG5AXrSgNzX
 l7taB7Xhd1AbjSCB5CGI8cYBq43//9yh4tb7kXcQJ+dYBcVS6ezpbRdVbz70nvi3V/R5
 AGzGbRP65ublJGXIq+AT+xzcEw8FrB+s1q0yLWufGHYFiiXBJ58DVnO1A9cW9epxbXtB
 nSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ADiN5BwzSeOxVFqNEHllSVQDFi7uKyyGv3DZ/u1hjtg=;
 fh=MEWCNc3s3+86VP8PmWdcYqUCTJTp4fWesq/jKIRZ/Wo=;
 b=bK+kNaaqcxYGAHVOpBzjmdQsFkatpEXNQk1w3ykXa0I8Po/huNN3uXXrnoa7iUVwnI
 gBYgrHJ5sCQrk0VfTwEXUNAR77M+nkaJwMaaOYESr94JvNhlTUbg0iDUg8qs0jtDZNJF
 41DPhIXk1XRofyt7Z4d3t1jkQDyyXvUFb650b4pWXg67dAZm5QWg170AOXmP+cj67ijo
 d0AX9OmNLH+T/6hPLiamiC/zM6PZmKZXZa7lwFVIZhALWkoc+EttHXsvXjlGsf2v2Wpi
 ZX4PhkOUccQLBSdPOkAX2Ng1AzEIPrHuccwkVG3h2tR+NeVL/DIl8L3FlTfXjllNE5um
 2Ovw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770071356; x=1770676156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADiN5BwzSeOxVFqNEHllSVQDFi7uKyyGv3DZ/u1hjtg=;
 b=Xnczw5NoUZquQ8B90sXxWc7qsDXxy+L1c6LS7iLaVrdZQgolsH/Y0FXEqlz2vgfgUe
 IeNvYqpLkSoGH9jN6Mq0e/BUWlcPAjqLC0Q+PeD601xHSti8Iz3bspmPSU76NpYzW9wv
 6/Hgm5IXZMPj0gH2vIah0a4CadkojKpBEhp6E/uQ7/bVM1l3WAyIGAtg7UKL38RTfzDx
 v9XjRldWLFdtl9nCsnT26JPOUUe2VrOCPeAKAk7o4jCdh6CkJ4ZA1NnvrtryEZYwAwuX
 tuKKag//W1UVDvT1s9TFPSDML9BqeYwuw4y1f7fs+kNHmlWeIA/dVGTq6vacdd0BnM7N
 q5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071356; x=1770676156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ADiN5BwzSeOxVFqNEHllSVQDFi7uKyyGv3DZ/u1hjtg=;
 b=YuPQeIH8AYERJRWFAjkISqsvuGz/IMpGL1OTqLxYmyNV1gPC1hveAmfldUJJfaTYfF
 laNFbUW9wdRaIFXfxSOlN4xyBsqX8WObKldiGakmVNL8lBTFX723j7VfWajD/uMdr1jS
 TF6jdgZWWv7TBQ19kD0I+7GcTemKuBKFW6QeDqBJHIe+3/8I1eMJRcMeiWfF3ETkJ4LQ
 +EnzP3MGmL9Q5kExchLdM14fXJzBuip/9XC5U+7GeuQFmdOg+/bfcY8vcFtkyiudfBC7
 mbBPi5xXEQ3LItueWWV2CyJ9X5amRfLOASW8eGH9KDmruyEwkCaWznys/zNJ0YoOUU4Y
 ZyUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkyCy3SKeqDeKLTZIF3Ddc3EJxXBKfZ7PCm72cMWay/DcHBNZyuZ3eAJIUFKpnGpFnqDYdQfU9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTyZpMuDbjngFhD4Kop/d0oIzpa552SnsRLP9n54ik5Os8xy/y
 tYVK/796utpyWrb7qMfuNC/V/h8fIst6X4+uVjTIDNq8MwZ/t9eeQ+CiTuHojpP3Vz7hz/eaqsl
 jis5maL5/HKs2gt43mNJC2Umg97qRp+xNQg==
X-Gm-Gg: AZuq6aLzJ5K/jdRVAODfr+EKLdJ2okElWJpg8/TK9jOyVU21D+yroLnC4o7WnNexczO
 9f3i2Xfdi8i+5FaULjxIzvCBFrL+pvMXhwSg911HAapTkw8tiLaC9LgMCFkrJdCMPbJtACWhYoO
 kDWq+snSrd8PHn2+RYxCZSdVhPhfl7gtdhLxsm6SBuedTISxWFdtSDfgj+Upr/YfHJjDLailqIw
 iD9Dv+NeSMy15nWSkSn5O6pm2sUlFxlAP2cELateyR/GaGexUKgA2l19tmz2PgGWCHYH4Nq
X-Received: by 2002:a05:7022:386:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-125c1010d8fmr3236852c88.6.1770071356247; Mon, 02 Feb 2026
 14:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-4-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 17:29:04 -0500
X-Gm-Features: AZwV_QgbOFNK7h8xq3BPMfPzmNsvvP6ZH17fXPxqLxqWy1Pl-xlJwAiy7c_Akzo
Message-ID: <CADnq5_Ou1Rg+k4eTE8vnMM4s8B7PpyDzD0pNTvosoKA5MGURiw@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/amdgpu: completely rework eviction fence handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com, 
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Feb 2, 2026 at 8:02=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Well that was broken on multiple levels.
>
> First of all a lot of checks where placed at incorrect locations, especia=
lly if
> the resume worker should run or not.
>
> Then a bunch of code was just mid-layering because of incorrect assignmen=
t who
> should do what.
>
> And finally comments explaining what happens instead of why.
>
> Just re-write it from scratch, that should at least fix some of the hangs=
 we
> are seeing.
>
> Use RCU for the eviction fence pointer in the manager, the spinlock usage=
 was
> mostly incorrect as well. Then finally remove all the nonsense checks and
> actually add them in the correct locations.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

The diff was a bit hard to parse, but it looks to be correct.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   4 +-
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 213 ++++++------------
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  54 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  29 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   2 +-
>  7 files changed, 112 insertions(+), 205 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index d6d0a6e34c6b..02abe85624a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2975,9 +2975,9 @@ static int amdgpu_drm_release(struct inode *inode, =
struct file *filp)
>         int idx;
>
>         if (fpriv && drm_dev_enter(dev, &idx)) {
> -               fpriv->evf_mgr.fd_closing =3D true;
> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +               amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>                 amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +               amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>                 drm_dev_exit(idx);
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 23d7d0b0d625..8fe9f91f9551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -25,9 +25,6 @@
>  #include <drm/drm_exec.h>
>  #include "amdgpu.h"
>
> -#define work_to_evf_mgr(w, name) container_of(w, struct amdgpu_eviction_=
fence_mgr, name)
> -#define evf_mgr_to_fpriv(e) container_of(e, struct amdgpu_fpriv, evf_mgr=
)
> -
>  static const char *
>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>  {
> @@ -43,102 +40,14 @@ amdgpu_eviction_fence_get_timeline_name(struct dma_f=
ence *f)
>         return ef->timeline_name;
>  }
>
> -int
> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *ev=
f_mgr,
> -                                   struct drm_exec *exec)
> -{
> -       struct amdgpu_eviction_fence *old_ef, *new_ef;
> -       struct drm_gem_object *obj;
> -       unsigned long index;
> -       int ret;
> -
> -       if (evf_mgr->ev_fence &&
> -           !dma_fence_is_signaled(&evf_mgr->ev_fence->base))
> -               return 0;
> -       /*
> -        * Steps to replace eviction fence:
> -        * * lock all objects in exec (caller)
> -        * * create a new eviction fence
> -        * * update new eviction fence in evf_mgr
> -        * * attach the new eviction fence to BOs
> -        * * release the old fence
> -        * * unlock the objects (caller)
> -        */
> -       new_ef =3D amdgpu_eviction_fence_create(evf_mgr);
> -       if (!new_ef) {
> -               DRM_ERROR("Failed to create new eviction fence\n");
> -               return -ENOMEM;
> -       }
> -
> -       /* Update the eviction fence now */
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       old_ef =3D evf_mgr->ev_fence;
> -       evf_mgr->ev_fence =3D new_ef;
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -       /* Attach the new fence */
> -       drm_exec_for_each_locked_object(exec, index, obj) {
> -               struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> -
> -               if (!bo)
> -                       continue;
> -               ret =3D amdgpu_eviction_fence_attach(evf_mgr, bo);
> -               if (ret) {
> -                       DRM_ERROR("Failed to attch new eviction fence\n")=
;
> -                       goto free_err;
> -               }
> -       }
> -
> -       /* Free old fence */
> -       if (old_ef)
> -               dma_fence_put(&old_ef->base);
> -       return 0;
> -
> -free_err:
> -       kfree(new_ef);
> -       return ret;
> -}
> -
> -static void
> -amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
> -{
> -       struct amdgpu_eviction_fence_mgr *evf_mgr =3D work_to_evf_mgr(wor=
k, suspend_work.work);
> -       struct amdgpu_fpriv *fpriv =3D evf_mgr_to_fpriv(evf_mgr);
> -       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> -       struct amdgpu_eviction_fence *ev_fence;
> -
> -       mutex_lock(&uq_mgr->userq_mutex);
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       ev_fence =3D evf_mgr->ev_fence;
> -       if (ev_fence)
> -               dma_fence_get(&ev_fence->base);
> -       else
> -               goto unlock;
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -       amdgpu_userq_evict(uq_mgr, ev_fence);
> -
> -       mutex_unlock(&uq_mgr->userq_mutex);
> -       dma_fence_put(&ev_fence->base);
> -       return;
> -
> -unlock:
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -       mutex_unlock(&uq_mgr->userq_mutex);
> -}
> -
>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>  {
>         struct amdgpu_eviction_fence_mgr *evf_mgr;
>         struct amdgpu_eviction_fence *ev_fence;
>
> -       if (!f)
> -               return true;
> -
>         ev_fence =3D to_ev_fence(f);
>         evf_mgr =3D ev_fence->evf_mgr;
> -
> -       schedule_delayed_work(&evf_mgr->suspend_work, 0);
> +       schedule_work(&evf_mgr->suspend_work);
>         return true;
>  }
>
> @@ -148,22 +57,52 @@ static const struct dma_fence_ops amdgpu_eviction_fe=
nce_ops =3D {
>         .enable_signaling =3D amdgpu_eviction_fence_enable_signaling,
>  };
>
> -void amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_=
mgr,
> -                                 struct amdgpu_eviction_fence *ev_fence)
> +static void
> +amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  {
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       dma_fence_signal(&ev_fence->base);
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> +       struct amdgpu_eviction_fence_mgr *evf_mgr =3D
> +               container_of(work, struct amdgpu_eviction_fence_mgr,
> +                            suspend_work);
> +       struct amdgpu_fpriv *fpriv =3D
> +               container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct dma_fence *ev_fence;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       ev_fence =3D amdgpu_evf_mgr_get_fence(evf_mgr);
> +       amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
> +
> +       /*
> +        * Signaling the eviction fence must be done while holding the
> +        * userq_mutex. Otherwise we won't resume the queues before issui=
ng the
> +        * next fence.
> +        */
> +       dma_fence_signal(ev_fence);
> +       dma_fence_put(ev_fence);
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> +                                struct amdgpu_bo *bo)
> +{
> +       struct dma_fence *ev_fence =3D amdgpu_evf_mgr_get_fence(evf_mgr);
> +       struct dma_resv *resv =3D bo->tbo.base.resv;
> +
> +       dma_resv_add_fence(resv, ev_fence, DMA_RESV_USAGE_BOOKKEEP);
> +       dma_fence_put(ev_fence);
>  }
>
> -struct amdgpu_eviction_fence *
> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +                        struct drm_exec *exec)
>  {
>         struct amdgpu_eviction_fence *ev_fence;
> +       struct drm_gem_object *obj;
> +       unsigned long index;
>
> +       /* Create and initialize a new eviction fence */
>         ev_fence =3D kzalloc(sizeof(*ev_fence), GFP_KERNEL);
>         if (!ev_fence)
> -               return NULL;
> +               return -ENOMEM;
>
>         ev_fence->evf_mgr =3D evf_mgr;
>         get_task_comm(ev_fence->timeline_name, current);
> @@ -171,56 +110,22 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction=
_fence_mgr *evf_mgr)
>         dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
>                          &ev_fence->lock, evf_mgr->ev_fence_ctx,
>                          atomic_inc_return(&evf_mgr->ev_fence_seq));
> -       return ev_fence;
> -}
> -
> -void amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf=
_mgr)
> -{
> -       struct amdgpu_eviction_fence *ev_fence;
> -
> -       /* Wait for any pending work to execute */
> -       flush_delayed_work(&evf_mgr->suspend_work);
> -
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       ev_fence =3D evf_mgr->ev_fence;
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -
> -       if (!ev_fence)
> -               return;
> -
> -       dma_fence_wait(&ev_fence->base, false);
>
> -       /* Last unref of ev_fence */
> -       dma_fence_put(&ev_fence->base);
> -}
> -
> -int amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> -                                struct amdgpu_bo *bo)
> -{
> -       struct amdgpu_eviction_fence *ev_fence;
> -       struct dma_resv *resv =3D bo->tbo.base.resv;
> -       int ret;
> +       /* Remember it for newly added BOs */
> +       dma_fence_put(evf_mgr->ev_fence);
> +       evf_mgr->ev_fence =3D &ev_fence->base;
>
> -       if (!resv)
> -               return 0;
> +       /* And add it to all existing BOs */
> +       drm_exec_for_each_locked_object(exec, index, obj) {
> +               struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
>
> -       ret =3D dma_resv_reserve_fences(resv, 1);
> -       if (ret) {
> -               DRM_DEBUG_DRIVER("Failed to resv fence space\n");
> -               return ret;
> +               amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>         }
> -
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       ev_fence =3D evf_mgr->ev_fence;
> -       if (ev_fence)
> -               dma_resv_add_fence(resv, &ev_fence->base, DMA_RESV_USAGE_=
BOOKKEEP);
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -
>         return 0;
>  }
>
> -void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_=
mgr,
> -                                 struct amdgpu_bo *bo)
> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> +                                struct amdgpu_bo *bo)
>  {
>         struct dma_fence *stub =3D dma_fence_get_stub();
>
> @@ -229,13 +134,25 @@ void amdgpu_eviction_fence_detach(struct amdgpu_evi=
ction_fence_mgr *evf_mgr,
>         dma_fence_put(stub);
>  }
>
> -int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr=
)
> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
> -       /* This needs to be done one time per open */
>         atomic_set(&evf_mgr->ev_fence_seq, 0);
>         evf_mgr->ev_fence_ctx =3D dma_fence_context_alloc(1);
> -       spin_lock_init(&evf_mgr->ev_fence_lock);
> +       evf_mgr->ev_fence =3D dma_fence_get_stub();
>
> -       INIT_DELAYED_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_s=
uspend_worker);
> -       return 0;
> +       INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_w=
orker);
> +}
> +
> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +       evf_mgr->shutdown =3D true;
> +       flush_work(&evf_mgr->suspend_work);
> +}
> +
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +       dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true)=
,
> +                      false);
> +       flush_work(&evf_mgr->suspend_work);
> +       dma_fence_put(evf_mgr->ev_fence);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..527de3a23583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -25,6 +25,8 @@
>  #ifndef AMDGPU_EV_FENCE_H_
>  #define AMDGPU_EV_FENCE_H_
>
> +#include <linux/dma-fence.h>
> +
>  struct amdgpu_eviction_fence {
>         struct dma_fence base;
>         spinlock_t       lock;
> @@ -35,35 +37,35 @@ struct amdgpu_eviction_fence {
>  struct amdgpu_eviction_fence_mgr {
>         u64                     ev_fence_ctx;
>         atomic_t                ev_fence_seq;
> -       spinlock_t              ev_fence_lock;
> -       struct amdgpu_eviction_fence *ev_fence;
> -       struct delayed_work     suspend_work;
> -       uint8_t fd_closing;
> -};
> -
> -/* Eviction fence helper functions */
> -struct amdgpu_eviction_fence *
> -amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
>
> -void
> -amdgpu_eviction_fence_destroy(struct amdgpu_eviction_fence_mgr *evf_mgr)=
;
> -
> -int
> -amdgpu_eviction_fence_attach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -                            struct amdgpu_bo *bo);
> +       /*
> +        * Only updated while holding the VM resv lock.
> +        * Only signaled while holding the userq mutex.
> +        */
> +       struct dma_fence __rcu  *ev_fence;
> +       struct work_struct      suspend_work;
> +       bool                    shutdown;
> +};
>
> -void
> -amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -                            struct amdgpu_bo *bo);
> +static inline struct dma_fence *
> +amdgpu_evf_mgr_get_fence(struct amdgpu_eviction_fence_mgr *evf_mgr)
> +{
> +       struct dma_fence *ev_fence;
>
> -int
> -amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +       rcu_read_lock();
> +       ev_fence =3D dma_fence_get_rcu_safe(&evf_mgr->ev_fence);
> +       rcu_read_unlock();
> +       return ev_fence;
> +}
>
> -void
> -amdgpu_eviction_fence_signal(struct amdgpu_eviction_fence_mgr *evf_mgr,
> -                            struct amdgpu_eviction_fence *ev_fence);
> +void amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> +                                struct amdgpu_bo *bo);
> +int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
> +                        struct drm_exec *exec);
> +void amdgpu_evf_mgr_detach_fence(struct amdgpu_eviction_fence_mgr *evf_m=
gr,
> +                                struct amdgpu_bo *bo);
> +void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr);
> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>
> -int
> -amdgpu_eviction_fence_replace_fence(struct amdgpu_eviction_fence_mgr *ev=
f_mgr,
> -                                   struct drm_exec *exec);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 5c90de58cc28..e28abfd04867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -263,13 +263,7 @@ static int amdgpu_gem_object_open(struct drm_gem_obj=
ect *obj,
>         else
>                 ++bo_va->ref_count;
>
> -       /* attach gfx eviction fence */
> -       r =3D amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> -       if (r) {
> -               DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n=
");
> -               amdgpu_bo_unreserve(abo);
> -               return r;
> -       }
> +       amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
>         drm_exec_fini(&exec);
>
>         /* Validate and add eviction fence to DMABuf imports with dynamic
> @@ -337,7 +331,7 @@ static void amdgpu_gem_object_close(struct drm_gem_ob=
ject *obj,
>         }
>
>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> -               amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
> +               amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
>
>         bo_va =3D amdgpu_vm_bo_find(vm, bo);
>         if (!bo_va || --bo_va->ref_count)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index f69332eed051..f512b6ec6c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1522,10 +1522,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>                          "Failed to init usermode queue manager (%d), use=
 legacy workload submission only\n",
>                          r);
>
> -       r =3D amdgpu_eviction_fence_init(&fpriv->evf_mgr);
> -       if (r)
> -               goto error_vm;
> -
> +       amdgpu_evf_mgr_init(&fpriv->evf_mgr);
>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>
>         file_priv->driver_priv =3D fpriv;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index af3922e9caea..e007f10a6c1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -480,17 +480,16 @@ void
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>                              struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
> -       struct amdgpu_eviction_fence *ev_fence;
> +       struct dma_fence *ev_fence;
>
>  retry:
>         /* Flush any pending resume work to create ev_fence */
>         flush_delayed_work(&uq_mgr->resume_work);
>
>         mutex_lock(&uq_mgr->userq_mutex);
> -       spin_lock(&evf_mgr->ev_fence_lock);
> -       ev_fence =3D evf_mgr->ev_fence;
> -       spin_unlock(&evf_mgr->ev_fence_lock);
> -       if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
> +       ev_fence =3D amdgpu_evf_mgr_get_fence(evf_mgr);
> +       if (dma_fence_is_signaled(ev_fence)) {
> +               dma_fence_put(ev_fence);
>                 mutex_unlock(&uq_mgr->userq_mutex);
>                 /*
>                  * Looks like there was no pending resume work,
> @@ -499,6 +498,7 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr =
*uq_mgr,
>                 schedule_delayed_work(&uq_mgr->resume_work, 0);
>                 goto retry;
>         }
> +       dma_fence_put(ev_fence);
>  }
>
>  int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
> @@ -1214,7 +1214,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *u=
q_mgr)
>                 dma_fence_wait(bo_va->last_pt_update, false);
>         dma_fence_wait(vm->last_update, false);
>
> -       ret =3D amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exe=
c);
> +       ret =3D amdgpu_evf_mgr_rearm(&fpriv->evf_mgr, &exec);
>         if (ret)
>                 drm_file_err(uq_mgr->file, "Failed to replace eviction fe=
nce\n");
>
> @@ -1234,11 +1234,13 @@ static void amdgpu_userq_restore_worker(struct wo=
rk_struct *work)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D work_to_uq_mgr(work, resume_w=
ork.work);
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> +       struct dma_fence *ev_fence;
>         int ret;
>
> -       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
> -
>         mutex_lock(&uq_mgr->userq_mutex);
> +       ev_fence =3D amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
> +       if (!dma_fence_is_signaled(ev_fence))
> +               goto unlock;
>
>         ret =3D amdgpu_userq_vm_validate(uq_mgr);
>         if (ret) {
> @@ -1254,6 +1256,7 @@ static void amdgpu_userq_restore_worker(struct work=
_struct *work)
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> +       dma_fence_put(ev_fence);
>  }
>
>  static int
> @@ -1317,11 +1320,8 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_m=
gr *uq_mgr)
>  }
>
>  void
> -amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> -                  struct amdgpu_eviction_fence *ev_fence)
> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume=
)
>  {
> -       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> -       struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         int ret;
>
> @@ -1334,10 +1334,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr=
,
>         if (ret)
>                 dev_err(adev->dev, "Failed to evict userqueue\n");
>
> -       /* Signal current eviction fence */
> -       amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> -
> -       if (!evf_mgr->fd_closing)
> +       if (schedule_resume)
>                 schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 5845d8959034..095c09f3d96c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -127,7 +127,7 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_=
mgr *uq_mgr,
>                                  struct amdgpu_userq_obj *userq_obj);
>
>  void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> -                       struct amdgpu_eviction_fence *ev_fence);
> +                       bool schedule_resume);
>
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>                                   struct amdgpu_eviction_fence_mgr *evf_m=
gr);
> --
> 2.43.0
>
