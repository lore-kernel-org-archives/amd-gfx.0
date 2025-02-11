Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF91C021A1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 16:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F26B10E718;
	Tue, 11 Feb 2025 16:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wvMQQo7f";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9178B10E11C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 10:08:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YscZw1Jg4z9t4R;
 Tue, 11 Feb 2025 11:08:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1739268488; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s96W1H3gANGId9X5PxBXgCRqKW5houTGbV847ZPN/2g=;
 b=wvMQQo7fZ/dKC7v/b780frr73KE6qgq9JkNQQv3mnPYbl7eaGbAP1b19i/6hUqNUWm5tQQ
 3/XiKJk8nmM8JC4L6oMBaOJPal4pNF8PaEbTPyJcqQ9eEl/cpcSU99VPfPQDoryKYkv+5t
 dS+WLLVrKwE9eZ5tp1K2LJPe5B/4Hh2p8/Uvrn7cSDcdlvZS4KGdNlEZEhKQNYpyZ38lVr
 tSnL5kGiVCBZrkRCrC6FHETGsujqjBpT9y/EAR8AuO3NsygvAZYSN11NVkacz5mFbpbgTL
 seBAU2hUr1EKMxlPCsA1vABeLWzmhLIpIsraMx2lhi4BRr8SjAaPZO3nT1NImA==
Message-ID: <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Date: Tue, 11 Feb 2025 11:08:05 +0100
In-Reply-To: <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
 <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: y7awscpmpwecm7841jhdwn87pmrg6eh7
X-MBO-RS-ID: ef1702cea21a21b6772
X-Mailman-Approved-At: Tue, 11 Feb 2025 16:57:59 +0000
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

On Tue, 2025-02-11 at 09:22 +0100, Christian K=C3=B6nig wrote:
> Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
> > Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a
> > newly
> > added __drm_sched_entity_queue_pop.
> >=20
> > This allows breaking the hidden dependency that queue_node has to
> > be the
> > first element in struct drm_sched_job.
> >=20
> > A comment is also added with a reference to the mailing list
> > discussion
> > explaining the copied helper will be removed when the whole broken
> > amdgpu_job_stop_all_jobs_on_sched is removed.
> >=20
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > Cc: Philipp Stanner <phasta@kernel.org>
> > Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

I think this v3 has been supplanted by a v4 by now.

@Tvrtko: btw, do you create patches with
git format-patch -v4 ?

That way the v4 label will be included in all patch titles, too, not
just the cover letter. That makes searching etc. easier in large
inboxes

P.

>=20
> > ---
> > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++=
-
> > --
> > =C2=A0 1 file changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index 100f04475943..22cb48bab24d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct
> > drm_sched_job *sched_job)
> > =C2=A0=C2=A0	return fence;
> > =C2=A0 }
> > =C2=A0=20
> > -#define to_drm_sched_job(sched_job)		\
> > -		container_of((sched_job), struct drm_sched_job,
> > queue_node)
> > +/*
> > + * This is a duplicate function from DRM scheduler
> > sched_internal.h.
> > + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is
> > removed, due
> > + * latter being incorrect and racy.
> > + *
> > + * See
> > https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@am=
d.com/
> > + */
> > +static struct drm_sched_job *
> > +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
> > +{
> > +	struct spsc_node *node;
> > +
> > +	node =3D spsc_queue_pop(&entity->job_queue);
> > +	if (!node)
> > +		return NULL;
> > +
> > +	return container_of(node, struct drm_sched_job,
> > queue_node);
> > +}
> > =C2=A0=20
> > =C2=A0 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
> > *sched)
> > =C2=A0 {
> > @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
> > drm_gpu_scheduler *sched)
> > =C2=A0=C2=A0		struct drm_sched_rq *rq =3D sched->sched_rq[i];
> > =C2=A0=C2=A0		spin_lock(&rq->lock);
> > =C2=A0=C2=A0		list_for_each_entry(s_entity, &rq->entities, list)
> > {
> > -			while ((s_job =3D
> > to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
> > +			while ((s_job =3D
> > __drm_sched_entity_queue_pop(s_entity))) {
> > =C2=A0=C2=A0				struct drm_sched_fence *s_fence =3D
> > s_job->s_fence;
> > =C2=A0=20
> > =C2=A0=C2=A0				dma_fence_signal(&s_fence-
> > >scheduled);
>=20

