Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B597AC5AE5A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 14:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6605310E55B;
	Wed, 28 Aug 2024 14:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SyIal+8d";
	dkim-atps=neutral
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4E510E55B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 14:52:40 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-498d3b9c911so169506137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724856759; x=1725461559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeSCoe33+9xd6QKhKCI6FCvqSJ8xKOj1JOnIZgAgOjs=;
 b=SyIal+8dnH0CEkXH+OoK/3dWMpFmEJAtmWRY4VnjWXb2MhaSqkH/FQ4vHG6dHlORAz
 yjAlT+8EpR1xWYp40oHLay0U55QAUIhZUORo8vDFZN+qVJADRVlGEQOdQCpPt6OeL2Z2
 6A1k4/k7wp2lf1+XlWOURjZlM3VSz+pCixWH3B54Z30hsOu67tZkUzYI3E6dkpAgersa
 FRcz5WxMoGilsCU7XpJZIMu6acqt5MSkwCDDFkonytyf13Qx/7MUT3/t3G+sQat1D7Wf
 iUynSex6GRc3r+dL38gUvR8crOCqCGFwkS7vTL1eNJgFvX7rbGwjfTDHZ6/Wh3u426rJ
 YV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724856759; x=1725461559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeSCoe33+9xd6QKhKCI6FCvqSJ8xKOj1JOnIZgAgOjs=;
 b=S7FP3YSxkDZ6XanViYBti9jx496ZqMVQiftWH4DbLHVvafIIpMaxIN2OO2bPwtdjVn
 NXxH/skMl/9L2+G/qhMRayGpeAXNsjX+ccZ1IX9BIAGY0fktdpmBZK9c13nJ0h1bXdPp
 MbtqoeI3M8gfaxZJ6zNLZwwDD/WoICKpDyPXgx9sdx5JZlQ3aPXZ8T1fq0qG+oPwF94B
 7TL0uXKNiUp5ZuBMDYzfnLzgyk54ZG1i5U2r5Im5b3NwBsVjGvNJaGGmKjWuu9GVbl+E
 CGmmsvZoq9Lcg4GHw4TaIYCCpkByNFUFmwwKnKj9Ci/jea/bix9qehDlo3KaQOd/gMM8
 pN7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVgQ0GiJ3iRDjdiK+6q08nXfpTEWjetvSAotr7YhQoKQjquRhTGQOrMNJ1vymoWTASWXCCWZr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziBBSC3nl8i7WJXrC6FoKFXYIrsPV3J6OpG/QYvpyJPcHHzCfv
 m5+u9bGOq32020J87yqTF7KNacyzjsrBN5D50ZdexsqJkAthvUbrI0u4boM/2CfyHvR5BTWnJku
 N6zxd7W6DVcHJHCUQmyuQtZYH0bqApQ==
X-Google-Smtp-Source: AGHT+IFhCKpqtbHNO7TcJK41yZM1oEusnX45AgA4EvLz8RrLp/J/Zj/w9k0KTwqdaAR4s5jiym2Vmn8wMwBFLM5TWig=
X-Received: by 2002:a05:6102:2ac9:b0:498:ea30:6c17 with SMTP id
 ada2fe7eead31-498f47c92edmr11483087137.5.1724856758660; Wed, 28 Aug 2024
 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240828052004.2889428-1-Prike.Liang@amd.com>
 <4de381fb-71c5-4364-993b-27666b7cfa29@amd.com>
 <DS7PR12MB6005781273A8FE737BDF3BB0FB952@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005781273A8FE737BDF3BB0FB952@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Aug 2024 10:52:26 -0400
Message-ID: <CADnq5_OxCkvoRCib_Y6xB38Eoy9zhvW0XFfG0ppAHr8OerqD0g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
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

On Wed, Aug 28, 2024 at 3:17=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Wednesday, August 28, 2024 2:45 PM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> > <Le.Ma@amd.com>
> > Subject: Re: [PATCH v4] drm/amdgpu/gfx9.4.3: Implement compute pipe res=
et
> >
> >
> >
> > On 8/28/2024 10:50 AM, Prike Liang wrote:
> > > Implement the compute pipe reset, and the driver will fallback to pip=
e
> > > reset when queue reset fails.
> > > The pipe reset only deactivates the queue which is scheduled in the
> > > pipe, and meanwhile the MEC engine will be reset to the firmware
> > > _start pointer. So, it seems pipe reset will cost more cycles than th=
e
> > > queue reset; therefore, the driver tries to recover by doing queue
> > > reset first.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 139
> > > ++++++++++++++++++++----
> > >  2 files changed, 124 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > index e28c1ebfa98f..d4d74ba2bc27 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
> > >                                uint32_t queue_type, uint32_t me_id,
> > >                                uint32_t pipe_id, uint32_t queue_id,
> > >                                uint32_t xcc_id, uint32_t vmid);
> > > +   int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> > > +                              uint32_t queue_type, uint32_t me,
> > > +                              uint32_t pipe, uint32_t queue,
> > > +                              uint32_t xcc_id);
> >
> > Missed the addition of this callback in earlier review.
> >
> > The implementation below -
> >       Doesn't use kiq to do a pipe reset. It's looks like a direct hard=
ware
> > reset. Passing a kiq_ring here or defining a callback in kiq  functions=
 doesn't
> > look required unless a pipe reset through kiq is available for other ha=
rdware
> > generations.
> >
> >       Also, it uses pipe reset as a fallback when queue unmap fails. So=
 the
> > callback eventually is not used.
> >
> > Is this really needed? For the below implementation, it seems a private
> > function like gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring) is goo=
d
> > enough.
> >
> > Thanks,
> > Lijo
> >
> This KIQ callback is implemented following Alex's software design spec. M=
aybe original design purpose was design to support the compute user queue.
> But IIRC the compute user queue pipe reset has a similar implementation i=
n the KFD and may not reuse this callback.
>
> Hi, @Deucher, Alexander Could you help comment here and do we need to imp=
lement pipe reset in the KIQ callback?

I had originally thought we should use KIQ, but after further
discussions with the HW and FW teams, we ended up using MMIO so I'm
fine to drop the KIQ callback.

Alex


>
> Thanks,
> Prike
> > > +
> > >     /* Packet sizes */
> > >     int set_resources_size;
> > >     int map_queues_size;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > > index 2067f26d3a9d..f47b55d6f673 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > > @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct
> > amdgpu_device *adev,
> > >                             struct amdgpu_cu_info *cu_info);
> > >  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev,
> > > int xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct
> > > amdgpu_device *adev, int xcc_id);
> > > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring=
,
> > > +                                   uint32_t queue_type, uint32_t me,
> > > +                                   uint32_t pipe, uint32_t queue,
> > > +                                   uint32_t xcc_id);
> > >
> > >  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_rin=
g,
> > >                             uint64_t queue_mask)
> > > @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs
> > gfx_v9_4_3_kiq_pm4_funcs =3D {
> > >     .kiq_query_status =3D gfx_v9_4_3_kiq_query_status,
> > >     .kiq_invalidate_tlbs =3D gfx_v9_4_3_kiq_invalidate_tlbs,
> > >     .kiq_reset_hw_queue =3D gfx_v9_4_3_kiq_reset_hw_queue,
> > > +   .kiq_reset_hw_pipe =3D gfx_v9_4_3_kiq_reset_hw_pipe,
> > >     .set_resources_size =3D 8,
> > >     .map_queues_size =3D 7,
> > >     .unmap_queues_size =3D 6,
> > > @@ -3466,6 +3471,101 @@ static void gfx_v9_4_3_emit_wave_limit(struct
> > amdgpu_ring *ring, bool enable)
> > >     }
> > >  }
> > >
> > > +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_=
t
> > me,
> > > +                           uint32_t pipe, uint32_t queue,
> > > +                           uint32_t xcc_id)
> > > +{
> > > +   int i, r;
> > > +   /* make sure dequeue is complete*/
> > > +   gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > > +   mutex_lock(&adev->srbm_mutex);
> > > +   soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id))=
;
> > > +   for (i =3D 0; i < adev->usec_timeout; i++) {
> > > +           if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> > regCP_HQD_ACTIVE) & 1))
> > > +                   break;
> > > +           udelay(1);
> > > +   }
> > > +   if (i >=3D adev->usec_timeout)
> > > +           r =3D -ETIMEDOUT;
> > > +   else
> > > +           r =3D 0;
> > > +   soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> > > +   mutex_unlock(&adev->srbm_mutex);
> > > +   gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > > +
> > > +   return r;
> > > +
> > > +}
> > > +
> > > +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev=
)
> > > +{
> > > +   /*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as
> > well.*/
> > > +   if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) &&
> > > +                   adev->gfx.mec_fw_version >=3D 0x0000009b)
> > > +           return true;
> > > +   else
> > > +           dev_warn_once(adev->dev, "Please use the latest MEC
> > version to see
> > > +whether support pipe reset\n");
> > > +
> > > +   return false;
> > > +}
> > > +
> > > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring=
,
> > > +                                   uint32_t queue_type, uint32_t me,
> > > +                                   uint32_t pipe, uint32_t queue,
> > > +                                   uint32_t xcc_id)
> > > +{
> > > +   struct amdgpu_device *adev =3D kiq_ring->adev;
> > > +   uint32_t reset_pipe, clean_pipe;
> > > +   int r;
> > > +
> > > +   if (!gfx_v9_4_3_pipe_reset_support(adev))
> > > +           return -EINVAL;
> > > +
> > > +   gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > > +   mutex_lock(&adev->srbm_mutex);
> > > +
> > > +   reset_pipe =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id),
> > regCP_MEC_CNTL);
> > > +   clean_pipe =3D reset_pipe;
> > > +
> > > +   if (me =3D=3D 1) {
> > > +           switch (pipe) {
> > > +           case 0:
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME1_PIPE0_RESET, 1=
);
> > > +                   break;
> > > +           case 1:
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME1_PIPE1_RESET, 1=
);
> > > +                   break;
> > > +           case 2:
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME1_PIPE2_RESET, 1=
);
> > > +                   break;
> > > +           case 3:
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME1_PIPE3_RESET, 1=
);
> > > +                   break;
> > > +           default:
> > > +                   break;
> > > +           }
> > > +   } else {
> > > +           if (pipe)
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME2_PIPE1_RESET, 1=
);
> > > +           else
> > > +                   reset_pipe =3D REG_SET_FIELD(reset_pipe,
> > CP_MEC_CNTL,
> > > +                                              MEC_ME2_PIPE0_RESET, 1=
);
> > > +   }
> > > +
> > > +   WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> > reset_pipe);
> > > +   WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> > clean_pipe);
> > > +   mutex_unlock(&adev->srbm_mutex);
> > > +   gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > > +
> > > +   r =3D gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> > > +   return r;
> > > +}
> > > +
> > >  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> > >                             unsigned int vmid)
> > >  {
> > > @@ -3473,7 +3573,7 @@ static int gfx_v9_4_3_reset_kcq(struct
> > amdgpu_ring *ring,
> > >     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
> > >     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > >     unsigned long flags;
> > > -   int r, i;
> > > +   int r;
> > >
> > >     if (amdgpu_sriov_vf(adev))
> > >             return -EINVAL;
> > > @@ -3495,26 +3595,25 @@ static int gfx_v9_4_3_reset_kcq(struct
> > amdgpu_ring *ring,
> > >     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > >
> > >     r =3D amdgpu_ring_test_ring(kiq_ring);
> > > -   if (r)
> > > -           return r;
> > > -
> > > -   /* make sure dequeue is complete*/
> > > -   amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> > > -   mutex_lock(&adev->srbm_mutex);
> > > -   soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0,
> > GET_INST(GC, ring->xcc_id));
> > > -   for (i =3D 0; i < adev->usec_timeout; i++) {
> > > -           if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> > > -                   break;
> > > -           udelay(1);
> > > -   }
> > > -   if (i >=3D adev->usec_timeout)
> > > -           r =3D -ETIMEDOUT;
> > > -   soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> > > -   mutex_unlock(&adev->srbm_mutex);
> > > -   amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
> > >     if (r) {
> > > -           dev_err(adev->dev, "fail to wait on hqd deactive\n");
> > > -           return r;
> > > +           dev_err(adev->dev, "kiq ring test failed after ring: %s q=
ueue
> > reset\n",
> > > +                           ring->name);
> > > +           goto pipe_reset;
> > > +   }
> > > +
> > > +   r =3D gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring-
> > >queue, ring->xcc_id);
> > > +   if (r)
> > > +           dev_err(adev->dev, "fail to wait on hqd deactive and will=
 try
> > pipe
> > > +reset\n");
> > > +
> > > +pipe_reset:
> > > +   if(r) {
> > > +           r =3D gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs-
> > >type,
> > > +                                           ring->me, ring->pipe,
> > > +                                           ring->queue, ring->xcc_id=
);
> > > +           dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->na=
me,
> > > +                           r ? "failed" : "successfully");
> > > +           if (r)
> > > +                   return r;
> > >     }
> > >
> > >     r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
