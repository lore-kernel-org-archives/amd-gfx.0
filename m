Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014E9CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 14:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F9110E730;
	Wed, 13 Aug 2025 14:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BkX0aAZO";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E60A10E735
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 14:03:46 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-242fe051121so2587405ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755093826; x=1755698626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qXDYYz4YZtrS/2PUtRKthhep/lS56YimKtW+MUBWdE=;
 b=BkX0aAZOL//WflGi5YnRmeSqBFP+dmhmCpGPnMKoe8k1QRhqtRtnJCoLcEd6vkFDoD
 6wD3XGbjDIzSawM3OQGO7VNGYrp1Jorh/SomXDC3q99nj7ISxxuoE1yk3jjBLuJMLZEj
 VTuLyNXLWf5RImHGOHHvF8I6I8gE/4XyPA7S3FyiZXbqEPKufmIQxN1gZ3X9YADBnwy3
 XpbF/szpkjXLj7zFf9v/l8T2zPwka4CzaPng25z03+270DjlKDCXg/tuKe8tIGzYHIFA
 fmO1GdhD1m074FVJ8LgOxTbUzLY8ctVFZC2eISbEym91kw2t3k9ct+5UEW5zdxmhpFWO
 FE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755093826; x=1755698626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qXDYYz4YZtrS/2PUtRKthhep/lS56YimKtW+MUBWdE=;
 b=pOz8ws8iMi5cWzZke3OvfkjZV3G5pZOZsel3Fp8eqLrkxEvu1vE5bZJAETPGCtynV1
 BjDIqCvqI/eg9T4tCjybGGGHyPdLGs9yrGEqFJNVebEsZ5toN6z2K7KJ456Mpf6RUFhD
 gKeczi0gATWqdJsVkj7uY6XMk9E3n87sN3nTc+UUPCmBSwRnPisO+MgkE+zqWIEMIhrV
 y2LLFN1pLwMrvJjizuYmjzDzhe/UrK+E4NSc7MgDVCcgCGG6BmqyS8E76BCrmpB45nBl
 jfq/4EKNG1vQ63tpONtsuJ/YM4GFu++mmBv/WPSHs5vgQxsIjkKK1deHlnjsBxqfe3c7
 El1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoh2g+FavVzM+S3UnmI2aE4eDJ3W/yfUKEVRbIQqmtFl7R/M6Rev1vP+hLoVsETKniNfL4oahN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzofjLlSVX+cLG4WM6eaoSLGhSTIBXTrZrG10LR4i0tdcuu7XCw
 jp4RTRNEM7Y6Y7yckE9c/YSE0CMk/lYbLCUQjU+SwApbNTD7/bSR3xqRb0elGn58xRONnJlYC55
 HvaQVE/uqmvE88FmgDIjdr9FoFD7Qy0Q=
X-Gm-Gg: ASbGnct926squNwgiwEQifoCSM9fNJZPE7VqvjtgWsoAEYl9ZYElPbo5goAfLrY3DQF
 FpCv7C2QSwYyKdlvXQV60JbDHqZz/Yaz0MvaQWuPFueqIqhIme9KsGmWvI6DHJkOW/Wi79rexyu
 DxJLE//KE82fJXybeWVttUBH2VKLesxOZsYQtNDB4VRCfEgWvTHg/oUW0CGtjA0tq9Knps66KN7
 vwyMW4=
X-Google-Smtp-Source: AGHT+IHvEMUbzwhrubV4ElBTJisRIdFceD+ztYHev00Xh3m5QAtb/FrTFK/ZRSC2FuYGY2cFw82GWQBWCOLOfEoF+dw=
X-Received: by 2002:a17:902:f688:b0:240:5bde:5353 with SMTP id
 d9443c01a7336-2430d20648bmr24245615ad.7.1755093825598; Wed, 13 Aug 2025
 07:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250812205816.1773798-1-alexander.deucher@amd.com>
 <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
 <CADnq5_NSvatcrG8qJL_be1e2XRqKiCZd0PdcWdDbxYxK6qMNug@mail.gmail.com>
 <bb315859-fd69-40a6-7efb-e9647261ea41@amd.com>
In-Reply-To: <bb315859-fd69-40a6-7efb-e9647261ea41@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 10:03:33 -0400
X-Gm-Features: Ac12FXzXedJrqDifFenuoxnnmgbKyD-V5kW1INYsj0jNcYSsD4YpFsr5PvKbUCI
Message-ID: <CADnq5_NLAyTtGoRP_xq4ntOHbXTF+u=yxCQ618dQkSiW2-c6=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
To: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
Cc: David Wu <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Aug 13, 2025 at 9:55=E2=80=AFAM Sundararaju, Sathishkumar
<sathishkumar.sundararaju@amd.com> wrote:
>
>
> On 8/13/2025 7:15 PM, Alex Deucher wrote:
> > On Tue, Aug 12, 2025 at 7:08=E2=80=AFPM David Wu <davidwu2@amd.com> wro=
te:
> >> Hi Alex,
> >>
> >> still have a concern - the fence or submission_cnt could increase in
> >> begin_use but idle handler
> >> has finished counting it (as 0) so it could also power off vcn.
> > Ok, I think that is possible.  Will send an updated patch to handle
> > that case as well.
>
> cancel_delayed_work_sync(&vcn_inst->idle_work) at the top of begin_use
> covers this situation.
>
> So there is no idle handler for this instance anymore after this call
> completes, but the additional checks are okay to have.

There are separate work handers for each instance.  What could happen
is that the instance 0 work handler is running when begin_use() is
running on instance 1.  The instance 1 begin_use() sees that the video
profile is already enabled.  The instance 0 work handler sees that
total_fences is 0 and disables the video profile because the fence for
instance 1 has not been emitted yet.  It won't be emitted until after
begin_use() completes.  The total_submission_cnt covers that period of
time (between begin_ring and end_ring until the actual fence is
emitted).

Alex

>
> Regards,
>
> Sathish
>
> >
> > Alex
> >
> >> David
> >>
> >> On 2025-08-12 16:58, Alex Deucher wrote:
> >>> If there are multiple instances of the VCN running,
> >>> we may end up switching the video profile while another
> >>> instance is active because we only take into account
> >>> the current instance's submissions.  Look at all
> >>> outstanding fences for the video profile.
> >>>
> >>> v2: drop early exit in begin_use()
> >>>
> >>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handlin=
g")
> >>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++---------=
----
> >>>    1 file changed, 17 insertions(+), 20 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vcn.c
> >>> index 9a76e11d1c184..fd127e9461c89 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct=
 work_struct *work)
> >>>        struct amdgpu_vcn_inst *vcn_inst =3D
> >>>                container_of(work, struct amdgpu_vcn_inst, idle_work.w=
ork);
> >>>        struct amdgpu_device *adev =3D vcn_inst->adev;
> >>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D =
{0};
> >>> -     unsigned int i =3D vcn_inst->inst, j;
> >>> +     unsigned int total_fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES=
] =3D {0};
> >>> +     unsigned int i, j;
> >>>        int r =3D 0;
> >>>
> >>> -     if (adev->vcn.harvest_config & (1 << i))
> >>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >>>                return;
> >>>
> >>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >>> -             fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->rin=
g_enc[j]);
> >>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> >>> +
> >>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>> +                     fence[i] +=3D amdgpu_fence_count_emitted(&v->ri=
ng_enc[j]);
> >>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v->ring_dec);
> >>> +             total_fences +=3D fence[i];
> >>> +     }
> >>>
> >>>        /* Only set DPG pause for VCN3 or below, VCN4 and above will b=
e handled by FW */
> >>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>> +         !vcn_inst->using_unified_queue) {
> >>>                struct dpg_pause_state new_state;
> >>>
> >>>                if (fence[i] ||
> >>> @@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct=
 work_struct *work)
> >>>                else
> >>>                        new_state.fw_based =3D VCN_DPG_STATE__UNPAUSE;
> >>>
> >>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
> >>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
> >>>        }
> >>>
> >>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> >>> -     fences +=3D fence[i];
> >>> -
> >>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>> +     if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_sub=
mission_cnt)) {
> >>> +             /* This is specific to this instance */
> >>>                mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>                vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> >>>                mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>                mutex_lock(&adev->vcn.workload_profile_mutex);
> >>> -             if (adev->vcn.workload_profile_active) {
> >>> +             /* This is global and depends on all VCN instances */
> >>> +             if (adev->vcn.workload_profile_active && !total_fences)=
 {
> >>>                        r =3D amdgpu_dpm_switch_power_profile(adev, PP=
_SMC_POWER_PROFILE_VIDEO,
> >>>                                                            false);
> >>>                        if (r)
> >>> @@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_rin=
g *ring)
> >>>
> >>>        cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>
> >>> -     /* We can safely return early here because we've cancelled the
> >>> -      * the delayed work so there is no one else to set it to false
> >>> -      * and we don't care if someone else sets it to true.
> >>> -      */
> >>> -     if (adev->vcn.workload_profile_active)
> >>> -             goto pg_lock;
> >>> -
> >>>        mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>        if (!adev->vcn.workload_profile_active) {
> >>>                r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POW=
ER_PROFILE_VIDEO,
> >>> @@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring=
 *ring)
> >>>        }
> >>>        mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>
> >>> -pg_lock:
> >>>        mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >>>
