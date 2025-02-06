Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51148C0219C
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43AA10E24B;
	Thu,  6 Feb 2025 16:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eR3F81c3";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1809010E850
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:53:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ypdqc5RJRz9smm;
 Thu,  6 Feb 2025 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1738850028; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=suS/Qv4gYrdFj0rDtwD5WeJ83dyEyBrQY9JfMOWDM0c=;
 b=eR3F81c3bdihjfRg+PP5cnQT99AiUvZh/iukj+iV7qi/8QJHFfGskSLXZauBP45spJ7xia
 C6ttRXgQD8xWcoJuJi7E9YQ9x2S6MkFg5CMw8Pks1AGt+cngh8GiL4R/M1pLpATYLvbR1I
 ZuXfp44DLPm3RP8Sc7ivXftbk1P0OXGoCsWuIUn+a7Yg3l57YtktyIiucZwSErDrUVokZL
 oVjCu4VX7qVJny73BwfoeEVOzFWPLITQ/QsZrUXb5Rd139popvBhSQYIkbhnDxtY1kruVM
 LMEjTbesNXzIqNaaIiteRXKieOglD120NKruMUsaJcaPD4J4oFBmSH1bRd5QMw==
Message-ID: <1fba8eab077800256145abf93f6d25a6dbed4303.camel@mailbox.org>
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>
Date: Thu, 06 Feb 2025 14:53:46 +0100
In-Reply-To: <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
 <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
 <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: fu8ijnicrabt5n68zbqjnf8g3ssc4pxa
X-MBO-RS-ID: a5415ae2f0177287689
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

On Thu, 2025-02-06 at 14:46 +0100, Christian K=C3=B6nig wrote:
> Am 06.02.25 um 14:35 schrieb Philipp Stanner:
> > On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
> > > The helper copies code from the existing
> > > amdgpu_job_stop_all_jobs_on_sched
> > > with the purpose of reducing the amount of driver code which
> > > directly
> > > touch scheduler internals.
> > >=20
> > > If or when amdgpu manages to change the approach for handling the
> > > permanently wedged state this helper can be removed.
> > Have you checked how many other drivers might need such a helper?
> >=20
> > I have a bit mixed feelings about this, because, AFAICT, in the
> > past
> > helpers have been added for just 1 driver, such as
> > drm_sched_wqueue_ready(), and then they have stayed for almost a
> > decade.
> >=20
> > AFAIU this is just code move, and only really "decouples" amdgpu in
> > the
> > sense of having an official scheduler function that does what
> > amdgpu
> > used to do.
> >=20
> > So my tendency here would be to continue "allowing" amdgpu to touch
> > the
> > scheduler internals until amdgpu fixes this "permanently wedged
> > state".=C2=A0And if that's too difficult, couldn't the helper reside in
> > a
> > amdgpu/sched_helpers.c or similar?
> >=20
> > I think that's better than adding 1 helper for just 1 driver and
> > then
> > supposedly removing it again in the future.
>=20
> Yeah, agree to that general approach.
>=20
> What amdgpu does here is kind of nasty and looks unnecessary, but=20
> changing it means we need time from Hawkings and his people involved
> on=20
> RAS for amdgpu.
>=20
> When we move the code to the scheduler we make it official scheduler=20
> interface to others to replicate and that is exactly what we should
> try=20
> to avoid.

Yes, I think if we all agree that the scheduler must only contain
infrastructure useful for >=3D 2 DRM drivers' job queueing related tasks
without any hacks for driver internal issues, that would be a great
thing.


P.

>=20
> So my suggestion is to add a /* TODO: This is nasty and should be=20
> avoided */ to the amdgpu code instead.
>=20
> Regards,
> Christian.
>=20
> >=20
> > P.
> >=20
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Philipp Stanner <phasta@kernel.org>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_main.c | 44
> > > ++++++++++++++++++++++++++
> > > =C2=A0=C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > =C2=A0=C2=A02 files changed, 45 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index a48be16ab84f..0363655db22d 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -703,6 +703,50 @@ void drm_sched_start(struct
> > > drm_gpu_scheduler
> > > *sched, int errno)
> > > =C2=A0=C2=A0}
> > > =C2=A0=C2=A0EXPORT_SYMBOL(drm_sched_start);
> > > =C2=A0=20
> > > +/**
> > > + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled
> > > jobs
> > > + *
> > > + * @sched: scheduler instance
> > > + * @errno: error value to set on signaled fences
> > > + *
> > > + * Signal all queued and scheduled jobs and set them to error
> > > state.
> > > + *
> > > + * Scheduler must be stopped before calling this.
> > > + */
> > > +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched,
> > > int
> > > errno)
> > > +{
> > > +	struct drm_sched_entity *entity;
> > > +	struct drm_sched_fence *s_fence;
> > > +	struct drm_sched_job *job;
> > > +	enum drm_sched_priority p;
> > > +
> > > +	drm_WARN_ON_ONCE(sched, !sched->pause_submit);
> > > +
> > > +	/* Signal all jobs not yet scheduled */
> > > +	for (p =3D DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs;
> > > p++)
> > > {
> > > +		struct drm_sched_rq *rq =3D sched->sched_rq[p];
> > > +
> > > +		spin_lock(&rq->lock);
> > > +		list_for_each_entry(entity, &rq->entities, list)
> > > {
> > > +			while ((job =3D
> > > to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> > > +				s_fence =3D job->s_fence;
> > > +				dma_fence_signal(&s_fence-
> > > > scheduled);
> > > +				dma_fence_set_error(&s_fence-
> > > > finished, errno);
> > > +				dma_fence_signal(&s_fence-
> > > > finished);
> > > +			}
> > > +		}
> > > +		spin_unlock(&rq->lock);
> > > +	}
> > > +
> > > +	/* Signal all jobs already scheduled to HW */
> > > +	list_for_each_entry(job, &sched->pending_list, list) {
> > > +		s_fence =3D job->s_fence;
> > > +		dma_fence_set_error(&s_fence->finished, errno);
> > > +		dma_fence_signal(&s_fence->finished);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
> > > +
> > > =C2=A0=C2=A0/**
> > > =C2=A0=C2=A0 * drm_sched_resubmit_jobs - Deprecated, don't use in new=
 code!
> > > =C2=A0=C2=A0 *
> > > diff --git a/include/drm/gpu_scheduler.h
> > > b/include/drm/gpu_scheduler.h
> > > index a0ff08123f07..298513f8c327 100644
> > > --- a/include/drm/gpu_scheduler.h
> > > +++ b/include/drm/gpu_scheduler.h
> > > @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct
> > > drm_gpu_scheduler *sched);
> > > =C2=A0=C2=A0void drm_sched_wqueue_start(struct drm_gpu_scheduler *sch=
ed);
> > > =C2=A0=C2=A0void drm_sched_stop(struct drm_gpu_scheduler *sched, stru=
ct
> > > drm_sched_job *bad);
> > > =C2=A0=C2=A0void drm_sched_start(struct drm_gpu_scheduler *sched, int
> > > errno);
> > > +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched,
> > > int
> > > errno);
> > > =C2=A0=C2=A0void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sc=
hed);
> > > =C2=A0=C2=A0void drm_sched_increase_karma(struct drm_sched_job *bad);
> > > =C2=A0=C2=A0void drm_sched_reset_karma(struct drm_sched_job *bad);
>=20

