Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08429CD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9895410F25A;
	Thu, 14 May 2026 15:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eeEAmEFS";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753BF10F25A
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 15:18:23 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12c750eaf4cso494058c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 08:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771903; cv=none;
 d=google.com; s=arc-20240605;
 b=UZ1Kl0PajrVvUaGShsHTAJ1BBvtIy8yAodzHp8c0nYVL231HX/mJhrjkDhw04CWbHd
 8s5wMqxst7+wpWvr9ZixSdiDsQM5JO4mbAhLpMr6uGc1Jd1GGm83I4Bx0LT8pLX/n79O
 PVSeAeopRR0O7Ts/2yydsYX0ZIEDcoItEqvwgAb9Oj1wZGpe62fKNJj9POntxHOAUc2v
 rG4k2+LP9Um6izUjluEsZUpbG4o+Bqpfh4586ojWejxbQ0yGkc5Ch/8Ort8rDF1l2bqm
 EzTKqzjSt000woqqfvzRW1q/nooxABCSjxM54SsFfePxwgrRgmXKDBuku8htvbB3Tjj8
 F5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HK+nVpRe6aFAWAsVZQbMsdI78CDDdYsNfa4jOutyR6c=;
 fh=IrMaVJY8cEHHM9oFQX7w4TEaGUPsscktABKEFFmjpVI=;
 b=GZakdMw4tRvQE0g+Rz0vslSns2hg/9WomKZhUoJhbntXtzFq6hMGNAUgpQLWhay2UP
 HnIQWqRh4m5E7+/6E/ZgD6KOZSFWkiOO+IUXBG12STYgmyr+a9E3awRCui/koKp658Qg
 voBUqHCTcpUL7hvjC1StowYGB8JcPi0SAB3dDzdD8whupM/a1sluCt8dsHAQZR+VMF+t
 NMXHaTzN8VPyMvikFwiDlVDrCiewPptbWrDP/wv9f3/OpHIm4t+FzQyNbvwteQy2ugz2
 vA50qDXuyMp2MmkEPeW2Yoo9HKVoWGJgml5qNaPSLMdJt7o1SbYIqaSkiBQVuw4sQqwX
 Xhzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778771903; x=1779376703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HK+nVpRe6aFAWAsVZQbMsdI78CDDdYsNfa4jOutyR6c=;
 b=eeEAmEFSsPq1RiT8d7rwRFDEZ9EQ7Vyt9Yw8jKo4T1f9mCpRwELdl+XrLLVVrEHyNO
 Ljowt+0UfjNXHL+s8feGLQUsl2F/JQA2a3QUC4ReaRjwH5eip+2ERIWx0INNuwXTOxvl
 13jleTsvbmt6wJoza+DpNyYoPJEdYZDqlh0N8k+p3hLvbj6TosoKFuAQdE/tuy763hYu
 zrE62CVyfaJZpVAda1kAYPRYBVaj2kr/0yXCt/VRsr8/H9nPWN76y8Un/pJ6zzfvf3w7
 eilw46XDkfn8m305rZdYhS1Q1PVZ/EDT6rgCCWcpBVPfjgpjNqp7lPsVedrtGBQpSqyk
 RB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778771903; x=1779376703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HK+nVpRe6aFAWAsVZQbMsdI78CDDdYsNfa4jOutyR6c=;
 b=izzMdvg/KSImCqiHDCQTCzdn84f7vJ+yR5RHXv5EVtpultZHa6wcW14txIcWrK7jv/
 jpfdIp3ye4Y7aI7XCPV+Ke8gmW4rrqnpwSi8Un72bmK+/dow4+HyGuyiWigZMGjbqmdN
 sPsSWyI2H0vBclhhTNHkZ58FwlFxjl8oIbSZWg8XNGozVVYTYF8nSZBZLF+79bqi5YGy
 jvp/9e+KiiwdED+L/CA85KDWtot5iW0mxPk1x3QVf+xcbTh55pi9Q9X2jJK0FV92Pzo8
 uvyAsnNd6w3BOXWJl3qBhGmGf2hfSQVHMXPQHocvNkAyA8YiC00zTLigPof3tTkOJBOH
 U+DA==
X-Gm-Message-State: AOJu0YwZMF8ZO8gz4cgY6/PBmEU1/SgCQ7ev56i1WFo+srBnx+8Jqh9Y
 26JYvCVrpRYwvBiddFz3Jh7qprgQSbCV3EiSBWoO/t1aBpa9/dw7f9bxZHkAJiujytdlnxvH8yN
 3UZahK0feTBaAYPebU9dTNLZRQodT25k=
X-Gm-Gg: Acq92OEutci0zgZHXOGC7MetSNFvc1HIUZfyo+RCVtbr2LD9JIe7IkBAr5F8bTbsdOH
 j1L+gj553umawM2617QEzpEY1az2s6YPnSyCwWHPx9Wb9iq89m/fV8xVhbvUQAMilTCSDKwH+k4
 4FOSWJ5Xr5VeoC87XwRvviTo/2pa1T1jQ2lHDzCYHaMjS21I7Jv0mkTE9W6Xk3Z/ANUqpaxUoHV
 ph7dQPmDlw0eTtn15qrUiQOb21cdiLrslIKIAHzuG5fjxKlxchG2fwXOG0mNf4C/j9VX6eYaiPJ
 K6y/tbNtuby+rt82Dpe7t4gMLljctf5+nyEMG12khVE35apvr9ISdluSM52XHtmf/joEQw==
X-Received: by 2002:a05:7300:e105:b0:2d9:244e:be20 with SMTP id
 5a478bee46e88-30119494332mr2273397eec.4.1778771902331; Thu, 14 May 2026
 08:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260512131149.1440454-1-yifan1.zhang@amd.com>
In-Reply-To: <20260512131149.1440454-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 May 2026 11:18:10 -0400
X-Gm-Features: AVHnY4JFTjRMWD3JCyPeeoz9VWPcXt5m59qfEYB0d-xmXiPxmefhqQQ2ANF12K0
Message-ID: <CADnq5_OugpU=sCwT3Hu-f6E6GVesB43RDG2M3fLXcf9PXS4gXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add ioctl to handle RAS poison error
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

On Tue, May 12, 2026 at 9:19=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace (ROCr)
> to control per-process SIGBUS delivery.

Please include the proposed userspace in the commit message.
Additional comments below.

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 114 +++++++++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h           |  23 +++++
>  5 files changed, 177 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 80b18bbd7f3a..653a2a516e18 100644
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
> index 9f3090db2f16..e0a382673b90 100644
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
> @@ -1673,6 +1675,27 @@ struct drm_amdgpu_info_uq_metadata {
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
> +
> +struct drm_amdgpu_user_options {
> +       __u32 op;
> +       union {
> +               struct {
> +                       __u32 value;

Do we really need a delay that long?  __u16 seems more reasonable.  If
you do reduce it. make sure to add to pad everything to 64 bits.

Alex

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
