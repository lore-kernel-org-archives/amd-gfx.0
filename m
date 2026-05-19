Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C7CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8655210E3A4;
	Tue, 19 May 2026 13:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S59GwXTv";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F177510E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:55:29 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c7288cfb9so116346c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198929; cv=none;
 d=google.com; s=arc-20240605;
 b=idPQLmmXnTsOSfQ15SaJcI0aomLxa3t0/eIwframEZdpbJYO/sA9qbQ4Dzu0RxYu30
 z8jN+0AXzSc1DWkzMaIegvYrgIgPY16Ne+LeL3f5wgUvCsaGYoEN6Tz2RdCcVPsN2QAy
 YnbUicBfffC4f/1hdHKdIPUfVqO7tZKaJw0pLiFmAH9PWUro1qF4ZLUiXATYZ4JwJBB3
 Y/4NkvHnQGfffV9KPHIzynFvK9+sOQ4C7yJ5vDyDpLcrkPdRSJEFDqFRSVOxJPvo8YNK
 hR8CdoO1y/6P7W/psKlCdQ8bPpCqpXD+/Sflsk9zJT8RpKdhrPQQmHa49oOdeChjs3XX
 hE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Eczg7R4dWoi4SKCoOuWJHinp8GWnfIo1bHvjGs10udU=;
 fh=IrMaVJY8cEHHM9oFQX7w4TEaGUPsscktABKEFFmjpVI=;
 b=MhuFbsmVdDtE1pTLCaIdRfX8thZaM8ttPxbD3psvfZrlcIcBKe6WbefYc1hTwQltcS
 nC4b4hQdohX/7xoUncyjSh17PLozKCl5Q4OkFIk7oXyZLPiO7WWkqIk/HIm5OmdV8TSm
 djsgRZLzILoaKpIjOPvy69s+DhSZa4BncoYzRPKbJywOiDeNAxu0Qw/64ch6OsiEAR3q
 S9dXSMQ1psOt9QDnnn6MUshJP9sX3QvCcikGLtzFg5cmn6uwgEjYCnjFijlGoMQwnI/K
 ctzcEK5zRi1zingmEVtsMDWPjiiTbTSnbsINZdqfKTyTRsHFFBl+0eUhs3MflTdgoIIp
 Zp2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779198929; x=1779803729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eczg7R4dWoi4SKCoOuWJHinp8GWnfIo1bHvjGs10udU=;
 b=S59GwXTvof2OeJuc/DJ+wH8iHZhIYC3IFHiQD4pdyMM2nAf1ZAe71agkRDbx98yMu+
 PAG+vYJGlD2ri6MlvwV/trrtyxL57syFtZprJpNrUu8PsfuK9xPDzzGAoT4KgHJEWtm8
 RimyfmNMXvB2P3gqpbyEoDVDNTGethO6i94UIqX0b0U1HE4+5EdM+TZPVZNK+QTmnT0M
 sECIppSXfY9X3gwTWppx9MkmbBeRi9QzlyGC3vSXtI1juXOiTmlSmbOx8XN62wEtyPsa
 U4c8ei+ClHNt7Gh5l1gQUunQ+KYf7AMl61F4VMm8Y2xnMd0HcV3ej9ofrtODL2cG+q5U
 6Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198929; x=1779803729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eczg7R4dWoi4SKCoOuWJHinp8GWnfIo1bHvjGs10udU=;
 b=k6Bw3UvXcFqKcGinbh9Erl9py4K+jdiSzZPhu7lfj7LgHGpJfdRbZWzXW1d5KhSW/3
 cAhQt7+P4dAZwrrgC2I7gGGS181ugf4NgqApCinH42o8E99DbrIa6/bmWHS1zuZtMAel
 40SvsynXYCkfaoLR/5jvR/vHPQ5c1bUw2TlosrAX57BSgM3TV+ftILVuTrh49EQ+TOyB
 biRAQgh55SelHGAY2bD5ER5Q9GpoShcfmVxINX2VU0fsfQ6Aamk6pFysG9GXi1MHmUnn
 loL1mr9O5d2PLdHPF12cVV87ven2WFzkm26d7S+YjOGn8G+55BuLCC/ZdiPWo6IRYHEB
 /PRw==
X-Gm-Message-State: AOJu0Yz7AISkKxMTdVHcvhkly3TQghHD6shRZmKEouc+WxFpymjOrywe
 HylPBKvXg/NRtnfLv45h2O6hTUlrfPjxbhHbphAzGHm8wpl3RBe2ZdL0VReR0pzT4IsPqfdejC9
 KHf7e9f0MGLCwwqKEpOloqRS7GBmzn84=
X-Gm-Gg: Acq92OGxx/KGDfRxY8A3F5/5m4Fh1nEbhS568v/Dq1rXSIbhZYt20Ug348qKcevNrWr
 Eqq77zRLhckYRqJnnUrTPFRvizQL0Eg8hyFtU0A9IAjANY6N2830XzhUHKcFid5lOIN1FG9FX+X
 yUTM2HBIvyFFWi7mKwaccQ/QyS8hGUJ1Lh4VWSSFJv5/cSvVXywNrUuHFzNPawwwsZo+t7B51X4
 SEHd/46VamCphp46X+wz242kcVWaKUJldNXUn7OBSJiTL0eeE+YkBAM9aF9KOFyfRieT9TL74fh
 gCCK2OCEQLtgOXy3yqh1Ol6EZM2O5t864Uu5XfGC/iInfPeKLU45EF6Iy43P4Mm9lpx+HA==
X-Received: by 2002:a05:7022:f8a:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-13504525046mr3794054c88.2.1779198928932; Tue, 19 May 2026
 06:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260517052649.1514840-1-yifan1.zhang@amd.com>
In-Reply-To: <20260517052649.1514840-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 09:55:17 -0400
X-Gm-Features: AVHnY4L7ShHkKDqnGq50EcTtWAublFsEh4GbWqmUfCY-32-z1NQkjDx_JfGyFRY
Message-ID: <CADnq5_NwcH3cpDfiUf1rpZPR3Kts6ARE+93ovng1Ht9pnN2ooQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: add ioctl to handle RAS poison error
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

On Sun, May 17, 2026 at 1:44=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
> to control per-process SIGBUS delivery.
>
> Userspace for this can be found at:
> https://github.com/ROCm/rocm-systems/pull/6190
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 118 +++++++++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h           |  24 +++++
>  5 files changed, 182 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5d7bfa59424a..0408476f1070 100644
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
> +        *   0xFFFF - suppress SIGBUS delivery
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
> index e9be798c0a2b..200570401f51 100644
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
> @@ -1337,6 +1339,119 @@ void kfd_signal_reset_event(struct kfd_node *dev)
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
> + *   0xFFFF - opt-in, never escalate to SIGBUS
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
> +static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p)
> +{
> +       u16 result =3D 0;
> +       int i;
> +
> +       mutex_lock(&p->mutex);
> +       for (i =3D 0; i < p->n_pdds; i++) {
> +               struct kfd_process_device *pdd =3D p->pdds[i];
> +               struct amdgpu_fpriv *drv_priv;
> +               u16 v;
> +
> +               if (!pdd || !pdd->drm_file)
> +                       continue;
> +               if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
> +                       continue;
> +
> +               v =3D atomic_read(&drv_priv->kfd_sigbus_delay_ms);
> +               if (v =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLE=
D) {
> +                       result =3D v;
> +                       break;
> +               }
> +               if (v > result)
> +                       result =3D v;
> +       }
> +       mutex_unlock(&p->mutex);
> +
> +       return result;
> +}
> +
> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> +                                        struct kfd_process *p)
> +{
> +       u16 delay_ms =3D kfd_get_sigbus_delay_ms(p);
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


Probably worth adding a comment here that this feature is not
supported with confidential compute.  Other than that, looks good to
me.

Alex

> +}
> +
>  void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>  {
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, NULL=
);
> @@ -1345,7 +1460,6 @@ void kfd_signal_poison_consumed_event(struct kfd_no=
de *dev, u32 pasid)
>         struct kfd_event *ev;
>         uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
>         int user_gpu_id;
> -
>         if (!p) {
>                 dev_warn(dev->adev->dev, "Not find process with pasid:%d\=
n", pasid);
>                 return; /* Presumably process exited. */
> @@ -1391,7 +1505,7 @@ void kfd_signal_poison_consumed_event(struct kfd_no=
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
> index 9f3090db2f16..e88d7cf53858 100644
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
> @@ -1673,6 +1675,28 @@ struct drm_amdgpu_info_uq_metadata {
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
> + *    0xFFFF: SIGBUS will not be raised
> + *    other:      Set the sigbus delay in milliseconds
> + */
> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
> +
> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED  0xFFFFu
> +
> +struct drm_amdgpu_user_options {
> +       __u32 op;
> +       union {
> +               struct {
> +                       __u16 value;
> +                       __u16 _pad;
> +               } kfd_sigbus_delay;
> +       };
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.43.0
>
