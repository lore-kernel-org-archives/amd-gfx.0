Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E43CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 13:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F53B10E713;
	Wed, 13 Aug 2025 13:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSX9vLlI";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27C610E713
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:45:47 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-75f7fc34691so478437b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755092747; x=1755697547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6x4YIC07dmzEr5D2/10usj1YKceNgTKMQuj01HJV00w=;
 b=KSX9vLlI0yWUgEzZvAk522/L9YXHFpcZIlB0SDbQ2+R0SzqKm3mSLseiGdmFnK7MXZ
 Vl3e9FOFKIELfCW+wWH86hZ/syx3XK3E37DyNtfqBVoSx5cm3DjKWPF6mMYU4myBHE8z
 mO/CfudYqQALAtxkecGvwMyPITh5mzTs7OFuQFZyiY9Ggk1hVqdOnmFb8otguNoUjnb3
 eNwIC27IbIMAVYlPmrZkJu6HwYyz1trDMcFnRp8LliZx9GZKc7g3rOkBSe/Ro2kz8kWK
 B+hr4K+1mx+mWgkQBVnm9x4gQFX6hyhZwLPfR+oIlGIGns/kjXR4JL8yRtlb2p0VIIbL
 2Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755092747; x=1755697547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6x4YIC07dmzEr5D2/10usj1YKceNgTKMQuj01HJV00w=;
 b=oREU/ByEOA5zvtkh9L3nEWFiTlJQP08yzT5GviYy3LXjv5yvSjJcNV36fA4oOxgF7l
 owAHaduJU2QmS5vS59tZqWBdVmnOPTviDYUpiDlBBBHbXyQuke3+28buCGlzKhX9hBlG
 1zQ3ZmlMG1dXMTPbZ4sy+b1LBGTiMLgwumIahwavoZ2sr3nsHhP+cE7OP7D1u7oiWQ+i
 EgVNB2DLniIJ+aqM1Vtcky03qKF87xpCahrVA/dHDtWP/30TTjfjjciLrwsF0CH1I10p
 swr+6IV9xObYAlTht5nrzdRmiMvITUIehUgXHujbg2XOuNLmgr3irKbj4C7knfrI+WFN
 fGAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMjHFijHDf+WIB16R53vly310w1fxdl7vz0gQelqYuMJXoJp/R8aIh4K5GzM+PCuSCyBy7HNQi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk9m5Pq/m689ow+ExEA3lI34dJYwt5f17/IUcmxQ1Jf74Lod2R
 rqc3oXZMTQhERtuootXlwiPN+64D6tjLn9/Bzvy0NSci37gQ0bgS3GXYUK7vE/2iPddMmhWmg+r
 7pvkAOcW5AsFqiIkx2FQNb3OHPH2R4DeWpA==
X-Gm-Gg: ASbGncsMzsH4fAoTUimX+nuQmPk51862vzyKH5PD3h0psLeFfD7SAOrbtdYW/SU/h5r
 onfdllB88PbyW0dkYf47hdXQWP0mR5/PHXyBquR3e+aG3Ta1XRLg1lhMkpifHYfEEDJc7bfVsFx
 7QXUVqq/xfrKMg8TjCd7rWUGomcbpm8GICbiUAhEhl5LOYLZ8kiavyRVlXFSdtFAYrluY3CcPkl
 qo7ytiQ3oOf9qZfCg==
X-Google-Smtp-Source: AGHT+IHgZSEikHSUvh/08+E3FE3OR+PKPAwsVSrwYzIXGeMzWvJdM5e7eRHf4k7fWQ+zFRzQlewkayOsetZRA9KdMFQ=
X-Received: by 2002:a17:902:e80b:b0:240:63bd:2701 with SMTP id
 d9443c01a7336-2430d1c29d4mr24277975ad.6.1755092747250; Wed, 13 Aug 2025
 06:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250812205816.1773798-1-alexander.deucher@amd.com>
 <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
In-Reply-To: <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 09:45:35 -0400
X-Gm-Features: Ac12FXyaDw-AGjS0OzzDyxfS1iZbmkjZeKSHAoKus_Nizs1DJjcJceozWPs-tgw
Message-ID: <CADnq5_NSvatcrG8qJL_be1e2XRqKiCZd0PdcWdDbxYxK6qMNug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
To: David Wu <davidwu2@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Sathishkumar S <sathishkumar.sundararaju@amd.com>
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

On Tue, Aug 12, 2025 at 7:08=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> Hi Alex,
>
> still have a concern - the fence or submission_cnt could increase in
> begin_use but idle handler
> has finished counting it (as 0) so it could also power off vcn.

Ok, I think that is possible.  Will send an updated patch to handle
that case as well.

Alex

>
> David
>
> On 2025-08-12 16:58, Alex Deucher wrote:
> > If there are multiple instances of the VCN running,
> > we may end up switching the video profile while another
> > instance is active because we only take into account
> > the current instance's submissions.  Look at all
> > outstanding fences for the video profile.
> >
> > v2: drop early exit in begin_use()
> >
> > Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling"=
)
> > Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++------------=
-
> >   1 file changed, 17 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.c
> > index 9a76e11d1c184..fd127e9461c89 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct w=
ork_struct *work)
> >       struct amdgpu_vcn_inst *vcn_inst =3D
> >               container_of(work, struct amdgpu_vcn_inst, idle_work.work=
);
> >       struct amdgpu_device *adev =3D vcn_inst->adev;
> > -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
> > -     unsigned int i =3D vcn_inst->inst, j;
> > +     unsigned int total_fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =
=3D {0};
> > +     unsigned int i, j;
> >       int r =3D 0;
> >
> > -     if (adev->vcn.harvest_config & (1 << i))
> > +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >               return;
> >
> > -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> > -             fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_=
enc[j]);
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> > +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> > +
> > +             for (j =3D 0; j < v->num_enc_rings; ++j)
> > +                     fence[i] +=3D amdgpu_fence_count_emitted(&v->ring=
_enc[j]);
> > +             fence[i] +=3D amdgpu_fence_count_emitted(&v->ring_dec);
> > +             total_fences +=3D fence[i];
> > +     }
> >
> >       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> > -         !adev->vcn.inst[i].using_unified_queue) {
> > +         !vcn_inst->using_unified_queue) {
> >               struct dpg_pause_state new_state;
> >
> >               if (fence[i] ||
> > @@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct w=
ork_struct *work)
> >               else
> >                       new_state.fw_based =3D VCN_DPG_STATE__UNPAUSE;
> >
> > -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
> > +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
> >       }
> >
> > -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> > -     fences +=3D fence[i];
> > -
> > -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> > +     if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submi=
ssion_cnt)) {
> > +             /* This is specific to this instance */
> >               mutex_lock(&vcn_inst->vcn_pg_lock);
> >               vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> >               mutex_unlock(&vcn_inst->vcn_pg_lock);
> >               mutex_lock(&adev->vcn.workload_profile_mutex);
> > -             if (adev->vcn.workload_profile_active) {
> > +             /* This is global and depends on all VCN instances */
> > +             if (adev->vcn.workload_profile_active && !total_fences) {
> >                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> >                                                           false);
> >                       if (r)
> > @@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring =
*ring)
> >
> >       cancel_delayed_work_sync(&vcn_inst->idle_work);
> >
> > -     /* We can safely return early here because we've cancelled the
> > -      * the delayed work so there is no one else to set it to false
> > -      * and we don't care if someone else sets it to true.
> > -      */
> > -     if (adev->vcn.workload_profile_active)
> > -             goto pg_lock;
> > -
> >       mutex_lock(&adev->vcn.workload_profile_mutex);
> >       if (!adev->vcn.workload_profile_active) {
> >               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> > @@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >       }
> >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> >
> > -pg_lock:
> >       mutex_lock(&vcn_inst->vcn_pg_lock);
> >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >
