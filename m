Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B423FC54ED0
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 13:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D18289DFF;
	Wed, 21 May 2025 13:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ARCU3hA/";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FCDA10ED00
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 13:29:12 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b07698318ebso960114a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747834146; x=1748438946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9BqhHXhYshA8uFnLgf0Ydd6laSkagFXMfZbMQyRcaw=;
 b=ARCU3hA/FTA+opD1YRhJgLgOx/LEPCAww/571lWNk7Is4YX7EV8QOT1VbllMErASNd
 KWPBwtAj6WyqCZLewtdSxgxjrcep7mnLQHU+JAdPr43c0MTqRVI0aO1VbMJzW4oRgCP6
 CKU69bmufeKxKW/hwTEoOGUgD7VMWShsEAsrKKz2304egZIA9Urs0GnmeGIz19kgTOeZ
 cY6QCyFB9sBe5QwoWGhXF4F5GamdF7DjNrn6EwXV63o5OczfdXEtuJE5dbKCuB5jHzMv
 HNjsENCXQ6VD6KKV3ysvBIzHAs/W7iCzumSBSQ16yDFjHLGsOx61dy/3UsOoq9QEPHgg
 qVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747834146; x=1748438946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9BqhHXhYshA8uFnLgf0Ydd6laSkagFXMfZbMQyRcaw=;
 b=F1cvupIb46CLqUEQHRTntawla1BbQSR0P1dUV7ZW91DOkeP0cDrQ2NWk/PKGSFTWmy
 RHyU3KI7aOidxTIlj2yzKo3WulZ8SVJws6cslgLFPeOk7rQqDYs76T65p4WtY7zUg79w
 e6p9CIJseCQA9NZqBP59EgV2E6zy/4cYl4B7aUHEVDqJAlgy6YTYFu/yuq60VnAz6FWn
 FEHxqLiUhQSRkOouZMaEF8Oeo6pbdhtLdQ1cGqyWK3DlABbQIEZOBb9wKOdA372N4oFv
 mgV4vJIjgyEI2U1ObD0MIwEk6S+ZdboG61n+XCKWm38bh0p64MOsz0I8fedy9I4XcnHG
 y5Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPIKKLoFtdlYMAJ+RZfoPuQMsWyPoA9miXkjA7xpPpabRoiCvZHRVDqI61e8MuZyCyUdhcCb6g@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyujTbf4ra0k9xdwtiGzdpQgdaEnTPWE/ca/cHFKTw0RYk2XIfM
 SGg2dPDO34AYryJ+M+PJeAxhbaDNncUZbh4ihHqRN9il14kyX5T329Cr/jtzhtLUnTZanJd/BhT
 pNbRDGCHoIwvKwCpiWlDBnPSEpIej1XI=
X-Gm-Gg: ASbGncs9bOy4KKEsvH31A67m8wiFDhLFs5oGmtt+Ix2kSg6L8WVA3O4PcJdY9xKYEDs
 7qfdgE4RZDi6G67ZLv/OyXCEonGO/ITc9FU0Ssi8peZfACoSXjDPNbvlGYqPaPyPfr0YErZBwMA
 8DxDpdx3wA5W02la5eEOsYT0echrrvcLd+nQ==
X-Google-Smtp-Source: AGHT+IGGhKCDIYOEI2RpnSfQwgQzB2tCuHSyfsQdb7aWjoASBo3Ouaq9TLdEKmZEZMBOKTsb2CwnXkebLHbDgo4z45s=
X-Received: by 2002:a17:902:ccc1:b0:22d:e53d:efb7 with SMTP id
 d9443c01a7336-231d43a65dcmr115778645ad.4.1747834146132; Wed, 21 May 2025
 06:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
 <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
 <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
 <CADnq5_PrNiZmgUnBH_p9w70wyczK6RtQnNptKQS9FO7ERHhaPg@mail.gmail.com>
 <7d523eba-7706-409a-aeef-5dc6ef309e24@amd.com>
In-Reply-To: <7d523eba-7706-409a-aeef-5dc6ef309e24@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 May 2025 09:28:54 -0400
X-Gm-Features: AX0GCFsKV3S5xXD2qwTqNSPMg0RVKaR8MljIDJUqs53gU8P8x0usnZqaMhuJ4sM
Message-ID: <CADnq5_O30OX=HcoE3TjJXdbbpVNMgto1gt57kbGy+5j7gKnHgg@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Wed, May 21, 2025 at 5:03=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/20/25 18:38, Alex Deucher wrote:
> > On Tue, May 20, 2025 at 9:49=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/20/25 15:09, Alex Deucher wrote:
> >>> On Mon, May 19, 2025 at 2:30=E2=80=AFPM Alex Deucher <alexander.deuch=
er@amd.com> wrote:
> >>>>
> >>>> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> >>>>
> >>>> Stopping the scheduler for queue reset is generally a good idea beca=
use
> >>>> it prevents any worker from touching the ring buffer.
> >>>>
> >>>> But using amdgpu_fence_driver_force_completion() before restarting i=
t was
> >>>> a really bad idea because it marked fences as failed while the work =
was
> >>>> potentially still running.
> >>>>
> >>>> Stop doing that and cleanup the comment a bit.
> >>>>
> >>>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++----------=
---
> >>>>  1 file changed, 13 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_job.c
> >>>> index acb21fc8b3ce5..a0fab947143b5 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_time=
dout(struct drm_sched_job *s_job)
> >>>>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> >>>>                 bool is_guilty;
> >>>>
> >>>> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job=
->sched->name);
> >>>> -               /* stop the scheduler, but don't mess with the
> >>>> -                * bad job yet because if ring reset fails
> >>>> -                * we'll fall back to full GPU reset.
> >>>> +               dev_err(adev->dev, "Starting %s ring reset\n",
> >>>> +                       s_job->sched->name);
> >>>> +
> >>>> +               /*
> >>>> +                * Stop the scheduler to prevent anybody else from t=
ouching the
> >>>> +                * ring buffer.
> >>>>                  */
> >>>>                 drm_sched_wqueue_stop(&ring->sched);
> >>>>
> >>>> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_time=
dout(struct drm_sched_job *s_job)
> >>>>
> >>>>                 r =3D amdgpu_ring_reset(ring, job->vmid);
> >>>>                 if (!r) {
> >>>> -                       if (amdgpu_ring_sched_ready(ring))
> >>>> -                               drm_sched_stop(&ring->sched, s_job);
> >>>> -                       if (is_guilty) {
> >>>> +                       if (is_guilty)
> >>>>                                 atomic_inc(&ring->adev->gpu_reset_co=
unter);
> >>>> -                               amdgpu_fence_driver_force_completion=
(ring);
> >>>
> >>> Do we still need this in the case of rings where we reset the entire
> >>> queue?  E.g., compute or VCN?  In which case we should move this to
> >>> the ring->reset callback.
> >>
> >> No, it shouldn't be necessary in the first place as long as the rings =
still execute their fence packages.
> >>
> >> And that should be the case at least for both graphics and compute.
> >>
> >> Forcing completion only makes sense when the whole ASIC was resetted a=
nd nothing executed any more.
> >
> > This seems to result in a deadlock if you reset the entire queue
> > rather than just the vmid.   I.e., if you test with just this patch
> > and not any of the following patches.  In that case, the queue is
> > reset so none of the fences are signaled.
>
> That is just because of a specific behavior of the GFX/Compute engine.
>
> When fences are issued while a reset is ongoing the CP writes the fence v=
alue not to the requested location, but rather to fence_addr + 4. See amdgp=
u_debugfs_fence_info_show for more details.
>
> That's why I cleared the reset before issuing the fence command in the fo=
llow up patches.
>
> Key point is that the stuff still executes and telling the core os that i=
t can release the memory by force completing the fences is a really bad ide=
a in that case.

But the current code (without this patch set), at least for gfx10 and
newer and VCN, doesn't write the fence, it just resets the entire ring
so the fence never gets written.  So either we need to keep this code
here, or we need to write the fence in the ring reset callbacks I
think.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>
> >>>
> >>> Alex
> >>>
> >>>> -                       }
> >>>> -                       if (amdgpu_ring_sched_ready(ring))
> >>>> -                               drm_sched_start(&ring->sched, 0);
> >>>> -                       dev_err(adev->dev, "Ring %s reset succeeded\=
n", ring->sched.name);
> >>>> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_=
WEDGE_RECOVERY_NONE);
> >>>> +                       drm_sched_wqueue_start(&ring->sched);
> >>>> +                       dev_err(adev->dev, "Ring %s reset succeeded\=
n",
> >>>> +                               ring->sched.name);
> >>>> +                       drm_dev_wedged_event(adev_to_drm(adev),
> >>>> +                                            DRM_WEDGE_RECOVERY_NONE=
);
> >>>>                         goto exit;
> >>>>                 }
> >>>> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->=
sched.name);
> >>>> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->s=
ched.name);
> >>>>         }
> >>>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> >>>>
> >>>> --
> >>>> 2.49.0
> >>>>
> >>
>
