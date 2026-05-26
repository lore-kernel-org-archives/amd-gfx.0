Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34802CD5BD5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 22:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD17E10E57E;
	Tue, 26 May 2026 22:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OK8ND/09";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C41010E57E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 22:34:34 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-57537257fbbso529987e0c.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 15:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779834873; cv=none;
 d=google.com; s=arc-20240605;
 b=kpuN+xZtzCiAhaG7zcTtflXMhPzmE7wTV4mA6SeSdJcGXJQrMDV2cB9A4BABjXfImI
 wwFBPDZBcZ1F7V47U8/u/ZGNzUNgKIkayGxhTEtCqDlCJnTzK2Ejr2n2LvkoaAMZavSl
 viHuGE3d/+BRBBYt53Ufyvp+zSML5Ri/Agww+HP13wJ4epzRlyZhtOdv/qTZHnd8VCkB
 jViwFtOx2ZUKrxEiLCOVVMSA+HIHDI0OheSjmpEV8CeYgzicCRRVfN3z9ZTqB0bNxfGF
 TDiSZ0BFm2Dq13KvqARCf0mpaOvUEKYNVCnJu26PTfJ7lES40ZbCBkZ2uQXYyLqfUok2
 Y1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dPabpmCE2UU65JgGNUFjweHroo/9ZSY2KVAsgPCr3O8=;
 fh=eEiSA1K7Z+IpjGnK5wFSvl2L40Kl55Dh4D5nQTypJJ8=;
 b=F5AvczcGqtCiZvI6aUhekhz0wPb+DgCw6g0Z4vY4ikhJ9vYmEZK9eV1mbG7JRP6GwT
 q/J+hbONo+vngYSPX6eaeecybk18bAuMtpd3R/2L4Uif4cRVgChqnMS55maHm3g+EIzG
 +lqdTzCYf1k5mgUQGKjR94jUHM04uZJMfl/AOQBc6XGaVjeM3ropwXCMCdYHXst2RJX9
 peCGX7xftb5T7TO1WmflrtQmmMcn1z+XgyAcTPGZi8kf/FkWUV4wCKTTbKDqq39XAHgb
 pHL70NE81KxQXJkbN6ZeA7AMTguTrI1MIpXHGX84uykX7ZLo2DnzGtty72kKa8pjrffK
 +yRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779834873; x=1780439673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPabpmCE2UU65JgGNUFjweHroo/9ZSY2KVAsgPCr3O8=;
 b=OK8ND/09qMSHMRRggSYGFkxbGoJ+FwhO61AIopUD6QLKaqzEa08uqPzj4zVFd1DlMN
 8qdEXnTtJ2xFvlDFAP43wc5Zl3hz1uthLc0nEZ2DO6UJuDO/LJOZAbWWqWnn7jk7kDVw
 xkHXkXdaz0m3kzpSskgelKiSUaUzTYT2yjA4xqJpcJX+uELyfvQZrfADQzu/4t6EXqqv
 ViS0t6I843exxOapZpJS4JlFC1cnd747tpzx0N7BrYgak7waxVAV8jjSXk53focqSvrO
 1+coQd2g87Wc3tCd7cMorCQAt2v4HaJb3IpMRmAZYvpjDb9rn1ipSyfHAQeNCdQCV6RA
 R/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779834873; x=1780439673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dPabpmCE2UU65JgGNUFjweHroo/9ZSY2KVAsgPCr3O8=;
 b=hc4KC5jO2uW8zpsBsGbRMNWa43x7egv8F+rPq1HuaxwAVfXchrIvr8UOTdq/Okc7hf
 R1jlhLFSkECHA+T5CE+g+zcmKjuz4Dw+GG04FGXWHx/5ULwRbyuiGAH1t0PfgiKvGC7d
 dEeyUlDSYk9PyOhJujzIzdaOt4DvIhhwAr0039OIHyOxmQUa2r+1TPecijlTKlo+eMiA
 3knpMPwG2EMHjjzb6U/nTbPW9cYT4NrupBgfAuaqMiWfmCebjbCd9ZUqu+XMBI8z315L
 ADkzNeghDCZtIk9k461S0bRLse0YplsQIGwZGQxNL0z5DtixMqAqvgUMUqeBX97j0Gj9
 3+Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WzUikMZhUgjASi23Ic4skaSqlHSM6Gbt/5pbdwcDoF8LYo/k7HxWo1h5ycxyIFukvTtmyV+ft@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9IyYBE/lLR40jemH6vjHXnEw3kK1hZZFJ+vUkd+6QEHOJVekb
 x/H/LYQqf5On8yA0dslejy7L5XY4dPflA/DFnDh8fYVqW7HuILSGsRU/BV32CE+B0yT5MGnrZmb
 mMU5a2CVH9HhJBRPtzCYdt7WkJUvW3ZM=
X-Gm-Gg: Acq92OGouFp2y8dUkgLARJvhg8P40EhjNqaWE4FU12paETfdxHfMevSfDS+UGGLBUQm
 QJm/EuAePij+WZUdpy3yxy81gINc46Ods9aRTZfpp5PXH3LBuV2/31ZcFvgNMat0IBZvgy95LfQ
 iv4N7qKAw3SHolzqBjTjOwoe2JealHb+yud08LU02mG3b9C33S3jKb9aCQyZ8zRfngDrmXL6fjP
 DtW4FMth8g6JS1dJSl0cF3F/yQFJyHm5Ckbo6iDlmKNIFcpHKNvm/uPi2nyQjBd0bYVq1FIfi1J
 qeQEQw13pZLYJDQa6F9jALaXA5Z5Fb/UtvJbyBIVTrvotToBVn90PM4eXjsMUgrtnkIg5U/KIqj
 nV7lU
X-Received: by 2002:a05:6102:2a64:b0:65a:fe89:c8e7 with SMTP id
 ada2fe7eead31-67c7e6e2b88mr3943673137.4.1779834872842; Tue, 26 May 2026
 15:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-38-alexander.deucher@amd.com>
 <DM4PR12MB5152A80D107241390960382AE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152A80D107241390960382AE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 18:34:20 -0400
X-Gm-Features: AVHnY4Knmh-PruTUJRkZdgnaXG_diwlvvgTtXQhaMpXuTV0QTlUtkyU_ArAWaiI
Message-ID: <CADnq5_OFSG2H+Q_qLQ4+fEzV=SHNk5-g0KyEN_1BZVnn_aUUEA@mail.gmail.com>
Subject: Re: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle MES
 compute resets
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>, 
 "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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

On Mon, May 25, 2026 at 4:34=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Friday, May 22, 2026 8:21 AM
> > To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, =
Amber
> > <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> > Shaoyun <Shaoyun.Liu@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> > <Jesse.Zhang@amd.com>
> > Subject: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle ME=
S
> > compute resets
> >
> > Add helpers to handle MES compute queue resets when multiple queues are
> > affected.  Can you be used by both KGD and KFD.
> >
> > v2: sqaush in updates
> > v3: squash in userq updates
> >
> > Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> > Co-developed-by: Amber Lin <Amber.Lin@amd.com>
> > Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> > Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 140 +++++++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   9 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   6 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   2 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   2 +
> >  6 files changed, 160 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index de8c85dfc4c62..960d192076de8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -34,6 +34,7 @@
> >  #include "amdgpu_xcp.h"
> >  #include "amdgpu_xgmi.h"
> >  #include "amdgpu_mes.h"
> > +#include "mes_userqueue.h"
> >  #include "nvd.h"
> >
> >  /* delay 0.1 second to enable gfx off feature */ @@ -1976,15 +1977,25 =
@@ int
> > amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
> >                              bool use_mmio)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > +     bool reinit_queue;
> >       int r;
> >
> [Zhang, Jesse(Jie)]  The *_pipe_reset_enable` property is always 0. Shoul=
d set the flag ?

It should only be set when we do pipe reset in MES firmware.  For now,
driver is doing it via MMIO.

Alex

>
> > +     if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) &&
> > +         adev->mes.compute_pipe_reset_enabled)
> > +             reinit_queue =3D true;
> > +     else if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) &&
> > +              adev->mes.gfx_pipe_reset_enabled)
> > +             reinit_queue =3D true;
> > +     else
> > +             reinit_queue =3D use_mmio;
> > +
> >       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >
> >       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_m=
mio, 0);
> >       if (r)
> >               return r;
> >
> > -     if (use_mmio) {
> > +     if (reinit_queue) {
> >               r =3D amdgpu_mes_unmap_legacy_queue(adev, ring,
> >                                                 RESET_QUEUES, 0, 0, 0);
> >               if (r)
> > @@ -2159,6 +2170,133 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device
> > *adev)
> >       }
> >  }
> >
> > +static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device
> > *adev,
> > +                                               struct amdgpu_ring *gui=
lty_ring) {
> > +     struct amdgpu_ring *ring;
> > +     int i;
> > +
> > +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > +             ring =3D &adev->gfx.compute_ring[i];
> > +             if (ring =3D=3D guilty_ring)
> > +                     continue;
> > +             drm_sched_wqueue_start(&ring->sched);
> > +     }
> > +}
> > +
> > +static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device
> > *adev,
> > +                                              struct amdgpu_ring *guil=
ty_ring) {
> > +     struct amdgpu_ring *ring;
> > +     int i;
> > +
> > +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > +             ring =3D &adev->gfx.compute_ring[i];
> > +             if (ring =3D=3D guilty_ring)
> > +                     continue;
> > +             drm_sched_wqueue_stop(&ring->sched);
> > +     }
> > +}
> > +
> > +static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
> > +                                 struct amdgpu_ring *guilty_ring,
> > +                                 unsigned int db)
> > +{
> > +     bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
> > +     struct amdgpu_fence *fence;
> > +     struct amdgpu_ring *ring;
> > +     int i, r;
> > +
> > +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > +             ring =3D &adev->gfx.compute_ring[i];
> > +             if (ring =3D=3D guilty_ring)
> > +                     continue;
> > +             if (ring->doorbell_index =3D=3D db) {
> > +                     fence =3D amdgpu_ring_find_guilty_fence(ring);
> > +                     r =3D amdgpu_gfx_mes_reset_queue(ring, 0, fence,
> > use_mmio);
> > +                     if (r)
> > +                             return r;
> > +                     break;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> > +                              struct amdgpu_ring *ring,
> > +                              struct amdgpu_fence *guilty_fence,
> > +                              struct amdgpu_usermode_queue *uq,
> > +                              unsigned int *hung_queue_count)
> > +{
> > +     struct amdgpu_mes_hung_queue_hqd_info *hqd_info =3D
> > +             (struct amdgpu_mes_hung_queue_hqd_info *)
> > +             &adev->gfx.mec.mes_hung_db_array[adev-
> > >mes.hung_queue_hqd_info_offset];
> > +     int i, r, pipe, queue, queue_type;
> > +     unsigned int num_hung =3D 0;
> > +     bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
> > +
> > +     guard(mutex)(&adev->gfx.mec.reset_mutex);
> > +     /* stop the drm schedulers for all compute queues */
> > +     amdgpu_gfx_reset_stop_compute_scheds(adev, ring);
> > +     /* suspend all will determine which queues are hung.
> > +      * reset detect will return the array of bad queue doorbells
> > +      */
> > +     r =3D amdgpu_mes_suspend(adev, 0);
> > +     /* if suspend all success, it should no hang queue */
> > +     if (!r)
> > +             /* always reset the KCQ/userq since we need to signal the=
 fence
> > +              * and we could be stuck in a loop which is preemptable.
> > +              */
> > +             goto fence_reset;
> > +     r =3D amdgpu_mes_detect_and_reset_hung_queues(adev,
> > AMDGPU_RING_TYPE_COMPUTE,
> > +                                                 true, &num_hung, adev=
-
> > >gfx.mec.mes_hung_db_array, 0);
> > +     if (r)
> > +             goto out;
> > +     if (hung_queue_count)
> > +             *hung_queue_count =3D num_hung;
> > +
> > +fence_reset:
> > +     /* reset the queue this came from if specified */
> > +     if (ring) {
> > +             r =3D amdgpu_gfx_mes_reset_queue(ring, 0, guilty_fence, u=
se_mmio);
> > +             if (r)
> > +                     goto out;
> > +     }
> > +     if (uq) {
> > +             r =3D mes_userq_reset(uq);
> > +             if (r)
> > +                     goto out;
> > +     }
> > +     for (i =3D 0; i < num_hung; i++) {
> > +             pipe =3D hqd_info[i].pipe_index;
> > +             queue =3D hqd_info[i].queue_index;
> > +             queue_type =3D hqd_info[i].queue_type;
> > +
> > +             /* reset any KCQs */
> > +             r =3D amdgpu_gfx_reset_mes_kcq(adev, ring,
> > +                                          adev->gfx.mec.mes_hung_db_ar=
ray[i]);
> > +             if (r)
> > +                     goto out;
> > +             /* reset any KFD queues */
> > +             r =3D amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, =
pipe,
> > queue,
> > +                                               adev-
> > >gfx.mec.mes_hung_db_array[i]);
> > +             if (r)
> > +                     goto out;
> > +             /* reset KGD user queues */
> > +             r =3D mes_userq_reset_queue(adev, uq, queue_type, pipe, q=
ueue,
> > +                                       adev->gfx.mec.mes_hung_db_array=
[i]);
> > +             if (r)
> > +                     goto out;
> > +     }
> > +out:
> > +     /* resume all will enable the non-hung queues */
> > +     amdgpu_mes_resume(adev, 0);
> > +     if (!r)
> > +             amdgpu_gfx_reset_start_compute_scheds(adev, ring);
> > +
> > +     return r;
> > +}
> > +
> >  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> >                                     unsigned int cleaner_shader_size)  =
{ diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index f9175faa64ab7..8ef2ef394e9af 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -36,6 +36,8 @@
> >  #include "amdgpu_ring_mux.h"
> >  #include "amdgpu_xcp.h"
> >
> > +struct amdgpu_usermode_queue;
> > +
> >  /* GFX current status */
> >  #define AMDGPU_GFX_NORMAL_MODE                       0x00000000L
> >  #define AMDGPU_GFX_SAFE_MODE                 0x00000001L
> > @@ -117,6 +119,8 @@ struct amdgpu_mec {
> >       u32 num_queue_per_pipe;
> >       void                    *mqd_backup[AMDGPU_MAX_COMPUTE_RINGS *
> > AMDGPU_MAX_GC_INSTANCES];
> >       bool use_mmio_for_reset;
> > +     u32 *mes_hung_db_array;
> > +     struct mutex            reset_mutex;
> >  };
> >
> >  struct amdgpu_mec_bitmap {
> > @@ -642,6 +646,11 @@ int amdgpu_gfx_poison_consumption_handler(struct
> > amdgpu_device *adev,  bool amdgpu_gfx_is_master_xcc(struct amdgpu_devic=
e
> > *adev, int xcc_id);  int amdgpu_gfx_sysfs_init(struct amdgpu_device *ad=
ev);  void
> > amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
> > +int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> > +                              struct amdgpu_ring *ring,
> > +                              struct amdgpu_fence *guilty_fence,
> > +                              struct amdgpu_usermode_queue *uq,
> > +                              unsigned int *hung_queue_count);
> >  void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
> >               void *ras_error_status,
> >               void (*func)(struct amdgpu_device *adev, void *ras_error_=
status, diff
> > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 370e8d159b6fe..ec4d9a1e029a7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -252,6 +252,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >               }
> >       }
> >
> > +     adev->gfx.mec.mes_hung_db_array =3D
> > +             kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
> > +                     sizeof(u32), GFP_KERNEL);
> > +
> >       return 0;
> >
> >  error_doorbell:
> > @@ -279,6 +283,8 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
> >       int i;
> >       int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
:
> > 1;
> >
> > +     kfree(adev->gfx.mec.mes_hung_db_array);
> > +
> >       amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
> >                             &adev->mes.event_log_gpu_addr,
> >                             &adev->mes.event_log_cpu_addr); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > index 1a214c274ad02..32e01eb311c3b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1908,6 +1908,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block)
> >       adev->gfx.me.use_mmio_for_reset =3D false;
> >       adev->gfx.mec.use_mmio_for_reset =3D true;
> >
> > +     mutex_init(&adev->gfx.mec.reset_mutex);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 5beb0ae980d0b..247bcb7034e19 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -1606,6 +1606,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block)
> >       adev->gfx.me.use_mmio_for_reset =3D false;
> >       adev->gfx.mec.use_mmio_for_reset =3D true;
> >
> > +     mutex_init(&adev->gfx.mec.reset_mutex);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > index 033f15e21ad33..7f8e43130bd28 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -1287,6 +1287,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block)
> >       if (r)
> >               return r;
> >
> > +     mutex_init(&adev->gfx.mec.reset_mutex);
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.54.0
>
