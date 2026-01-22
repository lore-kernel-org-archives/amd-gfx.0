Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0687D6CFA4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 20:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DAA710EAA8;
	Thu, 22 Jan 2026 20:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLLECGgv";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E841510EAA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 20:32:55 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b6a868ad45so179203eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 12:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769113975; cv=none;
 d=google.com; s=arc-20240605;
 b=CgTYnHLRI77s6AtqS2k0AJJCMge9Fct5i/9KJ/J6kKSlhJi1hwQDZlyyF02H4Z41VY
 7pSDss8puwAClc9IDqiEAcPcrYibhwztiiV7n1p2bamCYduTdL6reXEEg1/vos/E/hQL
 0nKtxXDpBq4tZNtsKTTYRcP8iy94LJpdoKmSOa6il8vMXakcMncIiVEoGdOZCbogetCN
 KHeW5KMNw2E+XlRZGAiInNXBL3NQnqcDG5b13WLUTp3MM+fZWqkjMjztB6alGuodHkSA
 wwnzjc+UfmzG84epYCibJhM/5VZ+pxLJalNLAFEavodsv/pus/w3C031RaA8CaMZva52
 4RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3QlVzDpmI9b/ulUslPpx58ATQ0YoSooaH7WIDYVKU6c=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=kQ/zjjxdZyLKRqw+CEpJVEPw2DJHqxEiSKps7qbFkM8xv0qgh1sZj951aylvQKXxwF
 ypnA8pGaiFxYI9EW2W4lNcE2J96rY+B+ZbMf026j6gizhIJ7q4AvZTXP/C3QyZNcsYNK
 bNxGZWHkbUh/YT2vcJCqrMhEDdBJpqhk3X8bdaB39a/8YT8v6OOAe/j9yd4jjvLDf3Ub
 0Lchq8fTGiOkjU+UjbPr9M4FvGjQ8zqR07XtQe3OcMpeXZgQZQFupRV/F3E58o0q7N6n
 k7cnp67fF1iqVSqPM6KTTO55MKk2yojkDtRYM1cgnngOjvHZoJqr6tCeEu2LZa9wtP/G
 pcmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769113975; x=1769718775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QlVzDpmI9b/ulUslPpx58ATQ0YoSooaH7WIDYVKU6c=;
 b=hLLECGgv+hZ663y+QFV7cfEjcLAME8Nh/mRZQ0KpMS/5hhT2Iv8uIV5Zx6tfm6dBn7
 0txsqv5Sc/CwTA7500PWHMC6Y8C0qw4+fpxmlAh5mxB7WPyJsaAdWwcki0wuqRsPmHWB
 Gywq76otwHh+kRTln9OZI92jxI6/HAsJwpACRus80GPvNxH2qm6gA6Q+xn9gVMpF7o5i
 nx2/yuV6C1T0cDynqMNKE6MVShxjwmPt4UwnYuqWwH4nvwFjKQV6CyekrW+CE43S+55Z
 MzETqx5I/pNMu9cjWQBulpkH8ciZsTpKTHPF7d/8ri3y5JWFw8p8L8a5NYXA1YUFk09p
 Hctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769113975; x=1769718775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QlVzDpmI9b/ulUslPpx58ATQ0YoSooaH7WIDYVKU6c=;
 b=X4RPB19f9DCDPwjcNeQ91xwJ4/ASIwJaExOA1pVjEQWCy8TQWtWSrNxfYDX3rnZeRc
 zHW0FlQ+KIWeeTVhcvUUkKRJdcOVcn2fC81bqvqjt0VZGvERbw6Bx/Ygt1osj3SCL7Jo
 XABFl0Jyi17v+vS27FtCUxf/1XdtgAVzWEpDaWWM0UKlFYqKF7Crc0zYcXNGVTD8TA3g
 cYXBeIa92PoVXXCSQy7+MdVfxmdbqW5VbAUMymEKpLSN0pANcSOGFTx/Ru0+qKChGyCL
 l3RnbVpDjpOsSj/5dd8gPFSAOUYtpVffDHBEU7+j5Zn/a/pKU5TUhLwZuMJiZj7jsQZi
 NY4Q==
X-Gm-Message-State: AOJu0Yx6ic9mwnj3Xu2iwFb4BJquR5260xGCZg7nfXPd2JVwtO7NSclR
 OhPNMZeUczrRJkqQpC6oxu+0itCbplrO0WSgHu/53a9HvL9qKvADxknW3G/TfcZ8WJxjboblzai
 ISnzEAnREoxdFi+AgXY7RRJvcTLfckh4=
X-Gm-Gg: AZuq6aIaHLkMn6tuR/ErFb3t7u2sY8qTZvfB9RAc6mJl6/w5RVCuChyZ1k/3tmeC3vS
 JXDFihrZRMpW3rAwPBbyEI9opTLQI4bNi6TRD2RRLRzl9hylh3HPTGO/OXzxe/LT+bsIST7HwaK
 aWnXTOxvqjWJh6Up6KrtHkcX/OziwaMIRtLg4evJ2dDAwiRkGm1IOLKwD4rN9X7WtmRfVeOwbk+
 eP3DW7HmmrvH1hmIeD4kmBJJVVZaDUVULBTd2mo48Qa4xCKai63ecnKUy5S/Qz+vIqDTFmA
X-Received: by 2002:a05:7300:572c:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b739bce440mr167181eec.4.1769113974806; Thu, 22 Jan 2026
 12:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
 <20260122085738.1542800-9-Jesse.Zhang@amd.com>
In-Reply-To: <20260122085738.1542800-9-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 15:32:43 -0500
X-Gm-Features: AZwV_QjTg25K3ZpmS2p8gFIlsMHvwit5hnOFpiJWr_zfzS0TGgQ30tNgrma1oQ4
Message-ID: <CADnq5_MZ_mv=u276x_XG3C962q6EaVSF1Cy4W6bzb+pstHWnbA@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amdgpu: Add queue update IOCTL support
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

On Thu, Jan 22, 2026 at 4:37=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Add AMDGPU_USERQ_UPDATE_QUEUE IOCTL to support updating user mode
> queue properties after creation. This allows userspace to modify
> queue attributes like ring buffer address, ring size, queue
> priority, and queue percentage dynamically.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 106 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   6 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   1 +
>  include/uapi/drm/amdgpu_drm.h              |  13 +++
>  6 files changed, 122 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 246d74205b48..1679075f679b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,9 @@ struct amdgpu_mqd_prop {
>         uint32_t cu_mask_count;
>         uint32_t cu_flags;
>         bool is_user_cu_masked;
> +       uint32_t queue_percentage;
> +       /* used in gfx9 and gfx12.1 */
> +       uint32_t pm4_target_xcc;
>  };
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 9c425169a4f9..bc6cc1517221 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3075,6 +3075,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DR=
M_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_=
RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_UPDATE_QUEUE, amdgpu_update_queue_=
ioctl, DRM_AUTH|DRM_RENDER_ALLOW),

I don't think we need a new IOCTL.  Just a new op for AMDGPU_USERQ.
E.g., AMDGPU_USERQ_OP_MODIFY

>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SET_CU_MASK, amdgpu_userq_set_cu_m=
ask_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 4cbf75723c08..922f73b92db3 100644
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
> @@ -907,7 +927,6 @@ static int amdgpu_userq_update_queue(struct amdgpu_us=
ermode_queue *queue,
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *uq_funcs;
> -       bool unmap_queue =3D false;
>         int r;
>
>         uq_funcs =3D adev->userq_funcs[queue->queue_type];
> @@ -923,23 +942,94 @@ static int amdgpu_userq_update_queue(struct amdgpu_=
usermode_queue *queue,
>                 r =3D amdgpu_userq_unmap_helper(queue);
>                 if (r)
>                         return r;
> -               unmap_queue =3D true;
>         }
>
>         r =3D uq_funcs->mqd_update(queue, minfo);
> +       if (r)
> +               return r;
>
> -       if (unmap_queue) {
> -               int map_r =3D amdgpu_userq_map_helper(queue);
> -               if (map_r)
> -                       dev_err(adev->dev, "Failed to remap queue %llu af=
ter update\n",
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
>                                 queue->doorbell_index);
> -               if (!r)
> -                       r =3D map_r;
>         }
>
>         return r;
>  }
>
> +int amdgpu_update_queue_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_userq_update_queue_args *args =3D data;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_mqd_prop *props;
> +       int r;
> +
> +       /*
> +        * Repurpose queue percentage to accommodate new features:
> +        * bit 0-7: queue percentage
> +        * bit 8-15: pm4_target_xcc
> +        */

Just make the target xcc an explicit parameter.

> +       if ((args->queue_percentage & 0xFF) > AMDGPU_USERQ_MAX_QUEUE_PERC=
ENTAGE) {
> +               drm_file_err(uq_mgr->file, "Queue percentage must be betw=
een 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Validate priority */
> +       if (args->queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
> +               drm_file_err(uq_mgr->file, "Queue priority must be betwee=
n 0 to KFD_MAX_QUEUE_PRIORITY\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Validate ring size */
> +       if (!is_power_of_2(args->ring_size) && (args->ring_size !=3D 0)) =
{
> +               drm_file_err(uq_mgr->file, "Ring size must be a power of =
2 or 0\n");
> +               return -EINVAL;
> +       }
> +
> +       if (args->ring_size > 0 && args->ring_size < AMDGPU_GPU_PAGE_SIZE=
) {
> +               args->ring_size =3D AMDGPU_GPU_PAGE_SIZE;
> +               drm_file_err(uq_mgr->file, "Size clamped to AMDGPU_GPU_PA=
GE_SIZE\n");
> +       }
> +
> +       if ((args->ring_base_address) &&
> +               (!access_ok((const void __user *) args->ring_base_address=
,
> +                       sizeof(uint64_t)))) {
> +               drm_file_err(uq_mgr->file, "Can't access ring base addres=
s\n");
> +               return -EFAULT;
> +       }
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       queue =3D amdgpu_userq_find(uq_mgr, args->queue_id);
> +       if (!queue) {
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +
> +       props =3D queue->userq_prop;
> +       props->queue_size =3D args->ring_size;
> +       props->hqd_base_gpu_addr =3D args->ring_base_address;
> +       props->queue_percentage =3D args->queue_percentage & 0xFF;
> +       /* bit 8-15 are repurposed to be PM4 target XCC */

We should handle this explicitly rather than stashing it in percentage.

> +       props->pm4_target_xcc =3D (args->queue_percentage >> 8) & 0xFF;
> +       props->hqd_pipe_priority =3D amdgpu_userq_pipe_priority_map[args-=
>queue_priority];
> +       props->hqd_queue_priority =3D args->queue_priority;
> +
> +       r =3D amdgpu_userq_update_queue(queue, NULL);
> +
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +
> +       return r;
> +}
> +
>  int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
>                                      struct drm_file *filp)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 43bf104d2fb8..c8ea81c17c6e 100644
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
> @@ -118,6 +121,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp
>  int amdgpu_userq_set_cu_mask_ioctl(struct drm_device *dev, void *data,
>                                         struct drm_file *filp);
>
> +int amdgpu_update_queue_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp);
> +
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
>                           struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index ae221eaa5b82..cfa3cb46a983 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -304,6 +304,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> +       userq_props->queue_percentage =3D 100;
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 41b6b3cea834..c42328453652 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,6 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
>  #define DRM_AMDGPU_USERQ_SET_CU_MASK   0x1a
> +#define DRM_AMDGPU_USERQ_UPDATE_QUEUE  0x1b
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -81,6 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_USERQ_SET_CU_MASK DRM_IOWR(DRM_COMMAND_BASE + D=
RM_AMDGPU_USERQ_SET_CU_MASK, struct amdgpu_userq_set_cu_mask_args)
> +#define DRM_IOCTL_AMDGPU_USERQ_UPDATE_QUEUE DRM_IOWR(DRM_COMMAND_BASE + =
DRM_AMDGPU_USERQ_UPDATE_QUEUE, struct amdgpu_userq_update_queue_args)
>
>  /**
>   * DOC: memory domains
> @@ -343,6 +345,7 @@ union drm_amdgpu_ctx {
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
> +#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE      100
>
>  /*
>   * This structure is a container to pass input configuration
> @@ -440,6 +443,16 @@ struct amdgpu_userq_set_cu_mask_args {
>         __u64 cu_mask_ptr;
>  };
>
> +
> +/* IOCTL parameters used to set user queue updates */
> +struct amdgpu_userq_update_queue_args {
> +       __u64 ring_base_address;
> +       __u32 queue_id;
> +       __u32 ring_size;

Do we actually need to be able to change the ring base address and
size?  I know KFD can do it, but we should verify if we really need to
be able to change the ring size at runtime.

> +       __u32 queue_percentage;
> +       __u32 queue_priority;

We should probably also make these available for USERQ create as well.
I would fold CU mask in as well.

Alex

> +};
> +
>  /* GFX V11 IP specific MQD parameters */
>  struct drm_amdgpu_userq_mqd_gfx11 {
>         /**
> --
> 2.49.0
>
