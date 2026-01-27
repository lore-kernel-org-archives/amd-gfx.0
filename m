Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF11CD2FEF4
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 22:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A79D10E210;
	Tue, 27 Jan 2026 22:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k+3r/0ig";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E812110E210
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 22:34:47 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124a7216c9cso73758c88.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:34:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769553287; cv=none;
 d=google.com; s=arc-20240605;
 b=CpdqlBohpHtkQYlQUDmg70ohPvN2rcwD5DqUETyY0FtpbcjHwk19oK5CWdldas96SL
 KjT/xdWTRvWi2q8rLXSGlfZ+LUI3erLJrq/yu3I5gvzEtcgMkOnfOnNnADmnUmA9EBnA
 banegcWsT4gl9IEAhk0V8a9WfOE/+9vITc9TofWEL49laajIW5M/jdrQw7qsPMzZJnUV
 jHZkXgZgjTc94WidwRxk9Yff69ZKI28eF8MrxjeYA08z+ykYLT7DkJjKX3pC6xnwxcku
 ZPwyI+AW6FoKAGnaB8yvogfbTPRSpOK9Ag4iH4VMl8Ms8IswhD2Z6RR1Jkb84MZ7hyNI
 ocWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Kn/DpU0lzpZWuQpiOjJvPBSp0c5Adfhthl4yAKmQlo=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=PxWiKgJvlR7/o3IsEb2kcmGuLHvFN+yJC/0TDFD4gvuLKxLr3FdSxj1xYw6vm8LImi
 Xz/hTfAaqh6WlwGPcZg/eNhLSp6oEmkVLyymBkIOJ6zXag/qeveyqGeTtWYOregzOBJX
 xnMHP/oAxYxGSIA79Mqo/uZoqS1skz4CTcAa79kkt6ph+eoXrVhwJp4nGCt2dNVLzFZW
 qbKx/TlTZ78Xs1Z++pq2XwC2mKwtzw9Z0WIqDHhzDrhojj9l62+fj2AlMpFIQ8juChns
 HsvWTZVW3YzUrHG6vja1Sl4cQmiLmgOG7rBGE1w1oRnJq4PIoIbsnrsP8fYzPXKflg6x
 l0pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769553287; x=1770158087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Kn/DpU0lzpZWuQpiOjJvPBSp0c5Adfhthl4yAKmQlo=;
 b=k+3r/0igSXZMmU29ivjmSZcg6JjmENiFH/xZXc+NHdEVhel6yBD9MsHdkMF/78v3Bn
 Aca/H9GR9OBGzzaYU28mPpvaYsVZPm7oNeg+SDEkUh5N+yLIHyJ0K/4oO9gf3E0dnId9
 JoRsBKBTlhpZo/kLZLAoWvcuLfXMQq81qHewJWWxQzZ5kvYsXdMgCLXDIqwjjHEohmmG
 KmThT6IyKuoFaXEJliKIya7S1Q2JL4pjpLtUJu1Q5OOyEjiedAfgkWS9DDvpf+jJVLVg
 NNvghO50aOLtQbmrKOwlX94gQwRTgqQSvOGp7KtxvzehxkEFmhFrr378G0x5dzOh50kG
 hgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769553287; x=1770158087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Kn/DpU0lzpZWuQpiOjJvPBSp0c5Adfhthl4yAKmQlo=;
 b=k2xr3Uo7MT5EB/IaP3UbLyuVwOwQg+GBAO5nkXIKYT+5Hvtdhzj3P0By1OBPjaPdfz
 n1CVIOmHcdaMhLxlZwWsMOQ/JptkXctUnhcTAkOMeg2sQb0cppD4qgxQu+7gD/DFhrs5
 uWPjyhEsZq+fj1mIeZ2qPscVzkUIQBJojKkKhFcEICHxFJyFqCN/vkcR8ZUJHt/EJ7DF
 cndoTHr0TA3ZqQ8MIXK58hPktjNfyXPRQd0qFUbWTJwRZpIhnKf+5uCBHCz8JYKWoUAu
 YUJXrehMVJ7/U8DWCCUajkc7LjybexbtFfADw1c0t0oTHtgAKxMYnmJ72jvx35WaDDFM
 3y3A==
X-Gm-Message-State: AOJu0Yx3Au4fsicTYIGZ63Nrl+8V0OaR2oK69bg0u4JKAqygPFwx5xWe
 ScTG/zMMAuGbEEPWzlkRoN+MvV7Ix80P7iNLVj5VdSrjytLOfjGF3/+fp4cHBuu/IamGWWu/2sy
 eVGd6IzgUqbKPtfJeUVgcIwKJ74VV8b4=
X-Gm-Gg: AZuq6aJVTMKolfcbIeYYOqdcWaltbfwlGI0SWBjMebbwhpvtz3zAuC1SPwEvLGlvP3p
 5h2y+gF+3h/UcpIW85IE0JDCzkZovU89DaYtGDZNzefv+wnpFBJpyJrEN/wdLYAUMF98PoObcZ9
 izp0NWkCEIVvHVbe8XuTirYzQV1QCcbEmtRTBvnbHnxc9ifo9DRn0QfKYT01FZgAZtyMvqexGyW
 21Csw2pg+12gOwo3SvYX8tceIJSB2s+0d65fsM41VgJS6sr9/8zbfREkcoubCEg7ezoHH3BhXo1
 +5ehRKM=
X-Received: by 2002:a05:7022:6287:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-124a99e2705mr98166c88.6.1769553285834; Tue, 27 Jan 2026
 14:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
 <20260127071800.2395621-6-Jesse.Zhang@amd.com>
In-Reply-To: <20260127071800.2395621-6-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 17:34:34 -0500
X-Gm-Features: AZwV_QjDh1pSVAeyFdaEh6a6tIFdraNpF5IfLOx5rk5OQSZ9wbWXVN_y1I9ua8U
Message-ID: <CADnq5_P5KmbagUTUOOrbUgfzRcP3aMRi4tChTCcvx_7i=BLsLg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/amdgpu: add MODIFY operation for compute queues
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
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

On Tue, Jan 27, 2026 at 2:57=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Implement the AMDGPU_USERQ_OP_MODIFY ioctl operation to enable runtime up=
dates
> of compute queues.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 78 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +
>  2 files changed, 81 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 256ceca6d429..eb1e27c27bde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -837,6 +837,7 @@ static int amdgpu_userq_input_args_validate(struct dr=
m_device *dev,
>
>         switch (args->in.op) {
>         case AMDGPU_USERQ_OP_CREATE:
> +       case AMDGPU_USERQ_OP_MODIFY:
>                 if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PR=
IORITY_MASK |
>                                        AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SE=
CURE))
>                         return -EINVAL;
> @@ -863,10 +864,29 @@ static int amdgpu_userq_input_args_validate(struct =
drm_device *dev,
>                         drm_file_err(filp, "invalidate userq queue va or =
size\n");
>                         return -EINVAL;
>                 }
> +
> +               if (!is_power_of_2(args->in.queue_size) && (args->in.queu=
e_size !=3D 0)) {
> +                       drm_file_err(filp, "Ring size must be a power of =
2 or 0\n");
> +                       return -EINVAL;
> +               }

Why 0?  Also this should probably be a separate patch as it's more of
a fix than part of the modify change.

> +
> +               if (args->in.queue_size > 0 && args->in.queue_size < AMDG=
PU_GPU_PAGE_SIZE) {
> +                       args->in.queue_size =3D AMDGPU_GPU_PAGE_SIZE;
> +                       drm_file_err(filp, "Size clamped to AMDGPU_GPU_PA=
GE_SIZE\n");
> +               }

Why not return an error here?  Also this check should probably also be
part of another fix patch like above.

> +
> +               if ((args->in.queue_va) &&
> +                       (!access_ok((const void __user *) args->in.queue_=
va,
> +                               sizeof(uint64_t)))) {

This isn't a CPU virtual address, it's a GPU virtual address.  It may
not be a valid CPU virtual address.

> +                       drm_file_err(filp, "Can't access ring base addres=
s\n");
> +                       return -EFAULT;
> +               }
> +
>                 if (!args->in.wptr_va || !args->in.rptr_va) {
>                         drm_file_err(filp, "invalidate userq queue rptr o=
r wptr\n");
>                         return -EINVAL;
>                 }
> +
>                 break;
>         case AMDGPU_USERQ_OP_FREE:
>                 if (args->in.ip_type ||
> @@ -901,6 +921,58 @@ bool amdgpu_userq_enabled(struct drm_device *dev)
>         return false;
>  }
>
> +static int amdgpu_modify_queue(struct drm_file *filp, union drm_amdgpu_u=
serq *args)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_usermode_queue *queue;
> +       const struct amdgpu_userq_funcs *userq_funcs;
> +       int r;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +       if (!queue) {
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +
> +       if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
> +               return -EOPNOTSUPP;

We'll probably want to support this for non-compute queues as well for
consistency.

Alex

> +
> +       userq_funcs =3D adev->userq_funcs[queue->queue_type];
> +
> +       /*
> +        * Unmap the queue if it's mapped or preempted to ensure a clean =
update.
> +        * If the queue is already unmapped or hung, we skip this step.
> +        */
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED ||
> +           queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> +               r =3D amdgpu_userq_unmap_helper(queue);
> +               if (r)
> +                       return r;
> +       }
> +
> +       r =3D userq_funcs->mqd_update(queue, &args->in);
> +       if (r)
> +               return r;
> +       /*
> +        * If the queue is considered active (has valid size, address, an=
d percentage),
> +        * we attempt to map it. This effectively starts the queue or res=
tarts it
> +        * if it was previously running.
> +        */
> +       if (AMDGPU_USERQ_IS_ACTIVE(queue)) {
> +               r =3D amdgpu_userq_map_helper(queue);
> +               if (r)
> +                       drm_file_err(uq_mgr->file, "Failed to remap queue=
 %llu after update\n",
> +                               queue->doorbell_index);
> +       }
> +
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                        struct drm_file *filp)
>  {
> @@ -920,6 +992,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>                         drm_file_err(filp, "Failed to create usermode que=
ue\n");
>                 break;
>
> +
> +       case AMDGPU_USERQ_OP_MODIFY:
> +               r =3D amdgpu_modify_queue(filp, args);
> +               if (r)
> +                       drm_file_err(filp, "Failed to modify usermode que=
ue\n");
> +               break;
>         case AMDGPU_USERQ_OP_FREE:
>                 r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>                 if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 833468b58603..7cd1ea94e368 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -31,6 +31,9 @@
>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, bas=
e)
>  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mg=
r)
>  #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,=
 name)
> +#define AMDGPU_USERQ_IS_ACTIVE(q) ((q)->userq_prop->queue_size > 0 &&  \
> +                           (q)->userq_prop->hqd_base_gpu_addr !=3D 0 && =
 \
> +                           (q)->userq_prop->queue_percentage > 0)
>
>  enum amdgpu_userq_state {
>         AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
> --
> 2.49.0
>
