Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D210CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 15:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAB410ED6A;
	Tue, 19 May 2026 15:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oaDTtN4s";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF49510ED6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 15:26:11 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f114d129c0so215220eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204371; cv=none;
 d=google.com; s=arc-20240605;
 b=Dd1GcnlY96DMQooar/VaJYzmcKaE9DVldm53o0/PnDT2Ez1/F5mDpfGFLWZzhcA3NC
 eFJ0iMAmfjhn30o9O2fCj19hZjIbt2IGmCXge30DqcYY7+xvzU3ts1tLE4n89v717XJ4
 gPMXIawSi35cirn4n7ZU+9Ud3mXJzPyl9tcKY6tbHQZEApfRq4E8oyQzoOfqMegbvyI0
 EavnG4pBonFXD9NUFd+VrCOjNOQl47Fal88H+CEFuTnq3fxBgd2V5VOWd2cLA9iVQziA
 r2fJ/43pHb8UwiHcwCWcB9j07oKr1r7dm3zCa0RMqwXkvW8oQAmaO9aN4wF5bjPP2X0v
 KtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lmMN+VSiAGZzXs/a0Paz9M3Ddm4aDvRsfuWB9LZzBN8=;
 fh=yi4vY8I0w5TtGOBSru263FOWC0Td6a/XsyTtnpQwMK4=;
 b=gbqVdM7FAia0prbDs6OyrzAlcXCDNanOYAsgJ28oHDxww60PBf0adelVDU/2wtu82/
 k515Skk0KRt/P8/LL7fAtK60F/pDiIh+wULQ9hOXu6C+epqIlj5FqA1LzcGw2Ifx896W
 Qsp2SfcgL1KmjYyCQ2CyjOIjy8Akw8RJ8US7sED0L4mTr+qTQMRL9a41LN7JCOKN2ngy
 FiSVdpC66wzbmAPyT/CFYpI9xELdsKBW4xpiAMCWqGflu6scyD2r6zLGhYSPDF8biC2J
 lUti4THgrUc6UYuOjVbcoGCDsAOL5PdV5TTszzrGVB+WtG+YKl4FHiUwd7eGrDo3SKV7
 5Cmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779204371; x=1779809171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmMN+VSiAGZzXs/a0Paz9M3Ddm4aDvRsfuWB9LZzBN8=;
 b=oaDTtN4svDJS5uy0E982/cRURgK49vWH3H9dEKNICGNek+KwHmWkzvyhyrM/kwEL1o
 wI/uZTY2yEJYVUiYymY7hv2T41Atn9QLwxTHgRNDql/Z6l0Nfy40cJwCJfNXTCkjqXZ/
 bGXTMLaZXD9V8U/zHzK2hsShgH0elzG7XJc9WnfaF78ytyrWzK5pEWAhOu+YQtfgp5Ww
 iohGDGWZR63OPfb+D3d6eBlNzJXa+n83C7lpCZlv0HBb36Kq8mdXaZcAIgxDakg3xWO7
 fy3+J1iAL4C4Ke/gP65U8ZUxoWsVTdMGI8xRhHRlhMKq+syYX87d6vtsiWwWju0KxaVy
 twuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204371; x=1779809171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lmMN+VSiAGZzXs/a0Paz9M3Ddm4aDvRsfuWB9LZzBN8=;
 b=RUUNRXVBtSuG7xQJ+qfMKkjzMQjXfoscZrNCUOak6UnN/YPxR1Wfe6P9oBpQPb+U57
 x+GMKQuTqCHrtGsWtT9GtoOepm+z5aXykoQ3tWORugOqIC7ZmaPSAqwbNPpDvl4Pv+i9
 ynDQAW8TpaRC25TUGs7925m3MDZNR4vYZgJ+TQEGf5TMB0Y7JyYPDrDW+43cTjGeHMR0
 dGp50ZuBlAGpqywFWjA9poGGmrCI+EKwfviGv19WNv/92RTl3jBMBzOvnGLmadQRyK75
 SE57EEaoOFcmZ7PU2FbpUxFJ+dYmOJUjV/flHhX+L4cZnHfJSHa0rYCVvQ0M3IqvcvEh
 jNVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/ZgeRaghB35N8KsHUmUEvqKBQy83QX2S3Tc64J3zYbHV0lLz1Jonx1w3ZImQN3QfAwlvrFJZB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo+PSPKtYt66OAYsSe8wAYoh3cTgDIrh3XusT+b4YP+IQ89AQi
 8Z1yJr4igJwPWQzw7i74VZ9S67qVN9zZ75N0+UC06SbX64vSkLRRQTZ0b9QiOWshWzVW0jMHRv6
 WI16msgQE/2uKW42eq942DVWxgecskmYzyg==
X-Gm-Gg: Acq92OHMEiHDNo7CCb9yDiL+yyvQvkEdn8SWRmV7Mck7HLQWyPOpfJa7m49pyayAy4x
 hlT0NJbpgUvKoWi2TRWdu8tZdLx7akZJXQohdx4ZH7YtlXgql5Ym/1uNvvJyarTTX9mpIVNPAqY
 8mf4BgIhCVWoLEh80EqcC45MM9VfuvwZnNHTmI1he8P3vPh07stDK6U8nAtgnpaRiEkoFsHvLiF
 YmZUo0/6FdBVAmd5HtsxSQdG7S7r/wYZZKdK6rARl84eSfr6f/zHluLLXyWUDHaUDTSDsccHC2V
 oiwMN86baN19Rscq/FvvYdCrBiGmznbfNkQZiNnEbKFibCZTN+PNXRVHPe6zsdG8W8Iq0Q==
X-Received: by 2002:a05:7022:128e:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-13504944586mr3771192c88.3.1779204371019; Tue, 19 May 2026
 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260517052649.1514840-1-yifan1.zhang@amd.com>
 <CADnq5_NwcH3cpDfiUf1rpZPR3Kts6ARE+93ovng1Ht9pnN2ooQ@mail.gmail.com>
 <PH0SPRMB01519A5F84447A115F939E4995002@PH0SPRMB0151.namprd12.prod.outlook.com>
In-Reply-To: <PH0SPRMB01519A5F84447A115F939E4995002@PH0SPRMB0151.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 11:25:59 -0400
X-Gm-Features: AVHnY4I4DWqO50DSbFhzFRvqfZWmoHx25VrrOtG56KWe6mhwlki8gY0EzPbcOG4
Message-ID: <CADnq5_M6e9X1zZVXJCSSufo+Mznw3DTtB-ueGAjce1UuQniOpw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: add ioctl to handle RAS poison error
To: "Yat Sin, David" <David.YatSin@amd.com>
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
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

On Tue, May 19, 2026 at 11:16=E2=80=AFAM Yat Sin, David <David.YatSin@amd.c=
om> wrote:
>
> AMD General
>
> I think the kfd_sigbus_delay should be uint32_t.
>
> uint16_t is only ~1 minute. Once userspace gets the first exception event=
, it may start generating a coredump file and the coredump file generation =
can take > 40 minutes.
>

Ah, ok.  That makes sense.

Alex

> ~David
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, May 19, 2026 9:55 AM
> > To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Yat Sin, David
> > <David.YatSin@amd.com>; Russell, Kent <Kent.Russell@amd.com>; Yuan, Per=
ry
> > <Perry.Yuan@amd.com>
> > Subject: Re: [PATCH v3] drm/amdgpu: add ioctl to handle RAS poison erro=
r
> >
> > On Sun, May 17, 2026 at 1:44=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.c=
om> wrote:
> > >
> > > Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> > > AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing
> > userspace
> > > (ROCr) to control per-process SIGBUS delivery.
> > >
> > > Userspace for this can be found at:
> > > https://github.com/ROCm/rocm-systems/pull/6190
> > >
> > > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  12 +++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  29 ++++++
> > > drivers/gpu/drm/amd/amdkfd/kfd_events.c | 118 +++++++++++++++++++++++=
-
> > >  include/uapi/drm/amdgpu_drm.h           |  24 +++++
> > >  5 files changed, 182 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index 5d7bfa59424a..0408476f1070 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -455,6 +455,16 @@ struct amdgpu_fpriv {
> > >
> > >         /** GPU partition selection */
> > >         uint32_t                xcp_id;
> > > +
> > > +       /**
> > > +        * @kfd_sigbus_delay_ms: Per-fd KFD SIGBUS delivery option (s=
et via
> > > +        * DRM_IOCTL_AMDGPU_USER_OPTIONS /
> > AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
> > > +        *
> > > +        *   0          - send SIGBUS immediately (default)
> > > +        *   0xFFFF - suppress SIGBUS delivery
> > > +        *   other      - delay SIGBUS delivery by this many millisec=
onds
> > > +        */
> > > +       atomic_t                kfd_sigbus_delay_ms;
> > >  };
> > >
> > >  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv
> > > **fpriv); @@ -1467,6 +1477,8 @@ int amdgpu_enable_vblank_kms(struct
> > > drm_crtc *crtc);  void amdgpu_disable_vblank_kms(struct drm_crtc
> > > *crtc);  int amdgpu_info_ioctl(struct drm_device *dev, void *data,
> > >                       struct drm_file *filp);
> > > +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> > > +                             struct drm_file *filp);
> > >
> > >  /*
> > >   * functions used by amdgpu_encoder.c diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 99688391e70b..cad18bd6f8b3 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -3078,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[]=
 =3D {
> > >         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL,
> > amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > >         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT,
> > amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > >         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
> > > amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > > +       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS,
> > > + amdgpu_user_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > >  };
> > >
> > >  static const struct drm_driver amdgpu_kms_driver =3D { diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index 24526e92f9b8..7903587b8bbb 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1423,6 +1423,35 @@ int amdgpu_info_ioctl(struct drm_device *dev, =
void
> > *data, struct drm_file *filp)
> > >         return 0;
> > >  }
> > >
> > > +/**
> > > + * amdgpu_user_options_ioctl - set per-fd user options
> > > + *
> > > + * @dev: drm dev pointer
> > > + * @data: pointer to struct drm_amdgpu_user_options
> > > + * @filp: drm file
> > > + *
> > > + * Sets options stored on the per-file amdgpu_fpriv. Currently the
> > > +only
> > > + * supported option is
> > %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY which
> > > + * controls how KFD delivers SIGBUS for poison/RAS events to the
> > > +calling
> > > + * process (immediate, suppressed, or delayed by N milliseconds).
> > > + */
> > > +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> > > +                             struct drm_file *filp) {
> > > +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> > > +       struct drm_amdgpu_user_options *args =3D data;
> > > +
> > > +       switch (args->op) {
> > > +       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> > > +               atomic_set(&fpriv->kfd_sigbus_delay_ms,
> > > +                          args->kfd_sigbus_delay.value);
> > > +               return 0;
> > > +       default:
> > > +               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op=
);
> > > +               return -EINVAL;
> > > +       }
> > > +}
> > > +
> > >  /**
> > >   * amdgpu_driver_open_kms - drm callback for open
> > >   *
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > > index e9be798c0a2b..200570401f51 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > > @@ -29,10 +29,12 @@
> > >  #include <linux/uaccess.h>
> > >  #include <linux/mman.h>
> > >  #include <linux/memory.h>
> > > +#include <linux/workqueue.h>
> > >  #include "kfd_priv.h"
> > >  #include "kfd_events.h"
> > >  #include "kfd_device_queue_manager.h"
> > >  #include <linux/device.h>
> > > +#include <uapi/drm/amdgpu_drm.h>
> > >
> > >  /*
> > >   * Wrapper around wait_queue_entry_t
> > > @@ -1337,6 +1339,119 @@ void kfd_signal_reset_event(struct kfd_node *=
dev)
> > >         srcu_read_unlock(&kfd_processes_srcu, idx);  }
> > >
> > > +/*
> > > + * Per-process opt-in for poison-consumption SIGBUS handling.
> > > + *
> > > + * Default: kernel sends SIGBUS to the process immediately when
> > > +poison is
> > > + * consumed, in addition to delivering the KFD HW/MEMORY exception e=
vents.
> > > + *
> > > + * Userspace (ROCr) can opt-in per-process via the
> > > + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
> > > +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> > > + * option. This lets the app's registered system-event callback
> > > +handle the
> > > + * RAS error first, instead of being killed by SIGBUS.
> > > + *
> > > + * Encoded value (set on any of the process' amdgpu render fds):
> > > + *   0          - default: SIGBUS immediately (no opt-in)
> > > + *   0xFFFF - opt-in, never escalate to SIGBUS
> > > + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does =
not
> > > + *                handle the error in time (safety timeout)
> > > + *
> > > + * Per-process scope: the option is honored if ANY of the process'
> > > +amdgpu
> > > + * fds has been configured. This matches the slide deck's
> > > +"Per-process,
> > > + * App set at init" semantics, while keeping the UAPI on amdgpu wher=
e
> > > +ROCr
> > > + * sets it.
> > > + */
> > > +struct kfd_sigbus_delayed_work {
> > > +       struct delayed_work work;
> > > +       struct kfd_process *p;
> > > +};
> > > +
> > > +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
> > > +       struct kfd_sigbus_delayed_work *dw =3D container_of(to_delaye=
d_work(work),
> > > +                               struct kfd_sigbus_delayed_work, work)=
;
> > > +       struct kfd_process *p =3D dw->p;
> > > +
> > > +       if (p->lead_thread)
> > > +               send_sig(SIGBUS, p->lead_thread, 0);
> > > +
> > > +       kfd_unref_process(p);
> > > +       kfree(dw);
> > > +}
> > > +
> > > +/*
> > > + * Resolve the per-process SIGBUS opt-in setting by scanning all of
> > > +the
> > > + * process' KFD pdds (each backed by an amdgpu render fd). Returns
> > > +the
> > > + * "most lenient" value across all fds, in this priority:
> > > + *   DISABLED (no SIGBUS)  >  any non-zero timeout  >  0 (immediate)
> > > + *
> > > + * Rationale: if the app has explicitly opted in on any GPU it uses,
> > > +it
> > > + * wants the chance to handle the error in userspace.
> > > + */
> > > +static u16 kfd_get_sigbus_delay_ms(struct kfd_process *p) {
> > > +       u16 result =3D 0;
> > > +       int i;
> > > +
> > > +       mutex_lock(&p->mutex);
> > > +       for (i =3D 0; i < p->n_pdds; i++) {
> > > +               struct kfd_process_device *pdd =3D p->pdds[i];
> > > +               struct amdgpu_fpriv *drv_priv;
> > > +               u16 v;
> > > +
> > > +               if (!pdd || !pdd->drm_file)
> > > +                       continue;
> > > +               if (amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))
> > > +                       continue;
> > > +
> > > +               v =3D atomic_read(&drv_priv->kfd_sigbus_delay_ms);
> > > +               if (v =3D=3D
> > AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
> > > +                       result =3D v;
> > > +                       break;
> > > +               }
> > > +               if (v > result)
> > > +                       result =3D v;
> > > +       }
> > > +       mutex_unlock(&p->mutex);
> > > +
> > > +       return result;
> > > +}
> > > +
> > > +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> > > +                                        struct kfd_process *p) {
> > > +       u16 delay_ms =3D kfd_get_sigbus_delay_ms(p);
> > > +       struct kfd_sigbus_delayed_work *dw;
> > > +
> > > +       if (delay_ms =3D=3D
> > AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED) {
> > > +               dev_info(dev->adev->dev,
> > > +                        "SIGBUS suppressed for process %s(pid:%d): a=
pp opted in to
> > handle RAS error\n",
> > > +                        p->lead_thread->comm, p->lead_thread->pid);
> > > +               return;
> > > +       }
> > > +
> > > +       if (delay_ms =3D=3D 0)
> > > +               goto send_now;
> > > +
> > > +       dw =3D kzalloc(sizeof(*dw), GFP_ATOMIC);
> > > +       if (!dw)
> > > +               goto send_now;
> > > +
> > > +       /* Take an extra reference for the delayed worker. */
> > > +       kref_get(&p->ref);
> > > +       dw->p =3D p;
> > > +       INIT_DELAYED_WORK(&dw->work, kfd_signal_sigbus_delayed_fn);
> > > +
> > > +       dev_info(dev->adev->dev,
> > > +                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RA=
S error opt-
> > in safety timeout)\n",
> > > +                p->lead_thread->comm, p->lead_thread->pid, delay_ms)=
;
> > > +       schedule_delayed_work(&dw->work, msecs_to_jiffies(delay_ms));
> > > +       return;
> > > +
> > > +send_now:
> > > +       send_sig(SIGBUS, p->lead_thread, 0);
> >
> >
> > Probably worth adding a comment here that this feature is not supported=
 with
> > confidential compute.  Other than that, looks good to me.
> >
> > Alex
> >
> > > +}
> > > +
> > >  void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32
> > > pasid)  {
> > >         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid,
> > > NULL); @@ -1345,7 +1460,6 @@ void
> > kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
> > >         struct kfd_event *ev;
> > >         uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
> > >         int user_gpu_id;
> > > -
> > >         if (!p) {
> > >                 dev_warn(dev->adev->dev, "Not find process with pasid=
:%d\n", pasid);
> > >                 return; /* Presumably process exited. */ @@ -1391,7
> > > +1505,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev=
, u32
> > pasid)
> > >         rcu_read_unlock();
> > >
> > >         /* user application will handle SIGBUS signal */
> > > -       send_sig(SIGBUS, p->lead_thread, 0);
> > > +       kfd_signal_sigbus_with_delay(dev, p);
> > >
> > >         kfd_unref_process(p);
> > >  }
> > > diff --git a/include/uapi/drm/amdgpu_drm.h
> > > b/include/uapi/drm/amdgpu_drm.h index 9f3090db2f16..e88d7cf53858
> > > 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -58,6 +58,7 @@ extern "C" {
> > >  #define DRM_AMDGPU_USERQ_SIGNAL                0x17
> > >  #define DRM_AMDGPU_USERQ_WAIT          0x18
> > >  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> > > +#define DRM_AMDGPU_USER_OPTIONS                0x1A
> > >
> > >  #define DRM_IOCTL_AMDGPU_GEM_CREATE
> > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
> > drm_amdgpu_gem_create)
> > >  #define DRM_IOCTL_AMDGPU_GEM_MMAP
> > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
> > drm_amdgpu_gem_mmap)
> > > @@ -79,6 +80,7 @@ extern "C" {
> > >  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL
> > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct
> > drm_amdgpu_userq_signal)
> > >  #define DRM_IOCTL_AMDGPU_USERQ_WAIT
> > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct
> > drm_amdgpu_userq_wait)
> > >  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
> > DRM_IOWR(DRM_COMMAND_BASE +
> > > DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> > > +#define DRM_IOCTL_AMDGPU_USER_OPTIONS
> > DRM_IOWR(DRM_COMMAND_BASE +
> > > +DRM_AMDGPU_USER_OPTIONS, struct drm_amdgpu_user_options)
> > >
> > >  /**
> > >   * DOC: memory domains
> > > @@ -1673,6 +1675,28 @@ struct drm_amdgpu_info_uq_metadata {
> > >  #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.=
5.4 */
> > >  #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.=
0.0 */
> > >
> > > +/*
> > > + * Definition of user options
> > > + *
> > > + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> > > + *    0:          Disable sigbus delay - SIGBUS will be raised immed=
iately
> > > + *    0xFFFF: SIGBUS will not be raised
> > > + *    other:      Set the sigbus delay in milliseconds
> > > + */
> > > +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
> > > +
> > > +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED
> > 0xFFFFu
> > > +
> > > +struct drm_amdgpu_user_options {
> > > +       __u32 op;
> > > +       union {
> > > +               struct {
> > > +                       __u16 value;
> > > +                       __u16 _pad;
> > > +               } kfd_sigbus_delay;
> > > +       };
> > > +};
> > > +
> > >  #if defined(__cplusplus)
> > >  }
> > >  #endif
> > > --
> > > 2.43.0
> > >
