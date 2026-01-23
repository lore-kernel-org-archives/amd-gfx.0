Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D3D778AE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 21:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD4710EBE0;
	Fri, 23 Jan 2026 21:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bN13IQlS";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A0D10EBDD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 21:05:52 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2b71e7dab12so244625eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 13:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769202352; cv=none;
 d=google.com; s=arc-20240605;
 b=kVuVmN5OJ5dJDLpFgPO4fgJFEKzVxzy/LZXoiqQG2QPEWyMzUrEIj0G1Jy38HZmXX5
 6iTmLbzl5vJjnTovulZcpjHYj6/DJanRakfa7Hyux836g1+L4rjbyWtaLssgZa2r6Iav
 fbNxX/MfCzf99IGydEOdbgU7wBeEvRzbjtLD1jRB3bq2gDkgHagZfhJqhqIZV0FRhFtf
 hJ+fqqFR3JXaz1WdilLly96Qtq/F3Dsi4VScWb/jhg/SApG377SkM4yX7xmnI4fEwkME
 v2z4WOuuo2HycnfiQDIdyUQukeA+oVgwEQnpCbqeE1yJRZWDok2ozgTQSS2YeuWggJl1
 v36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ET0/3x0frTMaccBxIz3nXAk2TYj+6KhpTUNqTf5QZeA=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=Qz/csUdqDniyj1IgAnD6L0WpNrHU1sw9I/TMXXriVTR4rOsYADiD5VN1zXQpGGJGnC
 ap1YHrAKAkhPcH9gHO5aCy6hecbmodAUEjfs2pBltFWlhbEqVvHsn9htJXy0LRI0sX9P
 ThjvjpgQbGRtcmkfcU1nZZsOkHpbJuo850CDIbQHxegjLDJEViGO52xk2FHhmdKTeAjM
 jYZAE0iC6+MdDLxY+OQPZvvn5lMRtVzzZ3zs1VOul4VXt14bDRJYJJvUkIktWX8lcjGe
 E/JkqaPUKhqGxnEXEl06y14oIB4JHYK0Gov35zRqAXBr69wepJPBMw7FZJaQfMK1Rngt
 A/7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769202352; x=1769807152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ET0/3x0frTMaccBxIz3nXAk2TYj+6KhpTUNqTf5QZeA=;
 b=bN13IQlS5bas0pO+v7VdoV9OGMLtwukjvx1ntwWvZBCU6ZwhAZYOED8Ysmu/wJfm7H
 P/1bMoRTYtk0rN/AD/sv4BVDGjeueb+JHjSnz0KW9eRTB9Vhae4xiW92rMuIJ3X9p/kZ
 avY8xQAmASd0cBbQVbHJ57Lq/1LNT+heu/iXpnyGNe62J7AC3aMrZMVyL8M5lPy3ODHA
 86zHM5hGZJTxqZWEspswJAM7UZHBQtrsImDKYVvEEHR4wxq0GdJ0HIUauGJgL6rkoY1A
 o5OTr6OOAaHJRFfNHZUwhzYLv5ielCoBC3hTU35Na+uDcSxuhphaErhRqjGTYXIFJjnM
 9JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769202352; x=1769807152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ET0/3x0frTMaccBxIz3nXAk2TYj+6KhpTUNqTf5QZeA=;
 b=Nu18kwwJxREap8oOFGV7drfNwVImhw/0inmB/0sRLfFB7QPM/jWiaZJBRRoy5J+yip
 6BgEuYl782sLkO4ayzaLIBnPm981QCbrYGaUbpYF4VvtmH0S7xMGa/cCCuinQWiwpUDO
 S7ZmzJuVtHKKNE3x3XZ5R6t3juPnVeMWi6PMyfBAf6W/dGzLuHnXtgPpe0AFb2/Xqmsi
 J+X3/7f0hwYt3kkt7g6jFoBSoCcFDxOg3OWJGUiwdpNW/sTzVzwY2GXBNLUxUBhlY9KA
 HhIwuF3NVxiigo001XGiJ6qxAxqyFiuaj9im53iUJA3icu37eUpfs4rx55i4fNkd4yLD
 b/Pg==
X-Gm-Message-State: AOJu0YzJdSoPRa93fuKp2x7gWmSS/7O0StdHAQYlad4SuYeGrzh+mVUh
 bupSTSscEX9RNE8uH0YGRm4YrzRQXW2IxG5GyowWbRLyNSsUZAe+ByUnv/pkO6GE9fOelD8gt37
 UOzYESkpgd2DYT6NRdkdpHngyasLb+3I=
X-Gm-Gg: AZuq6aJRb0tE9SV5EWwTgTA29rDfyQ08ZrO7vz/KtuWx0i+1vw8KukWNh1byBtureOw
 Wv556+kv1i8kewzuWs+fEY6vIr/nD5KiT2FFmcbcAGHyGdQ07LpGXx/SKzCyrIPgH13DUTSg6k6
 CyX9nAyToc064rFGwOSFW7jvfRnqFZbft8CRy9V/XgtmAm3kq6ZkFiNB1hkVQpxfxTjM1JS91XR
 5LvjsUV6M3cZOtEkWalMa2/m487xsF/vari7OYJ/pF70Edbx3xKFzrF83TJx67jN69xvy6Q
X-Received: by 2002:a05:7300:72ce:b0:2b4:849c:8dd8 with SMTP id
 5a478bee46e88-2b74e7face1mr236750eec.3.1769202351546; Fri, 23 Jan 2026
 13:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
 <20260123100219.1693990-7-Jesse.Zhang@amd.com>
In-Reply-To: <20260123100219.1693990-7-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 16:05:39 -0500
X-Gm-Features: AZwV_QjiYN--dx0qbPjNubKASoXFSFbxIhkGl7bYV5RD2fRMSbSHjA0JKgw9FxI
Message-ID: <CADnq5_Mncsm6BrQVkJz46hzppg+PL2azyJnQOkiV-ibNGqRLyQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: add queue modification support to
 AMDGPU_USERQ ioctl
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

On Fri, Jan 23, 2026 at 5:11=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Extend the AMDGPU_USERQ ioctl to support dynamic modification of
> existing user mode queues after creation. This provides userspace
> with the ability to update queue attributes without requiring
> destruction and recreation of queues.
>
> v2: add a new op for AMDGPU_USERQ. E.g., AMDGPU_USERQ_OP_MODIFY. (Alex)
>    make the target xcc an explicit parameter. (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 96 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  1 +
>  include/uapi/drm/amdgpu_drm.h              | 17 ++++
>  5 files changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a8f4f73fa0ce..ad136145316b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -819,6 +819,9 @@ struct amdgpu_mqd_prop {
>         uint32_t cu_mask_count;
>         uint32_t cu_flags;
>         bool is_user_cu_masked;
> +       uint32_t queue_percentage;
> +       /* used in gfx9 and gfx12.1 */
> +       uint32_t pm4_target_xcc;
>  };
>
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 4d7841f47dd3..de267135af69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,6 +34,26 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>
> +/* Mapping queue priority to pipe priority, indexed by queue priority */
> +int amdgpu_userq_pipe_priority_map[] =3D {
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2
> +};
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -906,7 +926,6 @@ static int amdgpu_userq_update_queue(struct amdgpu_us=
ermode_queue *queue)
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *uq_funcs;
> -       bool unmap_queue =3D false;
>         int r;
>
>         uq_funcs =3D adev->userq_funcs[queue->queue_type];
> @@ -922,12 +941,17 @@ static int amdgpu_userq_update_queue(struct amdgpu_=
usermode_queue *queue)
>                 r =3D amdgpu_userq_unmap_helper(queue);
>                 if (r)
>                         return r;
> -               unmap_queue =3D true;
>         }
>
>         r =3D uq_funcs->mqd_update(queue);
> -
> -       if (unmap_queue) {
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
>                 r =3D amdgpu_userq_map_helper(queue);
>                 if (r)
>                         drm_file_err(uq_mgr->file, "Failed to remap queue=
 %llu after update\n",
> @@ -937,6 +961,65 @@ static int amdgpu_userq_update_queue(struct amdgpu_u=
sermode_queue *queue)
>         return r;
>  }
>
> +static int amdgpu_modify_queue(struct drm_file *filp, union drm_amdgpu_u=
serq *args)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_mqd_prop *props;
> +       int r;
> +
> +       if (args->in.queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE=
) {
> +               drm_file_err(uq_mgr->file, "Queue percentage must be betw=
een 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Validate priority */
> +       if (args->in.hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIM=
UM) {
> +               drm_file_err(uq_mgr->file, "Queue priority must be betwee=
n 0 to KFD_MAX_QUEUE_PRIORITY\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Validate ring size */
> +       if (!is_power_of_2(args->in.queue_size) && (args->in.queue_size !=
=3D 0)) {
> +               drm_file_err(uq_mgr->file, "Ring size must be a power of =
2 or 0\n");
> +               return -EINVAL;
> +       }
> +
> +       if (args->in.queue_size > 0 && args->in.queue_size < AMDGPU_GPU_P=
AGE_SIZE) {
> +               args->in.queue_size =3D AMDGPU_GPU_PAGE_SIZE;
> +               drm_file_err(uq_mgr->file, "Size clamped to AMDGPU_GPU_PA=
GE_SIZE\n");
> +       }
> +
> +       if ((args->in.queue_va) &&
> +               (!access_ok((const void __user *) args->in.queue_va,
> +                       sizeof(uint64_t)))) {
> +               drm_file_err(uq_mgr->file, "Can't access ring base addres=
s\n");
> +               return -EFAULT;
> +       }
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       queue =3D amdgpu_userq_find(uq_mgr, args->in.queue_id);
> +       if (!queue) {
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +
> +       props =3D queue->userq_prop;
> +       props->queue_size =3D args->in.queue_size;
> +       props->hqd_base_gpu_addr =3D args->in.queue_va;
> +       props->queue_percentage =3D args->in.queue_percentage;
> +       props->pm4_target_xcc =3D args->in.pm4_target_xcc;
> +       props->hqd_pipe_priority =3D amdgpu_userq_pipe_priority_map[args-=
>in.hqd_queue_priority];
> +       props->hqd_queue_priority =3D args->in.hqd_queue_priority;
> +
> +       r =3D amdgpu_userq_update_queue(queue);
> +
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return r;
> +}
> +
>  static int amdgpu_userq_set_cu_mask(struct drm_file *filp,  union drm_am=
dgpu_userq *args)
>  {
>         struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> @@ -1031,6 +1114,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d *data,
>                 amdgpu_userq_set_cu_mask(filp, args);
>                 break;
>
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
> index c80d69368196..078f424e9415 100644
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 0565986949bd..1a0079a2b47c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -304,6 +304,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> +       userq_props->queue_percentage =3D AMDGPU_USERQ_MAX_QUEUE_PERCENTA=
GE;
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index cfc3a9313229..fab2914ac25c 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -331,6 +331,7 @@ union drm_amdgpu_ctx {
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
>  #define AMDGPU_USERQ_OP_MODIFY_CU_MASK 3
> +#define AMDGPU_USERQ_OP_MODIFY 4
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -342,6 +343,7 @@ union drm_amdgpu_ctx {
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
> +#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE      100
>
>  /*
>   * This structure is a container to pass input configuration
> @@ -423,6 +425,21 @@ struct drm_amdgpu_userq_in {
>          * represents 32 CUs/WGPs)
>          */
>         __u32 cu_mask_count;
> +       /**
> +        * @queue_percentage: Queue resource allocation percentage (0-100=
)
> +        * Defines the percentage of GPU resources allocated to this queu=
e
> +        */
> +       __u32 queue_percentage;
> +       /**
> +        * @hqd_queue_priority: Hqd Queue priority (0-15)
> +        * Higher values indicate higher scheduling priority for the queu=
e
> +        */
> +       __u32 hqd_queue_priority;
> +       /**
> +        * @pm4_target_xcc: PM4 target XCC identifier (for gfx9/gfx12.1)
> +        * Specifies the target XCC (Cross Compute Complex) for PM4 comma=
nds
> +        */
> +       __u32 pm4_target_xcc;

Same comment as patch 6.

Alex

>  };
>
>  /* The structure to carry output of userqueue ops */
> --
> 2.49.0
>
