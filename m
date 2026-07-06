Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B9AC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD8F10E405;
	Mon,  6 Jul 2026 20:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h9V2aQ50";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0F610E405
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:25:02 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso10617935ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 13:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369502; cv=none;
 d=google.com; s=arc-20260327;
 b=resxDWzm8EOTmz9gL6SRK0P8TSQf2HBFhow6ieT78sjaKykpAt/SfSeADBkro/e1ds
 wH4WxydfSM34n0LrVNRrkd+IAlIQtAp/HA20vI/hJAc3i3ALVSJTVQbIoo0MMXuZlNPt
 2y2ivfKMljS8UGnVnQ9ly/9LEuk3DskDTufUvkhnJeEy0kpvV+wkmcO/iGpnuUxvJlU1
 iOybgEoGDbFO/4HpQ5rtOcQlYAi18OVL//JGW03NcQvdqcizB8MhOzzaxGabRfLl+/Tk
 10Tw16LAAXI43kxb0dlS3Dkd+tEpPO1L9AChurbqmdb1CDDCQPvjyEoK12XAiFFswYng
 q1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tTkgPLgHhfSzRfhx42MIaZ/RRcmXgTwMi+kPiJNQhNQ=;
 fh=x76W68QU6HgdEOxQbnDph2KKEn/jSDLlc4Ad1DeIhWs=;
 b=Eq0f3W5/E5vkYuMuvWjkF3SJe6OMtRfQa6UtEos1pXI0B8YUGgXNxR/SOan9Pg/ZGt
 fmiuTQbRhO4xwTQLKQWigTUz6WrgWupDWU6TsXrWcvPtPRvai0ZVp8V03okOy+eSeErc
 W5DrX7DyZ1IacAZFh/9n+u0o6L4KhTLFQ6fKPOdt71z6QQS9LfxN2FcLN0L5yDWPuYhH
 ItHKeqfJUISh4Bqf4B6adYWSlYdH8s/U/v56nKqvVbzsc7k/b18iyKCw9gHToCfxsRCo
 N1ZPf16/ZmUp/CtGxu5bosTRyG5l1HuuyaQtyW1I4blXfHthTBz7hAfC2l/koRM2WfjR
 q1NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783369502; x=1783974302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tTkgPLgHhfSzRfhx42MIaZ/RRcmXgTwMi+kPiJNQhNQ=;
 b=h9V2aQ50JLEFl8auRAQEmIeeG0y1dxK2Ct7QW9Nladazexf0yBlDzZKQwz5Esww6tp
 bA54qANPNb8MLMmrHu2oNAcxbMyfIVWZoVc3bQpzthqr43lqcJua6UIoaKFt5mIt1Cpu
 1jb/4yjYFMErayRe9fRjpQQrCjZ/Rjw4+ED4MPHhjxB2RPlzZU/kLt5FRd5+9cr/ayHq
 FF96YpGToq+eANFG4rB9Z5+Q7k+UoFXsC3WISEHFTqZuVkiDjowHUNcxjquWRYKoIT1D
 WA0mukXbX14L2mW4czieT9SoM2M65q2AQfuF5UUASv6B48f5ojunczEhlMxe0MCVteFc
 9otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369502; x=1783974302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tTkgPLgHhfSzRfhx42MIaZ/RRcmXgTwMi+kPiJNQhNQ=;
 b=kw92abCwP+MZ+NQp1iEKJI2JPgGOmOt5+rcQR+gdPDrGfAK6uqbpLh2y3vNkzIPQTD
 cKoLvrGpaiuuFIGffC2qI8vzhm7qtrof9KEqsTDsw1lRj+iOYGsIdNLt1nCXh9O7uHXe
 qFYiwuZpAPHHBZZPnq9Y3vb8zSpoxNJ5rS9O+uj0aK82YHrvjn5ct9l8+5Sw96ZWGH9e
 9cszG/TRfhEqGhpJWINk40zb1yYfZpxnGo7V9oFOlqOGDmQTZYmYlOEbwZLCQMBzib4C
 JLZ1Rv/pjdsCaokVUVQSRJk6zc5vuC0sz9uJ6TGpOh+wb+gFGhYmr4VpCQ84yB9QXfgX
 0l9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpD8nv+bZ5/0FfKWd8Jx9dXqU4wldgn9MfIxQgh3MFpJzxp/n8kG9E/oO4BZin30+eGUKEqOb5T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT/9msuBtHi5io+G/EYKJCTJ02U8XekOPCyFPwR2Lxx4aXMGkO
 GrRtTeHd+NWO+8vYZwnEC9uRrTjck83aBWjGMASLni4pzWqN9Lna2V2Pk0W6s+8ojlgUyWtNFD9
 FtRUWkMGMbzuJNTmwk14QrK4+Ic4LEzvFYA==
X-Gm-Gg: AfdE7clnl9cVQaX3oqRzvaPCvSOIUJsjqKhS6sOJAZi4Ox2IHBbonLBJPzbQU/CAuiP
 qiEDCxVkaofsLNG+GkrM+6u37FxgQnkH67WcAIBNYFVOl76EHEG3S8ETWr4Frjy8lqo98tZVjy/
 GQStUJwaT4jHxMiitjabSxw8zmukYp6HPq9dRLfQWwh3OoM1idSgTieuxBvunM8BG+ABseprqlh
 Ue19Hw5UlNRwiJSBrnS02tnIMxgARh0WFBR3pIomFLFirMptTYyO/pSsTEiYnrXwt4DPiOdC1o8
 lz1rvkfi47gej5PmU1X7clOasiAoXloQBmcH5wvNm+ZuiosekNNcfsRX2Ys=
X-Received: by 2002:a17:903:2c0e:b0:2cc:7d4a:3f59 with SMTP id
 d9443c01a7336-2cc7d4a46d2mr64597175ad.6.1783369502126; Mon, 06 Jul 2026
 13:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
 <20260611143326.2870571-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260611143326.2870571-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 16:24:49 -0400
X-Gm-Features: AVVi8Ce-zy5wssVGa1ISWziixV9pkTF34M6IWic4NBgasRXdRr6aR1wnWT1TVV4
Message-ID: <CADnq5_Nv0hJWKRx0qfJ5kaqmDH8dZpF1AUN2g93hi77hEE6JEQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Jun 11, 2026 at 11:29=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The current EVENTFD UAPI uses a userspace-defined event identifier.
>
> For render-node event notifications, userspace should subscribe to
> kernel-defined event types instead, allowing the kernel to define event
> semantics and signaling sources.
>
> Add a shared AMDGPU EVENTFD event type enum and update the EVENTFD UAPI
> to use event_type instead of event_id.
>
> Value 0 is reserved and rejected by the existing event_type validation.
>
> queue_id remains part of the UAPI and is used to distinguish
> queue-scoped subscriptions from GPU/device-scoped subscriptions.
>
> Eventfd signaling remains notification-only.
>
> v10: (per Christian)
> - Add a comment clarifying that the flags field is currently unused,
>   reserved for future UAPI extensions, and must be zero.
> - Introduce event_type directly in the EVENTFD UAPI.
> - Remove the INVALID event type; value 0 remains rejected by validation.
> - Squash the event_id to event_type rename into the original UAPI patch.
>
> v11: (per Christian)
> - Keep the event_id to event_type rename in this patch so that later
>   patches focus only on queue reference handling.
> - Move queue reference conversion and queue-scoped EVENTFD handling
>   into the subsequent patch to reduce noise in this change.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 107 +++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  17 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  37 +++++++
>  include/uapi/drm/amdgpu_drm.h               |  43 ++++++++
>  6 files changed, 145 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a75c68195df9..54bc31ee795a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -460,6 +460,11 @@ struct amdgpu_fpriv {
>         struct amdgpu_eventfd_mgr       eventfd_mgr;
>  };
>
> +struct drm_device;
> +struct drm_file;
> +
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_=
file *file_priv);
> +
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)=
;
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..aaa4dd57099f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handle=
s_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDE=
R_ALLOW),
>  };
>
>  static const struct drm_driver amdgpu_kms_driver =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_eventfd.c
> index 4955ee942a1c..c777d563f1b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -24,14 +24,10 @@
>  /*
>   * Render-node eventfd subscription infrastructure.
>   *
> - * This module provides a simple event notification mechanism for render=
-node
> - * clients using Linux eventfd objects.
> + * EVENTFD is notification-only. It wakes userspace when a GPU event hap=
pens.
> + * Event metadata/details are expected to be consumed separately through=
 the
> + * corresponding wait/event path.
>   *
> - * Userspace can bind an eventfd to a userspace-defined event_id. When t=
he
> - * driver signals that event_id, all eventfds bound to it are notified.
> - *
> - * This mechanism is intended to support lightweight GPU event notificat=
ions
> - * without polling from userspace.
>   */
>
>  #include <linux/slab.h>
> @@ -42,19 +38,19 @@
>  #define AMDGPU_EVENTFD_MAX_BINDS 4096
>
>  /**
> - * amdgpu_eventfd_id_alloc - allocate an event id container
> - * @event_id: userspace-defined event identifier
> + * amdgpu_eventfd_id_alloc - allocate an event type container
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * Each event_id represents a notification category. Multiple eventfds c=
an
> - * be bound to the same event_id.
> + * Each event type represents a notification category. Multiple eventfds
> + * can be bound to the same event type.
>   *
>   * This function allocates the container which stores the list of eventf=
ds
> - * associated with that event_id.
> + * associated with that event type.
>   *
>   * Return:
>   * Pointer to the newly allocated structure or NULL on failure.
>   */
> -static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_type)
>  {
>         struct amdgpu_eventfd_id *id;
>
> @@ -62,43 +58,41 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_al=
loc(u32 event_id)
>         if (!id)
>                 return NULL;
>
> -       id->event_id =3D event_id;
> +       id->event_type =3D event_type;
>         INIT_HLIST_HEAD(&id->entries);
>         id->n_entries =3D 0;
> +
>         return id;
>  }
>
>  /**
> - * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * amdgpu_eventfd_id_get_or_create - lookup or create an event type
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> - *
> - * This helper returns the container associated with the given event_id.
> - * If it does not exist, it will create one.
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * The function is designed to be callable without holding any locks.
> - * Memory allocation is done outside the xarray lock to avoid blocking
> - * inside critical sections.
> + * Find the container associated with the specified event type. If none
> + * exists, allocate and insert a new one.
>   *
>   * Return:
> - * Pointer to the event_id structure or NULL on failure.
> + * Existing event type container or a newly allocated one.
>   */
>  static struct amdgpu_eventfd_id *
> -amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 even=
t_id)
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr,
> +                               u32 event_type)
>  {
>         struct amdgpu_eventfd_id *id;
>         struct amdgpu_eventfd_id *new_id;
> -       XA_STATE(xas, &mgr->ids, event_id);
> +       XA_STATE(xas, &mgr->ids, event_type);
>         unsigned long flags;
>         int r;
>
>         xa_lock_irqsave(&mgr->ids, flags);
> -       id =3D xa_load(&mgr->ids, event_id);
> +       id =3D xa_load(&mgr->ids, event_type);
>         xa_unlock_irqrestore(&mgr->ids, flags);
>         if (id)
>                 return id;
>
> -       new_id =3D amdgpu_eventfd_id_alloc(event_id);
> +       new_id =3D amdgpu_eventfd_id_alloc(event_type);
>         if (!new_id)
>                 return NULL;
>
> @@ -140,7 +134,7 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd=
_mgr *mgr, u32 event_id)
>   *
>   *   event_id -> list of eventfds
>   *
> - * The xarray provides efficient lookup of event_id containers.
> + * The xarray provides efficient lookup of event type containers.
>   */
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
>  {
> @@ -186,23 +180,19 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_=
mgr *mgr)
>  }
>
>  /**
> - * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * amdgpu_eventfd_bind - bind an eventfd to an event type
>   * @mgr: eventfd manager
> - * @event_id: userspace event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   * @eventfd: eventfd file descriptor
>   *
> - * This function allows userspace to subscribe to notifications for a
> - * specific event_id.
> - *
> - * Multiple eventfds can be bound to the same event_id.
> - *
> - * Duplicate bindings of the same eventfd are treated as success and do
> - * not create additional entries.
> + * Register an eventfd subscription for the specified event type.
> + * Duplicate subscriptions are treated as success.
>   *
>   * Return:
> - * 0 on success, negative error code on failure.
> + * 0 on success or a negative error code.
>   */
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, in=
t eventfd)
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +                       u32 event_type, int eventfd)
>  {
>         struct amdgpu_eventfd_id *id;
>         struct amdgpu_eventfd_entry *e =3D NULL, *it;
> @@ -211,7 +201,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mg=
r, u32 event_id, int eventf
>         bool dup =3D false;
>         int r =3D 0; /* duplicate binds are treated as success */
>
> -       if (!mgr || !event_id || eventfd < 0)
> +       if (!mgr || !event_type || eventfd < 0)
>                 return -EINVAL;
>
>         /*
> @@ -229,7 +219,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mg=
r, u32 event_id, int eventf
>                 return PTR_ERR(ctx);
>         }
>
> -       id =3D amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +       id =3D amdgpu_eventfd_id_get_or_create(mgr, event_type);
>         if (!id) {
>                 r =3D -ENOMEM;
>                 goto out_put_ctx;
> @@ -259,7 +249,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mg=
r, u32 event_id, int eventf
>
>         /*
>          * Re-check duplicate under lock to close the race with another b=
ind()
> -        * for the same (event_id, ctx).
> +        * for the same event_type and eventfd context.
>          */
>         xa_lock_irqsave(&mgr->ids, flags);
>         hlist_for_each_entry(it, &id->entries, hnode) {
> @@ -291,17 +281,18 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *=
mgr, u32 event_id, int eventf
>  }
>
>  /**
> - * amdgpu_eventfd_unbind - remove eventfd binding
> + * amdgpu_eventfd_unbind - remove an eventfd subscription
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   * @eventfd: eventfd file descriptor
>   *
> - * Removes an existing binding between an event_id and an eventfd.
> + * Remove an existing subscription for the specified event type.
>   *
>   * Return:
> - * 0 if removed, -ENOENT if binding does not exist.
> + * 0 on success or a negative error code.
>   */
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, =
int eventfd)
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +                         u32 event_type, int eventfd)
>  {
>         struct amdgpu_eventfd_id *id;
>         struct amdgpu_eventfd_entry *e;
> @@ -310,7 +301,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *=
mgr, u32 event_id, int even
>         unsigned long flags;
>         bool removed =3D false;
>
> -       if (!mgr || !event_id || eventfd < 0)
> +       if (!mgr || !event_type || eventfd < 0)
>                 return -EINVAL;
>
>         ctx =3D eventfd_ctx_fdget(eventfd);
> @@ -319,7 +310,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *=
mgr, u32 event_id, int even
>
>         xa_lock_irqsave(&mgr->ids, flags);
>
> -       id =3D xa_load(&mgr->ids, event_id);
> +       id =3D xa_load(&mgr->ids, event_type);
>         if (!id)
>                 goto out_unlock;
>
> @@ -337,7 +328,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *=
mgr, u32 event_id, int even
>                 atomic_dec(&mgr->bind_count);
>
>                 if (!id->n_entries) {
> -                       __xa_erase(&mgr->ids, event_id);
> +                       __xa_erase(&mgr->ids, event_type);
>                         kfree(id);
>                 }
>
> @@ -352,22 +343,22 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr=
 *mgr, u32 event_id, int even
>  }
>
>  /**
> - * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * amdgpu_eventfd_signal - signal all eventfds bound to an event type
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * This function is typically called from interrupt context.
> + * Notify all subscribers associated with the specified event type.
>   *
> - * All eventfds registered for the given event_id will be signaled.
> - * Userspace processes waiting on those eventfds will wake up.
> + * Signaling is notification-only and does not carry additional payload.
>   */
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> +                          u32 event_type)
>  {
>         struct amdgpu_eventfd_id *id;
>         struct amdgpu_eventfd_entry *e;
>         unsigned long flags;
>
> -       if (!mgr || !event_id)
> +       if (!mgr || !event_type)
>                 return;
>
>         /*
> @@ -376,7 +367,7 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr =
*mgr, u32 event_id)
>          */
>         xa_lock_irqsave(&mgr->ids, flags);
>
> -       id =3D xa_load(&mgr->ids, event_id);
> +       id =3D xa_load(&mgr->ids, event_type);
>         if (id) {
>                 hlist_for_each_entry(e, &id->entries, hnode)
>                         eventfd_signal(e->ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_eventfd.h
> index 248afb1f2f14..e13b86240afc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -28,9 +28,9 @@
>  #ifndef __AMDGPU_EVENTFD_H__
>  #define __AMDGPU_EVENTFD_H__
>
> +#include <linux/atomic.h>
>  #include <linux/eventfd.h>
>  #include <linux/xarray.h>
> -#include <linux/atomic.h>
>
>  struct amdgpu_eventfd_entry {
>         struct eventfd_ctx *ctx;
> @@ -38,22 +38,25 @@ struct amdgpu_eventfd_entry {
>  };
>
>  struct amdgpu_eventfd_id {
> -       u32 event_id;
> +       u32 event_type;
>         struct hlist_head entries;
>         u32 n_entries;
>  };
>
>  struct amdgpu_eventfd_mgr {
> -       struct xarray ids;          /* event_id -> struct amdgpu_eventfd_=
id* */
> -       atomic_t bind_count;        /* total binds across all event_ids *=
/
> +       struct xarray ids;      /* event_type -> struct amdgpu_eventfd_id=
* */
> +       atomic_t bind_count;    /* total binds across all event types */
>  };
>
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
>  void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
>
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, in=
t eventfd);
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, =
int eventfd);
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +                       u32 event_type, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +                         u32 event_type, int eventfd);
>
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)=
;
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> +                          u32 event_type);
>
>  #endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index f5719500527f..7cc54b7e3b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -634,6 +634,43 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *a=
dev,
>         return 0;
>  }
>
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
> +                        struct drm_file *file_priv)
> +{
> +       struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
> +       struct drm_amdgpu_eventfd *args =3D data;
> +
> +       if (!fpriv)
> +               return -EINVAL;
> +
> +       /*
> +        * flags are reserved for future UAPI extensions and must be zero=
.
> +        */
> +       if (args->flags || !args->event_type || args->eventfd < 0)
> +               return -EINVAL;
> +
> +       /*
> +        * Queue-scoped subscriptions are enabled by the later
> +        * queue-reference routing patch. Until then, keep
> +        * queue_id zero.
> +        */
> +       if (args->queue_id)
> +               return -EINVAL;
> +
> +       switch (args->op) {
> +       case DRM_AMDGPU_EVENTFD_OP_BIND:
> +               return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> +                                          args->event_type,
> +                                          args->eventfd);
> +       case DRM_AMDGPU_EVENTFD_OP_UNBIND:
> +               return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> +                                            args->event_type,
> +                                            args->eventfd);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9f3090db2f16..bf4fc61cf0c7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -39,6 +39,7 @@ extern "C" {
>  #endif
>
>  #define DRM_AMDGPU_GEM_CREATE          0x00
> +#define DRM_AMDGPU_EVENTFD             0x1A

Move this to the end so we keep these in order.  Other than that,
looks good to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>  #define DRM_AMDGPU_GEM_MMAP            0x01
>  #define DRM_AMDGPU_CTX                 0x02
>  #define DRM_AMDGPU_BO_LIST             0x03
> @@ -79,6 +80,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_EVENTFD \
> +       DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_=
eventfd)
>
>  /**
>   * DOC: memory domains
> @@ -204,6 +207,46 @@ union drm_amdgpu_gem_create {
>         struct drm_amdgpu_gem_create_out        out;
>  };
>
> +enum drm_amdgpu_event_type {
> +       DRM_AMDGPU_EVENT_TYPE_USERQ_EOP =3D 1,
> +       DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET =3D 2,
> +       DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION =3D 3,
> +       DRM_AMDGPU_EVENT_TYPE_SCRATCH =3D 4,
> +       DRM_AMDGPU_EVENT_TYPE_GPU_RESET =3D 5,
> +};
> +
> +enum drm_amdgpu_eventfd_op {
> +       DRM_AMDGPU_EVENTFD_OP_BIND =3D 0,
> +       DRM_AMDGPU_EVENTFD_OP_UNBIND =3D 1,
> +};
> +
> +/**
> + * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU ev=
ent
> + * @op: operation type, see &enum drm_amdgpu_eventfd_op
> + * @event_type: kernel-defined AMDGPU event type
> + * @eventfd: eventfd file descriptor
> + * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
> + *           device/GPU-scoped subscriptions
> + * @flags: must be 0
> + *
> + * This ioctl lets userspace register or unregister eventfd notification=
s
> + * for a render-node event.
> + *
> + * Eventfd signaling is notification-only.
> + *
> + * USERQ_EOP, QUEUE_RESET, and SCRATCH are queue-scoped events.
> + * Userspace specifies @queue_id when registering these subscriptions.
> + *
> + * MEMORY_EXCEPTION is currently GPU-scoped and requires @queue_id =3D 0=
.
> + */
> +struct drm_amdgpu_eventfd {
> +       __u32 op;
> +       __u32 event_type;
> +       __s32 eventfd;
> +       __u32 queue_id;
> +       __u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE       0
>  /** Opcode to destroy previously created residency list */
> --
> 2.34.1
>
