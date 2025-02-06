Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD506C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 16:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBB410E8C3;
	Thu,  6 Feb 2025 16:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hz34MMxd";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A132310E835
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:39:25 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YpdVy0JdTz9sps;
 Thu,  6 Feb 2025 14:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1738849162; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtYNnQW/bA1bCHtVtrCKi+1BXSdhr2YbRGPNE6lJ+vg=;
 b=Hz34MMxdyR3rOI5NInO9EK9f6HXHqKqnH0/Eqx+IS7ZT6C0oM/GjF/dPybDHVIUDogfp36
 nwg2dqyFmNO+iuvKxmFWJwJ2aSdLd+saQ7FXu0902/LEBAxypVj8Ravk0epcNUCorz8p8B
 uNgd86As9nt4LDat5Jd4aKY1dBNbw5dWbv0w5v7X3UTZDzoxQ/S/JLWErCuEC+zuP58v75
 csfa3iPDPaIZcgn8USVp+SGswyDYEQQIuRjqjkW79MJdrnlcwyWWZNNQGIoJJiHtuK9eur
 gIjXTIQlcp8OYSTFmcRrkuVbvsVGo6QWLs+nfIaborpQIEd5uUxzboxEZ1NuLA==
Message-ID: <78fe2f63a251791e8d1ea4c1da1ea3fddbc587f5.camel@mailbox.org>
Subject: Re: [PATCH 3/4] drm/sched: Add internal job peek/pop API
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
Date: Thu, 06 Feb 2025 14:39:20 +0100
In-Reply-To: <20250205153332.14852-4-tvrtko.ursulin@igalia.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: mna9dp3yin34k8ud9padi8attjfybug5
X-MBO-RS-ID: e3a0493392f861f69e3
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
> Idea is to add helpers for peeking and poppling jobs from entities

s/poppling/popping

> with
> the goal of decoupling the hidden assumption in the code that
> queue_node
> is the first element in struct drm_sched_job.
>=20
> That assumption usually comes in the form of:
>=20
> =C2=A0 while ((job =3D to_drm_sched_job(spsc_queue_pop(&entity-
> >job_queue))))
>=20
> Which breaks if the queue_node is re-positioned due to_drm_sched_job
> being implemented with a container_of.
>=20
> This also allows us to remove duplicate definition of
> to_drm_sched_job
> which the scheduler apparently tried to keep internal, but failed
> since
> in one of the previous patches we also removed a copy from amdgpu.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

This one LGTM, +1

> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0 | 11 +++---
> =C2=A0drivers/gpu/drm/scheduler/sched_internal.h | 43
> ++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 ++---
> =C2=A03 files changed, 52 insertions(+), 11 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/scheduler/sched_internal.h
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> b/drivers/gpu/drm/scheduler/sched_entity.c
> index 69bcf0e99d57..737feff147a5 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -28,11 +28,10 @@
> =C2=A0#include <drm/drm_print.h>
> =C2=A0#include <drm/gpu_scheduler.h>
> =C2=A0
> +#include "sched_internal.h"
> +
> =C2=A0#include "gpu_scheduler_trace.h"
> =C2=A0
> -#define to_drm_sched_job(sched_job)		\
> -		container_of((sched_job), struct drm_sched_job,
> queue_node)
> -
> =C2=A0/**
> =C2=A0 * drm_sched_entity_init - Init a context entity used by scheduler
> when
> =C2=A0 * submit to HW ring.
> @@ -255,7 +254,7 @@ static void drm_sched_entity_kill(struct
> drm_sched_entity *entity)
> =C2=A0	/* The entity is guaranteed to not be used by the scheduler
> */
> =C2=A0	prev =3D rcu_dereference_check(entity->last_scheduled, true);
> =C2=A0	dma_fence_get(prev);
> -	while ((job =3D to_drm_sched_job(spsc_queue_pop(&entity-
> >job_queue)))) {
> +	while ((job =3D __drm_sched_entity_queue_pop(entity))) {
> =C2=A0		struct drm_sched_fence *s_fence =3D job->s_fence;
> =C2=A0
> =C2=A0		dma_fence_get(&s_fence->finished);
> @@ -477,7 +476,7 @@ struct drm_sched_job
> *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
> =C2=A0{
> =C2=A0	struct drm_sched_job *sched_job;
> =C2=A0
> -	sched_job =3D to_drm_sched_job(spsc_queue_peek(&entity-
> >job_queue));
> +	sched_job =3D __drm_sched_entity_queue_peek(entity);
> =C2=A0	if (!sched_job)
> =C2=A0		return NULL;
> =C2=A0
> @@ -513,7 +512,7 @@ struct drm_sched_job
> *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
> =C2=A0	if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO) {
> =C2=A0		struct drm_sched_job *next;
> =C2=A0
> -		next =3D to_drm_sched_job(spsc_queue_peek(&entity-
> >job_queue));
> +		next =3D __drm_sched_entity_queue_peek(entity);
> =C2=A0		if (next) {
> =C2=A0			struct drm_sched_rq *rq;
> =C2=A0
> diff --git a/drivers/gpu/drm/scheduler/sched_internal.h
> b/drivers/gpu/drm/scheduler/sched_internal.h
> new file mode 100644
> index 000000000000..565c83e32371
> --- /dev/null
> +++ b/drivers/gpu/drm/scheduler/sched_internal.h
> @@ -0,0 +1,43 @@
> +
> +
> +/**
> + * __drm_sched_entity_queue_pop - Low level helper for popping
> queued jobs
> + *
> + * @entity: scheduler entity
> + *
> + * Low level helper for popping queued jobs.
> + *
> + * Returns the job dequeued or NULL.
> + */
> +static inline struct drm_sched_job *
> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> +{
> +	struct spsc_node *node;
> +
> +	node =3D spsc_queue_pop(&entity->job_queue);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct drm_sched_job, queue_node);
> +}
> +
> +/**
> + * __drm_sched_entity_queue_peek - Low level helper for peeking at
> the job queue
> + *
> + * @entity: scheduler entity
> + *
> + * Low level helper for peeking at the job queue
> + *
> + * Returns the job at the head of the queue or NULL.
> + */
> +static inline struct drm_sched_job *
> +__drm_sched_entity_queue_peek(struct drm_sched_entity *entity)
> +{
> +	struct spsc_node *node;
> +
> +	node =3D spsc_queue_peek(&entity->job_queue);
> +	if (!node)
> +		return NULL;
> +
> +	return container_of(node, struct drm_sched_job, queue_node);
> +}
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 0363655db22d..41d6f839748e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -78,6 +78,8 @@
> =C2=A0#include <drm/gpu_scheduler.h>
> =C2=A0#include <drm/spsc_queue.h>
> =C2=A0
> +#include "sched_internal.h"
> +
> =C2=A0#define CREATE_TRACE_POINTS
> =C2=A0#include "gpu_scheduler_trace.h"
> =C2=A0
> @@ -87,9 +89,6 @@ static struct lockdep_map drm_sched_lockdep_map =3D {
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> -#define to_drm_sched_job(sched_job)		\
> -		container_of((sched_job), struct drm_sched_job,
> queue_node)
> -
> =C2=A0int drm_sched_policy =3D DRM_SCHED_POLICY_FIFO;
> =C2=A0
> =C2=A0/**
> @@ -123,7 +122,7 @@ static bool drm_sched_can_queue(struct
> drm_gpu_scheduler *sched,
> =C2=A0{
> =C2=A0	struct drm_sched_job *s_job;
> =C2=A0
> -	s_job =3D to_drm_sched_job(spsc_queue_peek(&entity-
> >job_queue));
> +	s_job =3D __drm_sched_entity_queue_peek(entity);
> =C2=A0	if (!s_job)
> =C2=A0		return false;
> =C2=A0
> @@ -728,7 +727,7 @@ void drm_sched_cancel_all_jobs(struct
> drm_gpu_scheduler *sched, int errno)
> =C2=A0
> =C2=A0		spin_lock(&rq->lock);
> =C2=A0		list_for_each_entry(entity, &rq->entities, list) {
> -			while ((job =3D
> to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> +			while ((job =3D
> __drm_sched_entity_queue_pop(entity))) {
> =C2=A0				s_fence =3D job->s_fence;
> =C2=A0				dma_fence_signal(&s_fence-
> >scheduled);
> =C2=A0				dma_fence_set_error(&s_fence-
> >finished, errno);

