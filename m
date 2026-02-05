Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED370ECD9AF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 921C410E142;
	Thu,  5 Feb 2026 21:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaUtAPTf";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940CE10E142
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:45:20 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b7267ff06fso129696eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 13:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327920; cv=none;
 d=google.com; s=arc-20240605;
 b=QaDcvoj1pxnV69C0veoRe/CcpGx5+Lc0WmZJaGU0laysD776SGoRUY/2sfMfRJP9iu
 JH+N5iktzFuDaeXUlcqyGL9uIZOixiGQJEkkq8ghwG1s41judWDnL39N3Aqr2KwT+QX9
 OYFCj0RIlyf9yt911m5ipk6wyhaivqK/v3+EEMQLn4qZJ4URE3eEA92J2boF98eJKppX
 5IlFV9vbRj7CJhTyNK8qISv558KQe5Q+LUFZmrKtzgsxh7v6SzhcNptiAfZ8kI31xhaA
 NyhzJofe0NJqhGAWUZqK36Yg22Y85HHbB5+ZPnlWhepdrUKOFytxtq+r1ztoZz/ShEPj
 E2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jfka5XFt5VUuCGxOnNvROqefoUT52prsdj9EtYSlQ08=;
 fh=HvMJyYtL42LG7kcQWJzdHtf7xGfoBjXbsXwR7TjHqXY=;
 b=NnbeH/mT8YsXpuKN8O5ZE1DE93dob1B28vtuyW8RNTTFiJedtbPkpLis0EL7XtKXVT
 xM4fQ8y3lnLflG54Y7RDgcVTlndcjUD2QU3IcULNl0BzV+1DzbeeQS+TVqJRe/V3fW1r
 3mxJEgB0HDWlz9cUHDrCLj3zJL/8k7sYYZoqLFXUZayRvUawRt9wSKHJv5pj5Wz+x/pI
 cgDTn4wgmZoI5CHV1tCO4JL4uTW4xDhkORE3lxf/fWYgj8LRRiBPo9OPPWG6NgunOhTp
 ci5c38C1F+dEnCEoeg8lHK5h+HD71edEBSqEbjoMZtvNaca0qItwd0Gz2D6nsPbnp+Jc
 Xc7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770327920; x=1770932720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfka5XFt5VUuCGxOnNvROqefoUT52prsdj9EtYSlQ08=;
 b=gaUtAPTfPCq6bAHdDHBnYRh1c+VRZuW8Ow7Re0Pbu32Gs1lUapkfLlj7WNR4EYI9UI
 ZmWaJqZPgIqgPv1jSIk9VJQx0BK4MBkudcaV5BOSXiKfVmvo47m5fCAsHnGEzODpSe+t
 o55RVnDyRC1eD050fJc1unheE3uVbfEPayrtQ1rToNSwOnFd460gLED42FZ+1+QN/PTx
 0TlU0Y7Kt8BtiiZA9mGILUusNWNKTw2i2hORHcF2F2FL0YlhzENhUqdLdqY3B45eAYAT
 HjRIQG9LG54xPrkfsaGG9Kh97BlOj8IQ0gJQUPZNL5pVbuQ1yuFSTKQO0Rir9vbdgjIr
 jvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327920; x=1770932720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jfka5XFt5VUuCGxOnNvROqefoUT52prsdj9EtYSlQ08=;
 b=sb096PQZVghJPSBNeD9ath8ZBjzuTWkLbKZfDx9LqcLm9H0f1iLtiiW2oW2o9Mfm3f
 zHvUfbd83627Nop2lN/sisBlm2k/nYczCNfoSR6uMc8xokwNaXH8oLEqfGjA1nywh0bj
 Q2/lo7WI4ERGBLx/osUw+Bag8XyatUj5A1ibBS3pc9HzzBWxsHcv7DHLsnFHambQyX84
 RSPENzESgQGv675ltcG7JA9JPLAu7dsFDDXmR63UBQb6vv0V9AQaNLwA1wdjxliuwgUe
 B1gcs/EJlzXM1ziWQU2Q3esZXBTXyHn4bvyj/0IfNM86+mgChBjRRbS90qvNVjlOLC4K
 5aLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBN/i8Qh4SlgmoNFGfiLgnIx4LJe/bwHJfIexflkmZPwmJ+Im8bBNdRNNqUEx0CYnEK+CXI5/G@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze5vKz+QzKxwgbzQnivQ+U0kTkyKJ+o3N1p1R8ZbC1YSaE8Jqr
 CHvYHGd3M+ZVXz04hzj0ivAVrfVm9H7oXYOVCE+MQQPdXLfJWtcMnhmblnR6of7oWeN2PWKbY2j
 o5Do4t+YLZoPhbJysf+a3m8dz8qoHtuY=
X-Gm-Gg: AZuq6aJpOMw7Optx2UAIeihmAfh5C88hSORtIGdzFvSIXaK4DkenbdPbCprY6g0buIV
 sh93ef9O6yiwQAfUlNhq940INdfXFt98DWNbOwUlNwT44Yf0zuRH0KNXINCccMFz8M/Bjhy7RZ1
 tKBgLHKvre6FyU4n7Eyfwft8BuJ1MPLkQ8C1PZs6gUH5XCaIiBDoWbaV7hKO4sQuovnyUNzipl9
 Qsmn4Cvg5CtZfFye4ABDjEYwX0XAg6+ZG45vQTen95Eu1edJxCyuTIna9gIXWS+ltNNGrma
X-Received: by 2002:a05:7022:92c:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12703faeaffmr161866c88.3.1770327919768; Thu, 05 Feb 2026
 13:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-11-perry.yuan@amd.com>
In-Reply-To: <20260205065130.654921-11-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 16:45:08 -0500
X-Gm-Features: AZwV_Qgdqdjnyb0uA1xGnygkLSC6QlJll_9R4vTXd1QL356usyjacZT2eIzP5Ok
Message-ID: <CADnq5_OZEVEhdy4onJNCM6thp0M83cgaKhhAFrPPWNhj5K0W_w@mail.gmail.com>
Subject: Re: [PATCH 11/22] drm/amdkfd: Add PTL control IOCTL Option and unify
 refcount logic
To: Perry Yuan <perry.yuan@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 yifan1.zhang@amd.com
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

On Thu, Feb 5, 2026 at 2:17=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wrot=
e:
>
> Introduce a new IOCTL option to allow userspace explicit control over
> the Peak Tops Limiter (PTL) state for profiling
>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Please provide a link to the userspace that uses this new IOCTL interface.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 89 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c |  5 +-
>  include/uapi/linux/kfd_ioctl.h           |  7 ++
>  6 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 0a2f8d33a0ad..1af641ae9a02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -476,6 +476,8 @@ struct psp_context {
>         enum amdgpu_ptl_fmt             ptl_fmt2;
>         bool                            ptl_enabled;
>         bool                            ptl_hw_supported;
> +       /* PTL disable reference counting */
> +       atomic_t                        ptl_disable_ref;
>  };
>
>  struct amdgpu_psp_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index d94bf21db281..472e2f41fed2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2395,6 +2395,8 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct =
amdgpu_device *adev, bool sta
>
>         adev->psp.ptl_hw_supported =3D true;
>
> +       atomic_set(&adev->psp.ptl_disable_ref, 0);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 285219781939..6457c5703f99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1785,6 +1785,88 @@ int kfd_ptl_control(struct kfd_process_device *pdd=
, bool enable)
>         return ret;
>  }
>
> +int kfd_ptl_disable_request(struct kfd_process_device *pdd,
> +               struct kfd_process *p)
> +{
> +       struct amdgpu_device *adev;
> +       int ret =3D 0;
> +
> +       if (!pdd)
> +               return -ENODEV;
> +
> +       adev =3D pdd->dev->adev;
> +       mutex_lock(&p->mutex);
> +
> +       if (pdd->ptl_disable_req)
> +               goto out;
> +
> +       if (atomic_inc_return(&adev->psp.ptl_disable_ref) =3D=3D 1) {
> +               ret =3D kfd_ptl_control(pdd, false);
> +               if (ret) {
> +                       atomic_dec(&adev->psp.ptl_disable_ref);
> +                       dev_warn(pdd->dev->adev->dev,
> +                                       "failed to disable PTL\n");
> +                       goto out;
> +               }
> +       }
> +       pdd->ptl_disable_req =3D true;
> +
> +out:
> +       mutex_unlock(&p->mutex);
> +       return ret;
> +}
> +
> +int kfd_ptl_disable_release(struct kfd_process_device *pdd,
> +               struct kfd_process *p)
> +{
> +       struct amdgpu_device *adev;
> +       int ret =3D 0;
> +
> +       if (!pdd)
> +               return -ENODEV;
> +
> +       adev =3D pdd->dev->adev;
> +       mutex_lock(&p->mutex);
> +       if (!pdd->ptl_disable_req)
> +               goto out;
> +
> +       if (atomic_dec_return(&adev->psp.ptl_disable_ref) =3D=3D 0) {
> +               ret =3D kfd_ptl_control(pdd, true);
> +               if (ret) {
> +                       atomic_inc(&adev->psp.ptl_disable_ref);
> +                       dev_warn(pdd->dev->adev->dev,
> +                                       "failed to enable PTL\n");
> +                       goto out;
> +               }
> +       }
> +       pdd->ptl_disable_req =3D false;
> +
> +out:
> +       mutex_unlock(&p->mutex);
> +       return ret;
> +}
> +
> +static int kfd_profiler_ptl_control(struct kfd_process *p,
> +               struct kfd_ioctl_ptl_control *args)
> +{
> +       struct kfd_process_device *pdd;
> +       int ret;
> +
> +       mutex_lock(&p->mutex);
> +       pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> +       mutex_unlock(&p->mutex);
> +
> +       if (!pdd)
> +               return -ENODEV;
> +
> +       if (args->enable =3D=3D 0)
> +               ret =3D kfd_ptl_disable_request(pdd, p);
> +       else
> +               ret =3D kfd_ptl_disable_release(pdd, p);
> +
> +       return ret;
> +}
> +
>  static int criu_checkpoint_process(struct kfd_process *p,
>                              uint8_t __user *user_priv_data,
>                              uint64_t *priv_offset)
> @@ -3250,7 +3332,7 @@ static inline uint32_t profile_lock_device(struct k=
fd_process *p,
>                 if (!kfd->profiler_process) {
>                         kfd->profiler_process =3D p;
>                         status =3D 0;
> -                       kfd_ptl_control(pdd, false);
> +                       kfd_ptl_disable_request(pdd, p);
>                 } else if (kfd->profiler_process =3D=3D p) {
>                         status =3D -EALREADY;
>                 } else {
> @@ -3259,7 +3341,8 @@ static inline uint32_t profile_lock_device(struct k=
fd_process *p,
>         } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
>                 kfd->profiler_process =3D NULL;
>                 status =3D 0;
> -               kfd_ptl_control(pdd, true);
> +               kfd_ptl_disable_release(pdd, p);
> +
>         }
>         mutex_unlock(&kfd->profiler_lock);
>
> @@ -3302,6 +3385,8 @@ static int kfd_ioctl_profiler(struct file *filep, s=
truct kfd_process *p, void *d
>                 return 0;
>         case KFD_IOC_PROFILER_PMC:
>                 return kfd_profiler_pmc(p, &args->pmc);
> +       case KFD_IOC_PROFILER_PTL_CONTROL:
> +               return kfd_profiler_ptl_control(p, &args->ptl);
>         }
>         return -EINVAL;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 164f69924a3d..48347065b9cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -872,6 +872,8 @@ struct kfd_process_device {
>         bool has_reset_queue;
>
>         u32 pasid;
> +       /* Indicates this process has requested PTL stay disabled */
> +       bool ptl_disable_req;
>  };
>
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -1609,6 +1611,10 @@ static inline bool kfd_is_first_node(struct kfd_no=
de *node)
>
>  /* PTL support */
>  int kfd_ptl_control(struct kfd_process_device *pdd, bool enable);
> +int kfd_ptl_disable_request(struct kfd_process_device *pdd,
> +               struct kfd_process *p);
> +int kfd_ptl_disable_release(struct kfd_process_device *pdd,
> +               struct kfd_process *p);
>
>  /* Debugfs */
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 5114ac4da5b9..882080dc4925 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1115,7 +1115,6 @@ static void kfd_process_profiler_release(struct kfd=
_process *p, struct kfd_proce
>         mutex_lock(&pdd->dev->kfd->profiler_lock);
>         if (pdd->dev->kfd->profiler_process =3D=3D p) {
>                 pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
> -               kfd_ptl_control(pdd, true);
>                 pdd->dev->kfd->profiler_process =3D NULL;
>         }
>         mutex_unlock(&pdd->dev->kfd->profiler_lock);
> @@ -1133,6 +1132,10 @@ static void kfd_process_destroy_pdds(struct kfd_pr=
ocess *p)
>                 pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
>                         pdd->dev->id, p->lead_thread->pid);
>                 kfd_process_profiler_release(p, pdd);
> +
> +               if (pdd->ptl_disable_req)
> +                       kfd_ptl_disable_release(pdd, p);
> +
>                 kfd_process_device_destroy_cwsr_dgpu(pdd);
>                 kfd_process_device_destroy_ib_mem(pdd);
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 8db0c474a769..d48c407e9ee5 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1572,6 +1572,7 @@ enum kfd_profiler_ops {
>         KFD_IOC_PROFILER_PMC =3D 0,
>         KFD_IOC_PROFILER_PC_SAMPLE =3D 1,
>         KFD_IOC_PROFILER_VERSION =3D 2,
> +       KFD_IOC_PROFILER_PTL_CONTROL =3D 3,
>  };
>
>  /**
> @@ -1583,10 +1584,16 @@ struct kfd_ioctl_pmc_settings {
>         __u32 perfcount_enable;   /* Force Perfcount Enable for queues on=
 GPU */
>  };
>
> +struct kfd_ioctl_ptl_control {
> +       __u32 gpu_id; /* user_gpu_id */
> +       __u32 enable; /* set 1 to enable PTL, set 0 to disable PTL */
> +};
> +
>  struct kfd_ioctl_profiler_args {
>         __u32 op;                                               /* kfd_pr=
ofiler_op */
>         union {
>                 struct kfd_ioctl_pmc_settings  pmc;
> +               struct kfd_ioctl_ptl_control   ptl;
>                 __u32 version;                          /* KFD_IOC_PROFIL=
ER_VERSION_NUM */
>         };
>  };
> --
> 2.34.1
>
