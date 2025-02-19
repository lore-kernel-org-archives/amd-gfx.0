Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9E3C021B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 23:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D016A10E032;
	Wed, 19 Feb 2025 23:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIBMP/py";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCC38825B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 23:08:55 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fc0ab102e2so72662a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740006534; x=1740611334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rISeevuXiLZlvWMmNK7EIDPEVhC1JkFuz4iOw7EqTXg=;
 b=YIBMP/pyz34V48nbLK6nZVe8c/DnWzVWMiVDBM4CgGSlzomA2iFyyRkPJVWKYPlOg2
 1Hjn9ceQYu2E+XMJEIl3bTaVXfCmrXQ4dDm8dC0OTuviOcYlu2FoKMiOIGX37FDo5Wry
 5sGIQAP+G8XsVvbHfOqYpRwIwdG9Q3CreEGT8GkX+gpFULk/pql9xdzuobmNeq5v0Fd1
 JcxFhm0qcNRAReunJ3D+VUW1aOE+pstMPr0csHKrIvQ3l7HW0RBxDFTqzZD+hHq54l1B
 Kl/dSXIt553dcYGRbdyUKxRbzoaFP8urAgw+bouOhMrwjcD6eLg6FIdj5RcDG9FrZmnR
 OgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740006534; x=1740611334;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rISeevuXiLZlvWMmNK7EIDPEVhC1JkFuz4iOw7EqTXg=;
 b=b8/BXAajMP0rspWqooZnbH5E/7f9/qBFNT9CODlovzUqp32TZdSh/TRi2Exe1Y7qqr
 921TA1/Pfz7PRbuxIsBkDO8oewYWIdJPvTP+Uvx15UJjtj64gt4Y7gXoltNHEuOdPVyu
 Lugp+WFDy90jPLr+Jq6Z+x3yJbqNHOKFA3TMz3k8PvatEuws+0lscVhwzjZ1WBJuD0dk
 kPEUY9+jRTe2NJIwbWBmFmWBz15POWsdtfevC5rsW26qUZIwPlfvJN2jm3gLWVM9dN4p
 MqliCdiZ28aSezmxVWEBJccZJiZMDigEFXTstH1sN5uMYy1pEoTzkmIas82/xdB3j5PS
 N/pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ZR1xoEmxr3MB7vxhWwP8vV70zB0Wy8N+3fH2inFtf2DStAjcgQ+voLm8nCJadYI68NCmnqze@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3agueedgzaBAOJVs0EMjDBCXCZt247zUCl7/gba2IAzE1RMDE
 4lgbiVVCTgCKoqFkBa3B/XYb5Y5Tok+RHCBJyf2ao8kqnytw9th1oYiKt+uYL9NKL+Umb8KViFz
 tY+Wowgj3lvY/Ol2cxjN0x9ULKROtMrmb
X-Gm-Gg: ASbGnctpLveso4rZhKcDntV/6DMvCCUNHFidnuGaoa3WXX2xEwZIqU6qWcHZUbMLp/I
 JOSvyoH7ctGbJYy4EfY1VbXzlsdmbP/EnF5UybJof02S0iAch+CLbZBEDkDTzen0glsijIXM6
X-Google-Smtp-Source: AGHT+IEN64B4HpIAE6zNNajGi0qxBgpNzO9gkiijqQw0lD8ENbeRzJL//5DunlTau3V5WHaqSC2/SlErXE+KtV1LYv8=
X-Received: by 2002:a17:90b:4ac4:b0:2f2:f6e5:d28e with SMTP id
 98e67ed59e1d1-2fc4103cc26mr11320453a91.3.1740006534336; Wed, 19 Feb 2025
 15:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-3-jesse.zhang@amd.com>
 <f61682b9-59cf-487f-9d83-a79d4555ffd8@amd.com>
 <CY8PR12MB74359FDE16AF97D324B7EFB285FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <BL1PR12MB51449A0FA22045FA57CB3162F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CY8PR12MB7435A90C377278B3CDF1174B85C52@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435A90C377278B3CDF1174B85C52@CY8PR12MB7435.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 18:08:42 -0500
X-Gm-Features: AWEUYZkwvbn9e-_gHpCXSmiNUR0QWLE3pUJR_ZLMnp1duiMbYUdO2XwOgDTzS00
Message-ID: <CADnq5_M1V6JOB8vfWSUPz2CoCB7VcGWrUZcbV3-P8NAY=9Uq7A@mail.gmail.com>
Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
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

On Wed, Feb 19, 2025 at 3:29=E2=80=AFPM Kim, Jonathan <Jonathan.Kim@amd.com=
> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Wednesday, February 19, 2025 12:39 PM
> > To: Kim, Jonathan <Jonathan.Kim@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.c=
om>;
> > Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, Jiadong
> > <Jiadong.Zhu@amd.com>
> > Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset calle=
r
> > parameter for SDMA reset synchronization
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Kim, Jonathan <Jonathan.Kim@amd.com>
> > > Sent: Tuesday, February 18, 2025 12:42 PM
> > > To: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie)
> > > <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > > Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset cal=
ler
> > > parameter for SDMA reset synchronization
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > > > Sent: Monday, February 17, 2025 10:36 PM
> > > > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> > > > amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > > <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Zhu=
,
> > > > Jiadong <Jiadong.Zhu@amd.com>
> > > > Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset
> > > > caller parameter for SDMA reset synchronization
> > > >
> > > >
> > > >
> > > > On 2/13/2025 11:17 AM, jesse.zhang@amd.com wrote:
> > > > > From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> > > > >
> > > > > This commit introduces a caller parameter to the
> > > > > amdgpu_sdma_reset_instance
> > > > function to differentiate
> > > > > between reset requests originating from the KGD and KFD.
> > > > > This change ensures proper synchronization between KGD and KFD
> > > > > during SDMA
> > > > resets.
> > > > >
> > > > > If the caller is KFD, the function now acquires and releases the
> > > > > scheduler lock
> > > > (ring->sched.job_list_lock)
> > > > > to protect the SDMA queue during the reset.
> > > > >
> > > > > These changes prevent race conditions and ensure safe SDMA reset
> > > > > operations when initiated by KFD, improving system stability and =
reliability.
> > > > >
> > > > > V2: replace the ring_lock with the existed the scheduler
> > > > >     locks for the queues (ring->sched) on the sdma engine.(Alex)
> > > > >
> > > > > v3: call drm_sched_wqueue_stop() rather than job_list_lock.
> > > > >     If a GPU ring reset was already initiated for one ring at
> > amdgpu_job_timedout,
> > > > >     skip resetting that ring and call drm_sched_wqueue_stop()
> > > > >     for the other rings (Alex)
> > > > >
> > > > >    replace  the common lock (sdma_reset_lock) with DQM lock to
> > > > >    to resolve reset races between the two driver sections during =
KFD
> > > > > eviction.(Jon)
> > > > >
> > > > >    Rename the caller to Reset_src and
> > > > >    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to
> > > > AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
> > > > > v4: restart the wqueue if the reset was successful,
> > > > >     or fall back to a full adapter reset. (Alex)
> > > > >
> > > > >    move definition of reset source to enumeration AMDGPU_RESET_SR=
CS,
> > > and
> > > > >    check reset src in amdgpu_sdma_reset_instance (Jon)
> > > > >
> > > > > v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset
> > > > > function
> > > > respectively under !SRC_HWS
> > > > >     conditions only (Jon)
> > > > >
> > > > > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> > > > > Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> > > > > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > > > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
> > > > > drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65
> > > > > ++++++++++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > |
> > > > > 6 +--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
> > > > >  4 files changed, 67 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > > > > index 4d9b9701139b..5b86e12ff9fe 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> > > > > @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
> > > > >     AMDGPU_RESET_SRC_MES,
> > > > >     AMDGPU_RESET_SRC_HWS,
> > > > >     AMDGPU_RESET_SRC_USER,
> > > > > +   AMDGPU_RESET_SRC_SDMA_RING,
> > > > > +   AMDGPU_RESET_SRC_SDMA_HWS,
> > > > >  };
> > > > >
> > > > >  struct amdgpu_reset_context {
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > > > index fe39198307ec..808c7112ef10 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > > > > @@ -25,6 +25,7 @@
> > > > >  #include "amdgpu.h"
> > > > >  #include "amdgpu_sdma.h"
> > > > >  #include "amdgpu_ras.h"
> > > > > +#include "amdgpu_reset.h"
> > > > >
> > > > >  #define AMDGPU_CSA_SDMA_SIZE 64
> > > > >  /* SDMA CSA reside in the 3rd page of CSA */ @@ -485,6 +486,7 @@
> > > > > void amdgpu_sdma_register_on_reset_callbacks(struct
> > > > amdgpu_device *adev, struct
> > > > >   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
> > > > >   * @adev: Pointer to the AMDGPU device
> > > > >   * @instance_id: ID of the SDMA engine instance to reset
> > > > > + * @src: The source of reset function (KGD or KFD)
> > > > >   *
> > > > >   * This function performs the following steps:
> > > > >   * 1. Calls all registered pre_reset callbacks to allow KFD and
> > > > > AMDGPU to save
> > > > their state.
> > > > > @@ -493,20 +495,49 @@ void
> > > > > amdgpu_sdma_register_on_reset_callbacks(struct
> > > > amdgpu_device *adev, struct
> > > > >   *
> > > > >   * Returns: 0 on success, or a negative error code on failure.
> > > > >   */
> > > > > -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_=
t
> > > > instance_id)
> > > > > +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_=
t
> > > > instance_id, int src)
> > > > >  {
> > > > >     struct sdma_on_reset_funcs *funcs;
> > > > > -   int ret;
> > > > > +   int ret =3D 0;
> > > > > +   struct amdgpu_sdma_instance *sdma_instance =3D &adev-
> > > > >sdma.instance[instance_id];;
> > > > > +   struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> > > > > +   struct amdgpu_ring *page_ring =3D &sdma_instance->page;
> > > > > +   bool gfx_sched_stopped =3D false, page_sched_stopped =3D fals=
e;
> > > > > +
> > > > > +   /* Check if the reset source is valid for SDMA ring reset */
> > > > > +   if (src !=3D AMDGPU_RESET_SRC_SDMA_RING && src !=3D
> > > > AMDGPU_RESET_SRC_HWS)
> > > > > +           return -EINVAL;
> > > > > +
> > > > > +   /* Suspend KFD if the reset source is not SDMA_HWS.
> > > > > +    * prevent the destruction of in-flight healthy user queue pa=
ckets and
> > > > > +    * avoid race conditions between KFD and KGD during the reset=
 process.
> > > > > +    */
> > > > > +   if (src !=3D AMDGPU_RESET_SRC_SDMA_HWS)
> > > > > +           amdgpu_amdkfd_suspend(adev, false);
> > > >
> > > > It this has to be done here, what's the idea behind registering a
> > > > separate pre/post callback for KFD initiated resets?
> > >
> > > The problem is that for SDMA v5.x and below, a single soft reset call=
 will reset all
> > > queues on the target SDMA engine.
> > > If the KGD calls the reset, a transient KFD suspend/resume around the=
 reset will
> > > guarantee that healthy user queues survive the reset.
> > > If the KFD calls the reset, it will only do so during preemption fail=
ure, and we don't
> > > want to suspend and resume the KFD again when the KFD calls this func=
tion.
> > > The KFD needs to call this common function to not disturb GFX and pag=
ing queues
> > > for the same reason KGD resets need to be wary of KFD queues.
> > > In the case of preemption failure and a KFD initiated reset, the KFD =
is holding the
> > > device wide preemption lock, so if the KGD is trying to reset as well=
, it will have to
> > > wait on its own KFD suspend call until the KFD is done its own reset.
> > >
> > > I think SDMA6+ can target specific queues via MMIO reg writes, but I =
see in the
> > > KGD code that soft_reset for SDMA 6+ does a sweep of all engines so w=
e would
> > > still need to keep KFD queues safe (I'm not familiar with this chunk =
of the code or
> > > the need for sweeping all engines on the KGD side).
> > > So I'm not sure if Jesse had concerns about potential multiple calls =
being made in
> > > other parts of the code and maybe this was some way to simplify thing=
s.
> > > Either way, not sure if it's simpler to drop the reset source param a=
nd have the
> > KGD
> > > remember to unconditionally KFD suspend/resume around the soft reset =
call for
> > > each IP version, or keep the reset source param here so that we only =
have to
> > > remember to do this once.
> >
> > Could KFD keep track of whether the hang was detected by KFD or KGD?  E=
.g., if
> > KFD detects the hang when suspending queues, it could set a flag and th=
en KFD
> > could include a call to amdgpu_amdkfd_suspend() in its pre_reset callba=
ck that
> > would depend on the value of that flag.  At that point I don't think we=
'd need the src
> > parameter any more.
>
> Hmmm.  Something similar to GPU resets?
> The thing about GPU resets is that the KFD could just detect the flag, sc=
hedule an event then carry on knowing the driver is going to die and re-ini=
t at some point.
> SDMA resets are different because the KFD would call back into the common=
 KGD call immediately because it wants to fix things right away, and the KG=
D has to ensure the KFD is quiesced in any case.
> So any flag would have to be locked as well in the KFD pre/post calls.   =
Which means we'd probably have to conditionally lock it based on a new rese=
t context that the KGD would have to supply anyways.
> This was the main reason why I wanted to simplify things by leveraging a =
conditional suspend/resume call in the common interface.
> Maybe I'm not looking at things clearly atm, but if feels like we're push=
ing the complication from one part of the driver into another.
>
> If we really don't like the idea of adding flags, maybe we can just add a=
 param "bool suspend_user_queues" to the common interface?
> Then maybe it's clearer that the KGD, as a reset requester, wants to be c=
areful of destroying in-flight user queues while the KFD doesn't care about=
 this for its own needs (since it's already in post-preemption recovery).
>

Having the src for a parameter is fine with me.  It just seemed
logical to keep it in KFD since presumably KFD would have detected
this condition after calling amdgpu_amdkfd_suspend() itself so it
would know whether it would need to be called based on its own state
so it would know what to do in its pre and post reset hooks already.
I guess we also stop the kernel queues explicitly in the same function
so it makes sense to do the same for KFD.

Alex

> Jon
>
> >
> > Alex
> >
> >
> > >
> > > Jon
> > >
> > > >
> > > > Thanks,
> > > > Lijo
> > > >
> > > > > +
> > > > > +   /* Stop the scheduler's work queue for the GFX and page rings=
 if
> > > > > + they are
> > > > running.
> > > > > +   * This ensures that no new tasks are submitted to the queues =
while
> > > > > +   * the reset is in progress.
> > > > > +   */
> > > > > +   if (!amdgpu_ring_sched_ready(gfx_ring)) {
> > > > > +           drm_sched_wqueue_stop(&gfx_ring->sched);
> > > > > +           gfx_sched_stopped =3D true;;
> > > > > +   }
> > > > > +
> > > > > +   if (adev->sdma.has_page_queue
> > > > && !amdgpu_ring_sched_ready(page_ring)) {
> > > > > +           drm_sched_wqueue_stop(&page_ring->sched);
> > > > > +           page_sched_stopped =3D true;
> > > > > +   }
> > > > >
> > > > >     /* Invoke all registered pre_reset callbacks */
> > > > >     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, l=
ist) {
> > > > >             if (funcs->pre_reset) {
> > > > > -                   ret =3D funcs->pre_reset(adev, instance_id);
> > > > > +                   ret =3D funcs->pre_reset(adev, instance_id, s=
rc);
> > > > >                     if (ret) {
> > > > >                             dev_err(adev->dev,
> > > > >                             "beforeReset callback failed for inst=
ance %u: %d\n",
> > > > >                                     instance_id, ret);
> > > > > -                           return ret;
> > > > > +                           goto exit;
> > > > >                     }
> > > > >             }
> > > > >     }
> > > > > @@ -515,21 +546,39 @@ int amdgpu_sdma_reset_engine(struct
> > > > > amdgpu_device
> > > > *adev, uint32_t instance_id)
> > > > >     ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> > > > >     if (ret) {
> > > > >             dev_err(adev->dev, "Failed to reset SDMA instance %u\=
n",
> > > > instance_id);
> > > > > -           return ret;
> > > > > +           goto exit;
> > > > >     }
> > > > >
> > > > >     /* Invoke all registered post_reset callbacks */
> > > > >     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, l=
ist) {
> > > > >             if (funcs->post_reset) {
> > > > > -                   ret =3D funcs->post_reset(adev, instance_id);
> > > > > +                   ret =3D funcs->post_reset(adev, instance_id, =
src);
> > > > >                     if (ret) {
> > > > >                             dev_err(adev->dev,
> > > > >                             "afterReset callback failed for insta=
nce %u: %d\n",
> > > > >                                     instance_id, ret);
> > > > > -                           return ret;
> > > > > +                           goto exit;
> > > > >                     }
> > > > >             }
> > > > >     }
> > > > >
> > > > > -   return 0;
> > > > > +exit:
> > > > > +   /* Restart the scheduler's work queue for the GFX and page ri=
ngs
> > > > > +    * if they were stopped by this function. This allows new tas=
ks
> > > > > +    * to be submitted to the queues after the reset is complete.
> > > > > +    */
> > > > > +   if (ret) {
> > > > > +           if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_=
ring)) {
> > > > > +                   drm_sched_wqueue_start(&gfx_ring->sched);
> > > > > +           }
> > > > > +           if (page_sched_stopped && amdgpu_ring_sched_ready(pag=
e_ring)) {
> > > > > +                   drm_sched_wqueue_start(&page_ring->sched);
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   /* Resume KFD if the reset source is not SDMA_HWS */
> > > > > +   if (src !=3D AMDGPU_RESET_SRC_SDMA_HWS)
> > > > > +           amdgpu_amdkfd_resume(adev, false);
> > > > > +
> > > > > +       return ret;
> > > > >  }
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > > > index f91d75848557..2ef2da772254 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> > > > > @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {  };
> > > > >
> > > > >  struct sdma_on_reset_funcs {
> > > > > -   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instanc=
e_id);
> > > > > -   int (*post_reset)(struct amdgpu_device *adev, uint32_t instan=
ce_id);
> > > > > +   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instanc=
e_id, int src);
> > > > > +   int (*post_reset)(struct amdgpu_device *adev, uint32_t
> > > > > + instance_id, int src);
> > > > >     /* Linked list node to store this structure in a list; */
> > > > >     struct list_head list;
> > > > >  };
> > > > > @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {  };
> > > > >
> > > > >  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_devic=
e
> > > > > *adev,
> > > > struct sdma_on_reset_funcs *funcs);
> > > > > -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_=
t
> > > > instance_id);
> > > > > +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_=
t
> > > > instance_id, int src);
> > > > >
> > > > >  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)-
> > > > >mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> > > > >  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
> > > > >(adev)->mman.buffer_funcs- emit_fill_buffer((ib), (s), (d), (b))
> > > > >diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > > > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > > > > index 29a123be90b7..50a086264792 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > > > > @@ -30,6 +30,7 @@
> > > > >  #include "amdgpu_xcp.h"
> > > > >  #include "amdgpu_ucode.h"
> > > > >  #include "amdgpu_trace.h"
> > > > > +#include "amdgpu_reset.h"
> > > > >
> > > > >  #include "sdma/sdma_4_4_2_offset.h"
> > > > >  #include "sdma/sdma_4_4_2_sh_mask.h"
> > > > > @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct
> > > > amdgpu_ip_block *ip_block)
> > > > >     if (r)
> > > > >             return r;
> > > > >     INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> > > > > +
> > > > >     return r;
> > > > >  }
> > > > >
> > > > > @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct
> > > > amdgpu_ring *ring, unsigned int vmid)
> > > > >  {
> > > > >     struct amdgpu_device *adev =3D ring->adev;
> > > > >     u32 id =3D GET_INST(SDMA0, ring->me);
> > > > > -   return amdgpu_sdma_reset_engine(adev, id);
> > > > > +   return amdgpu_sdma_reset_engine(adev, id,
> > > > AMDGPU_RESET_SRC_SDMA_RING);
> > > > >  }
> > > > >
> > > > > -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
> > > > > uint32_t
> > > > instance_id)
> > > > > +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
> > > > > +uint32_t
> > > > instance_id, int src)
> > > > >  {
> > > > >     u32 inst_mask;
> > > > >     struct amdgpu_ring *ring =3D
> > > > > &adev->sdma.instance[instance_id].ring;
> > > > > @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct
> > > > amdgpu_device *adev, uint32_t instance_
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
> > > > > uint32_t
> > > > instance_id)
> > > > > +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
> > > > > +uint32_t
> > > > instance_id, int src)
> > > > >  {
> > > > >     int i;
> > > > >     u32 inst_mask;
> > >
> >
>
