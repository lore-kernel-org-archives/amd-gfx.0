Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E58CD4F3C
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 18:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CC910E0BB;
	Fri, 15 May 2026 18:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZjUMAtN";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FB210E0BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 18:56:45 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c87f1f8c8so8430c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 11:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778871405; cv=none;
 d=google.com; s=arc-20240605;
 b=KZDSKnN671nSmMw492PI7fq85B3t6kWI8vGNo123iAKicF4Mvv0SZkkrNYfH90QXIb
 mDvAYVwWa5ukCCh5BqS7GrNzSEhFmsYVs1PDiRSCnqLkqe0aqtYxfIHka0u4N6x9W4V5
 VxUPbMBQzpU8wCPADnqORX8c5PEMNFcMMi2n5J9SmcWcj8jrH6sGQNmXpM6iPM6cJt0q
 rvbn8R2bkusFxz/imeS/DH3sJ9irHmCEQWOULwYbohP3Kz4Uo7HteZ2LfPtF/DKQqRVN
 c7KWC3ob1S56hVNv831LYC7ZRfmaUr/3myDmnK09Redl/2GrKTECsWDgA035A7JuPnYD
 lsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZEE16l/blLoH5rIbcJX7opi5VXlZHTERnoBoBmHCeJM=;
 fh=IrMaVJY8cEHHM9oFQX7w4TEaGUPsscktABKEFFmjpVI=;
 b=hYupeoNzHNCTMGy8ru53wB8d1KOxE/D6VCGQZTIgYuLy33AVPKprkutAnNEEhNHp+B
 VWg/1lc72QbE8Q7Avkj6P3LHjR9wn63qaChIubrtTfGO+LDQFSXj6daf8Dq4i1pxnhMI
 IuJt+bkijJpGJ71rNYc7/rsvDBbB8SYD4FUbEDPvp2bILsmgNE7qSOtSNHnn4AmupsYw
 ojIMvc3HA3BFQzsMJbpvhfcHGPKUZGBfJOHtqcvQe1H+GaOuizADchYF7MT5RoQD3egy
 mKTYKzPPZVRcGNK/tJYwkU6WVXIm0nl4Vin1UzmqMS+d5ZKRVODq3Pmfi/yv1mDrFLyj
 /o8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778871405; x=1779476205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEE16l/blLoH5rIbcJX7opi5VXlZHTERnoBoBmHCeJM=;
 b=QZjUMAtNWVvczZsnFAXzIIDUkSSOCcZYK/VmKoKfs5RAOKGnRgPYn9D1xtA4n1ab1W
 l0wLPXY5M5crLc0YhwQC2ahHHduOj8JuuIWtu9Ba5DOAg79KVpBNNWLj1qvEfqBlOXpm
 GS33RiSbu/VLP8xI1VArXsypI+Xe33oketMsMcz467xSSYNFI0e00pM5+CbDglg5TBh6
 Kvarn+wwRy+bkVX6SJqc0Q4bUu/tlNer3XmiDpBzGmAiBJ6UT8gpTd+jHuqTiftNZ9WE
 Ks3kexaUgGJwm8P9ugY9tmz7hWKprZ6UyZ8jMaX4ObRiVj4nggTojsgKO0qrpgBWD5/l
 EVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778871405; x=1779476205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEE16l/blLoH5rIbcJX7opi5VXlZHTERnoBoBmHCeJM=;
 b=Gk4IxbbwtQ11mYvA60pl6z0wWYjS++qz5Jq4OztxHiRhfD0P1IXMtTzzdXt7qxsnrn
 tGw7T0hFJLLfwJEQ7iOXSZhypP4Qzi+7qQuHBjrefTw8OiH/xJld9UKRIgChLMAo/HfB
 4t3u8zk/VqnRDpcGcG2Plsdls9yZA4mXE2QOJ/ytJtvUTfS4oIqrzr3ZqgmUadFNGCU/
 v5dCFuShT9Ghw/L14mqX3Aqm2dgE2m0e/hYVzRVNW6PICFZOYC6+I3DuAc0a6pqsHW5V
 MwdQOtXIquEuPPJzx/S4/1ixUqTyVmOSUVMrODE0PNHD83QED38aMdYTU7VBH1PXxrLT
 heAQ==
X-Gm-Message-State: AOJu0YzdC7T3RhKwFbBdVlpLsJJS2HvvHvKu/o+SKk8sZAnDNwkzwDNY
 svCspUQ6DLsRx4+wjGAgVcQCvXroSBKUtqtYf7glKNkEKWuQdJjDLdFW3n0KgN1KwKU285CQate
 fCkLTeI1tZ2wUWWcwqwv7Z/VoJ9wjO4Y=
X-Gm-Gg: Acq92OEMFySbRTeVp+YoJjiWUtwEr6WeBOIKYNd2w4jao8Yy5OO267AptxfhqZhd9iR
 JZ7I/vZSBhffI94yV2fUXeOx8YLXjahGhkgl8m0T6L0KX0jRu6pDnAPuXdBbynufEKZW8Gk0Z67
 zYW01sWRuN2tuj/JfV3+dmBeFo8StUP1vKNSdcKT0BPermPeacRx3SdgpDG94tWXdK3diqh4gRy
 WmDY4dmq5EQDyXrfguHOGmewrEL2Uilqy47Fx2kWuSHcab8Y1VDDVYkvKsVAdqVh/NQAIw/U+rt
 9dnPFbbfBHLnxyS8gUJqAGRbthF5EV7ZQYKwuVlhmWVYho5XCFEHf3WQAdi2OAuV5QSf/PgLgep
 BBZ71
X-Received: by 2002:a05:7301:290b:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-3039870695fmr1267580eec.6.1778871404643; Fri, 15 May 2026
 11:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260515132702.1494187-1-yifan1.zhang@amd.com>
In-Reply-To: <20260515132702.1494187-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 May 2026 14:56:33 -0400
X-Gm-Features: AVHnY4K6Ix1ce1rQDCAdJqGKQhCB21Qzf5-f1GTfrnoOSX7FYubr9Uy6B14e3_I
Message-ID: <CADnq5_Ntk=4aG9+Y5RsH-oeAcHUDCamS9i4+nY5eDr1NW88n0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add ioctl to handle RAS poison error
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com, Felix.Kuehling@amd.com, David.YatSin@amd.com, 
 Kent.Russell@amd.com, Perry.Yuan@amd.com
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

On Fri, May 15, 2026 at 9:27=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
> to control per-process SIGBUS delivery.
>
> Userspace for this can be found at:
> https://github.com/ROCm/rocm-systems/pull/6148
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h           |  25 ++++++
>  5 files changed, 179 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5d7bfa59424a..6a5459b59af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
>
>         /** GPU partition selection */
>         uint32_t                xcp_id;
> +
> +       /**
> +        * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (set v=
ia
> +        * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIG=
BUS_DELAY).
> +        *
> +        *   0          - send SIGBUS immediately (default)
> +        *   0xFFFFFFFF - suppress SIGBUS delivery
> +        *   other      - delay SIGBUS delivery by this many milliseconds
> +        */
> +       atomic_t                kfd_sigbus_delay_ms;
>  };
>
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)=
;
> @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crtc)=
;
>  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
>  int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp);
>
>  /*
>   * functions used by amdgpu_encoder.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 99688391e70b..cad18bd6f8b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handle=
s_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>
>  static const struct drm_driver amdgpu_kms_driver =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..7903587b8bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>         return 0;
>  }
>
> +/**
> + * amdgpu_user_options_ioctl - set per-fd user options
> + *
> + * @dev: drm dev pointer
> + * @data: pointer to struct drm_amdgpu_user_options
> + * @filp: drm file
> + *
> + * Sets options stored on the per-file amdgpu_fpriv. Currently the only
> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
> + * controls how KFD delivers SIGBUS for poison/RAS events to the calling
> + * process (immediate, suppressed, or delayed by N milliseconds).
> + */
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct drm_amdgpu_user_options *args =3D data;
> +
> +       switch (args->op) {
> +       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> +               atomic_set(&fpriv->kfd_sigbus_delay_ms,
> +                          args->kfd_sigbus_delay.value);
> +               return 0;
> +       default:
> +               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
> +               return -EINVAL;
> +       }
> +}
> +
>  /**
>   * amdgpu_driver_open_kms - drm callback for open
>   *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index e9be798c0a2b..2ff6348105b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -29,10 +29,12 @@
>  #include <linux/uaccess.h>
>  #include <linux/mman.h>
>  #include <linux/memory.h>
> +#include <linux/workqueue.h>
>  #include "kfd_priv.h"
>  #include "kfd_events.h"
>  #include "kfd_device_queue_manager.h"
>  #include <linux/device.h>
> +#include <uapi/drm/amdgpu_drm.h>
>
>  /*
>   * Wrapper around wait_queue_entry_t
> @@ -1337,6 +1339,115 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>         srcu_read_unlock(&kfd_processes_srcu, idx);
>  }
>
> +/*
> + * Per-process opt-in for poison-consumption SIGBUS handling.
> + *
> + * Default: kernel sends SIGBUS to the process immediately when poison i=
s
> + * consumed, in addition to delivering the KFD HW/MEMORY exception event=
s.
> + *
> + * Userspace (ROCr) can opt-in per-process via the
> + * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DEL=
AY
> + * option. This lets the app's registered system-event callback handle t=
he
> + * RAS error first, instead of being killed by SIGBUS.
> + *
> + * Encoded value (set on any of the process' amdgpu render fds):
> + *   0          - default: SIGBUS immediately (no opt-in)
> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
> + *                handle the error in time (safety timeout)
> + *
> + * Per-process scope: the option is honored if ANY of the process' amdgp=
u
> + * fds has been configured. This matches the slide deck's "Per-process,
> + * App set at init" semantics, while keeping the UAPI on amdgpu where RO=
Cr
> + * sets it.
> + */
> +struct kfd_sigbus_delayed_work {
> +       struct delayed_work work;
> +       struct kfd_process *p;
> +};
> +
> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
> +{
> +       struct kfd_sigbus_delayed_work *dw =3D container_of(to_delayed_wo=
rk(work),
> +                               struct kfd_sigbus_delayed_work, work);
> +       struct kfd_process *p =3D dw->p;
> +
> +       if (p->lead_thread)
> +               send_sig(SIGBUS, p->lead_thread, 0);
> +
> +       kfd_unref_process(p);
> +       kfree(dw);
> +}
> +
> +/*
> + * Resolve the per-process SIGBUS opt-in setting by scanning all of the
> + * process' KFD pdds (each backed by an amdgpu render fd). Returns the
> + * "most lenient" value across all fds, in this priority:
> + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
> + *
> + * Rationale: if the app has explicitly opted in on any GPU it uses, it
> + * wants the chance to handle the error in userspace.
> + */
> +static u32 kfd_get_sigbus_delay_ms(struct kfd_process *p)
> +{
> +       u32 result =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < p->n_pdds; i++) {
> +               struct kfd_process_device *pdd =3D p->pdds[i];
> +               struct amdgpu_fpriv *drv_priv;
> +               u32 v;
> +
> +               if (!pdd || !pdd->drm_file)
> +                       continue;
> +               if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
> +                       continue;
> +
> +               v =3D atomic_read(&drv_priv->kfd_sigbus_delay_ms);
> +               if (v =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLE=
D)
> +                       return v;
> +               if (v > result)
> +                       result =3D v;
> +       }
> +
> +       return result;
> +}
> +
> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> +                                        struct kfd_process *p)
> +{
> +       u32 delay_ms =3D kfd_get_sigbus_delay_ms(p);
> +       struct kfd_sigbus_delayed_work *dw;
> +
> +       if (delay_ms =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED=
) {
> +               dev_info(dev->adev->dev,
> +                        "SIGBUS suppressed for process %s(pid:%d): app o=
pted in to handle RAS error\n",
> +                        p->lead_thread->comm, p->lead_thread->pid);
> +               return;
> +       }
> +
> +       if (delay_ms =3D=3D 0)
> +               goto send_now;
> +
> +       dw =3D kzalloc(sizeof(*dw), GFP_ATOMIC);
> +       if (!dw)
> +               goto send_now;
> +
> +       /* Take an extra reference for the delayed worker. */
> +       kref_get(&p->ref);
> +       dw->p =3D p;
> +       INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
> +
> +       dev_info(dev->adev->dev,
> +                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS er=
ror opt-in safety timeout)\n",
> +                p->lead_thread->comm, p->lead_thread->pid, delay_ms);
> +       schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
> +       return;
> +
> +send_now:
> +       send_sig(SIGBUS, p->lead_thread, 0);
> +}
> +
>  void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>  {
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, NULL=
);
> @@ -1345,7 +1456,6 @@ void kfd_signal_poison_consumed_event(struct kfd_no=
de *dev, u32 pasid)
>         struct kfd_event *ev;
>         uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
>         int user_gpu_id;
> -
>         if (!p) {
>                 dev_warn(dev->adev->dev, "Not find process with pasid:%d\=
n", pasid);
>                 return; /* Presumably process exited. */
> @@ -1391,7 +1501,7 @@ void kfd_signal_poison_consumed_event(struct kfd_no=
de *dev, u32 pasid)
>         rcu_read_unlock();
>
>         /* user application will handle SIGBUS signal */
> -       send_sig(SIGBUS, p->lead_thread, 0);
> +       kfd_signal_sigbus_with_delay(dev, p);
>
>         kfd_unref_process(p);
>  }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9f3090db2f16..dfc91d25c80d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> +#define DRM_AMDGPU_USER_OPTIONS                0x1A
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT    DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DR=
M_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS  DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
>
>  /**
>   * DOC: memory domains
> @@ -1673,6 +1675,29 @@ struct drm_amdgpu_info_uq_metadata {
>  #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 =
*/
>  #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 =
*/
>
> +/*
> + * Definition of user options
> + *
> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> + *    0:          Disable sigbus delay - SIGBUS will be raised immediate=
ly
> + *    0xFFFFFFFF: SIGBUS will not be raised
> + *    other:      Set the sigbus delay in milliseconds
> + */
> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
> +
> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED  0xFFFFFFFFu

AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED should be 0xFFFFu

> +
> +struct drm_amdgpu_user_options {
> +       __u32 op;
> +       union {
> +               struct {
> +                       __u16 value;
> +                       __u16 _pad;
> +               } kfd_sigbus_delay;
> +               __u32 _pad;

You can drop the __u32 _pad here.  the op and value and u16 _pad are
already aligned to 64 bits.

Alex

> +       };
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.43.0
>
