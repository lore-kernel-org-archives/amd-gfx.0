Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C38ACD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 17:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DDA10E83A;
	Wed, 27 May 2026 17:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qMQk8ASo";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C4710E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 17:23:28 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-136af97e62fso126670c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 10:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779902608; cv=none;
 d=google.com; s=arc-20240605;
 b=YmNcTGbjqTBH8cs5e8aWnRDY87nSCEtOz9TDn1SoNtuN2BO5k0kPOwFwFMGr5XZiBX
 +w9q3GoAhrUwRAtho+NpB1766zDTrRPltmfrtSD5srCaeFX6P2w2udwOiNqsK+4WmUFj
 DDXzN+8z+LNuKZs2OvWZyJDAbilY/we8tiESZUqHEhKXc78KzNP5dXaWqEl2qBRZiMLc
 OHF1Ewpk6okdELeCdo2xRAqX7Ju2/XFGHy5fP54gHAdzsuN+Sdwy7iqiJ5gWNze8lWw1
 IESDQP7IS+afIas0ez5slmlBinGXAaaWTrGMOjrtQ21+BdOv2hEwrVBYBhIn8iYzhnQy
 QHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i03O9b4teaHrovNnKK4Pppw9rXidvDLCix+Z2KaHwy8=;
 fh=wWOFNk5sUCklAcQii4zxAj3gL6FszaB+8rFh2R9st2w=;
 b=TGHblQrlGnwsZRr2qGi96LCuueRrDkeH/++bu4qJ7soR7syK7u70KqNqa0r2f0aotS
 fd7ddPdtGOTe8sVGPf3i6MbyXY/TSyrYA7a3W3Q0F9RiWr0Ke45vWMh2xM1G/PStjyD/
 O2rleNxnUsKLuE0i26Xpton8MJyKzzyftXuu4SRvgsNkRrbi6MNfHByQXl96XeIwzTX0
 XNNoWgv+kr8r5PcypVgBFvl/fei+21M9bfrI7NzRX4GSiRGfnZyOURqvW+ZnmMs5tqGs
 XiAsWpMa0YCGbQEKTXujniLlia0FQonDuAcRRn+DkhHG4CtZp+LEycE3zRiB+TWHmbXy
 cfmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779902608; x=1780507408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i03O9b4teaHrovNnKK4Pppw9rXidvDLCix+Z2KaHwy8=;
 b=qMQk8ASoau7zoA2pgjRkREqzSf/amTuLGsuCakQicz5VsmHUIkDuR9ReKhuc2SXOE1
 8MWxLJgoRZh8rFmisu/JQgJStZG1uJrKVbBhCt0ptOTfKJCZW+EBkqHwcQ6++r7swvx/
 qJVfUCWi75y65i9bIAHbRI7kB1mbVYe5dnvzdppdZK7VQldZWGEQEt/4R5NrfKb4JtVQ
 Gy97DBntrTWRxk71wB8YJ3GXb/1rXfCVxTG1aELPgZYCL09Z823Nm51nKcHvOycvdDWi
 yrhM+HwSjLR6Z9B5uPjXigxd1N0pMNSrXlmA1EOrn1jYWwv1BYSJuxe3xVlu3Qre1IHB
 KY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779902608; x=1780507408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i03O9b4teaHrovNnKK4Pppw9rXidvDLCix+Z2KaHwy8=;
 b=Cm2+o7Jb87Pq4SAJf7+b4028vRr9HSmbw4BvdyYFeSynui34VnTsyi8D5r5yIg4inF
 SkCRTlBOVjXEzUOLHO9XloMumkj2a1DkS3f9QwTszdDCMTGMRrrVf2zAo3sKsEw1sr64
 2zaOKlBr5jRL+wkEkJXfYkp7yjA+hgwEBH0CAg3WTJPDswhGfYppINhdMRmihF0EN4yi
 iqxqZ+rGWN3fIlj5UZ0u/eXbukG7vczkPzX29A5nsoX1bth+TyrrLjLyiNR5qKcwRhcY
 OMBDrtll5o4ZqbiuStF3t/KkgaEejRN/6/1V0AfgAMt3hYIxDX4sC10tWrNu25DnTfdk
 VNnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j5gn87UV9vAyW6SuAOwkk/FCtok5n2xNbtXpsHvkR9pUp66Xlk6oaAQ1/Tq8h6O2ovEtLRnk+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWAxyLn9fuT+mFwOGgKYKyUU+rbpLnjtGo8VQj7tD39igxCga8
 iPDOCbBaUl1tE+h/T+FVdFRidGuMq6p8ZX4OaBrWPYe9UV71TOg/6rN4h1FajXFT3UeNC3bj/bQ
 A/1iO/NPE0eSrf8/P/hJKKS2DTX1Jg4U=
X-Gm-Gg: Acq92OECuhJEOEO/nGgfyeAS+aj2uz+UwpTvjTD2P2Z3OJgSmyrEg1v/rP2eLuUKTG2
 NCso7tI6SjR4qFkrAfnUVSmGBHSSuVvkGJ21crr4ekB5RcNFiI5famlAgABMUZXpQJ5AVVVXetM
 1RTyVONtLUk7/9txCkEN0YTtnFbYLX76FvTX96p4KfatAQ7W/NCDxH/R7JKns+1fTqHPX+joQJl
 UoyNqyLBjX4tAcOxu1NwG+wtnnvCR2Zty6dzdJsbc99TNs29xDJ7ynSL8D9ogWcUs/d+34lccxl
 SP+SbgYEYEnJpTi7pdn1QSVhioFLk8ci9sE2dXfUm0lRnHqWxu89Iwkzxp7pc4pZnSUp0A==
X-Received: by 2002:a05:7022:7a5:b0:12d:ce63:d8c5 with SMTP id
 a92af1059eb24-1365f6f595amr4276835c88.2.1779902607700; Wed, 27 May 2026
 10:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260526022834.2380471-1-yifan1.zhang@amd.com>
 <0086fc92-7a66-4e77-b49d-1b9bc6c110a7@amd.com>
In-Reply-To: <0086fc92-7a66-4e77-b49d-1b9bc6c110a7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2026 13:23:15 -0400
X-Gm-Features: AVHnY4I8z0SQwREtYOOKunBnemzdpu8YSV-saq8ns7fjwqqGfgWQrJg3XvnmieM
Message-ID: <CADnq5_O-RHFM=k+E_uMKxdo8JTD2jPWxd0b4oMfqtqTRidHcPQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/amdgpu: add ioctl to handle RAS poison error
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, christian.koenig@amd.com, Felix.Kuehling@amd.com, 
 David.YatSin@amd.com, Kent.Russell@amd.com, Perry.Yuan@amd.com
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

On Tue, May 26, 2026 at 4:04=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 26-May-26 7:58 AM, Yifan Zhang wrote:
> > Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> > AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROC=
r)
> > to control per-process SIGBUS delivery.
> >
> > Userspace for this can be found at:
> > https://github.com/ROCm/rocm-systems/pull/6190
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> Have one generic comment on the ioctl naming convention. Need comments
> from Alex/Christian also.
>
> Apart from that looks good to me -
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 69 +++++++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 15 +++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 33 +++++++++++
> >   include/uapi/drm/amdgpu_drm.h              | 21 +++++++
> >   8 files changed, 173 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 5d7bfa59424a..771ec0608270 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc *crt=
c);
> >   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
> >   int amdgpu_info_ioctl(struct drm_device *dev, void *data,
> >                     struct drm_file *filp);
> > +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> > +                           struct drm_file *filp);
> >
> >   /*
> >    * functions used by amdgpu_encoder.c
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.h
> > index 5333e052d56d..68d83a6e6b3a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval=
_notifier *mni,
> >   int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
> >                                       uint32_t domain,
> >                                       struct dma_fence *fence);
> > +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
> >   #else
> >   static inline
> >   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> > @@ -241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amd=
gpu_bo *bo,
> >   {
> >       return 0;
> >   }
> > +static inline
> > +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> >   #endif
> >   /* Shared API */
> >   int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t=
 size,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 1781c0c3d010..4d4d21babc61 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =
=3D {
> >       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
> >       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handle=
s_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > +     DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS, amdgpu_user_options_ioctl,=
 DRM_AUTH|DRM_RENDER_ALLOW),
> >   };
> >
> >   static const struct drm_driver amdgpu_kms_driver =3D {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 24526e92f9b8..772e0fda7e14 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >       return 0;
> >   }
> >
> > +/**
> > + * amdgpu_user_options_ioctl - set per-fd user options
> > + *
> > + * @dev: drm dev pointer
> > + * @data: pointer to struct drm_amdgpu_user_options
> > + * @filp: drm file
> > + *
> > + * Sets options stored on the per-file amdgpu_fpriv. Currently the onl=
y
> > + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
> > + * controls how KFD delivers SIGBUS for poison/RAS events to the calli=
ng
> > + * process (immediate, suppressed, or delayed by N milliseconds).
> > + */
> > +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> > +                           struct drm_file *filp)
> > +{
> > +     struct drm_amdgpu_user_options *args =3D data;
> > +
> > +     switch (args->op) {
> > +     case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> > +             return amdgpu_amdkfd_set_sigbus_delay(current,
> > +                                                   args->kfd_sigbus_de=
lay.value);
> > +     default:
> > +             DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> >   /**
> >    * amdgpu_driver_open_kms - drm callback for open
> >    *
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_events.c
> > index e9be798c0a2b..92027c5aae61 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > @@ -29,10 +29,12 @@
> >   #include <linux/uaccess.h>
> >   #include <linux/mman.h>
> >   #include <linux/memory.h>
> > +#include <linux/workqueue.h>
> >   #include "kfd_priv.h"
> >   #include "kfd_events.h"
> >   #include "kfd_device_queue_manager.h"
> >   #include <linux/device.h>
> > +#include <uapi/drm/amdgpu_drm.h>
> >
> >   /*
> >    * Wrapper around wait_queue_entry_t
> > @@ -1337,6 +1339,71 @@ void kfd_signal_reset_event(struct kfd_node *dev=
)
> >       srcu_read_unlock(&kfd_processes_srcu, idx);
> >   }
> >
> > +/*
> > + * Per-process opt-in for poison-consumption SIGBUS handling.
> > + *
> > + * Default: kernel sends SIGBUS to the process immediately when poison=
 is
> > + * consumed, in addition to delivering the KFD HW/MEMORY exception eve=
nts.
> > + *
> > + * Userspace (ROCr) can opt-in per-process via the
> > + * DRM_IOCTL_AMDGPU_USER_OPTIONS / AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_D=
ELAY
> > + * option. This lets the app's registered system-event callback handle=
 the
> > + * RAS error first, instead of being killed by SIGBUS.
> > + *
> > + * Encoded value (stored on the kfd_process):
> > + *   0          - default: SIGBUS immediately (no opt-in)
> > + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
> > + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does no=
t
> > + *                handle the error in time (safety timeout)
> > + */
> > +
> > +void kfd_signal_sigbus_delayed_fn(struct work_struct *work)
> > +{
> > +     struct kfd_process *p =3D container_of(to_delayed_work(work),
> > +                             struct kfd_process, signal_work);
> > +
> > +     if (p->lead_thread)
> > +             send_sig(SIGBUS, p->lead_thread, 0);
> > +
> > +     kfd_unref_process(p);
> > +}
> > +
> > +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> > +                                      struct kfd_process *p)
> > +{
> > +     u32 delay_ms =3D atomic_read(&p->kfd_sigbus_delay_ms);
> > +
> > +     if (delay_ms =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED=
) {
> > +             dev_info(dev->adev->dev,
> > +                      "SIGBUS suppressed for process %s(pid:%d): app o=
pted in to handle RAS error\n",
> > +                      p->lead_thread->comm, p->lead_thread->pid);
> > +             return;
> > +     }
> > +
> > +     if (delay_ms =3D=3D 0)
> > +             goto send_now;
> > +
> > +     /*
> > +      * Take an extra reference for the delayed worker. If the work is
> > +      * already pending (e.g. another device of this process consumed =
poison
> > +      * just before), drop the reference and skip rescheduling - the p=
rocess
> > +      * only needs to be notified once.
> > +      */
> > +     kref_get(&p->ref);
> > +     if (!schedule_delayed_work(&p->signal_work, msecs_to_jiffies(dela=
y_ms))) {
> > +             kfd_unref_process(p);
> > +             return;
> > +     }
> > +
> > +     dev_info(dev->adev->dev,
> > +              "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS er=
ror opt-in safety timeout)\n",
> > +              p->lead_thread->comm, p->lead_thread->pid, delay_ms);
> > +     return;
> > +
> > +send_now:
> > +     send_sig(SIGBUS, p->lead_thread, 0);
> > +}
> > +
> >   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid=
)
> >   {
> >       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, NULL=
);
> > @@ -1391,7 +1458,7 @@ void kfd_signal_poison_consumed_event(struct kfd_=
node *dev, u32 pasid)
> >       rcu_read_unlock();
> >
> >       /* user application will handle SIGBUS signal */
> > -     send_sig(SIGBUS, p->lead_thread, 0);
> > +     kfd_signal_sigbus_with_delay(dev, p);
> >
> >       kfd_unref_process(p);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index f037062c33ea..ae6d1ecb14d5 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -957,6 +957,20 @@ struct kfd_process {
> >       size_t signal_event_count;
> >       bool signal_event_limit_reached;
> >
> > +     /**
> > +      * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option f=
or
> > +      * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
> > +      * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
> > +      *
> > +      *   0          - send SIGBUS immediately (default)
> > +      *   0xFFFFFFFF - suppress SIGBUS delivery
> > +      *   other      - delay SIGBUS delivery by this many milliseconds
> > +      */
> > +     atomic_t kfd_sigbus_delay_ms;
> > +
> > +     /* Delayed signal delivery to user */
> > +     struct delayed_work signal_work;
> > +
> >       /* Information used for memory eviction */
> >       void *kgd_process_info;
> >       /* Eviction fence that is attached to all the BOs of this process=
. The
> > @@ -1554,6 +1568,7 @@ void kfd_signal_vm_fault_event(struct kfd_process=
_device *pdd,
> >   void kfd_signal_reset_event(struct kfd_node *dev);
> >
> >   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid=
);
> > +void kfd_signal_sigbus_delayed_fn(struct work_struct *work);
> >   void kfd_signal_process_terminate_event(struct kfd_process *p);
> >
> >   static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_process.c
> > index 419bb8086ccd..dd48ad9a3438 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -992,6 +992,33 @@ struct kfd_process *kfd_create_process(struct task=
_struct *thread)
> >       return process;
> >   }
> >
> > +/**
> > + * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
> > + * @task: task in the target process
> > + * @ms:   encoded delay value (0 =3D immediate, 0xFFFFFFFF =3D suppres=
s,
> > + *        otherwise delay in milliseconds)
> > + *
> > + * Stores the SIGBUS delivery option on the kfd_process associated wit=
h
> > + * @task. If the calling process has not opened /dev/kfd yet (no
> > + * kfd_process exists), this is a no-op - the option only applies to
> > + * processes that actually use KFD.
> > + */
> > +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms)
> > +{
> > +     struct kfd_process *p;
> > +
> > +     if (!task->mm)
> > +             return -EINVAL;
> > +
> > +     p =3D kfd_lookup_process_by_mm(task->mm);
> > +     if (!p)
> > +             return 0;
> > +
> > +     atomic_set(&p->kfd_sigbus_delay_ms, ms);
> > +     kfd_unref_process(p);
> > +     return 0;
> > +}
> > +
> >   static struct kfd_process *find_process_by_mm(const struct mm_struct =
*mm)
> >   {
> >       struct kfd_process *process;
> > @@ -1328,6 +1355,11 @@ void kfd_process_notifier_release_internal(struc=
t kfd_process *p)
> >       kfd_process_table_remove(p);
> >       cancel_delayed_work_sync(&p->eviction_work);
> >       cancel_delayed_work_sync(&p->restore_work);
> > +     /*
> > +      * If work pending, cancel it and drop the extra ref
> > +      */
> > +     if (cancel_delayed_work_sync(&p->signal_work))
> > +             kfd_unref_process(p);
> >
> >       /*
> >        * Dequeue and destroy user queues, it is not safe for GPU to acc=
ess
> > @@ -1584,6 +1616,7 @@ struct kfd_process *create_process(const struct t=
ask_struct *thread, bool primar
> >
> >       INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
> >       INIT_DELAYED_WORK(&process->restore_work, restore_process_worker)=
;
> > +     INIT_DELAYED_WORK(&process->signal_work, kfd_signal_sigbus_delaye=
d_fn);
> >       process->last_restore_timestamp =3D get_jiffies_64();
> >       err =3D kfd_event_init_process(process);
> >       if (err)
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 9f3090db2f16..ab71c4b4aeac 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -58,6 +58,7 @@ extern "C" {
> >   #define DRM_AMDGPU_USERQ_SIGNAL             0x17
> >   #define DRM_AMDGPU_USERQ_WAIT               0x18
> >   #define DRM_AMDGPU_GEM_LIST_HANDLES 0x19
> > +#define DRM_AMDGPU_USER_OPTIONS              0x1A
> >
> >   #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >   #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> > @@ -79,6 +80,7 @@ extern "C" {
> >   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL       DRM_IOWR(DRM_COMMAND_BASE=
 + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> >   #define DRM_IOCTL_AMDGPU_USERQ_WAIT DRM_IOWR(DRM_COMMAND_BASE + DRM_A=
MDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> >   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +=
 DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> > +#define DRM_IOCTL_AMDGPU_USER_OPTIONS        DRM_IOWR(DRM_COMMAND_BASE=
 + DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
> >
> >   /**
> >    * DOC: memory domains
> > @@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
> >   #define AMDGPU_FAMILY_GC_11_5_4                     154 /* GC 11.5.4 =
*/
> >   #define AMDGPU_FAMILY_GC_12_0_0                     152 /* GC 12.0.0 =
*/
> >
> > +/*
> > + * Definition of user options
> > + *
> > + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> > + *    0:          Disable sigbus delay - SIGBUS will be raised immedia=
tely
> > + *    0xFFFFFFFF: SIGBUS will not be raised
> > + *    other:      Set the sigbus delay in milliseconds
> > + */
> > +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY              0
> > +
> > +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED        0xFFFFFFF=
Fu
> > +
> > +struct drm_amdgpu_user_options {
> > +     __u32 op;
> > +     struct {
> > +             __u32 value;
> > +     } kfd_sigbus_delay;
> > +};
>
> Rather than 'user', it may be good to consider naming it as
> amdgpu_proc_options (process related options).

Yeah, I think AMDGPU_PROC_OPTIONS might be better in this case, but I
don't have a strong opinion.  user_options may be better depending on
what else we add to it.  Either way:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Lijo
>
> > +
> >   #if defined(__cplusplus)
> >   }
> >   #endif
>
