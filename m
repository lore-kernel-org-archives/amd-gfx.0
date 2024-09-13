Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F47FEEE26C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 12:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183E910ED0F;
	Fri, 13 Sep 2024 12:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OMYHnQ3C";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43B910ED0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726229995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74g+6Lc20YMUCLnZEXSet2FyAPh+zgOsXvUzgQi+s9Y=;
 b=OMYHnQ3CvSe2WJ+DJAuBO+7zBLu0OCD74vHB7eMBC7ZkcewjeDWSt08VZvlXSMumCne7uA
 lWLAnuoxFinnhaAs8R5KdpgNc+2vqi90IKYFPNuhZt36hn+W4YuS2IP2oMdSL4eCEJ4fdb
 vTWsWi/8bS3zhoMDHlWJpNU2BGoMRlI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Lt_ePusOMgGuRY1Oy_CeJg-1; Fri, 13 Sep 2024 08:19:54 -0400
X-MC-Unique: Lt_ePusOMgGuRY1Oy_CeJg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c3402d93so1155011f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 05:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726229993; x=1726834793;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XKJAOxxildor2C+JyAi309c2iCVs3etP4p4DATyTUo=;
 b=aO2zoe8kowRdimxAjXIlV80AwRx/SgHGNm/RPIgP5s2hLWWiUAaxqaKUwh0RVnDyRj
 LwTssj/0JERwsC+n+kp/3Kq2RVx36fMOEqquY6rKeWtDDqh1lTwm7SiRDnc28XG2ZfKU
 kLi2098J71gcVNCZAm+LMonsdQh7Zl3BJIFjVAhYBkJjoFjmPmYLDmiRUxU5n1d1DE3/
 DywO0Vd/ieki0n7x1DqK9yty1emYjVr7gyHZOd0vHDO5gOM7X5UmxhHuwtyFKHnOjsNg
 20T12mEcF3WxiizQOk+51BF3ZISlFtmA+ObUFuDQYHNznHyIzi7Eq1jAt9TckfF0bCXb
 Cxww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+7KyOE5tAFdEMAzrEyGKCcNSrTmgzid2zaWmJYJm1BwstyAwKJJlP2I0JVKX3u3yO/gXlcWg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0C7SCkwTphJzxYw87erCvtNEf7xVsOwJXoEnGLWONpv3mb67d
 V/5Bf1yRceRMbNQKshek6dplVMysRlBOKFU8w4wN8pulnwwSSVJsK8Pv0c6pTYaonC2157tm8GJ
 06Iwbys/T/ngYcl0wzcujg99fVmP+wrGX8bbEuB169ulaAMnWI63wTj9GyhuvItk=
X-Received: by 2002:a5d:428f:0:b0:374:b9a1:28f with SMTP id
 ffacd0b85a97d-378c2d5b0f1mr3873955f8f.43.1726229993356; 
 Fri, 13 Sep 2024 05:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHtMpeBsSe/ie77wRssbK27CLDdBmkI+eYg1BeRPyWcphE9e6GW9bPrh3yaBITdTRr10k2Ng==
X-Received: by 2002:a5d:428f:0:b0:374:b9a1:28f with SMTP id
 ffacd0b85a97d-378c2d5b0f1mr3873931f8f.43.1726229992758; 
 Fri, 13 Sep 2024 05:19:52 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d2a:6400:5050:48a2:62f2:4d16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564b02asm17029823f8f.4.2024.09.13.05.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 05:19:52 -0700 (PDT)
Message-ID: <661856cf6695ee063db2d49527b2ed539d941b8e.camel@redhat.com>
Subject: Re: [PATCH 8/8] drm/sched: Further optimise drm_sched_entity_push_job
From: Philipp Stanner <pstanner@redhat.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Tvrtko Ursulin
 <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>
Date: Fri, 13 Sep 2024 14:19:51 +0200
In-Reply-To: <60d30fe6-9485-4cbe-8b72-69b3214edd3f@igalia.com>
References: <20240909171937.51550-1-tursulin@igalia.com>
 <20240909171937.51550-9-tursulin@igalia.com>
 <5be10361b0b77f2eaf54c52367b5c4e3934443ab.camel@redhat.com>
 <60d30fe6-9485-4cbe-8b72-69b3214edd3f@igalia.com>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, 2024-09-11 at 13:22 +0100, Tvrtko Ursulin wrote:
>=20
> On 10/09/2024 11:25, Philipp Stanner wrote:
> > On Mon, 2024-09-09 at 18:19 +0100, Tvrtko Ursulin wrote:
> > > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > >=20
> > > Having removed one re-lock cycle on the entity->lock in a patch
> > > titled
> > > "drm/sched: Optimise drm_sched_entity_push_job", with only a tiny
> > > bit
> > > larger refactoring we can do the same optimisation on the rq-
> > > >lock
> > > (Currently both drm_sched_rq_add_entity() and
> > > drm_sched_rq_update_fifo_locked() take and release the same
> > > lock.)
> > >=20
> > > To achieve this we rename drm_sched_rq_add_entity() to
> > > drm_sched_rq_add_entity_locked(), making it expect the rq->lock
> > > to be
> > > held, and also add the same expectation to
> > > drm_sched_rq_update_fifo_locked().
> > >=20
> > > For more stream-lining we also add the run-queue as an explicit
> > > parameter
> > > to drm_sched_rq_remove_fifo_locked() to avoid both callers and
> > > callee
> > > having to dereference entity->rq.
> >=20
> > Why is dereferencing it a problem?
>=20
> As you have noticed below the API is a bit unsightly. Consider for=20
> example this call chain:
>=20
> drm_sched_entity_kill(entity)
> =C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_rq_remove_entity(entity->rq, entity);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_rq_remove_fifo=
_locked(entity);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct drm_sched_rq *rq =3D entity->rq;
>=20
> A bit confused, no?
>=20
> I thought adding rq to remove_fifo_locked at least removes one back
> and=20
> forth between the entity->rq and rq.
>=20
> And then if we cache the rq in a local variable, after having
> explicitly=20
> taken the correct lock, we have this other call chain example:
>=20
> drm_sched_entity_push_job()
> ...
> =C2=A0=C2=A0=C2=A0=C2=A0 rq =3D entity->rq;
> =C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(rq->lock);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_rq_add_entity_locked(rq, entity);
> =C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_rq_update_fifo_locked(rq, entity, subm=
it_ts);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(rq->lock);
>=20
> To me at least this reads more streamlined.

Alright, doesn't sound to bad, but

>=20
> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Luben Tuikov <ltuikov89@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Philipp Stanner <pstanner@redhat.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_entity.c |=C2=A0 7 ++--
> > > =C2=A0=C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0 | 41 +=
++++++++++++----
> > > -----
> > > --
> > > =C2=A0=C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++--
> > > =C2=A0=C2=A03 files changed, 31 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c
> > > b/drivers/gpu/drm/scheduler/sched_entity.c
> > > index b4c4f9923e0b..2102c726d275 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > > @@ -614,11 +614,14 @@ void drm_sched_entity_push_job(struct
> > > drm_sched_job *sched_job)
> > > =C2=A0=C2=A0=09=09sched =3D rq->sched;
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09=09atomic_inc(sched->score);
> > > -=09=09drm_sched_rq_add_entity(rq, entity);
> > > +
> > > +=09=09spin_lock(&rq->lock);
> > > +=09=09drm_sched_rq_add_entity_locked(rq, entity);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09=09if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > > -=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > > submit_ts);
> > > +=09=09=09drm_sched_rq_update_fifo_locked(entity,
> > > rq,
> > > submit_ts);
> > > =C2=A0=20
> > > +=09=09spin_unlock(&rq->lock);
> > > =C2=A0=C2=A0=09=09spin_unlock(&entity->lock);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09=09drm_sched_wakeup(sched, entity);
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index 937e7d1cfc49..1ccd2aed2d32 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -153,41 +153,44 @@ static __always_inline bool
> > > drm_sched_entity_compare_before(struct rb_node *a,
> > > =C2=A0=C2=A0=09return ktime_before(ent_a->oldest_job_waiting, ent_b-
> > > > oldest_job_waiting);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > -static inline void drm_sched_rq_remove_fifo_locked(struct
> > > drm_sched_entity *entity)
> > > +static void drm_sched_rq_remove_fifo_locked(struct
> > > drm_sched_entity
> > > *entity,
> > > +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 struct drm_sched_rq
> > > *rq)

I would then at least like to see a comment somewhere telling the
reader why rq is taken as a separate variable. One might otherwise
easily wonder why it's not obtained through the entity and what the
difference is.

> >=20
> > So here we'd add a new function parameter that still doesn't allow
> > for
> > getting rid of 'entity' as a parameter.
>=20
> We can't get rid of the entity.
>=20
> Maaaybe instead we could get rid of the rq in the whole chain, I mean
> from drm_sched_rq_add_entity and drm_sched_rq_remove_entity to start
> with.

Let's postpone that.

>=20
> But then to remove double re-lock we still (like in this patch) need
> to=20
> make the callers take the locks and rename the helpers with _locked=20
> suffix. Otherwise it would be incosistent that a lock is taken
> outside=20
> the helpers with no _locked suffix.
>=20
> I am not sure if that is better. All it achieves is remove the rq as=20
> explicit parameter my making the callees dereference it from the
> entity.

OK, as I see it now it would actually be desirable to have suffix
_locked indicate that the caller must hold all necessary locks. So your
patch would actually make that consistent within drm/sched/.

Looks good

P.

>=20
> Worst part is all these helpers have drm_sched_rq_ prefix.. which to
> me=20
> reads as "we operate on rq". So not passing in rq is confusing to
> start=20
> with.
>=20
> Granted, some confusion still remains with my approach since ideally,
> to=20
> those helpers, I wanted to add some asserts that rq =3D=3D entity->rq...
>=20
> > The API gets larger that way and readers will immediately wonder
> > why
> > sth is passed as a separate variable that could also be obtained
> > through the pointer.
> >=20
> > > =C2=A0=C2=A0{
> > > -=09struct drm_sched_rq *rq =3D entity->rq;
> > > -
> > > =C2=A0=C2=A0=09if (!RB_EMPTY_NODE(&entity->rb_tree_node)) {
> > > =C2=A0=C2=A0=09=09rb_erase_cached(&entity->rb_tree_node, &rq-
> > > > rb_tree_root);
> > > =C2=A0=C2=A0=09=09RB_CLEAR_NODE(&entity->rb_tree_node);
> > > =C2=A0=C2=A0=09}
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > -void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > > *entity, ktime_t ts)
> > > +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > > *entity,
> > > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq,
> > > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 ktime_t ts)
> >=20
> > The function is still called _locked. That implies to the reader
> > that
> > this function takes care of locking. But it doesn't anymore.
> > Instead,
> >=20
> > > =C2=A0=C2=A0{
> > > =C2=A0=C2=A0=09lockdep_assert_held(&entity->lock);
> > > +=09lockdep_assert_held(&rq->lock);
> > > =C2=A0=20
> > > -=09spin_lock(&entity->rq->lock);
> > > -
> > > -=09drm_sched_rq_remove_fifo_locked(entity);
> > > +=09drm_sched_rq_remove_fifo_locked(entity, rq);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09entity->oldest_job_waiting =3D ts;
> > > =C2=A0=20
> > > -=09rb_add_cached(&entity->rb_tree_node, &entity->rq-
> > > > rb_tree_root,
> > > +=09rb_add_cached(&entity->rb_tree_node, &rq->rb_tree_root,
> > > =C2=A0=C2=A0=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_sched_entity_com=
pare_before);
> > > -
> > > -=09spin_unlock(&entity->rq->lock);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0void drm_sched_rq_update_fifo(struct drm_sched_entity *en=
tity,
> > > ktime_t ts)
> > > =C2=A0=C2=A0{
> > > +=09struct drm_sched_rq *rq;
> > > +
> > > =C2=A0=C2=A0=09/*
> > > =C2=A0=C2=A0=09 * Both locks need to be grabbed, one to protect from
> > > entity->rq change
> > > =C2=A0=C2=A0=09 * for entity from within concurrent
> > > drm_sched_entity_select_rq and the
> > > =C2=A0=C2=A0=09 * other to update the rb tree structure.
> > > =C2=A0=C2=A0=09 */
> > > =C2=A0=C2=A0=09spin_lock(&entity->lock);
> > > -=09drm_sched_rq_update_fifo_locked(entity, ts);
> > > +=09rq =3D entity->rq;
> > > +=09spin_lock(&rq->lock);
> > > +=09drm_sched_rq_update_fifo_locked(entity, rq, ts);
> > > +=09spin_unlock(&rq->lock);
> >=20
> > its caller, drm_sched_rq_update_fifo(), now takes care of the
> > locking.
> > So if it all drm_sched_rq_update_fifo_locked() should be called
> > drm_sched_rq_update_fifo_unlocked().
> >=20
> > If such a change is really being done, we have to go through the
> > entire
> > scheduler and make sure that the suffix "_locked" is used
> > consistently
> > throughout the scheduler. And even better, as consistent with the
> > kernel as possible.
>=20
> Use of _locked follows the existing pattern of=20
> drm_sched_rq_remove_fifo_locked :shrug:
>=20
> Are you referring to drm_sched_start_timeout(_unlocked) which is the=20
> opposite pattern? (Although a more recent addition.)
>=20
> The wider kernel also uses both patterns so don't know. Would be nice
> to=20
> align in the scheduler but drm_sched_start_timeout is out of scope
> for=20
> this series.
>=20
> > To be honest folks, I don't think this entire "optimization" patch
> > is
> > that much of a good idea. The scheduler has real, big problems,
> > such as
> > race conditions, memory leaks and lack of documentation.
> >=20
> > I think we should for the forseeable future dedicate our attention
> > towards solving those problems, instead of optimizing things.
> > Especially if the optimization might decrease readability as with
> > the
> > naming here.
>=20
> In principle I agree, but on the other hand lets first see if this
> patch=20
> is really making things any worse, or is perhaps just maintaining the
> status quo in the API elegance department, while at the same time=20
> removing the quite lazy double re-lock from the main submission path.
>=20
> Regards,
>=20
> Tvrtko
>=20
> >=20
> > P.
> >=20
> >=20
> > > =C2=A0=C2=A0=09spin_unlock(&entity->lock);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > @@ -210,25 +213,23 @@ static void drm_sched_rq_init(struct
> > > drm_gpu_scheduler *sched,
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0/**
> > > - * drm_sched_rq_add_entity - add an entity
> > > + * drm_sched_rq_add_entity_locked - add an entity
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * @rq: scheduler run queue
> > > =C2=A0=C2=A0 * @entity: scheduler entity
> > > =C2=A0=C2=A0 *
> > > =C2=A0=C2=A0 * Adds a scheduler entity to the run queue.
> > > =C2=A0=C2=A0 */
> > > -void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
> > > -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *entity)
> > > +void drm_sched_rq_add_entity_locked(struct drm_sched_rq *rq,
> > > +=09=09=09=09=C2=A0=C2=A0=C2=A0 struct drm_sched_entity
> > > *entity)
> > > =C2=A0=C2=A0{
> > > +=09lockdep_assert_held(&rq->lock);
> > > +
> > > =C2=A0=C2=A0=09if (!list_empty(&entity->list))
> > > =C2=A0=C2=A0=09=09return;
> > > =C2=A0=20
> > > -=09spin_lock(&rq->lock);
> > > -
> > > =C2=A0=C2=A0=09atomic_inc(rq->sched->score);
> > > =C2=A0=C2=A0=09list_add_tail(&entity->list, &rq->entities);
> > > -
> > > -=09spin_unlock(&rq->lock);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > =C2=A0=C2=A0/**
> > > @@ -242,6 +243,8 @@ void drm_sched_rq_add_entity(struct
> > > drm_sched_rq
> > > *rq,
> > > =C2=A0=C2=A0void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> > > =C2=A0=C2=A0=09=09=09=09struct drm_sched_entity *entity)
> > > =C2=A0=C2=A0{
> > > +=09lockdep_assert_held(&entity->lock);
> > > +
> > > =C2=A0=C2=A0=09if (list_empty(&entity->list))
> > > =C2=A0=C2=A0=09=09return;
> > > =C2=A0=20
> > > @@ -254,7 +257,7 @@ void drm_sched_rq_remove_entity(struct
> > > drm_sched_rq *rq,
> > > =C2=A0=C2=A0=09=09rq->current_entity =3D NULL;
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09if (drm_sched_policy =3D=3D DRM_SCHED_POLICY_FIFO)
> > > -=09=09drm_sched_rq_remove_fifo_locked(entity);
> > > +=09=09drm_sched_rq_remove_fifo_locked(entity, rq);
> > > =C2=A0=20
> > > =C2=A0=C2=A0=09spin_unlock(&rq->lock);
> > > =C2=A0=C2=A0}
> > > diff --git a/include/drm/gpu_scheduler.h
> > > b/include/drm/gpu_scheduler.h
> > > index 5a1e4c803b90..2ad33e2fe2d2 100644
> > > --- a/include/drm/gpu_scheduler.h
> > > +++ b/include/drm/gpu_scheduler.h
> > > @@ -591,13 +591,14 @@ bool drm_sched_dependency_optimized(struct
> > > dma_fence* fence,
> > > =C2=A0=C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 struct drm_sched_entity
> > > *entity);
> > > =C2=A0=C2=A0void drm_sched_fault(struct drm_gpu_scheduler *sched);
> > > =C2=A0=20
> > > -void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
> > > -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_entity *entity);
> > > +void drm_sched_rq_add_entity_locked(struct drm_sched_rq *rq,
> > > +=09=09=09=09=C2=A0=C2=A0=C2=A0 struct drm_sched_entity
> > > *entity);
> > > =C2=A0=C2=A0void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
> > > =C2=A0=C2=A0=09=09=09=09struct drm_sched_entity
> > > *entity);
> > > =C2=A0=20
> > > =C2=A0=C2=A0void drm_sched_rq_update_fifo(struct drm_sched_entity *en=
tity,
> > > ktime_t ts);
> > > -void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > > *entity, ktime_t ts);
> > > +void drm_sched_rq_update_fifo_locked(struct drm_sched_entity
> > > *entity,
> > > +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_sched_rq *rq,
> > > ktime_t ts);
> > > =C2=A0=20
> > > =C2=A0=C2=A0int drm_sched_entity_init(struct drm_sched_entity *entity=
,
> > > =C2=A0=C2=A0=09=09=09=C2=A0 enum drm_sched_priority priority,
> >=20
>=20

