Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AABC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 18:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BBB10E460;
	Fri, 26 Jul 2024 18:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtbwHK1/";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39A710E460
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 18:57:01 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-25d6dd59170so1011862fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722020221; x=1722625021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PK+rXE7Qblbbe0049l1uqBWXtxOOwuauBHCmsV+ilwg=;
 b=OtbwHK1/UNguIUTd++sV35lIxOn45BK6y0tfFfz4H52X1jhS6UHujPa7ywcs4Oarir
 tol+cjWH8sFFwg0T5GpwL80Vw4/A7zmPiuHCOei5pbKolpE1IedogIG6jaaGmz/rj0NC
 im1M/e15rBJl7uLMd0QAbZHxT8CuuqKS7BJ8t83We5cmO0lfN6dMR1+hKUvFJ3YhnN6C
 wum+2/VSqwVQmQJ6coAdZiKBfAaD3TO+algQzIQrUNbT1LJJI1ZoM6sJvn76CaGAJWLC
 V+6eFop7U87IhUfZRbVTHGCrZLFwFZYl1bGzaUGHH4jiCv8/L7fhxsJvfLmonTJRbbcQ
 HO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722020221; x=1722625021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PK+rXE7Qblbbe0049l1uqBWXtxOOwuauBHCmsV+ilwg=;
 b=IDiWcR9N3DM53uaXIXwopKbaxw/Of4lhu6NG+zXIQ6Ty8RZO8rXL6BHLNWJItd0cyk
 hn318ggKZUiDvM+77wRR3ms8sYKo5Cm2eBopUcBANV0ThzRHv00ixANHT9kNgXpnqC7a
 gOLJheCVVv9nfTQpO1OXsis/PdulyxCK3zCfn9rsH61LHgJ3ucaHRM2ExXukH+r9O8dx
 hwgeOp0esJ48m6AmFBY8YRy663MTlfDCRny+HmyKxhCCmNabcru7zcqbYVG+B7NNXvE4
 Q1TQRRRaTlkIo6+fXYoA7LkVt6kKTTfdcfyeIZmswTxenrbpSKw6X0ucnh/swLzWwuvi
 V88A==
X-Gm-Message-State: AOJu0Yywb6wrqYmVpAsG7WV7X2dj2o7JwZx9IvRWyetnqTt5EQOtm4Tp
 xUO+cxJ0oY8ZYcojQcRWJVQp7qZtjm47DRnodxYGsWds0vDmKJ+nrM1RY60sSGAZOofIg61G7vM
 xqV93uOXnv3lZWvsFLqyNroio3EDnCA==
X-Google-Smtp-Source: AGHT+IEfF96E0yHYWqNkY205Z++u1umQ7qkrVJ6Lc+HcV6KGo5Uh8Kfgcv72LYwlmVS70cnTpQJ37B0AMowrt57nrtw=
X-Received: by 2002:a05:6870:80d1:b0:260:f244:a0ce with SMTP id
 586e51a60fabf-267d49f84a8mr989482fac.0.1722020220702; Fri, 26 Jul 2024
 11:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
 <20240726153049.1296575-2-Jonathan.Kim@amd.com>
In-Reply-To: <20240726153049.1296575-2-Jonathan.Kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 14:56:49 -0400
Message-ID: <CADnq5_O9KSpYyczgNZC-6G1rpmbTJYS7xGE0OOLq0P6ToK_eJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: support the debugger during per-queue
 reset
To: Jonathan Kim <Jonathan.Kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com
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

On Fri, Jul 26, 2024 at 11:40=E2=80=AFAM Jonathan Kim <Jonathan.Kim@amd.com=
> wrote:
>
> In order to allow ROCm GDB to handle reset queues, raise an
> EC_QUEUE_RESET exception so that the debugger can subscribe and
> query this exception.
>
> Reset queues should still be considered suspendable with a status
> flag of KFD_DBG_QUEUE_RESET_MASK.
> However they should not be resumable since user space will no longer
> be able to access reset queues.

Do you have a link to the proposed debugger code which uses this?

Alex

>
> v2: move per-queue reset flag to this patch
> rebase based on patch 1 changes
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 31 ++++++++++++++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  include/uapi/linux/kfd_ioctl.h                |  4 +++
>  3 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e335703eff84..cb7b5bbf5c40 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -164,6 +164,10 @@ static void kfd_hws_hang(struct device_queue_manager=
 *dqm)
>                         struct kfd_process_device *pdd =3D qpd_to_pdd(qpd=
);
>
>                         pdd->has_reset_queue =3D true;
> +                       q->properties.is_reset =3D true;
> +                       kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET),
> +                                        q->process, q->device, q->doorbe=
ll_id,
> +                                        false, NULL, 0);
>                 }
>         }
>
> @@ -986,7 +990,7 @@ static int suspend_single_queue(struct device_queue_m=
anager *dqm,
>  {
>         bool is_new;
>
> -       if (q->properties.is_suspended)
> +       if (q->properties.is_suspended || q->properties.is_reset)
>                 return 0;
>
>         pr_debug("Suspending PASID %u queue [%i]\n",
> @@ -1007,6 +1011,9 @@ static int suspend_single_queue(struct device_queue=
_manager *dqm,
>                 if (dqm->dev->kfd->shared_resources.enable_mes) {
>                         int r =3D remove_queue_mes(dqm, q, &pdd->qpd);
>
> +                       if (q->properties.is_reset)
> +                               return 0;
> +
>                         if (r)
>                                 return r;
>                 }
> @@ -1967,10 +1974,14 @@ static void set_queue_as_reset(struct device_queu=
e_manager *dqm, struct queue *q
>                q->properties.queue_id, q->process->pasid);
>
>         pdd->has_reset_queue =3D true;
> +       q->properties.is_reset =3D true;
>         if (q->properties.is_active) {
>                 q->properties.is_active =3D false;
>                 decrement_queue_count(dqm, qpd, q);
>         }
> +
> +       kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET), q->process, q->devi=
ce,
> +                        q->doorbell_id, false, NULL, 0);
>  }
>
>  static int detect_queue_hang(struct device_queue_manager *dqm)
> @@ -3037,7 +3048,8 @@ int resume_queues(struct kfd_process *p,
>                                                 queue_ids[q_idx] &=3D
>                                                         ~KFD_DBG_QUEUE_IN=
VALID_MASK;
>                                         } else {
> -                                               queue_ids[q_idx] |=3D
> +                                               queue_ids[q_idx] |=3D q->=
properties.is_reset ?
> +                                                       KFD_DBG_QUEUE_RES=
ET_MASK :
>                                                         KFD_DBG_QUEUE_ERR=
OR_MASK;
>                                                 break;
>                                         }
> @@ -3072,7 +3084,7 @@ int resume_queues(struct kfd_process *p,
>                                                         queue_ids);
>
>                                         /* mask queue as error on resume =
fail */
> -                                       if (q_idx !=3D QUEUE_NOT_FOUND)
> +                                       if (q_idx !=3D QUEUE_NOT_FOUND &&=
 !q->properties.is_reset)
>                                                 queue_ids[q_idx] |=3D
>                                                         KFD_DBG_QUEUE_ERR=
OR_MASK;
>                                 }
> @@ -3119,6 +3131,7 @@ int suspend_queues(struct kfd_process *p,
>                 struct qcm_process_device *qpd =3D &pdd->qpd;
>                 struct queue *q;
>                 int r, per_device_suspended =3D 0;
> +               bool has_queue_reset_fail =3D false;
>
>                 mutex_lock(&p->event_mutex);
>                 dqm_lock(dqm);
> @@ -3135,6 +3148,9 @@ int suspend_queues(struct kfd_process *p,
>
>                                 if (!err) {
>                                         queue_ids[q_idx] &=3D ~KFD_DBG_QU=
EUE_INVALID_MASK;
> +                                       if (q->properties.is_reset)
> +                                               queue_ids[q_idx] |=3D KFD=
_DBG_QUEUE_RESET_MASK;
> +
>                                         if (exception_clear_mask && is_me=
s)
>                                                 q->properties.exception_s=
tatus &=3D
>                                                         ~exception_clear_=
mask;
> @@ -3176,13 +3192,18 @@ int suspend_queues(struct kfd_process *p,
>                                 continue;
>
>                         /* mask queue as error on suspend fail */
> -                       if (r)
> +                       if (r && !q->properties.is_reset) {
> +                               has_queue_reset_fail =3D true;
>                                 queue_ids[q_idx] |=3D KFD_DBG_QUEUE_ERROR=
_MASK;
> -                       else if (exception_clear_mask)
> +                       } else if (exception_clear_mask) {
>                                 q->properties.exception_status &=3D
>                                                         ~exception_clear_=
mask;
> +                       }
>                 }
>
> +               if (!has_queue_reset_fail)
> +                       total_suspended +=3D per_device_suspended;
> +
>                 dqm_unlock(dqm);
>                 mutex_unlock(&p->event_mutex);
>                 amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 892a85408c09..192e3102c152 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -504,6 +504,7 @@ struct queue_properties {
>         bool is_being_destroyed;
>         bool is_active;
>         bool is_gws;
> +       bool is_reset;
>         uint32_t pm4_target_xcc;
>         bool is_dbg_wa;
>         bool is_user_cu_masked;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 285a36601dc9..4713f9a6796e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -875,6 +875,7 @@ enum kfd_dbg_trap_exception_code {
>         EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID =3D 21,
>         EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID =3D 22,
>         EC_QUEUE_PACKET_VENDOR_UNSUPPORTED =3D 23,
> +       EC_QUEUE_RESET =3D 29,
>         EC_QUEUE_PREEMPTION_ERROR =3D 30,
>         EC_QUEUE_NEW =3D 31,
>         /* per device */
> @@ -907,6 +908,7 @@ enum kfd_dbg_trap_exception_code {
>                                  KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WOR=
K_GROUP_SIZE_INVALID) |        \
>                                  KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REG=
ISTER_INVALID) |       \
>                                  KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUP=
PORTED)        |       \
> +                                KFD_EC_MASK(EC_QUEUE_RESET)    |       \
>                                  KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR) |=
       \
>                                  KFD_EC_MASK(EC_QUEUE_NEW))
>  #define KFD_EC_MASK_DEVICE     (KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) |   =
       \
> @@ -997,8 +999,10 @@ struct kfd_queue_snapshot_entry {
>  };
>
>  /* Queue status return for suspend/resume */
> +#define KFD_DBG_QUEUE_RESET_BIT                29
>  #define KFD_DBG_QUEUE_ERROR_BIT                30
>  #define KFD_DBG_QUEUE_INVALID_BIT      31
> +#define KFD_DBG_QUEUE_RESET_MASK       (1 << KFD_DBG_QUEUE_RESET_BIT)
>  #define KFD_DBG_QUEUE_ERROR_MASK       (1 << KFD_DBG_QUEUE_ERROR_BIT)
>  #define KFD_DBG_QUEUE_INVALID_MASK     (1 << KFD_DBG_QUEUE_INVALID_BIT)
>
> --
> 2.34.1
>
