Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B490CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 20:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56BC10E040;
	Wed, 13 Aug 2025 20:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0ARfmwe";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0FE10E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 20:05:49 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-244581eab34so164735ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755115549; x=1755720349; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JLgU6uIss9+nfodQELGjgUOCfIefG+nNTSkcnF9hNa4=;
 b=N0ARfmweLlKNGOcwo4NxGIByKM3Wby/6VMzKDhO1fDU/B4W9GJ6lZtNBchd9v+V0CT
 4ATETQnVz9fpBzJc4+ov1JF9SZ2fIrRDBrx1ruvlWRaYW/6BQJcnZbBaHKvylJGsQ2Ls
 Oz4ALNvJlS2GHqaaaqodHnKHJaIQ5y9PVbSRAWg4xCt2bFc5Q08wiA8PE001yGelKiUe
 hJ2nXqhUb8Pa+2LZfwItfAsWjt/O/Z7bLqSd68uXZA5xzRDQWSJBInoYGIu04W2WVJxZ
 SwHhzroApXmjGv76NsIYKhnn+4A6pRbQnpYP3rlNBdlhOYhthDzIHWPZ2p6YFXEVAtZ2
 IgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755115549; x=1755720349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JLgU6uIss9+nfodQELGjgUOCfIefG+nNTSkcnF9hNa4=;
 b=LEV7PTHVitvJ05ARi3+ee8CSKj3zYFFHCtBgLI2aXOE7+lQGYYmKzRxiHARx02TL1Y
 5yq3H8QiDZ5dCV9ZrDozQqqbGCYOCp0pIbHQumzerM6lBFAPTRvkqE+7kJlEurWCxQb0
 u0wpUSmjQ557I9rvfJofQROSdoub7rwSt1H86/Junt/d/tik6xXdh2hm0tgygjJ0vbBr
 BZwRpm5gUu/6PhCtbqzlVAuGr499xwr90NZIYh85hqGYK0SSr7eOUnnpS5O6PF2MynA7
 fdm+pqbOY3tAaOMoOlFdHOBbUjzNyjZDmWebq1erWlxFWFoTHYVhPogRvT9WiBKyZFFz
 TCeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5OfxzwgHzOu6SFKD9rEV+NRzIxkhkyYC1SVszgUwPIwQriEMzEmTOgeN/NhlAkXjDyTHLIkll@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzW0A39RzygsC4ONWOnaOdL1TdKq+IXfCN8dKZ2VVd9VwyXpyhB
 HGjD3hz1KUZbYgEjSN9kbo7e42ILVy0DWshkwZ37VxPVRGwWLM42AuLIxwvRNbas+dLdzLowIND
 fIuA2U4zxX3nxSAmLlRHKmeeaH8KKKM0=
X-Gm-Gg: ASbGncuB5IA/vSgYTp8YZFsYs7ynirXfaH7akz0C4/oirCJdfQBHjGdFGNNpKZ8/4y0
 DhGce+zJnKoCPFQMDufpJDRHUkCHKsvTPaxpdx2qUJIxDjaH34amFms1mi4d/QfwNmFkqzpyLnC
 LNPeSljsereV1MbECPSta2j2121H9ciH6ip8SlOEn52TPXhbpouXkpJ2HP5bLOSlzc0cpjF3FER
 u8gpJAdNxQeH37EiQ==
X-Google-Smtp-Source: AGHT+IHFtSrXopC1yDQuRJaogDtjsRbNJ0A9p63Xnj77nexvvwlTXcajuQk91HzLs3Fj+XXpehDdUxTWHu/Op1FczN8=
X-Received: by 2002:a17:903:244e:b0:240:711f:2068 with SMTP id
 d9443c01a7336-244586d8ce7mr2057315ad.7.1755115548673; Wed, 13 Aug 2025
 13:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
In-Reply-To: <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 16:05:36 -0400
X-Gm-Features: Ac12FXyWyie7FuPHTJH6B38-sbnOcchFXEFI42NLxfMIN9ulLqRMw4P2AQEXtmA
Message-ID: <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
Cc: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000d1a85e063c44ae17"
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

--000000000000d1a85e063c44ae17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:23=E2=80=AFPM Sundararaju, Sathishkumar
<sathishkumar.sundararaju@amd.com> wrote:
>
> Hi Alex, Hi David,
>
> I see David's concern but his suggestion yet wont solve the problem,
> neither the current form , reason :-
>
> The emitted fence count and total submission count are fast transients
> which frequently become 0 in between video decodes (between jobs) even
> with the atomics and locks there can be a switch of video power profile,
> in the current form of patch that window is minimized, but still can
> happen if stress tested. But power state of any instance becoming zero

Can you explain how this can happen?  I'm not seeing it.

If it is possible, maybe it would be easier to just split the profile
and powergating into separate handlers.  The profile one would be
global and the powergating one would be per instance.  See the
attached patches.

Alex

> can be a sure shot indication of break in a video decode, the mistake in
> my patch was using per instance mutex, I should have used a common
> global mutex, then that covers the situation David is trying to bring out=
.
>
> Using one global vcn.pg_lock for idle and begin_use and using flags to
> track power state could help us totally avoid this situation.
>
> Regards,
>
> Sathish
>
> On 8/13/2025 11:46 PM, Wu, David wrote:
> > On 8/13/2025 12:51 PM, Alex Deucher wrote:
> >> On Wed, Aug 13, 2025 at 12:39=E2=80=AFPM Wu, David <davidwu2@amd.com> =
wrote:
> >>> Hi Alex,
> >>>
> >>> The addition of  total_submission_cnt should work - in that
> >>> it is unlikely to have a context switch right after the begin_use().
> >>> The suggestion of moving it inside the lock (which I prefer in case
> >>> someone
> >>> adds more before the lock and not reviewed thoroughly)
> >>>    - up to you to decide.
> >>>
> >>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >>>
> >>> Thanks,
> >>> David
> >>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
> >>>> If there are multiple instances of the VCN running,
> >>>> we may end up switching the video profile while another
> >>>> instance is active because we only take into account
> >>>> the current instance's submissions.  Look at all
> >>>> outstanding fences for the video profile.
> >>>>
> >>>> v2: drop early exit in begin_use()
> >>>> v3: handle possible race between begin_use() work handler
> >>>>
> >>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
> >>>> handling")
> >>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
> >>>> ++++++++++++-------------
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
> >>>>    2 files changed, 21 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> index 9a76e11d1c184..593c1ddf8819b 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> >>>> @@ -415,19 +415,25 @@ static void
> >>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>        struct amdgpu_vcn_inst *vcn_inst =3D
> >>>>                container_of(work, struct amdgpu_vcn_inst,
> >>>> idle_work.work);
> >>>>        struct amdgpu_device *adev =3D vcn_inst->adev;
> >>>> -     unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D=
 {0};
> >>>> -     unsigned int i =3D vcn_inst->inst, j;
> >>>> +     unsigned int total_fences =3D 0,
> >>>> fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0};
> >>>> +     unsigned int i, j;
> >>>>        int r =3D 0;
> >>>>
> >>>> -     if (adev->vcn.harvest_config & (1 << i))
> >>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
> >>>>                return;
> >>>>
> >>>> -     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >>>> -             fence[i] +=3D
> >>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
> >>>> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>>> +             struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> >>>> +
> >>>> +             for (j =3D 0; j < v->num_enc_rings; ++j)
> >>>> +                     fence[i] +=3D
> >>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
> >>>> +             fence[i] +=3D amdgpu_fence_count_emitted(&v->ring_dec)=
;
> >>>> +             total_fences +=3D fence[i];
> >>>> +     }
> >>>>
> >>>>        /* Only set DPG pause for VCN3 or below, VCN4 and above will
> >>>> be handled by FW */
> >>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >>>> -         !adev->vcn.inst[i].using_unified_queue) {
> >>>> +         !vcn_inst->using_unified_queue) {
> >>>>                struct dpg_pause_state new_state;
> >>>>
> >>>>                if (fence[i] ||
> >>>> @@ -436,18 +442,18 @@ static void
> >>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
> >>>>                else
> >>>>                        new_state.fw_based =3D VCN_DPG_STATE__UNPAUSE=
;
> >>>>
> >>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state)=
;
> >>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
> >>>>        }
> >>>>
> >>>> -     fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> >>>> -     fences +=3D fence[i];
> >>>> -
> >>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) =
{
> >>>> +     if (!fence[vcn_inst->inst] &&
> >>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
> >>>> +             /* This is specific to this instance */
> >>>>                mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>                vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> >>>>                mutex_unlock(&vcn_inst->vcn_pg_lock);
> >>>> mutex_lock(&adev->vcn.workload_profile_mutex);
> >>>> -             if (adev->vcn.workload_profile_active) {
> >>>> +             /* This is global and depends on all VCN instances */
> >>>> +             if (adev->vcn.workload_profile_active &&
> >>>> !total_fences &&
> >>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
> >>>>                        r =3D amdgpu_dpm_switch_power_profile(adev,
> >>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>> false);
> >>>>                        if (r)
> >>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>> amdgpu_ring *ring)
> >>>>        int r =3D 0;
> >>>>
> >>>>        atomic_inc(&vcn_inst->total_submission_cnt);
> >>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
> >>> move this addition down inside the mutex lock
> >>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
> >>>>
> >>>> -     /* We can safely return early here because we've cancelled the
> >>>> -      * the delayed work so there is no one else to set it to false
> >>>> -      * and we don't care if someone else sets it to true.
> >>>> -      */
> >>>> -     if (adev->vcn.workload_profile_active)
> >>>> -             goto pg_lock;
> >>>> -
> >>>>        mutex_lock(&adev->vcn.workload_profile_mutex);
> >>> move to here:
> >>> atomic_inc(&adev->vcn.total_submission_cnt);
> >>> I think this should work for multiple instances.
> >> Why does this need to be protected by the mutex?
> > hmm.. OK - no need and it is actually better before the mutex.
> > David
> >> Alex
> >>
> >>> David
> >>>>        if (!adev->vcn.workload_profile_active) {
> >>>>                r =3D amdgpu_dpm_switch_power_profile(adev,
> >>>> PP_SMC_POWER_PROFILE_VIDEO,
> >>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
> >>>> amdgpu_ring *ring)
> >>>>        }
> >>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
> >>>>
> >>>> -pg_lock:
> >>>>        mutex_lock(&vcn_inst->vcn_pg_lock);
> >>>>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> >>>>
> >>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
> >>>> *ring)
> >>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
> >>>>
> >>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
> >>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
> >>>>
> >>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> >>>>                              VCN_IDLE_TIMEOUT);
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> >>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
> >>>>
> >>>>        uint16_t inst_mask;
> >>>>        uint8_t num_inst_per_aid;
> >>>> +     atomic_t                total_submission_cnt;
> >>>>
> >>>>        /* IP reg dump */
> >>>>        uint32_t                *ip_dump;
> >

--000000000000d1a85e063c44ae17
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-vcn-fix-video-profile-race-condition-v4.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-vcn-fix-video-profile-race-condition-v4.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_meaeh0s21>
X-Attachment-Id: f_meaeh0s21

RnJvbSA4NTk5MTEyY2ZjOTRlOGJjZjQ3MmRiMzg2MjdmZDliMzI2MWIxMDdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMTIgQXVnIDIwMjUgMTE6Mzg6MDkgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdS92Y246IGZpeCB2aWRlbyBwcm9maWxlIHJhY2UgY29uZGl0aW9uICh2
NCkKCklmIHRoZXJlIGFyZSBtdWx0aXBsZSBpbnN0YW5jZXMgb2YgdGhlIFZDTiBydW5uaW5nLAp3
ZSBtYXkgZW5kIHVwIHN3aXRjaGluZyB0aGUgdmlkZW8gcHJvZmlsZSB3aGlsZSBhbm90aGVyCmlu
c3RhbmNlIGlzIGFjdGl2ZSBiZWNhdXNlIHdlIG9ubHkgdGFrZSBpbnRvIGFjY291bnQKdGhlIGN1
cnJlbnQgaW5zdGFuY2UncyBzdWJtaXNzaW9ucy4gIFNwbGl0IHRoZSBpbnRvCnR3byB3b3JrIGhh
bmRsZXJzLCBvbmUgZm9yIGdsb2JhbCBzdGF0ZSBhbmQgb25lIGZvcgpwZXIgaW5zdGFuY2Ugc3Rh
dGUuCgp2MjogZHJvcCBlYXJseSBleGl0IGluIGJlZ2luX3VzZSgpCnYzOiBoYW5kbGUgcG9zc2li
bGUgcmFjZSBiZXR3ZWVuIGJlZ2luX3VzZSgpIHdvcmsgaGFuZGxlcgp2NDogc3BsaXQgaW50byB0
d28gaGFuZGxlcnMsIG9uZSBnbG9iYWwgYW5kIG9uZSBwZXIgaW5zdGFuY2UKCkZpeGVzOiAzYjY2
OWRmOTJjODUgKCJkcm0vYW1kZ3B1L3ZjbjogYWRqdXN0IHdvcmtsb2FkIHByb2ZpbGUgaGFuZGxp
bmciKQpSZXZpZXdlZC1ieTogRGF2aWQgKE1pbmcgUWlhbmcpIFd1IDxEYXZpZC5XdTNAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IFNhdGhpc2hrdW1hciBTIDxzYXRoaXNoa3VtYXIuc3VuZGFyYXJhanVA
YW1kLmNvbT4gKHYxKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5j
IHwgNTYgKysrKysrKysrKysrKysrKystLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5oIHwgIDQgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
Ml8wLmMgICB8ICAzICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jICAg
fCAgMiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMC5jICAgfCAgMyArKwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jIHwgIDMgKysKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzUuYyB8ICAzICsrCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjVfMF8wLmMgfCAgMyArKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3Y1XzBfMS5jIHwgIDMgKysKIDkgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5j
CmluZGV4IGZkOGViZjRiNWE4MjQuLmViZjczMGY4YWNlNDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmMKQEAgLTkxLDcgKzkxLDcgQEAgTU9EVUxFX0ZJUk1XQVJFKEZJ
Uk1XQVJFX1ZDTjRfMF82XzEpOwogTU9EVUxFX0ZJUk1XQVJFKEZJUk1XQVJFX1ZDTjVfMF8wKTsK
IE1PRFVMRV9GSVJNV0FSRShGSVJNV0FSRV9WQ041XzBfMSk7CiAKLXN0YXRpYyB2b2lkIGFtZGdw
dV92Y25faWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsKK3N0YXRp
YyB2b2lkIGFtZGdwdV92Y25faW5zdGFuY2Vfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVj
dCAqd29yayk7CiBzdGF0aWMgdm9pZCBhbWRncHVfdmNuX3JlZ19kdW1wX2Zpbmkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpOwogCiBpbnQgYW1kZ3B1X3Zjbl9lYXJseV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBpbnQgaSkKQEAgLTEzNyw3ICsxMzcsNyBAQCBpbnQgYW1kZ3B1
X3Zjbl9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaSkKIAltdXRleF9p
bml0KCZhZGV2LT52Y24uaW5zdFtpXS52Y25fcGdfbG9jayk7CiAJbXV0ZXhfaW5pdCgmYWRldi0+
dmNuLmluc3RbaV0uZW5naW5lX3Jlc2V0X211dGV4KTsKIAlhdG9taWNfc2V0KCZhZGV2LT52Y24u
aW5zdFtpXS50b3RhbF9zdWJtaXNzaW9uX2NudCwgMCk7Ci0JSU5JVF9ERUxBWUVEX1dPUksoJmFk
ZXYtPnZjbi5pbnN0W2ldLmlkbGVfd29yaywgYW1kZ3B1X3Zjbl9pZGxlX3dvcmtfaGFuZGxlcik7
CisJSU5JVF9ERUxBWUVEX1dPUksoJmFkZXYtPnZjbi5pbnN0W2ldLmlkbGVfd29yaywgYW1kZ3B1
X3Zjbl9pbnN0YW5jZV93b3JrX2hhbmRsZXIpOwogCWF0b21pY19zZXQoJmFkZXYtPnZjbi5pbnN0
W2ldLmRwZ19lbmNfc3VibWlzc2lvbl9jbnQsIDApOwogCWlmICgoYWRldi0+ZmlybXdhcmUubG9h
ZF90eXBlID09IEFNREdQVV9GV19MT0FEX1BTUCkgJiYKIAkgICAgKGFkZXYtPnBnX2ZsYWdzICYg
QU1EX1BHX1NVUFBPUlRfVkNOX0RQRykpCkBAIC00MDgsNDMgKzQwOCw2MSBAQCBpbnQgYW1kZ3B1
X3Zjbl9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpKQogCXJldHVybiAw
OwogfQogCi1zdGF0aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykKK3N0YXRpYyB2b2lkIGFtZGdwdV92Y25faW5zdGFuY2Vfd29ya19o
YW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsKIAlzdHJ1Y3QgYW1kZ3B1X3Zjbl9p
bnN0ICp2Y25faW5zdCA9CiAJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgYW1kZ3B1X3Zjbl9p
bnN0LCBpZGxlX3dvcmsud29yayk7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSB2Y25f
aW5zdC0+YWRldjsKLQl1bnNpZ25lZCBpbnQgZmVuY2VzID0gMCwgZmVuY2VbQU1ER1BVX01BWF9W
Q05fSU5TVEFOQ0VTXSA9IHswfTsKLQl1bnNpZ25lZCBpbnQgaSA9IHZjbl9pbnN0LT5pbnN0LCBq
OwotCWludCByID0gMDsKKwl1bnNpZ25lZCBpbnQgZmVuY2VzID0gMDsKKwl1bnNpZ25lZCBpbnQg
aTsKIAotCWlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkKKwlpZiAoYWRl
di0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgdmNuX2luc3QtPmluc3QpKQogCQlyZXR1cm47
CiAKLQlmb3IgKGogPSAwOyBqIDwgYWRldi0+dmNuLmluc3RbaV0ubnVtX2VuY19yaW5nczsgKytq
KQotCQlmZW5jZVtpXSArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmdmNuX2luc3QtPnJp
bmdfZW5jW2pdKTsKKwlmb3IgKGkgPSAwOyBpIDwgdmNuX2luc3QtPm51bV9lbmNfcmluZ3M7ICsr
aSkKKwkJZmVuY2VzICs9IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZ2Y25faW5zdC0+cmlu
Z19lbmNbaV0pOworCWZlbmNlcyArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmdmNuX2lu
c3QtPnJpbmdfZGVjKTsKIAogCS8qIE9ubHkgc2V0IERQRyBwYXVzZSBmb3IgVkNOMyBvciBiZWxv
dywgVkNONCBhbmQgYWJvdmUgd2lsbCBiZSBoYW5kbGVkIGJ5IEZXICovCiAJaWYgKGFkZXYtPnBn
X2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRyAmJgotCSAgICAhYWRldi0+dmNuLmluc3Rb
aV0udXNpbmdfdW5pZmllZF9xdWV1ZSkgeworCSAgICAhdmNuX2luc3QtPnVzaW5nX3VuaWZpZWRf
cXVldWUpIHsKIAkJc3RydWN0IGRwZ19wYXVzZV9zdGF0ZSBuZXdfc3RhdGU7CiAKLQkJaWYgKGZl
bmNlW2ldIHx8CisJCWlmIChmZW5jZXMgfHwKIAkJICAgIHVubGlrZWx5KGF0b21pY19yZWFkKCZ2
Y25faW5zdC0+ZHBnX2VuY19zdWJtaXNzaW9uX2NudCkpKQogCQkJbmV3X3N0YXRlLmZ3X2Jhc2Vk
ID0gVkNOX0RQR19TVEFURV9fUEFVU0U7CiAJCWVsc2UKIAkJCW5ld19zdGF0ZS5md19iYXNlZCA9
IFZDTl9EUEdfU1RBVEVfX1VOUEFVU0U7CiAKLQkJYWRldi0+dmNuLmluc3RbaV0ucGF1c2VfZHBn
X21vZGUodmNuX2luc3QsICZuZXdfc3RhdGUpOworCQl2Y25faW5zdC0+cGF1c2VfZHBnX21vZGUo
dmNuX2luc3QsICZuZXdfc3RhdGUpOwogCX0KIAotCWZlbmNlW2ldICs9IGFtZGdwdV9mZW5jZV9j
b3VudF9lbWl0dGVkKCZ2Y25faW5zdC0+cmluZ19kZWMpOwotCWZlbmNlcyArPSBmZW5jZVtpXTsK
LQogCWlmICghZmVuY2VzICYmICFhdG9taWNfcmVhZCgmdmNuX2luc3QtPnRvdGFsX3N1Ym1pc3Np
b25fY250KSkgewogCQltdXRleF9sb2NrKCZ2Y25faW5zdC0+dmNuX3BnX2xvY2spOwogCQl2Y25f
aW5zdC0+c2V0X3BnX3N0YXRlKHZjbl9pbnN0LCBBTURfUEdfU1RBVEVfR0FURSk7CiAJCW11dGV4
X3VubG9jaygmdmNuX2luc3QtPnZjbl9wZ19sb2NrKTsKLQkJbXV0ZXhfbG9jaygmYWRldi0+dmNu
Lndvcmtsb2FkX3Byb2ZpbGVfbXV0ZXgpOworCX0gZWxzZSB7CisJCXNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmdmNuX2luc3QtPmlkbGVfd29yaywgVkNOX0lETEVfVElNRU9VVCk7CisJfQorfQorCit2
b2lkIGFtZGdwdV92Y25fZ2xvYmFsX3dvcmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCit7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPQorCQljb250YWluZXJfb2Yod29y
aywgc3RydWN0IGFtZGdwdV9kZXZpY2UsIHZjbi5nbG9iYWxfd29yay53b3JrKTsKKwl1bnNpZ25l
ZCBpbnQgdG90YWxfZmVuY2VzID0gMDsKKwl1bnNpZ25lZCBpbnQgaSwgajsKKwlpbnQgciA9IDA7
CisKKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgKytpKSB7CisJCXN0
cnVjdCBhbWRncHVfdmNuX2luc3QgKnYgPSAmYWRldi0+dmNuLmluc3RbaV07CisKKwkJZm9yIChq
ID0gMDsgaiA8IHYtPm51bV9lbmNfcmluZ3M7ICsraikKKwkJCXRvdGFsX2ZlbmNlcyArPSBhbWRn
cHVfZmVuY2VfY291bnRfZW1pdHRlZCgmdi0+cmluZ19lbmNbal0pOworCQl0b3RhbF9mZW5jZXMg
Kz0gYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJnYtPnJpbmdfZGVjKTsKKwl9CisKKwlpZiAo
IXRvdGFsX2ZlbmNlcyAmJiAhYXRvbWljX3JlYWQoJmFkZXYtPnZjbi50b3RhbF9zdWJtaXNzaW9u
X2NudCkpIHsKIAkJaWYgKGFkZXYtPnZjbi53b3JrbG9hZF9wcm9maWxlX2FjdGl2ZSkgewogCQkJ
ciA9IGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGUoYWRldiwgUFBfU01DX1BPV0VSX1BS
T0ZJTEVfVklERU8sCiAJCQkJCQkJICAgIGZhbHNlKTsKQEAgLTQ1NCw3ICs0NzIsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykKIAkJfQogCQltdXRleF91bmxvY2soJmFkZXYtPnZjbi53b3JrbG9hZF9wcm9maWxlX211
dGV4KTsKIAl9IGVsc2UgewotCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnZjbl9pbnN0LT5pZGxl
X3dvcmssIFZDTl9JRExFX1RJTUVPVVQpOworCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYt
PnZjbi5nbG9iYWxfd29yaywgVkNOX0lETEVfVElNRU9VVCk7CiAJfQogfQogCkBAIC00NjQsOCAr
NDgyLDEwIEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcpCiAJc3RydWN0IGFtZGdwdV92Y25faW5zdCAqdmNuX2luc3QgPSAmYWRldi0+dmNu
Lmluc3RbcmluZy0+bWVdOwogCWludCByID0gMDsKIAorCWF0b21pY19pbmMoJmFkZXYtPnZjbi50
b3RhbF9zdWJtaXNzaW9uX2NudCk7CiAJYXRvbWljX2luYygmdmNuX2luc3QtPnRvdGFsX3N1Ym1p
c3Npb25fY250KTsKIAorCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmdsb2Jh
bF93b3JrKTsKIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnZjbl9pbnN0LT5pZGxlX3dvcmsp
OwogCiAJLyogV2UgY2FuIHNhZmVseSByZXR1cm4gZWFybHkgaGVyZSBiZWNhdXNlIHdlJ3ZlIGNh
bmNlbGxlZCB0aGUKQEAgLTUyNSw4ICs1NDUsMTAgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfZW5k
X3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCiAJICAgICFhZGV2LT52Y24uaW5zdFtyaW5n
LT5tZV0udXNpbmdfdW5pZmllZF9xdWV1ZSkKIAkJYXRvbWljX2RlYygmcmluZy0+YWRldi0+dmNu
Lmluc3RbcmluZy0+bWVdLmRwZ19lbmNfc3VibWlzc2lvbl9jbnQpOwogCisJYXRvbWljX2RlYygm
cmluZy0+YWRldi0+dmNuLnRvdGFsX3N1Ym1pc3Npb25fY250KTsKIAlhdG9taWNfZGVjKCZyaW5n
LT5hZGV2LT52Y24uaW5zdFtyaW5nLT5tZV0udG90YWxfc3VibWlzc2lvbl9jbnQpOwogCisJc2No
ZWR1bGVfZGVsYXllZF93b3JrKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmssIFZDTl9JRExFX1RJTUVP
VVQpOwogCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmcmluZy0+YWRldi0+dmNuLmluc3RbcmluZy0+
bWVdLmlkbGVfd29yaywKIAkJCSAgICAgIFZDTl9JRExFX1RJTUVPVVQpOwogfQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCmluZGV4IGIzZmIxZDBlNDNmYzkuLjcwZDk3YTJh
Yzc3MTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKQEAgLTM1Miw2
ICszNTIsOCBAQCBzdHJ1Y3QgYW1kZ3B1X3ZjbiB7CiAKIAl1aW50MTZfdCBpbnN0X21hc2s7CiAJ
dWludDhfdAludW1faW5zdF9wZXJfYWlkOworCWF0b21pY190CQl0b3RhbF9zdWJtaXNzaW9uX2Nu
dDsKKwlzdHJ1Y3QgZGVsYXllZF93b3JrCWdsb2JhbF93b3JrOwogCiAJLyogSVAgcmVnIGR1bXAg
Ki8KIAl1aW50MzJfdAkJKmlwX2R1bXA7CkBAIC01NjUsNCArNTY3LDYgQEAgaW50IGFtZGdwdV92
Y25fcmVnX2R1bXBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgY29u
c3Qgc3RydWN0IGFtZGdwdV9od2lwX3JlZ19lbnRyeSAqcmVnLCB1MzIgY291bnQpOwogdm9pZCBh
bWRncHVfdmNuX2R1bXBfaXBfc3RhdGUoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2sp
Owogdm9pZCBhbWRncHVfdmNuX3ByaW50X2lwX3N0YXRlKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sg
KmlwX2Jsb2NrLCBzdHJ1Y3QgZHJtX3ByaW50ZXIgKnApOwordm9pZCBhbWRncHVfdmNuX2dsb2Jh
bF93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsKKwogI2VuZGlmCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYwppbmRleCBiMTE1MTM3YWIyZDY5Li4wNjhiYjE3
YzUxYzIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKQEAgLTEzOSw2ICsx
MzksOCBAQCBzdGF0aWMgaW50IHZjbl92Ml8wX3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9j
ayAqaXBfYmxvY2spCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRl
djsKIAl2b2xhdGlsZSBzdHJ1Y3QgYW1kZ3B1X2Z3X3NoYXJlZCAqZndfc2hhcmVkOwogCisJSU5J
VF9ERUxBWUVEX1dPUksoJmFkZXYtPnZjbi5nbG9iYWxfd29yaywgYW1kZ3B1X3Zjbl9nbG9iYWxf
d29ya19oYW5kbGVyKTsKKwogCS8qIFZDTiBERUMgVFJBUCAqLwogCXIgPSBhbWRncHVfaXJxX2Fk
ZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9WQ04sCiAJCQkgICAgICBWQ05fMl8wX19TUkNJ
RF9fVVZEX1NZU1RFTV9NRVNTQUdFX0lOVEVSUlVQVCwKQEAgLTMyMiw2ICszMjQsNyBAQCBzdGF0
aWMgaW50IHZjbl92Ml8wX2h3X2Zpbmkoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2sp
CiAJc3RydWN0IGFtZGdwdV92Y25faW5zdCAqdmluc3QgPSBhZGV2LT52Y24uaW5zdDsKIAogCWNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmdmluc3QtPmlkbGVfd29yayk7CisJY2FuY2VsX2RlbGF5
ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmspOwogCiAJaWYgKChhZGV2LT5wZ19m
bGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpIHx8CiAJICAgICh2aW5zdC0+Y3VyX3N0YXRl
ICE9IEFNRF9QR19TVEFURV9HQVRFICYmCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAu
YwppbmRleCA5NTE3MzE1NmY5NTZhLi4yODAwMjVhM2EwY2IzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92M18wLmMKQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdGF0aWMgaW50IHZjbl92M18w
X3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spCiAJaW50IHZjbl9kb29y
YmVsbF9pbmRleCA9IDA7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+
YWRldjsKIAorCUlOSVRfREVMQVlFRF9XT1JLKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmssIGFtZGdw
dV92Y25fZ2xvYmFsX3dvcmtfaGFuZGxlcik7CiAJLyoKIAkgKiBOb3RlOiBkb29yYmVsbCBhc3Np
Z25tZW50IGlzIGZpeGVkIGZvciBTUklPViBtdWx0aXBsZSBWQ04gZW5naW5lcwogCSAqIEZvcm11
bGE6CkBAIC00NDQsNiArNDQ1LDcgQEAgc3RhdGljIGludCB2Y25fdjNfMF9od19maW5pKHN0cnVj
dCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gaXBfYmxvY2stPmFkZXY7CiAJaW50IGk7CiAKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMo
JmFkZXYtPnZjbi5nbG9iYWxfd29yayk7CiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1f
dmNuX2luc3Q7ICsraSkgewogCQlzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0ICp2aW5zdCA9ICZhZGV2
LT52Y24uaW5zdFtpXTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMKaW5kZXgg
YWU5ZDQwOGU1MGMzNy4uMzgwMTBmNDJiY2VlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3Y0XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjRfMC5jCkBAIC0xODQsNiArMTg0LDggQEAgc3RhdGljIGludCB2Y25fdjRfMF9zd19pbml0
KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gaXBfYmxvY2stPmFkZXY7CiAJaW50IGksIHI7CiAKKwlJTklUX0RFTEFZRURfV09S
SygmYWRldi0+dmNuLmdsb2JhbF93b3JrLCBhbWRncHVfdmNuX2dsb2JhbF93b3JrX2hhbmRsZXIp
OworCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7IGkrKykgewogCQlp
ZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCiAJCQljb250aW51ZTsKQEAg
LTM3MCw2ICszNzIsNyBAQCBzdGF0aWMgaW50IHZjbl92NF8wX2h3X2Zpbmkoc3RydWN0IGFtZGdw
dV9pcF9ibG9jayAqaXBfYmxvY2spCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9i
bG9jay0+YWRldjsKIAlpbnQgaTsKIAorCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+
dmNuLmdsb2JhbF93b3JrKTsKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5z
dDsgKytpKSB7CiAJCXN0cnVjdCBhbWRncHVfdmNuX2luc3QgKnZpbnN0ID0gJmFkZXYtPnZjbi5p
bnN0W2ldOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRf
MF8zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF8zLmMKaW5kZXggZDE4
YWNhM2Q2NjNiOS4uMDY2OWRmOGQ4NzMxNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3Y0XzBfMy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92NF8wXzMuYwpAQCAtMTYxLDYgKzE2MSw4IEBAIHN0YXRpYyBpbnQgdmNuX3Y0XzBfM19zd19p
bml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCXN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZzsKIAlpbnQgaSwgciwgdmNuX2luc3Q7CiAKKwlJTklUX0RFTEFZRURfV09SSygmYWRl
di0+dmNuLmdsb2JhbF93b3JrLCBhbWRncHVfdmNuX2dsb2JhbF93b3JrX2hhbmRsZXIpOworCiAJ
LyogVkNOIERFQyBUUkFQICovCiAJciA9IGFtZGdwdV9pcnFfYWRkX2lkKGFkZXYsIFNPQzE1X0lI
X0NMSUVOVElEX1ZDTiwKIAkJVkNOXzRfMF9fU1JDSURfX1VWRF9FTkNfR0VORVJBTF9QVVJQT1NF
LCAmYWRldi0+dmNuLmluc3QtPmlycSk7CkBAIC0zNzMsNiArMzc1LDcgQEAgc3RhdGljIGludCB2
Y25fdjRfMF8zX2h3X2Zpbmkoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spCiAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRldjsKIAlpbnQgaTsKIAorCWNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmdsb2JhbF93b3JrKTsKIAlmb3IgKGkg
PSAwOyBpIDwgYWRldi0+dmNuLm51bV92Y25faW5zdDsgKytpKSB7CiAJCXN0cnVjdCBhbWRncHVf
dmNuX2luc3QgKnZpbnN0ID0gJmFkZXYtPnZjbi5pbnN0W2ldOwogCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMF81LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjRfMF81LmMKaW5kZXggNzVjODg0YThmNTU2Yi4uNjViMzRmOWJlZTVhNSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfNS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzUuYwpAQCAtMTQ4LDYgKzE0OCw4
IEBAIHN0YXRpYyBpbnQgdmNuX3Y0XzBfNV9zd19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sg
KmlwX2Jsb2NrKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7
CiAJaW50IGksIHI7CiAKKwlJTklUX0RFTEFZRURfV09SSygmYWRldi0+dmNuLmdsb2JhbF93b3Jr
LCBhbWRncHVfdmNuX2dsb2JhbF93b3JrX2hhbmRsZXIpOworCiAJZm9yIChpID0gMDsgaSA8IGFk
ZXYtPnZjbi5udW1fdmNuX2luc3Q7IGkrKykgewogCQl2b2xhdGlsZSBzdHJ1Y3QgYW1kZ3B1X3Zj
bjRfZndfc2hhcmVkICpmd19zaGFyZWQ7CiAKQEAgLTMyMCw2ICszMjIsNyBAQCBzdGF0aWMgaW50
IHZjbl92NF8wXzVfaHdfZmluaShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAlz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2OwogCWludCBpOwogCisJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmspOwogCWZvciAo
aSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKIAkJc3RydWN0IGFtZGdw
dV92Y25faW5zdCAqdmluc3QgPSAmYWRldi0+dmNuLmluc3RbaV07CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NV8wXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92NV8wXzAuYwppbmRleCA0NTVmODI5YjhiYjk5Li44ODJkYTM1OTFhZDRh
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8wLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMC5jCkBAIC0xMjgsNiArMTI4
LDggQEAgc3RhdGljIGludCB2Y25fdjVfMF8wX3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9j
ayAqaXBfYmxvY2spCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBpcF9ibG9jay0+YWRl
djsKIAlpbnQgaSwgcjsKIAorCUlOSVRfREVMQVlFRF9XT1JLKCZhZGV2LT52Y24uZ2xvYmFsX3dv
cmssIGFtZGdwdV92Y25fZ2xvYmFsX3dvcmtfaGFuZGxlcik7CisKIAlmb3IgKGkgPSAwOyBpIDwg
YWRldi0+dmNuLm51bV92Y25faW5zdDsgaSsrKSB7CiAJCXZvbGF0aWxlIHN0cnVjdCBhbWRncHVf
dmNuNV9md19zaGFyZWQgKmZ3X3NoYXJlZDsKIApAQCAtMjgzLDYgKzI4NSw3IEBAIHN0YXRpYyBp
bnQgdmNuX3Y1XzBfMF9od19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQog
CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7CiAJaW50IGk7CiAK
KwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjbi5nbG9iYWxfd29yayk7CiAJZm9y
IChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkgewogCQlzdHJ1Y3QgYW1k
Z3B1X3Zjbl9pbnN0ICp2aW5zdCA9ICZhZGV2LT52Y24uaW5zdFtpXTsKIApkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y1XzBfMS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3Y1XzBfMS5jCmluZGV4IDdjYjIxZTJiNGViMGUuLjIxM2IyNGIxZDBj
YzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NV8wXzEuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjVfMF8xLmMKQEAgLTE0Miw2ICsx
NDIsOCBAQCBzdGF0aWMgaW50IHZjbl92NV8wXzFfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Js
b2NrICppcF9ibG9jaykKIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7CiAJaW50IGksIHIsIHZj
bl9pbnN0OwogCisJSU5JVF9ERUxBWUVEX1dPUksoJmFkZXYtPnZjbi5nbG9iYWxfd29yaywgYW1k
Z3B1X3Zjbl9nbG9iYWxfd29ya19oYW5kbGVyKTsKKwogCS8qIFZDTiBVTklGSUVEIFRSQVAgKi8K
IAlyID0gYW1kZ3B1X2lycV9hZGRfaWQoYWRldiwgU09DMTVfSUhfQ0xJRU5USURfVkNOLAogCQlW
Q05fNV8wX19TUkNJRF9fVVZEX0VOQ19HRU5FUkFMX1BVUlBPU0UsICZhZGV2LT52Y24uaW5zdC0+
aXJxKTsKQEAgLTMxOCw2ICszMjAsNyBAQCBzdGF0aWMgaW50IHZjbl92NV8wXzFfaHdfZmluaShz
dHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGlwX2Jsb2NrLT5hZGV2OwogCWludCBpOwogCisJY2FuY2VsX2RlbGF5ZWRfd29ya19z
eW5jKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmspOwogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24u
bnVtX3Zjbl9pbnN0OyArK2kpIHsKIAkJc3RydWN0IGFtZGdwdV92Y25faW5zdCAqdmluc3QgPSAm
YWRldi0+dmNuLmluc3RbaV07CiAKLS0gCjIuNTAuMQoK
--000000000000d1a85e063c44ae17
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-vcn2.5-switch-to-the-global-work-handler.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-vcn2.5-switch-to-the-global-work-handler.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_meaeh0rq0>
X-Attachment-Id: f_meaeh0rq0

RnJvbSBjNjdlOGVjMTFlZDFhODBiZGQ0ODg4OWVkZjJmMDU0MmNlN2MzOWE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMTMgQXVnIDIwMjUgMTY6MDM6MjAgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdS92Y24yLjU6IHN3aXRjaCB0byB0aGUgZ2xvYmFsIHdvcmsgaGFuZGxl
cgoKQWxsIG9mIHRoZSBpZGxlIHdvcmsgb24gdmNuMi41IGlzIGdsb2JhbCwgc28gdXNlIHRoZQpu
ZXcgZ2xvYmFsIHdvcmsgaGFuZGxlciByYXRoZXIgdGhhbiBhYnVzaW5nIGEgc2luZ2xlCmluc3Rh
bmNlIG9mIHRoZSBwZXIgaW5zdGFuY2Ugd29yayBoYW5kbGVyLgoKU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgfCAyOCArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwppbmRleCAzYTdjMTM3YTgzZWZiLi43NTE1OGY0
MWI4NDYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKQEAgLTEwOSwxMSAr
MTA5LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2loX2NsaWVudGlkX3ZjbnNbXSA9IHsKIAlTT0Mx
NV9JSF9DTElFTlRJRF9WQ04xCiB9OwogCi1zdGF0aWMgdm9pZCB2Y25fdjJfNV9pZGxlX3dvcmtf
aGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCitzdGF0aWMgdm9pZCB2Y25fdjJfNV9n
bG9iYWxfd29ya19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIHsKLQlzdHJ1Y3Qg
YW1kZ3B1X3Zjbl9pbnN0ICp2Y25faW5zdCA9Ci0JCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qg
YW1kZ3B1X3Zjbl9pbnN0LCBpZGxlX3dvcmsud29yayk7Ci0Jc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSB2Y25faW5zdC0+YWRldjsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9CisJ
CWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSwgdmNuLmdsb2JhbF93b3Jr
LndvcmspOwogCXVuc2lnbmVkIGludCBmZW5jZXMgPSAwLCBmZW5jZVtBTURHUFVfTUFYX1ZDTl9J
TlNUQU5DRVNdID0gezB9OwogCXVuc2lnbmVkIGludCBpLCBqOwogCWludCByID0gMDsKQEAgLTE0
Niw3ICsxNDUsNyBAQCBzdGF0aWMgdm9pZCB2Y25fdjJfNV9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAKIAl9CiAKLQlpZiAoIWZlbmNlcyAmJiAhYXRvbWljX3Jl
YWQoJmFkZXYtPnZjbi5pbnN0WzBdLnRvdGFsX3N1Ym1pc3Npb25fY250KSkgeworCWlmICghZmVu
Y2VzICYmICFhdG9taWNfcmVhZCgmYWRldi0+dmNuLnRvdGFsX3N1Ym1pc3Npb25fY250KSkgewog
CQlhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxP
Q0tfVFlQRV9WQ04sCiAJCQkJCQkgICAgICAgQU1EX1BHX1NUQVRFX0dBVEUpOwogCQltdXRleF9s
b2NrKCZhZGV2LT52Y24ud29ya2xvYWRfcHJvZmlsZV9tdXRleCk7CkBAIC0xNTksNyArMTU4LDcg
QEAgc3RhdGljIHZvaWQgdmNuX3YyXzVfaWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQogCQl9CiAJCW11dGV4X3VubG9jaygmYWRldi0+dmNuLndvcmtsb2FkX3Byb2Zp
bGVfbXV0ZXgpOwogCX0gZWxzZSB7Ci0JCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmYWRldi0+dmNu
Lmluc3RbMF0uaWRsZV93b3JrLCBWQ05fSURMRV9USU1FT1VUKTsKKwkJc2NoZWR1bGVfZGVsYXll
ZF93b3JrKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmssIFZDTl9JRExFX1RJTUVPVVQpOwogCX0KIH0K
IApAQCAtMTY5LDkgKzE2OCw5IEBAIHN0YXRpYyB2b2lkIHZjbl92Ml81X3JpbmdfYmVnaW5fdXNl
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKIAlzdHJ1Y3QgYW1kZ3B1X3Zjbl9pbnN0ICp2ID0g
JmFkZXYtPnZjbi5pbnN0W3JpbmctPm1lXTsKIAlpbnQgciA9IDA7CiAKLQlhdG9taWNfaW5jKCZh
ZGV2LT52Y24uaW5zdFswXS50b3RhbF9zdWJtaXNzaW9uX2NudCk7CisJYXRvbWljX2luYygmYWRl
di0+dmNuLnRvdGFsX3N1Ym1pc3Npb25fY250KTsKIAotCWNhbmNlbF9kZWxheWVkX3dvcmtfc3lu
YygmYWRldi0+dmNuLmluc3RbMF0uaWRsZV93b3JrKTsKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5
bmMoJmFkZXYtPnZjbi5nbG9iYWxfd29yayk7CiAKIAkvKiBXZSBjYW4gc2FmZWx5IHJldHVybiBl
YXJseSBoZXJlIGJlY2F1c2Ugd2UndmUgY2FuY2VsbGVkIHRoZQogCSAqIHRoZSBkZWxheWVkIHdv
cmsgc28gdGhlcmUgaXMgbm8gb25lIGVsc2UgdG8gc2V0IGl0IHRvIGZhbHNlCkBAIC0yMzAsMTAg
KzIyOSw5IEBAIHN0YXRpYyB2b2lkIHZjbl92Ml81X3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcpCiAJICAgICFhZGV2LT52Y24uaW5zdFtyaW5nLT5tZV0udXNpbmdfdW5pZmll
ZF9xdWV1ZSkKIAkJYXRvbWljX2RlYygmYWRldi0+dmNuLmluc3RbcmluZy0+bWVdLmRwZ19lbmNf
c3VibWlzc2lvbl9jbnQpOwogCi0JYXRvbWljX2RlYygmYWRldi0+dmNuLmluc3RbMF0udG90YWxf
c3VibWlzc2lvbl9jbnQpOworCWF0b21pY19kZWMoJmFkZXYtPnZjbi50b3RhbF9zdWJtaXNzaW9u
X2NudCk7CiAKLQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmFkZXYtPnZjbi5pbnN0WzBdLmlkbGVf
d29yaywKLQkJCSAgICAgIFZDTl9JRExFX1RJTUVPVVQpOworCXNjaGVkdWxlX2RlbGF5ZWRfd29y
aygmYWRldi0+dmNuLmdsb2JhbF93b3JrLCBWQ05fSURMRV9USU1FT1VUKTsKIH0KIAogLyoqCkBA
IC0yOTksNiArMjk3LDggQEAgc3RhdGljIGludCB2Y25fdjJfNV9zd19pbml0KHN0cnVjdCBhbWRn
cHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCWludCBpLCBqLCByOwogCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7CiAKKwlJTklUX0RFTEFZRURfV09SSygmYWRldi0+
dmNuLmdsb2JhbF93b3JrLCB2Y25fdjJfNV9nbG9iYWxfd29ya19oYW5kbGVyKTsKKwogCWZvciAo
aiA9IDA7IGogPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyBqKyspIHsKIAkJdm9sYXRpbGUgc3Ry
dWN0IGFtZGdwdV9md19zaGFyZWQgKmZ3X3NoYXJlZDsKIApAQCAtMzI4LDkgKzMyOCw2IEBAIHN0
YXRpYyBpbnQgdmNuX3YyXzVfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9j
aykKIAkJaWYgKHIpCiAJCQlyZXR1cm4gcjsKIAotCQkvKiBPdmVycmlkZSB0aGUgd29yayBmdW5j
ICovCi0JCWFkZXYtPnZjbi5pbnN0W2pdLmlkbGVfd29yay53b3JrLmZ1bmMgPSB2Y25fdjJfNV9p
ZGxlX3dvcmtfaGFuZGxlcjsKLQogCQlhbWRncHVfdmNuX3NldHVwX3Vjb2RlKGFkZXYsIGopOwog
CiAJCXIgPSBhbWRncHVfdmNuX3Jlc3VtZShhZGV2LCBqKTsKQEAgLTUzMywxNCArNTMwLDEzIEBA
IHN0YXRpYyBpbnQgdmNuX3YyXzVfaHdfZmluaShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9i
bG9jaykKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2OwogCWlu
dCBpOwogCisJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uZ2xvYmFsX3dvcmsp
OwogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKIAkJc3Ry
dWN0IGFtZGdwdV92Y25faW5zdCAqdmluc3QgPSAmYWRldi0+dmNuLmluc3RbaV07CiAKIAkJaWYg
KGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQogCQkJY29udGludWU7CiAKLQkJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ2aW5zdC0+aWRsZV93b3JrKTsKLQogCQlpZiAoKGFk
ZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRykgfHwKIAkJICAgICh2aW5zdC0+
Y3VyX3N0YXRlICE9IEFNRF9QR19TVEFURV9HQVRFICYmCiAJCSAgICAgUlJFRzMyX1NPQzE1KFZD
TiwgaSwgbW1VVkRfU1RBVFVTKSkpCi0tIAoyLjUwLjEKCg==
--000000000000d1a85e063c44ae17--
