Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD0CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 21:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF39D10EAD9;
	Thu, 28 Aug 2025 21:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QaZuOJmF";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C27210EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 21:01:39 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-248e3eade89so1779515ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756414899; x=1757019699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pglFtRkMtvCVnJoaqBJK2iHCLlOvGzvFnjXGfZxIBD8=;
 b=QaZuOJmFj+774NZRINQeNFpjfh83n9nayny1V/iZpkwjIepkLa1jnGKJJnurJun+cQ
 V+R7efIx5kYALNiFhtH9MPDAn2sMtYI38UXyeOdZT6cpI8Pf9+0yDd/C8hONZtgtjcZY
 UYT05aWzECGD4Tpl7XM78CrEAxrBnCvEqxc+DA1HQyKDbgOthMhAAsAitaBr6q68N7bu
 v/cgWYzDkqxAqZMeorrRRjZHjAE0abKLZaP0zVGrCOoNnJx/NAhAoS1bDt+4hkK1AVPn
 7xnuAgfi6CoS5YdPsIjtYXDv62sFytuC6A6NsDYKYr+oePkeQc1YLXLVR/Vl3WKl317O
 oPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756414899; x=1757019699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pglFtRkMtvCVnJoaqBJK2iHCLlOvGzvFnjXGfZxIBD8=;
 b=K1kA484/t2vZQubgkiBbhBMcrEFpSJRJ15Vrk0ezeJzt7PhxCPbXpB2Ayh+/i0YAoG
 Kr2xKWJTQd7VY1+P2tzL38S4Aujz5uns13LJ/LPunKCRPnBSWMFURUxdS29encm165+w
 nsEaJy7VezFRrSGGHgzjvKDpycC9is/MRBz5tWC3HruLclwoivbU3Koy8e3TiyvVSPly
 HkbH4H84xIilr9B4IVr/Dx8wj83ys71bcH2k8ppDMRFJR96HhRfF5Bo7ryx/iRjb5sGf
 /Eehb2OM0kl8dkoKaSFayyfLQAwmXSHfrFKKteUJDs+P7OlJjxjy4gj0dnz0AqkLdbQP
 C4HQ==
X-Gm-Message-State: AOJu0YykCdZS1tDYoWv50mhVoanBN205lI9C9nFD8o7Ni7OJbAVf5f5l
 Svj4JvAP3ck+LoC/cuJwKVbU7guWod6jFzgHQKQ9cCNERwYVj9qPTiz1yqzVbhsVFJwKVInTq3b
 eE31e1YFCpRyAiCV92IxFOwZCCpPTt90=
X-Gm-Gg: ASbGncs3IVGSRx26SloLr4pSNfeS8XeHtDNOPMOLEybXCGUwX461kBfhNgkr3c3N2wC
 AchfFSHuqv9rMaqCmtoTecXNQF407sU9zMUe/YKIevaWkN1aC42pQSOLC7F1rWkhvVxZVuaNObm
 JPnXgKwZMAdATsasOU6eh6HYn7SQck72aICfYBuMU69hZkNTDpTjvbcsL09PR9qcO6ozmLF92Q6
 Y/y9JZgkoqUYRDKlg==
X-Google-Smtp-Source: AGHT+IHqDI0OabTNl88iPCsxbpfFr6hCgIaDA8CRmswaHH/BFc5mwr3uLBPu7j9sgRUC9C3qj4gi6redf1Iq2Q4lQpo=
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2462ef99564mr158780035ad.6.1756414898397; Thu, 28 Aug 2025
 14:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
 <20250826014648.1711926-11-Jesse.Zhang@amd.com>
 <CADnq5_N6EyJ-sk6DUjiAF=DoujCM1Bg-Pce58w7=w3UQZ9zo2A@mail.gmail.com>
 <DM4PR12MB51528395FF9873F98604F5C1E33BA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <DM4PR12MB5152BAD955B5FC2B0C3FAD43E33BA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152BAD955B5FC2B0C3FAD43E33BA@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 17:01:26 -0400
X-Gm-Features: Ac12FXypHOUPB37uDyFZQHzieNSchl2PdGDc_lvPoDmbLWSFSpCSLvfyghRocEY
Message-ID: <CADnq5_OxawtsABS=1GCQ_2j-P+P2XLgJCncVGNXRX2is+RChow@mail.gmail.com>
Subject: Re: [v12 11/11] drm/amdgpu: Implement user queue reset functionality
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Thu, Aug 28, 2025 at 4:54=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,=
 Jesse(Jie)
> Sent: Thursday, August 28, 2025 4:16 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [v12 11/11] drm/amdgpu: Implement user queue reset functiona=
lity
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, August 26, 2025 10:49 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [v12 11/11] drm/amdgpu: Implement user queue reset functiona=
lity
>
> On Mon, Aug 25, 2025 at 10:43=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com=
> wrote:
> >
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > This patch adds robust reset handling for user queues (userq) to
> > improve recovery from queue failures. The key components include:
> >
> > 1. Queue detection and reset logic:
> >    - amdgpu_userq_detect_and_reset_queues() identifies failed queues
> >    - Per-IP detect_and_reset callbacks for targeted recovery
> >    - Falls back to full GPU reset when needed
> >
> > 2. Reset infrastructure:
> >    - Adds userq_reset_work workqueue for async reset handling
> >    - Implements pre/post reset handlers for queue state management
> >    - Integrates with existing GPU reset framework
> >
> > 3. Error handling improvements:
> >    - Enhanced state tracking with HUNG state
> >    - Automatic reset triggering on critical failures
> >    - VRAM loss handling during recovery
> >
> > 4. Integration points:
> >    - Added to device init/reset paths
> >    - Called during queue destroy, suspend, and isolation events
> >    - Handles both individual queue and full GPU resets
> >
> > The reset functionality works with both compute and graphics queues,
> > providing better resilience against queue failures while minimizing
> > disruption to unaffected queues.
> >
> > v2: Separate SDMA and GFX/COMPUTE queue reset handling
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 215 +++++++++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
> >  4 files changed, 216 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index ef3af170dda4..9db05cdc7304 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1302,6 +1302,7 @@ struct amdgpu_device {
> >         struct list_head                userq_mgr_list;
> >         struct mutex                    userq_mutex;
> >         bool                            userq_halt_for_enforce_isolatio=
n;
> > +       struct work_struct              userq_reset_work;
> >  };
> >
> >  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device
> > *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 3757634613c3..1dc88b0055dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4475,6 +4475,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >         }
> >
> >         INIT_WORK(&adev->xgmi_reset_work,
> > amdgpu_device_xgmi_reset_func);
> > +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
> >
> >         adev->gfx.gfx_off_req_count =3D 1;
> >         adev->gfx.gfx_off_residency =3D 0; @@ -5880,6 +5881,10 @@ int
> > amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_con=
text)
> >                                 if (r)
> >                                         goto out;
> >
> > +                               r =3D amdgpu_userq_post_reset(tmp_adev,=
 vram_lost);
> > +                               if (r)
> > +                                       goto out;
> > +
> >
> > drm_client_dev_resume(adev_to_drm(tmp_adev), false);
> >
> >                                 /*
> > @@ -6102,6 +6107,7 @@ static inline void amdgpu_device_stop_pending_res=
ets(struct amdgpu_device *adev)
> >         if (!amdgpu_sriov_vf(adev))
> >                 cancel_work(&adev->reset_work);  #endif
> > +       cancel_work(&adev->userq_reset_work);
> >
> >         if (adev->kfd.dev)
> >                 cancel_work(&adev->kfd.reset_work);
> > @@ -6232,6 +6238,8 @@ static void amdgpu_device_halt_activities(struct =
amdgpu_device *adev,
> >                       amdgpu_device_ip_need_full_reset(tmp_adev))
> >                         amdgpu_ras_suspend(tmp_adev);
> >
> > +               amdgpu_userq_pre_reset(tmp_adev);
> > +
> >                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
> >                         struct amdgpu_ring *ring =3D tmp_adev->rings[i]=
;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index decedf8057ac..996c7397a57f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -25,8 +25,10 @@
> >  #include <drm/drm_auth.h>
> >  #include <drm/drm_exec.h>
> >  #include <linux/pm_runtime.h>
> > +#include <drm/drm_drv.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_reset.h"
> >  #include "amdgpu_vm.h"
> >  #include "amdgpu_userq.h"
> >  #include "amdgpu_userq_fence.h"
> > @@ -44,6 +46,102 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgp=
u_device *adev)
> >         return userq_ip_mask;
> >  }
> >
> > +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev) {
> > +
> > +       if (amdgpu_device_should_recover_gpu(adev)) {
> > +               amdgpu_reset_domain_schedule(adev->reset_domain,
> > +                                            &adev->userq_reset_work);
> > +               /* Wait for the reset job to complete */
> > +               flush_work(&adev->userq_reset_work);
> > +       }
> > +}
> > +
> > +static int
> > +amdgpu_userq_detect_and_reset_sdma(struct amdgpu_userq_mgr *uq_mgr) {
> > +       struct amdgpu_device *adev =3D uq_mgr->adev;
> > +       const struct amdgpu_userq_funcs *userq_sdma_funcs =3D
> > +                       adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
> > +       struct amdgpu_usermode_queue *userq;
> > +       bool has_sdma =3D false;
> > +       bool gpu_reset =3D false;
> > +       int id, r =3D 0;
> > +
> > +       /* Detect if SDMA queues are present */
> > +       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
> > +               if (userq->queue_type =3D=3D AMDGPU_RING_TYPE_SDMA) {
> > +                       has_sdma =3D true;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (has_sdma && userq_sdma_funcs && userq_sdma_funcs->detect_an=
d_reset) {
> > +               r =3D userq_sdma_funcs->detect_and_reset(adev, AMDGPU_R=
ING_TYPE_SDMA);
> > +               if (r)
> > +                       gpu_reset =3D true;
> > +       }
> > +
> > +       if (gpu_reset)
> > +               amdgpu_userq_gpu_reset(adev);
> > +
> > +       return r;
> > +}
> > +
> > +static int
> > +amdgpu_userq_detect_and_reset_gfx_compute(struct amdgpu_userq_mgr
> > +*uq_mgr) {
> > +       struct amdgpu_device *adev =3D uq_mgr->adev;
> > +       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
> > +                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> > +       const struct amdgpu_userq_funcs *userq_compute_funcs =3D
> > +                       adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
> > +       struct amdgpu_usermode_queue *userq;
> > +       bool has_gfx =3D false, has_compute =3D false;
> > +       bool gpu_reset =3D false;
> > +       int id, r =3D 0;
> > +
> > +       /* Detect which types of queues are present (excluding SDMA) */
> > +       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
> > +               switch (userq->queue_type) {
> > +               case AMDGPU_RING_TYPE_GFX:
> > +                       has_gfx =3D true;
> > +                       break;
> > +               case AMDGPU_RING_TYPE_COMPUTE:
> > +                       has_compute =3D true;
> > +                       break;
> > +               default:
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> > +               dev_err(adev->dev, "userq reset disabled by debug mask\=
n");
> > +       } else if (amdgpu_gpu_recovery) {
> > +               if (has_compute && userq_compute_funcs->detect_and_rese=
t) {
> > +                       r =3D userq_compute_funcs->detect_and_reset(ade=
v, AMDGPU_RING_TYPE_COMPUTE);
> > +                       if (r) {
> > +                               gpu_reset =3D true;
> > +                               goto gpu_reset;
> > +                       }
> > +               }
> > +
> > +               if (has_gfx && userq_gfx_funcs->detect_and_reset) {
> > +                       r =3D userq_gfx_funcs->detect_and_reset(adev, A=
MDGPU_RING_TYPE_GFX);
> > +                       if (r) {
> > +                               gpu_reset =3D true;
> > +                               goto gpu_reset;
> > +                       }
> > +               }
> > +       }
> > +
> > +gpu_reset:
> > +       if (gpu_reset)
> > +               amdgpu_userq_gpu_reset(adev);
> > +
> > +       return r;
> > +}
>
> > Why split these into two functions?  I think it would be more
> efficient to just have a single function
> (amdgpu_userq_detect_and_reset()) that works at the device level and chec=
ks to see what types of user queues are present and then calls
> detect_and_reset() for each queue type that is present and then have that=
 function update the queue state of all queues that are hung.
> Then just call this function in all the places we call preempt or unmap. =
 E.g.,
>
> > amdgpu_userq_detect_and_reset()
> idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>     /* evict, unmap, */
> }
>
> > We probably also need some way to determine whether the queue reset
> was successful or not because we ultimately need to decide when to do a f=
ull adapter reset.
>
> Thanks Alex.
> You are right, I would revert the changes and call it everywhere we call =
preempt and unmap, including when preempt/unmap fails.

How about if we have a per device userq counter for each user queue
type.  It would get incremented when a queue is created and
decremented when it's destroyed.  Then we can just check the counters
and call detect_and_reset for all queue types where the counter is
non-0.  Update the state of any affected queues. Take all the locks.

Then do whatever preempt/umap is requested and update the queue state.

Then afterwards, call detect_and_reset() again with all the locks.

At this point we can do a full adapter reset if necessary.  I'm not
clear on how we determine whether we need to or not.

Alex

>
> Jesse
>
> >Hi Alex,
>
> For SDMA, preemption on the GFX12 always succeeds even if the SDMA queue =
is pending. Therefore, we must detect the hung queues before preempting/unm=
apping.
>
> For compute/GFX queues, the API does not detect the hung queues before pr=
eempting/unmapping.
> However, if a GFX/compute queue is hung, preemption will fail. After pree=
mption/unmapping fails, we call the detection and reset API, and MES resets=
 the unmapped queue.
>
> For this reason, I've split these into two functions.
>
> Thanks
> Jesse
>
>
> Alex
>
> > +
> >  static int
> >  amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
> >                           struct amdgpu_usermode_queue *queue) @@
> > -56,6 +154,7 @@ amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr=
 *uq_mgr,
> >         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> >                 r =3D userq_funcs->preempt(uq_mgr, queue);
> >                 if (r) {
> > +
> > + amdgpu_userq_detect_and_reset_gfx_compute(uq_mgr);
> >                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> >                 } else {
> >                         queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> > @@ -72,17 +171,21 @@ amdgpu_userqueue_restore_helper(struct amdgpu_user=
q_mgr *uq_mgr,
> >         struct amdgpu_device *adev =3D uq_mgr->adev;
> >         const struct amdgpu_userq_funcs *userq_funcs =3D
> >                 adev->userq_funcs[queue->queue_type];
> > +       bool gpu_reset =3D false;
> >         int r =3D 0;
> >
> >         if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
> >                 r =3D userq_funcs->restore(uq_mgr, queue);
> >                 if (r) {
> >                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > +                       gpu_reset =3D true;
> >                 } else {
> >                         queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> >                 }
> >         }
> >
> > +       if (gpu_reset)
> > +               amdgpu_userq_gpu_reset(adev);
> >         return r;
> >  }
> >
> > @@ -98,11 +201,14 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr =
*uq_mgr,
> >         if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
> >                 (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
> >                 r =3D userq_funcs->unmap(uq_mgr, queue);
> > -               if (r)
> > +               if (r) {
> > +
> > + amdgpu_userq_detect_and_reset_gfx_compute(uq_mgr);
> >                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > -               else
> > +               } else {
> >                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> > +               }
> >         }
> > +
> >         return r;
> >  }
> >
> > @@ -113,16 +219,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *=
uq_mgr,
> >         struct amdgpu_device *adev =3D uq_mgr->adev;
> >         const struct amdgpu_userq_funcs *userq_funcs =3D
> >                 adev->userq_funcs[queue->queue_type];
> > +       bool gpu_reset =3D false;
> >         int r =3D 0;
> >
> >         if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> >                 r =3D userq_funcs->map(uq_mgr, queue);
> >                 if (r) {
> >                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> > +                       gpu_reset =3D true;
> >                 } else {
> >                         queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> >                 }
> >         }
> > +
> > +       if (gpu_reset)
> > +               amdgpu_userq_gpu_reset(adev);
> > +
> >         return r;
> >  }
> >
> > @@ -361,6 +473,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
ue_id)
> >                 amdgpu_bo_unreserve(queue->db_obj.obj);
> >         }
> >         amdgpu_bo_unref(&queue->db_obj.obj);
> > +       amdgpu_userq_detect_and_reset_sdma(uq_mgr);
> >         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> >         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
> >         mutex_unlock(&uq_mgr->userq_mutex);
> > @@ -734,6 +847,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_=
mgr)
> >         int queue_id;
> >         int ret =3D 0, r;
> >
> > +       amdgpu_userq_detect_and_reset_sdma (uq_mgr);
> >         /* Try to unmap all the queues in this process ctx */
> >         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> >                 r =3D amdgpu_userqueue_preempt_helper(uq_mgr, queue); @=
@
> > -746,6 +860,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
> >         return ret;
> >  }
> >
> > +void amdgpu_userq_reset_work(struct work_struct *work) {
> > +       struct amdgpu_device *adev =3D container_of(work, struct amdgpu=
_device,
> > +                                                 userq_reset_work);
> > +       struct amdgpu_reset_context reset_context;
> > +
> > +       memset(&reset_context, 0, sizeof(reset_context));
> > +
> > +       reset_context.method =3D AMD_RESET_METHOD_NONE;
> > +       reset_context.reset_req_dev =3D adev;
> > +       reset_context.src =3D AMDGPU_RESET_SRC_USERQ;
> > +       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> > +       /*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> > +
> > +       amdgpu_device_gpu_recover(adev, NULL, &reset_context); }
> > +
> >  static int
> >  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)  { @@
> > -772,22 +903,19 @@ void  amdgpu_userq_evict(struct amdgpu_userq_mgr
> > *uq_mgr,
> >                    struct amdgpu_eviction_fence *ev_fence)  {
> > -       int ret;
> >         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> >         struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
> > +       struct amdgpu_device *adev =3D uq_mgr->adev;
> > +       int ret;
> >
> >         /* Wait for any pending userqueue fence work to finish */
> >         ret =3D amdgpu_userq_wait_for_signal(uq_mgr);
> > -       if (ret) {
> > -               drm_file_err(uq_mgr->file, "Not evicting userqueue, tim=
eout waiting for work\n");
> > -               return;
> > -       }
> > +       if (ret)
> > +               dev_err(adev->dev, "Not evicting userqueue, timeout
> > + waiting for work\n");
> >
> >         ret =3D amdgpu_userq_evict_all(uq_mgr);
> > -       if (ret) {
> > -               drm_file_err(uq_mgr->file, "Failed to evict userqueue\n=
");
> > -               return;
> > -       }
> > +       if (ret)
> > +               dev_err(adev->dev, "Failed to evict userqueue\n");
> >
> >         /* Signal current eviction fence */
> >         amdgpu_eviction_fence_signal(evf_mgr, ev_fence); @@ -828,6
> > +956,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> > *userq_mgr)
> >
> >         mutex_lock(&adev->userq_mutex);
> >         mutex_lock(&userq_mgr->userq_mutex);
> > +       amdgpu_userq_detect_and_reset_sdma(userq_mgr);
> >         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> >                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
> >                 amdgpu_userq_unmap_helper(userq_mgr, queue); @@
> > -861,10 +990,13 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
> >         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >                 cancel_delayed_work_sync(&uqm->resume_work);
> >                 mutex_lock(&uqm->userq_mutex);
> > +               amdgpu_userq_detect_and_reset_sdma(uqm);
> >                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
> > -                       if (r)
> > +                       if (r) {
> > +
> > + amdgpu_userq_detect_and_reset_gfx_compute(uqm);
> >                                 ret =3D r;
> > +                       }
> >                 }
> >                 mutex_unlock(&uqm->userq_mutex);
> >         }
> > @@ -917,13 +1049,16 @@ int amdgpu_userq_stop_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
> >         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> >                 cancel_delayed_work_sync(&uqm->resume_work);
> >                 mutex_lock(&uqm->userq_mutex);
> > +               amdgpu_userq_detect_and_reset_sdma(uqm);
> >                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> >                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX=
) ||
> >                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COM=
PUTE)) &&
> >                             (queue->xcp_id =3D=3D idx)) {
> >                                 r =3D amdgpu_userq_unmap_helper(uqm, qu=
eue);
> > -                               if (r)
> > +                               if (r) {
> > +
> > + amdgpu_userq_detect_and_reset_gfx_compute(uqm);
> >                                         ret =3D r;
> > +                               }
> >                         }
> >                 }
> >                 mutex_unlock(&uqm->userq_mutex); @@ -965,3 +1100,57 @@
> > int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device=
 *adev,
> >         mutex_unlock(&adev->userq_mutex);
> >         return ret;
> >  }
> > +
> > +void amdgpu_userq_pre_reset(struct amdgpu_device *adev) {
> > +       const struct amdgpu_userq_funcs *userq_funcs;
> > +       struct amdgpu_usermode_queue *queue;
> > +       struct amdgpu_userq_mgr *uqm, *tmp;
> > +       int queue_id;
> > +
> > +       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list)=
 {
> > +               cancel_delayed_work_sync(&uqm->resume_work);
> > +               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> > +                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPP=
ED) {
> > +                               amdgpu_userq_wait_for_last_fence(uqm, q=
ueue);
> > +                               userq_funcs =3D adev->userq_funcs[queue=
->queue_type];
> > +                               userq_funcs->unmap(uqm, queue);
> > +                               /* just mark all queues as hung at this=
 point.
> > +                                * if unmap succeeds, we could map agai=
n
> > +                                * in amdgpu_userq_post_reset() if vram=
 is not lost
> > +                                */
> > +                               queue->state =3D AMDGPU_USERQ_STATE_HUN=
G;
> > +                               amdgpu_userq_fence_driver_force_complet=
ion(queue);
> > +                       }
> > +               }
> > +       }
> > +}
> > +
> > +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool
> > +vram_lost) {
> > +       /* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> > +        * at this point, we should be able to map it again
> > +        * and continue if vram is not lost.
> > +        */
> > +       struct amdgpu_userq_mgr *uqm;
> > +       struct amdgpu_usermode_queue *queue;
> > +       const struct amdgpu_userq_funcs *userq_funcs;
> > +       int queue_id, r =3D 0;
> > +
> > +       list_for_each_entry(uqm, &adev->userq_mgr_list, list) {
> > +               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> > +                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG=
 && !vram_lost) {
> > +                               userq_funcs =3D adev->userq_funcs[queue=
->queue_type];
> > +                               /* re-map queue */
> > +                               r =3D userq_funcs->map(uqm, queue);
> > +                               if (r) {
> > +                                       dev_err(adev->dev, "Failed to r=
emap queue %d\n", queue_id);
> > +                                       continue;
> > +                               }
> > +                               queue->state =3D AMDGPU_USERQ_STATE_MAP=
PED;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return r;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > index 9fa0d1a88d71..e68bb144b26f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> > @@ -138,4 +138,9 @@ int
> > amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *ade=
v,  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device=
 *adev,
> >                                                    u32 idx);
> >
> > +void amdgpu_userq_reset_work(struct work_struct *work);
> > +
> > +void amdgpu_userq_pre_reset(struct amdgpu_device *adev); int
> > +amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> > +
> >  #endif
> > --
> > 2.49.0
> >
