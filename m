Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1D2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 13:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D085610E7E1;
	Tue, 20 Aug 2024 13:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DmzvhC2b";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60F810E7E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 13:50:42 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-7b5aacae4f0so611015a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724161842; x=1724766642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYG2jr/6zY4jV0E0QeQRjXw7K+nail4YQS+AIxhhkCU=;
 b=DmzvhC2bOrULanOBQucgud/zocP9LKSB/i/mgtwVoOQ+5z10TIjVurQsnKGtd3XMMG
 cY0w8zbUWUd+KY9tos2n+0uirf1Bzy56HSN4XTar75yWH9cZmITgpjhKLon2KuTbuqEv
 a+vlIut//K4IX6P+hN+JXHToFhq8QmuY0r+QOBmib3tCJRCOThmlZUnnymtJudsrVc6y
 WZicYi0fu39QNkk1Fjtsu0CitUzoEnQeWW2vBCKaVlhOs3Eo6GoO8riYvZO+OzJHf4Nt
 loOwSIfRkd/Mq0R08TDNsonIQQ7LcGROXwf+TOoeCkGSnL84j+5MZhkCiDCnQxChr80G
 +sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724161842; x=1724766642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYG2jr/6zY4jV0E0QeQRjXw7K+nail4YQS+AIxhhkCU=;
 b=QLCYloKcoI2tknJmBWeLSkufvcmNLis4Fldk4Ao1DoeRtSsGr2y+15ChgHrg8TLT+3
 RId7lamUKc9WbNn+BIocBnWanqDmPq3E6hM4ymq0Rq2Hz8+a2BAMKyPxV74AJGKA2oLi
 IYldFtglrmXxRBw0Kn7ee0xa1NM8P/+as4R8doT91E23nDwYbQAZfUUJPLFLH9mrJPYG
 xLdI80wCsn0V6LZK5rUP+lifkKREjDYFmm4uGAEDXZ555FNA9ceBd0YyFJraBq0F8gIn
 AiSnl01TXMk1MjS0o6f5/p+nMbzlyNe4ScB33/ZRJ4DVqheP7kktZUD6TxS9Lrm+0KFu
 5hWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8gNhrLDlVJiJQ54cR8ZZZNvrinbIijYgx0fRV53k9daOM4oN6Fn2tF+ek+1Te13w1cgFfIAG9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfPTyF/65SBFtjf3h3MKFQf312MTMiCyaA+p/jZf2Cqq014RzY
 5cK6kKjxReFr4SY0ZNv8wB7JCc+mS/RcuTwAGsT9EYtGVHOth8v/6C1eA4oUIMWqX7j5Q6O2VMB
 n2E9aO8BNYVqwfHXzmPLyp+l0Bxad3A==
X-Google-Smtp-Source: AGHT+IHlUxGeRxn6G5rLRY73FIR5pWmYtZDAvynVhuRLnTZxYw9Ab2AOji4ZUu73iADcMlqLY+xTIN/GysqNE15pbfo=
X-Received: by 2002:a17:902:e742:b0:202:535a:78f1 with SMTP id
 d9443c01a7336-202535a8300mr32075205ad.4.1724161841865; Tue, 20 Aug 2024
 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240820103144.2831848-1-Prike.Liang@amd.com>
 <690d4517-a0c2-4951-ad7a-dbada7274f3a@amd.com>
In-Reply-To: <690d4517-a0c2-4951-ad7a-dbada7274f3a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Aug 2024 09:50:29 -0400
Message-ID: <CADnq5_OrCZ6y2W4QqUvh2kd=w2cTiMkG0v66SAhW9pei6RsFMg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Le.Ma@amd.com
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

On Tue, Aug 20, 2024 at 8:43=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 8/20/2024 4:01 PM, Prike Liang wrote:
> > Implement the compute pipe reset and driver will
> > fallback to pipe reset when queue reset failed.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> > v2: Convert the GC logic instance to physical instance in the
> >     register accessing process and
>
> > use the dev_* print to specify the failed device.
>
> This is not fully done, marked below.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153 ++++++++++++++++++++----
> >  2 files changed, 138 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index e28c1ebfa98f..d4d74ba2bc27 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
> >                                  uint32_t queue_type, uint32_t me_id,
> >                                  uint32_t pipe_id, uint32_t queue_id,
> >                                  uint32_t xcc_id, uint32_t vmid);
> > +     int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> > +                                uint32_t queue_type, uint32_t me,
> > +                                uint32_t pipe, uint32_t queue,
> > +                                uint32_t xcc_id);
> > +
> >       /* Packet sizes */
> >       int set_resources_size;
> >       int map_queues_size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index 2067f26d3a9d..ab9d5adbbfe8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_de=
vice *adev,
> >                               struct amdgpu_cu_info *cu_info);
> >  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, i=
nt xcc_id);
> >  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,=
 int xcc_id);
> > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> > +                                     uint32_t queue_type, uint32_t me,
> > +                                     uint32_t pipe, uint32_t queue,
> > +                                     uint32_t xcc_id);
> >
> >  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
> >                               uint64_t queue_mask)
> > @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm=
4_funcs =3D {
> >       .kiq_query_status =3D gfx_v9_4_3_kiq_query_status,
> >       .kiq_invalidate_tlbs =3D gfx_v9_4_3_kiq_invalidate_tlbs,
> >       .kiq_reset_hw_queue =3D gfx_v9_4_3_kiq_reset_hw_queue,
> > +     .kiq_reset_hw_pipe =3D gfx_v9_4_3_kiq_reset_hw_pipe,
> >       .set_resources_size =3D 8,
> >       .map_queues_size =3D 7,
> >       .unmap_queues_size =3D 6,
> > @@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct a=
mdgpu_ring *ring, bool enable)
> >       }
> >  }
> >
> > +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t =
me,
> > +                             uint32_t pipe, uint32_t queue,
> > +                             uint32_t xcc_id)
> > +{
> > +     int i, r;
> > +     /* make sure dequeue is complete*/
> > +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > +     mutex_lock(&adev->srbm_mutex);
> > +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id))=
;
> > +     for (i =3D 0; i < adev->usec_timeout; i++) {
> > +             if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_AC=
TIVE) & 1))
> > +                     break;
> > +             udelay(1);
> > +     }
> > +     if (i >=3D adev->usec_timeout)
> > +             r =3D -ETIMEDOUT;
> > +     else
> > +             r =3D 0;
> > +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> > +     mutex_unlock(&adev->srbm_mutex);
> > +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > +
> > +     return r;
> > +
> > +}
> > +
> > +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
> > +{
> > +
> > +     if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
> > +             DRM_WARN_ONCE("MEC firmware version too old, please use F=
W no older than 155!\n");
> > +             return false;
> > +     }
>
> This path will be taken GCv9.4.3 and GCv9.4.4. GCv9.4.4 has a different
> FW version. If FW is not yet ready for 9.4.4, better check that and
> return false for that.
>
> > +
> > +     return true;
> > +}
> > +
> > +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> > +                                     uint32_t queue_type, uint32_t me,
> > +                                     uint32_t pipe, uint32_t queue,
> > +                                     uint32_t xcc_id)
> > +{
> > +     struct amdgpu_device *adev =3D kiq_ring->adev;
> > +     uint32_t reset_pipe, clean_pipe;
> > +     int r;
> > +
> > +     if (!gfx_v9_4_3_pipe_reset_support(adev))
> > +             return -EINVAL;
> > +
> > +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> > +     mutex_lock(&adev->srbm_mutex);
> > +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id))=
;
> > +
> > +     reset_pipe =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_C=
NTL);
> > +     clean_pipe =3D reset_pipe;
> > +
> > +     if (me =3D=3D 1) {
> > +             switch (pipe) {
> > +             case 0:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE0_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE0_RESET, 0=
);
> > +                     break;
> > +             case 1:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE1_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE1_RESET, 0=
);
> > +                     break;
> > +             case 2:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE2_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE2_RESET, 0=
);
> > +                     break;
> > +             case 3:
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE3_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME1_PIPE3_RESET, 0=
);
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     } else {
> > +             if (pipe) {
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME2_PIPE1_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME2_PIPE1_RESET, 0=
);
> > +             } else {
> > +                     reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME2_PIPE0_RESET, 1=
);
> > +                     clean_pipe =3D REG_SET_FIELD(clean_pipe, CP_MEC_C=
NTL,
> > +                                                MEC_ME2_PIPE0_RESET, 0=
);
> > +             }
> > +     }
> > +
> > +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe=
);
> > +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe=
);
> > +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> > +     mutex_unlock(&adev->srbm_mutex);
> > +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> > +
> > +     r =3D gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> > +     return r;
> > +}
> > +
> >  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> >                               unsigned int vmid)
> >  {
> > @@ -3473,7 +3587,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_rin=
g *ring,
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
> >       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> >       unsigned long flags;
> > -     int r, i;
> > +     int r;
> >
> >       if (amdgpu_sriov_vf(adev))
> >               return -EINVAL;
> > @@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_r=
ing *ring,
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > -     if (r)
> > -             return r;
> > -
> > -     /* make sure dequeue is complete*/
> > -     amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> > -     mutex_lock(&adev->srbm_mutex);
> > -     soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET=
_INST(GC, ring->xcc_id));
> > -     for (i =3D 0; i < adev->usec_timeout; i++) {
> > -             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> > -                     break;
> > -             udelay(1);
> > -     }
> > -     if (i >=3D adev->usec_timeout)
> > -             r =3D -ETIMEDOUT;
> > -     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> > -     mutex_unlock(&adev->srbm_mutex);
> > -     amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
> >       if (r) {
> > -             dev_err(adev->dev, "fail to wait on hqd deactive\n");
> > -             return r;
> > +             DRM_ERROR("kiq ring test failed after ring: %s queue rese=
t\n",
> > +                             ring->name);
>
> dev_err here
>
> > +             goto pipe_reset;
> > +     }
> > +
> > +     r =3D gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->que=
ue, ring->xcc_id);
> > +     if (r)
> > +             dev_err(adev->dev,"fail to wait on hqd deactive and will =
try pipe reset\n");
> > +
> > +pipe_reset:
> > +     if(r) {
> > +             r =3D gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs-=
>type,
> > +                                             ring->me, ring->pipe,
> > +                                             ring->queue, ring->xcc_id=
);
>
> A side question about this - what's the expectation about the other
> queue(s) on this pipe at this point? Are they expected to be also hung
> at this point?

According to the firmware team, the pipe will only have one queue
executing on it at a given time, so resetting the pipe will only reset
that queue.

Alex

>
> In short, checking if this should be done from a higher level code or
> from here itself. Ex:
>
> Queue reset -> Failed -> Try dequeue of all other active queues -> Do a
> pipe reset
>
> > +             DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
> > +                             r ? "failed" : "successfully");
> dev_info here
>
> Thanks,
> Lijo
>
> > +             if (r)
> > +                     return r;
> >       }
> >
> >       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
