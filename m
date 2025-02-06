Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E885BC02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933AB10E301;
	Thu,  6 Feb 2025 16:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SOjkiPOj";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B9510E2F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:00:22 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ypdz65MgMz9tJ2;
 Thu,  6 Feb 2025 15:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1738850418; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scOaibsDOiF746t0YrRrhPKUIzyEqPfjDOV1i7kYTjU=;
 b=SOjkiPOj7cij22MwJshDTQjjZT9azfsRs1jo0Q+mLrU9DW4AKXwcZoONgm/JFe7HMUN5Z3
 PdELkOSkFd9CZXFl4WinrewfTVambH4ivUXHKTD53d553NEoFdSTjJuDLUXFgssGGlNwIp
 1IAlFFar/KU6/nqYC5bNBLvSe4OHzRPhyAtUJPk/PqGuLDwuxCpJNIg+ZvbwllQuNFwlo7
 GUlZtm+rszEdQm6b+UGi+dg7TcFdsHhotAnSAqk5CWmMzZW8LZQ3KSF/xVFRYPqk1brDIE
 jasu7ITmDqqQyXss+SrXYO70AnWEzZN5IQkg0Vnr7pnBv3nMdSXV2fA9IIKBoQ==
Message-ID: <eb8e5966f7f1518b62fe3b88e857572747e5fd28.camel@mailbox.org>
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, phasta@kernel.org,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>
Date: Thu, 06 Feb 2025 15:00:16 +0100
In-Reply-To: <37b0eef7-684e-4616-8d3d-d5e8932b8004@igalia.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
 <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
 <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
 <37b0eef7-684e-4616-8d3d-d5e8932b8004@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 627d62d39c375f0ad59
X-MBO-RS-META: hm9pt7qaiqrayoa1iaqpzpr5hphes744
X-Mailman-Approved-At: Thu, 06 Feb 2025 16:29:33 +0000
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
Reply-To: phasta@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2025-02-06 at 13:53 +0000, Tvrtko Ursulin wrote:
>=20
> On 06/02/2025 13:46, Christian K=C3=B6nig wrote:
> > Am 06.02.25 um 14:35 schrieb Philipp Stanner:
> > > On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
> > > > The helper copies code from the existing
> > > > amdgpu_job_stop_all_jobs_on_sched
> > > > with the purpose of reducing the amount of driver code which
> > > > directly
> > > > touch scheduler internals.
> > > >=20
> > > > If or when amdgpu manages to change the approach for handling
> > > > the
> > > > permanently wedged state this helper can be removed.
> > > Have you checked how many other drivers might need such a helper?
> > >=20
> > > I have a bit mixed feelings about this, because, AFAICT, in the
> > > past
> > > helpers have been added for just 1 driver, such as
> > > drm_sched_wqueue_ready(), and then they have stayed for almost a
> > > decade.
> > >=20
> > > AFAIU this is just code move, and only really "decouples" amdgpu
> > > in the
> > > sense of having an official scheduler function that does what
> > > amdgpu
> > > used to do.
> > >=20
> > > So my tendency here would be to continue "allowing" amdgpu to
> > > touch the
> > > scheduler internals until amdgpu fixes this "permanently wedged
> > > state".=C2=A0And if that's too difficult, couldn't the helper reside
> > > in a
> > > amdgpu/sched_helpers.c or similar?
> > >=20
> > > I think that's better than adding 1 helper for just 1 driver and
> > > then
> > > supposedly removing it again in the future.
> >=20
> > Yeah, agree to that general approach.
> >=20
> > What amdgpu does here is kind of nasty and looks unnecessary, but=20
> > changing it means we need time from Hawkings and his people
> > involved on=20
> > RAS for amdgpu.
> >=20
> > When we move the code to the scheduler we make it official
> > scheduler=20
> > interface to others to replicate and that is exactly what we should
> > try=20
> > to avoid.
> >=20
> > So my suggestion is to add a /* TODO: This is nasty and should be=20
> > avoided */ to the amdgpu code instead.
>=20
> So I got a no go to export a low level queue pop helper

The spsc_queue helper in patch 3 is totally alright. Patch 3 only
depends on patch 1 in the sense of it adding the new helper to the
cancel_all function of patch 1, or am I missing something obvious?

> , no go to move=20
> the whole dodgy code to common (reasonable). Any third way to break
> the=20
> status quo? What if I respin with just a change local to amdgpu which
> would, instead of duplicating the to_drm_sched_job macro, duplicate=20
> __drm_sched_entity_queue_pop from 3/4 of this series?

I'm willing to take patch 3 if it's independent. That would then mean
that to_drm_sched_job() is only necessary anmyore in amdgpu, wouldn't
it?

That's independent from the cancel_all() function as far as the
scheduler is concerned.


P.


>=20
> Regards,
>=20
> Tvrtko
>=20
> >=20
> > Regards,
> > Christian.
> >=20
> > >=20
> > > P.
> > >=20
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > > Cc: Philipp Stanner <phasta@kernel.org>
> > > > ---
> > > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_main.c | 44
> > > > ++++++++++++++++++++++++++
> > > > =C2=A0=C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0=C2=A02 files changed, 45 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > index a48be16ab84f..0363655db22d 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > @@ -703,6 +703,50 @@ void drm_sched_start(struct
> > > > drm_gpu_scheduler
> > > > *sched, int errno)
> > > > =C2=A0=C2=A0}
> > > > =C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_start);
> > > > +/**
> > > > + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled
> > > > jobs
> > > > + *
> > > > + * @sched: scheduler instance
> > > > + * @errno: error value to set on signaled fences
> > > > + *
> > > > + * Signal all queued and scheduled jobs and set them to error
> > > > state.
> > > > + *
> > > > + * Scheduler must be stopped before calling this.
> > > > + */
> > > > +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler
> > > > *sched, int
> > > > errno)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *entity;
> > > > +=C2=A0=C2=A0=C2=A0 struct drm_sched_fence *s_fence;
> > > > +=C2=A0=C2=A0=C2=A0 struct drm_sched_job *job;
> > > > +=C2=A0=C2=A0=C2=A0 enum drm_sched_priority p;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 drm_WARN_ON_ONCE(sched, !sched->pause_submit);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 /* Signal all jobs not yet scheduled */
> > > > +=C2=A0=C2=A0=C2=A0 for (p =3D DRM_SCHED_PRIORITY_KERNEL; p < sched=
->num_rqs;
> > > > p++)
> > > > {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq=
 =3D sched->sched_rq[p];
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&rq->lock);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(ent=
ity, &rq->entities, list) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 while ((job =3D
> > > > to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 s_fence =3D job->s_fence;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_signal(&s_fence-
> > > > > scheduled);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_set_error(&s_fence-
> > > > > finished, errno);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_signal(&s_fence-
> > > > > finished);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&rq->lock);
> > > > +=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 /* Signal all jobs already scheduled to HW */
> > > > +=C2=A0=C2=A0=C2=A0 list_for_each_entry(job, &sched->pending_list, =
list) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s_fence =3D job->s_fenc=
e;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_set_error(&s_=
fence->finished, errno);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_signal(&s_fen=
ce->finished);
> > > > +=C2=A0=C2=A0=C2=A0 }
> > > > +}
> > > > +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
> > > > +
> > > > =C2=A0=C2=A0/**
> > > > =C2=A0=C2=A0 * drm_sched_resubmit_jobs - Deprecated, don't use in n=
ew
> > > > code!
> > > > =C2=A0=C2=A0 *
> > > > diff --git a/include/drm/gpu_scheduler.h
> > > > b/include/drm/gpu_scheduler.h
> > > > index a0ff08123f07..298513f8c327 100644
> > > > --- a/include/drm/gpu_scheduler.h
> > > > +++ b/include/drm/gpu_scheduler.h
> > > > @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct
> > > > drm_gpu_scheduler *sched);
> > > > =C2=A0=C2=A0void drm_sched_wqueue_start(struct drm_gpu_scheduler *s=
ched);
> > > > =C2=A0=C2=A0void drm_sched_stop(struct drm_gpu_scheduler *sched, st=
ruct
> > > > drm_sched_job *bad);
> > > > =C2=A0=C2=A0void drm_sched_start(struct drm_gpu_scheduler *sched, i=
nt
> > > > errno);
> > > > +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler
> > > > *sched, int
> > > > errno);
> > > > =C2=A0=C2=A0void drm_sched_resubmit_jobs(struct drm_gpu_scheduler
> > > > *sched);
> > > > =C2=A0=C2=A0void drm_sched_increase_karma(struct drm_sched_job *bad=
);
> > > > =C2=A0=C2=A0void drm_sched_reset_karma(struct drm_sched_job *bad);
> >=20

