Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78CEC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 19:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57AC1113789;
	Wed, 17 Apr 2024 19:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8rISK62";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B877113789
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 19:21:56 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso109590a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713381716; x=1713986516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZi6MVDSPkJ85fRAl743Rai/MoC06ZJQe7afDiHiBR8=;
 b=g8rISK62xPDgTvh33cBicuxWJ9+un3p7LkuLIQE020WvHC24r/eTYG6JvdJfmDt9Cn
 vQulQ2vh9lAsFmpY2C8EJO+b1/60dmgQVPB+j8YzbdvyZ4MfR8K7+83mV+UEzz9V97qT
 h9lfythXcrQW23AMjGigJex53nWr8mA28RwiS70GbgFSZl/oQuYYZzhB37Vo+cvdNNd5
 FqKA/cSHs8ieAbSLtQiYCQnhokVZu2yExzGhE6Sh2Lg7AJlCQr3r4v5aNia2osCQh+QQ
 U3IsCxtWnqVQfkHCP7ixdHtXwq497goOkUwqZEAQHnU6pJiHpWgoy8PaEQ+a3JsFVOMD
 NtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381716; x=1713986516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZi6MVDSPkJ85fRAl743Rai/MoC06ZJQe7afDiHiBR8=;
 b=giHYI0lt6Fytri/HIjKpBsOLlWcCnqGb+WKS7Zkr88v6DbdhoKO2h1QO9rDxgRQ91i
 vEnKXJ4eXevoxEhoE3y4WPkd3wB+LTDQT1y4xKksEEVLUURuFDOY37J3XEMmF7g5VG1t
 b+pZjyd9XwAa6Wt4dZaEeFz+CI8HBzY0jvaJx2zkdhyS1IicNXJoR24zIB07tNBTeYph
 dRFB5RwJpWfVmW9D4Tpb0Q6R9SE5ZpbVtUDZASQoRuPbF9pSFR/njiLSToQrYrBLzug1
 x2R5DlaxmS2vTJPD27HQruNpzwS+wT+MUMDArI8NInINBmTrUjgkn6sqIRc3YsZs6CTY
 0cDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+7tDVbuVEPeSXGpQknG8FGi1SaZfA81FDL08zUTrxiiNlY7UMKmlyA65Ir9rlmDSgVZLD+Y1LOGbbb79kshRd5g+IV2JR+9+SEjFy5Q==
X-Gm-Message-State: AOJu0YwAJ659h8B5T8g+dMlYMBEP6bc/tKv6L5o2WYENt8gAtUgfvp2/
 LvMClOoecRFZvM3St9G0miZpgGt6s6L9mkykqAxxnuHQAOtTs/OQBqXBDbT8JnHEMS41B/RscBm
 Mf9SPg8kA8Kn/sJI/iyID5Q+ja0M=
X-Google-Smtp-Source: AGHT+IGpSXqL6W4XlmbWDJ+eH2T4x614ju0n4nuNRQy28bxp+ixSwAyJs+wIK0CEU41rkGIyFrmh40fJ0ybRIgRJBdk=
X-Received: by 2002:a17:90b:3902:b0:2a2:a243:478f with SMTP id
 ob2-20020a17090b390200b002a2a243478fmr384826pjb.1.1713381715648; Wed, 17 Apr
 2024 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240417113025.2886905-1-horace.chen@amd.com>
 <20240417113025.2886905-3-horace.chen@amd.com>
 <8997494d-4b4e-4522-acbe-af44a8320c3d@amd.com>
 <CH0PR12MB53727853A2173DA703452EF5F40F2@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53727853A2173DA703452EF5F40F2@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 15:21:43 -0400
Message-ID: <CADnq5_MJJk=wW4tDKtOCCVPk9HeK8as75jxgkaHU3LmXb8ezxg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, 
 "Xu, Feifei" <Feifei.Xu@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 Leo Liu <leo.liiu@amd.com>, "Liu, Jenny (Jing)" <Jenny-Jing.Liu@amd.com>
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

On Wed, Apr 17, 2024 at 3:17=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - General]
>
> I have  a discussion with Christian about this before .  The conclusion i=
s that driver should prevent multiple process from using  the  MES ring at =
the same time . Also for current MES  ring usage ,driver doesn't have the  =
logic to prevent the ring  been  overflowed and we doesn't hit the issue be=
cause MES will wait polling for each MES submission . If we want to change =
the MES to work asynchronously , we need to consider a way to avoid this (s=
imilar to add the limit in the fence handling we use for kiq and  HMM pagin=
g)
>

I think we need a separate fence (different GPU address and seq
number) per request.  Then each caller can wait independently.

Alex

> Regards
> Shaoyun.liu
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christ=
ian K=C3=B6nig
> Sent: Wednesday, April 17, 2024 8:49 AM
> To: Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Kuehling, Felix <Felix=
.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, J=
ack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk =
<Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang, HaiJun <HaiJun.C=
hang@amd.com>; Leo Liu <leo.liiu@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.Li=
u@amd.com>
> Subject: Re: [PATCH 3/3] drm/amdgpu/mes11: make fence waits synchronous
>
> Am 17.04.24 um 13:30 schrieb Horace Chen:
> > The MES firmware expects synchronous operation with the driver.  For
> > this to work asynchronously, each caller would need to provide its own
> > fence location and sequence number.
>
> Well that's certainly not correct. The seqno takes care that we can wait =
async for the submission to complete.
>
> So clear NAK for that patch here.
>
> Regards,
> Christian.
>
> >
> > For now, add a mutex lock to serialize the MES submission.
> > For SR-IOV long-wait case, break the long-wait to separated part to
> > prevent this wait from impacting reset sequence.
> >
> > Signed-off-by: Horace Chen <horace.chen@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 18 ++++++++++++++----
> >   3 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 78e4f88f5134..8896be95b2c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -137,6 +137,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >       spin_lock_init(&adev->mes.queue_id_lock);
> >       spin_lock_init(&adev->mes.ring_lock);
> >       mutex_init(&adev->mes.mutex_hidden);
> > +     mutex_init(&adev->mes.submission_lock);
> >
> >       adev->mes.total_max_queue =3D AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> >       adev->mes.vmid_mask_mmhub =3D 0xffffff00; @@ -221,6 +222,7 @@ int
> > amdgpu_mes_init(struct amdgpu_device *adev)
> >       idr_destroy(&adev->mes.queue_id_idr);
> >       ida_destroy(&adev->mes.doorbell_ida);
> >       mutex_destroy(&adev->mes.mutex_hidden);
> > +     mutex_destroy(&adev->mes.submission_lock);
> >       return r;
> >   }
> >
> > @@ -240,6 +242,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
> >       idr_destroy(&adev->mes.queue_id_idr);
> >       ida_destroy(&adev->mes.doorbell_ida);
> >       mutex_destroy(&adev->mes.mutex_hidden);
> > +     mutex_destroy(&adev->mes.submission_lock);
> >   }
> >
> >   static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > index 6b3e1844eac5..90af935cc889 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > @@ -85,6 +85,7 @@ struct amdgpu_mes {
> >
> >       struct amdgpu_ring              ring;
> >       spinlock_t                      ring_lock;
> > +     struct mutex                    submission_lock;
> >
> >       const struct firmware           *fw[AMDGPU_MAX_MES_PIPES];
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > index e40d00afd4f5..0a609a5b8835 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -162,6 +162,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
> >       struct amdgpu_ring *ring =3D &mes->ring;
> >       unsigned long flags;
> >       signed long timeout =3D adev->usec_timeout;
> > +     signed long retry_count =3D 1;
> >       const char *op_str, *misc_op_str;
> >
> >       if (x_pkt->header.opcode >=3D MES_SCH_API_MAX) @@ -169,15 +170,19=
 @@
> > static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes
> > *mes,
> >
> >       if (amdgpu_emu_mode) {
> >               timeout *=3D 100;
> > -     } else if (amdgpu_sriov_vf(adev)) {
> > +     }
> > +
> > +     if (amdgpu_sriov_vf(adev) && timeout > 0) {
> >               /* Worst case in sriov where all other 15 VF timeout, eac=
h VF needs about 600ms */
> > -             timeout =3D 15 * 600 * 1000;
> > +             retry_count =3D (15 * 600 * 1000) / timeout;
> >       }
> >       BUG_ON(size % 4 !=3D 0);
> >
> > +     mutex_lock(&mes->submission_lock);
> >       spin_lock_irqsave(&mes->ring_lock, flags);
> >       if (amdgpu_ring_alloc(ring, ndw)) {
> >               spin_unlock_irqrestore(&mes->ring_lock, flags);
> > +             mutex_unlock(&mes->submission_lock);
> >               return -ENOMEM;
> >       }
> >
> > @@ -199,8 +204,13 @@ static int mes_v11_0_submit_pkt_and_poll_completio=
n(struct amdgpu_mes *mes,
> >       else
> >               dev_dbg(adev->dev, "MES msg=3D%d was emitted\n",
> > x_pkt->header.opcode);
> >
> > -     r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
> > -                   timeout);
> > +     do {
> > +             r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.syn=
c_seq,
> > +                             timeout);
> > +             retry_count--;
> > +     } while (retry_count > 0 && !amdgpu_in_reset(adev));
> > +
> > +     mutex_unlock(&mes->submission_lock);
> >       if (r < 1) {
> >
> >               if (misc_op_str)
>
