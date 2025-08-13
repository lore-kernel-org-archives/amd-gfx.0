Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCFC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 16:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5BA10E0CF;
	Wed, 13 Aug 2025 16:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1c5TGMa";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A62210E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 16:51:23 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-242abc28161so10777475ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755103883; x=1755708683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MremXB2AdNe553kVFJOIodgor4PWh65eDC1t5NHoBo=;
 b=W1c5TGMaLdSbYSEx7KCDhyd2IbnO3rzZ8z0ndcuP+DhvW0W4SE0yPw48S0+o+SHNY8
 gpvL2KYL3kj9kfMqJSxhI31KzXe48l5viWpewzDXS3nIq9nzF+YqRMFP+BTq1U714UIG
 xxGwObyBt6kWVPZeb07fRRzXLPWjEdShI9mPAESohc2Hxjy1l6Mc355GG7zqzt+2OEtp
 7PJoBCUgvRnRnzUj948nmAWDs0aACOmJeUObCHSEweht7dggQSc++zzyx7We61Py+EMh
 VZrCAuPVS7Y+BDJNeHtWkWZccfbZBYMFA+nitlB1XtSry8ORjQehHxLe+rBQxwQrsIo8
 RXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755103883; x=1755708683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MremXB2AdNe553kVFJOIodgor4PWh65eDC1t5NHoBo=;
 b=NWmkeQZFs6prIQqh0h/mke4amfGCT6omFLX3i2Jf0b4Wh+omi+BYdbPVk5MWUoWCcm
 CzSKTGfu+DOfJpqn7BfUtGGRNcdSkwpFHqv4mRzIlUqc+G5l48jVRzN3ciO5qhftZn3a
 ADn5kedHJQ5QKodIPnE3MH4fhXumguVMbJXBSo3OvDZJNBDvsCJtgbGtRZlYjjd+WQLR
 53wcy3w9Mu3nT/nKtUm/JFm04ydA+5kaKK1ZV8qdCFCAPlszVeDDX1nacMK7QPcqCB9u
 TZiNkoRetkto4OfIKICVAK9AWFMhSJG581C96GFpqIYOi0vjTN/5SQYnvUKqoOqVTPpX
 GjIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEvdo5qxN9Y1rQJXG5LkrxQazUVv0yGDaVN/sY2fkCONokIzx9JkismJDfHDQyEWZshdxfbF90@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzUcztqiUJ4OpbqydvqPP+qwB9HKUt2v58n/uMQ2qiOgGSbGuH
 +JBbDSnbCJEWRhrqLkKWuZ/aISBKNWv8uFMEKqY2hnslEceTHzsVKosspGu/xQCnn+hIZGcRyuZ
 V25UlkL8IZo4Y4Il412Gsxj2MGhthMgDcyQ==
X-Gm-Gg: ASbGncsNkHYIZNoLlZnr08fbvNCBFkQzjk+rfKuMxUFZkD0PWJAEJS7sJr931qwQkzP
 y19YLvvvlEdjqvH19V4J843MH50NoDY0cVPXU0KOe+RqTHAUBxpK34bl4OAuB/R4XvogDkQbr3f
 nxdnGtBkFpHApyb9spcLGskpEXCIU9TzAAyEhJ2dZDj5BIJSUJrf9lkomq4Zy7lLOSfuia3WAUE
 JN2DB6mpwwBiTbC+Q==
X-Google-Smtp-Source: AGHT+IH/YDmNSRjR02Cs77j14fVjUd+W3HwWpxJgFL6LdHst8j/oeVH0ECFo5Ez7QxAGW6Fl/11jXTNdxbfS+2ptHXA=
X-Received: by 2002:a17:902:f548:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-2430d0b0f77mr27343335ad.1.1755103882968; Wed, 13 Aug 2025
 09:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
In-Reply-To: <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 12:51:11 -0400
X-Gm-Features: Ac12FXxSBZQz8JtPXDQEhfg20u9A9iCVsz2POCP59N-S15q5NzqNOQ-0f8lDadw
Message-ID: <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: "Wu, David" <davidwu2@amd.com>
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

On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2@amd.com> wrote=
:
>
> Hi Alex,
>
> The addition of  total_submission_cnt should work - in that
> it is unlikely to have a context switch right after the begin_use().
> The suggestion of moving it inside the lock (which I prefer in case someo=
ne
> adds more before the lock and not reviewed thoroughly)
>   - up to you to decide.
>
> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>
> Thanks,
> David
> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> > If there are multiple instances of the VCN running,
> > we may end up switching the video profile while another
> > instance is active because we only take into account
> > the current instance's submissions.  Look at all
> > outstanding fences for the video profile.
> >
> > v2: drop early exit in begin_use()
> > v3: handle possible race between begin_use() work handler
> >
> > Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling"=
)
> > Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40 ++++++++++++------------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >   2 files changed, 21 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.c
> > index 9a76e11d1c184..593c1ddf8819b 100644
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
> > @@ -436,18 +442,18 @@ static void amdgpu_vcn_idle_work_handler(struct w=
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
> > +             if (adev->vcn.workload_profile_active && !total_fences &&
> > +                 !atomic_read(&adev->vcn.total_submission_cnt)) {
> >                       r =3D amdgpu_dpm_switch_power_profile(adev, PP_SM=
C_POWER_PROFILE_VIDEO,
> >                                                           false);
> >                       if (r)
> > @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring=
 *ring)
> >       int r =3D 0;
> >
> >       atomic_inc(&vcn_inst->total_submission_cnt);
> > +     atomic_inc(&adev->vcn.total_submission_cnt);
> move this addition down inside the mutex lock
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
> move to here:
>                 atomic_inc(&adev->vcn.total_submission_cnt);
> I think this should work for multiple instances.

Why does this need to be protected by the mutex?

Alex

>
> David
> >       if (!adev->vcn.workload_profile_active) {
> >               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> > @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >       }
> >       mutex_unlock(&adev->vcn.workload_profile_mutex);
> >
> > -pg_lock:
> >       mutex_lock(&vcn_inst->vcn_pg_lock);
> >       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >
> > @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ri=
ng)
> >               atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submis=
sion_cnt);
> >
> >       atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
> > +     atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >
> >       schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> >                             VCN_IDLE_TIMEOUT);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.h
> > index b3fb1d0e43fc9..febc3ce8641ff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >
> >       uint16_t inst_mask;
> >       uint8_t num_inst_per_aid;
> > +     atomic_t                total_submission_cnt;
> >
> >       /* IP reg dump */
> >       uint32_t                *ip_dump;
>
