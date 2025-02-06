Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D2AC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDEC10E113;
	Thu,  6 Feb 2025 16:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gqTGu09c";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2227D10E1BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:35:18 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YpdQ95gbRz9slG;
 Thu,  6 Feb 2025 14:35:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1738848913; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0S0+7/YLe9UlVmBLRWnNKvgWO2UCJbhc33Vf/qu+44=;
 b=gqTGu09cuHiPhpb7lnP7AuovRBbWLm4xZ+l189foQLQwW/5whox80VNPgLk6PHmg4WicKI
 /fpqjrZR2AHKps7W/3eOx4CePafOQUH7O2ELFbGwdGLNYuFPZCfUSTntPQ6qDl2ru0M+ZR
 XGC+iyoW9o2JLHKPhDuz5xhu1kbW8Nv86DvUUmdWH9C/kNoqh++JT4Ps/HSSApI3Er39Eo
 I18nZWWxkkmQOTDGVLWl5C0Nt/WzoOsxD1zqnbFFrhmrapv7KFlHBbnn2ttmoW2QChDlzU
 RxENhd2wYwYG+aToC+yVDJufYmLB3TDMYXDxo6sK85OTFpWBtHCcuQ/5lN5xLQ==
Message-ID: <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Thu, 06 Feb 2025 14:35:10 +0100
In-Reply-To: <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 9bc705d2bb847bf4880
X-MBO-RS-META: wk4gjcrtitm78ntrwreh7oyahd1sm6nm
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

On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
> The helper copies code from the existing
> amdgpu_job_stop_all_jobs_on_sched
> with the purpose of reducing the amount of driver code which directly
> touch scheduler internals.
>=20
> If or when amdgpu manages to change the approach for handling the
> permanently wedged state this helper can be removed.

Have you checked how many other drivers might need such a helper?

I have a bit mixed feelings about this, because, AFAICT, in the past
helpers have been added for just 1 driver, such as
drm_sched_wqueue_ready(), and then they have stayed for almost a
decade.

AFAIU this is just code move, and only really "decouples" amdgpu in the
sense of having an official scheduler function that does what amdgpu
used to do.

So my tendency here would be to continue "allowing" amdgpu to touch the
scheduler internals until amdgpu fixes this "permanently wedged
state".=C2=A0And if that's too difficult, couldn't the helper reside in a
amdgpu/sched_helpers.c or similar?

I think that's better than adding 1 helper for just 1 driver and then
supposedly removing it again in the future.

P.

>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 44
> ++++++++++++++++++++++++++
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A02 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index a48be16ab84f..0363655db22d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -703,6 +703,50 @@ void drm_sched_start(struct drm_gpu_scheduler
> *sched, int errno)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(drm_sched_start);
> =C2=A0
> +/**
> + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled jobs
> + *
> + * @sched: scheduler instance
> + * @errno: error value to set on signaled fences
> + *
> + * Signal all queued and scheduled jobs and set them to error state.
> + *
> + * Scheduler must be stopped before calling this.
> + */
> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
> errno)
> +{
> +	struct drm_sched_entity *entity;
> +	struct drm_sched_fence *s_fence;
> +	struct drm_sched_job *job;
> +	enum drm_sched_priority p;
> +
> +	drm_WARN_ON_ONCE(sched, !sched->pause_submit);
> +
> +	/* Signal all jobs not yet scheduled */
> +	for (p =3D DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs; p++)
> {
> +		struct drm_sched_rq *rq =3D sched->sched_rq[p];
> +
> +		spin_lock(&rq->lock);
> +		list_for_each_entry(entity, &rq->entities, list) {
> +			while ((job =3D
> to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> +				s_fence =3D job->s_fence;
> +				dma_fence_signal(&s_fence-
> >scheduled);
> +				dma_fence_set_error(&s_fence-
> >finished, errno);
> +				dma_fence_signal(&s_fence-
> >finished);
> +			}
> +		}
> +		spin_unlock(&rq->lock);
> +	}
> +
> +	/* Signal all jobs already scheduled to HW */
> +	list_for_each_entry(job, &sched->pending_list, list) {
> +		s_fence =3D job->s_fence;
> +		dma_fence_set_error(&s_fence->finished, errno);
> +		dma_fence_signal(&s_fence->finished);
> +	}
> +}
> +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
> +
> =C2=A0/**
> =C2=A0 * drm_sched_resubmit_jobs - Deprecated, don't use in new code!
> =C2=A0 *
> diff --git a/include/drm/gpu_scheduler.h
> b/include/drm/gpu_scheduler.h
> index a0ff08123f07..298513f8c327 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct
> drm_gpu_scheduler *sched);
> =C2=A0void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
> =C2=A0void drm_sched_stop(struct drm_gpu_scheduler *sched, struct
> drm_sched_job *bad);
> =C2=A0void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
> errno);
> =C2=A0void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
> =C2=A0void drm_sched_increase_karma(struct drm_sched_job *bad);
> =C2=A0void drm_sched_reset_karma(struct drm_sched_job *bad);

